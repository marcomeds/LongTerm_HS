### CUTOFF PER SCHOOL
rm(list=ls())
gc()
gc(reset = TRUE)

# Load data
metro2010 = read.dta("01_Data/01_Raw/01_COMIPEMS_CURP/metro_2010/metro_10.dta")
metro2010 = setDT(metro2010)

# Keep relevant variables
metro2010 <- metro2010 %>% 
  select(curp, cve_cct, mun_cct, folio, sus_cp, sus_prom, fol_cert, ano_cert,
         opc_ed01, opc_ed02, opc_ed03, opc_ed04, opc_ed05, opc_ed06, opc_ed07,
         opc_ed08, opc_ed09, opc_ed10, opc_ed11, opc_ed12, opc_ed13, opc_ed14,
         opc_ed15, opc_ed16, opc_ed17, opc_ed18, opc_ed19, opc_ed20, pre_exa,
         examen, nglobal, expl_asi, copc_asi)

# Get the cutoffs for each assigned option
cutoff_school_2010 <- metro2010 %>% 
  group_by(copc_asi) %>%
  summarise(cutoff = min(nglobal)) %>% 
  filter(copc_asi != "") %>%
  rename(school_code = copc_asi) %>%
  # Substract 0.5 to make the RD symmetric around the cutoff. 
  # Min score is 31 out of 128, so 30.5 is the min of the "artificial cutoff"
  mutate(cutoff_school = 1 - (cutoff-0.5-30.5)/(128-30.5)) %>% 
  select(-cutoff)

# Save cutoff_school
write_dta(cutoff_school_2010, path = "01_Data/02_Created/cutoff_school_2010.dta", version = 15)
save(cutoff_school_2010, file = "01_Data/02_Created/cutoff_school_2010.RData")

# Get school list
SchoolList = sort(unique(cutoff_school_2010$school_code))

#Just to test the code that elimintates irrelevant options
#metro2010=metro2010[curp=="BESM900201HDFCNR",]

## HERE WE ARE TALKING ABOUT THE CENEVAL ASSIGNMENT, NOT RE-ASSIGMENTS AFTER THE FACT
metro2010 <- metro2010 %>% 
  # Filter students:
  # 1) Those without a secondary certificate are not assigned
  # 2) Those who did not present the exam are not assigned
  # 3) Those who score under 31 are not assigned
  filter(expl_asi!="SC", 
         expl_asi!="NP", 
         expl_asi!="<31")


## IF GPA UNDER 7, THEN IPN AND UNAM SCHOOLS ARE NOT AN OPTION
metro2010 <- metro2010 %>%
  mutate(low_gpa = sus_prom < 7) %>%
  # Remove options that where IPN or UNAM was chosen, but the student has low gpa
  # Replace with NA so we can use shift_row_values
  mutate(across(starts_with("opc_ed"),
                ~ifelse(substr(., 1, 1) %in% c(5,6) & low_gpa == 1, NA, .)))

## Shift the columns to the right for empty options
metro2010[,9:28] <- metro2010[,9:28] %>%
  shift_row_values() %>%
  mutate(across(starts_with("opc_ed"), ~ifelse(is.na(.),"",.)))

# Create normalized score 0-1 (1 is worst)
metro2010 <- metro2010 %>% 
  # Min score is 31 out of 128
  mutate(normalized_score = 1 - (nglobal-31)/(128-31)) %>%
  select(-low_gpa)

write_dta(metro2010, path = "01_Data/02_Created/metro2010_fixed.dta", version = 15)
save(metro2010, file = "01_Data/02_Created/metro2010_fixed.RData")

# Get the cutoff for each of the options selected
for(i in c(1:20)){
  opt <- str_c("opc_ed", str_pad(i, 2, pad = "0"))
  var <- str_c("cutoff_", opt)
  
  cutoff_aux <- cutoff_school_2010 %>%
    rename(!!opt := school_code)
  
  metro2010 <- metro2010 %>% 
    left_join(cutoff_aux) %>%
    rename(!!var := cutoff_school)
}

DFmetro2010=data.frame(metro2010)
DFmetro2010=DFmetro2010[,paste0("cutoff_opc_ed",str_pad(1:20,2,pad="0"))]




### MID_theta_s for each person
for(sc_temp in SchoolList){
  y = paste0("mid_eval_",sc_temp)
  #metro2010[,eval(y):=NULL]
  metro2010[opc_ed01==sc_temp,eval(y):=0]
  
  for(i in 2){
    padded_i=str_pad(i, 2, pad = "0")
    index=which(metro2010[[eval(paste0("opc_ed",padded_i))]]==sc_temp)
    metro2010[index,(y):=cutoff_opc_ed01]
  }
  
  for(i in 3:20){
    padded_i=str_pad(i, 2, pad = "0")
    index=which(metro2010[[eval(paste0("opc_ed",padded_i))]]==sc_temp)
    metro2010[index,eval(y):=apply(DFmetro2010[index,paste0("cutoff_opc_ed",str_pad((1):(i-1),2,pad="0"))],1,max,na.rm=T)]
  }
}

rm(DFmetro2010)
ColsBasicas=c("curp","nglobal","normalized_score",
              paste0("opc_ed",str_pad(1:20,2,pad="0")),
              paste0("cutoff_opc_ed",str_pad(1:20,2,pad="0")),
              paste0("mid_eval_",SchoolList))

metro2010_basic=metro2010[, ..ColsBasicas]

write_dta(metro2010_basic, path = "01_Data/02_Created/metro2010_MID.dta", version = 15)
save(metro2010_basic, file = "01_Data/02_Created/metro2010_MID.RData")


rm(metro2010)
delta1=0.5/(128-31)
delta2=1/(128-31)
delta3=2/(128-31)
delta4=3/(128-31)
delta5=4/(128-31)


for(sc_temp in SchoolList){
  y = paste0("p_delta1_",sc_temp)
  z = paste0("mid_eval_",sc_temp)
  r = paste0("r_delta1_",sc_temp)
  tau_s=cutoff_school_2010$cutoff_school[cutoff_school_2010$school_code==sc_temp]
  
  #metro2010_basic[,eval(y):=NA]
  
  #Propostion 2 of EMTA
  
  #Part1: zero if cutoff for school is below MID
  index=which(metro2010_basic[[z]]>tau_s)
  metro2010_basic[index,eval(y):=0]
  #metro2010_basic[[y]]=as.numeric(metro2010_basic[[y]])
  
  #Part2a: zero if score<=MID-delta or score>tau_s+delta 
  index=which((metro2010_basic$normalized_score<=(metro2010_basic[[z]]-delta1)) & metro2010_basic[[z]]<tau_s)
  metro2010_basic[index,eval(y):=0]
  index=which((metro2010_basic$normalized_score>(tau_s+delta1)) & metro2010_basic[[z]]<tau_s)
  metro2010_basic[index,eval(y):=0]
  
  #Part2b: 1 if score \in (MID+delta,tau_s-delta]
  index=which((metro2010_basic$normalized_score>(metro2010_basic[[z]]+delta1)) &  (metro2010_basic$normalized_score<=(tau_s-delta1)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=10]
  
  #Part 3a: 0.5 if score \in (MID-delta,MID+delta] 
  index=which((metro2010_basic$normalized_score>(metro2010_basic[[z]]-delta1)) &  (metro2010_basic$normalized_score<=(metro2010_basic[[z]]+delta1)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=5]
  
  #Part 3a: 0.5 if score \in (tau_s-delta,tau_s+delta]
  index=which((metro2010_basic$normalized_score>(tau_s-delta1)) &  (metro2010_basic$normalized_score<=(tau_s+delta1)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=5]
  
  # Get the normalized score - cutoff
  index=which(!is.na(metro2010_basic[[y]]))
  metro2010_basic[index,eval(r):=normalized_score-tau_s]
}

ColsBasicas=c("curp","nglobal","normalized_score",
              paste0("p_delta1_",SchoolList),
              paste0("r_delta1_",SchoolList))

metro2010_pdelta=metro2010_basic[,..ColsBasicas]

write_dta(metro2010_pdelta, path = "01_Data/02_Created/metro2010_pdelta1.dta", version = 15)
save(metro2010_pdelta, file = "01_Data/02_Created/metro2010_pdelta1.RData")
rm(metro2010_pdelta)

ColsBasicas=c(paste0("p_delta1_",SchoolList), paste0("r_delta1_",SchoolList))
metro2010_basic[,eval(ColsBasicas):=NULL]



for(sc_temp in SchoolList){
  y = paste0("p_delta2_",sc_temp)
  z = paste0("mid_eval_",sc_temp)
  r = paste0("r_delta2_",sc_temp)
  tau_s=cutoff_school_2010$cutoff_school[cutoff_school_2010$school_code==sc_temp]
  
  #metro2010_basic[,eval(y):=NA]
  
  #Propostion 2 of EMTA
  
  #Part1: zero if cutoff for school is below MID
  index=which(metro2010_basic[[z]]>tau_s)
  metro2010_basic[index,eval(y):=0]
  #metro2010_basic[[y]]=as.numeric(metro2010_basic[[y]])
  
  #Part2a: zero if score<=MID-delta or score>tau_s+delta 
  index=which((metro2010_basic$normalized_score<=(metro2010_basic[[z]]-delta2)) & metro2010_basic[[z]]<tau_s)
  metro2010_basic[index,eval(y):=0]
  index=which((metro2010_basic$normalized_score>(tau_s+delta2)) & metro2010_basic[[z]]<tau_s)
  metro2010_basic[index,eval(y):=0]
  
  #Part2b: 1 if score \in (MID+delta,tau_s-delta]
  index=which((metro2010_basic$normalized_score>(metro2010_basic[[z]]+delta2)) &  (metro2010_basic$normalized_score<=(tau_s-delta2)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=10]
  
  #Part 3a: 0.5 if score \in (MID-delta,MID+delta] 
  index=which((metro2010_basic$normalized_score>(metro2010_basic[[z]]-delta2)) &  (metro2010_basic$normalized_score<=(metro2010_basic[[z]]+delta2)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=5]
  
  #Part 3a: 0.5 if score \in (tau_s-delta,tau_s+delta]
  index=which((metro2010_basic$normalized_score>(tau_s-delta2)) &  (metro2010_basic$normalized_score<=(tau_s+delta2)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=5]
  
  # Get the normalized score - cutoff
  index=which(!is.na(metro2010_basic[[y]]))
  metro2010_basic[index,eval(r):=normalized_score-tau_s]
}

ColsBasicas=c("curp","nglobal","normalized_score",
              paste0("p_delta2_",SchoolList),
              paste0("r_delta2_",SchoolList))

metro2010_pdelta=metro2010_basic[,..ColsBasicas]

write_dta(metro2010_pdelta, path = "01_Data/02_Created/metro2010_pdelta2.dta", version = 15)
save(metro2010_pdelta, file = "01_Data/02_Created/metro2010_pdelta2.RData")
rm(metro2010_pdelta)

ColsBasicas=c(paste0("p_delta2_",SchoolList), paste0("r_delta2_",SchoolList))
metro2010_basic[,eval(ColsBasicas):=NULL]



for(sc_temp in SchoolList){
  y = paste0("p_delta3_",sc_temp)
  z = paste0("mid_eval_",sc_temp)
  r = paste0("r_delta3_",sc_temp)
  tau_s=cutoff_school_2010$cutoff_school[cutoff_school_2010$school_code==sc_temp]
  
  #metro2010_basic[,eval(y):=NA]
  
  #Propostion 2 of EMTA
  
  #Part1: zero if cutoff for school is below MID
  index=which(metro2010_basic[[z]]>tau_s)
  metro2010_basic[index,eval(y):=0]
  #metro2010_basic[[y]]=as.numeric(metro2010_basic[[y]])
  
  #Part2a: zero if score<=MID-delta or score>tau_s+delta 
  index=which((metro2010_basic$normalized_score<=(metro2010_basic[[z]]-delta3)) & metro2010_basic[[z]]<tau_s)
  metro2010_basic[index,eval(y):=0]
  index=which((metro2010_basic$normalized_score>(tau_s+delta3)) & metro2010_basic[[z]]<tau_s)
  metro2010_basic[index,eval(y):=0]
  
  #Part2b: 1 if score \in (MID+delta,tau_s-delta]
  index=which((metro2010_basic$normalized_score>(metro2010_basic[[z]]+delta3)) &  (metro2010_basic$normalized_score<=(tau_s-delta3)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=10]
  
  #Part 3a: 0.5 if score \in (MID-delta,MID+delta] 
  index=which((metro2010_basic$normalized_score>(metro2010_basic[[z]]-delta3)) &  (metro2010_basic$normalized_score<=(metro2010_basic[[z]]+delta3)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=5]
  
  #Part 3a: 0.5 if score \in (tau_s-delta,tau_s+delta]
  index=which((metro2010_basic$normalized_score>(tau_s-delta3)) &  (metro2010_basic$normalized_score<=(tau_s+delta3)) & metro2010_basic[[z]]<tau_s  )
  metro2010_basic[index,eval(y):=5]
  
  # Get the normalized score - cutoff
  index=which(!is.na(metro2010_basic[[y]]))
  metro2010_basic[index,eval(r):=normalized_score-tau_s]
}

ColsBasicas=c("curp","nglobal","normalized_score",
              paste0("p_delta3_",SchoolList),
              paste0("r_delta3_",SchoolList))

metro2010_pdelta=metro2010_basic[,..ColsBasicas]

write_dta(metro2010_pdelta, path = "01_Data/02_Created/metro2010_pdelta3.dta", version = 15)
save(metro2010_pdelta, file = "01_Data/02_Created/metro2010_pdelta3.RData")
rm(metro2010_pdelta)

ColsBasicas=c(paste0("p_delta3_",SchoolList), paste0("r_delta3_",SchoolList))
metro2010_basic[,eval(ColsBasicas):=NULL]

