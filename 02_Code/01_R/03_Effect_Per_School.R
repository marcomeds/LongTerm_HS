rm(list=ls())
metro2005_original=read.dta13("RawData/COMIPEMS_CURP/metro_2005/metro2005.dta")
metro2005_fixed=read.dta13("CreatedData/metro2005_Fixed.dta")
metro2005_MID=read.dta13("CreatedData/metro2005_MID.dta")
metro2005_pdelta=read.dta13("CreatedData/metro2005_pdelta.dta")
CutOff_School_2005=read.dta13("CreatedData/CutOff_School_2005.dta")

M08=read.dta13("RawData/ENLACE/M08.dta")
M09=read.dta13("RawData/ENLACE/M09.dta")

metro2005_original=setDT(metro2005_original)
metro2005_fixed=setDT(metro2005_fixed)
metro2005_MID=setDT(metro2005_MID)
metro2005_pdelta=setDT(metro2005_pdelta)
CutOff_School_2005=setDT(CutOff_School_2005)
M08=setDT(M08)
M09=setDT(M09)


metro2005_original[, N:=.N, by=curp]
unique=metro2005_original$curp[metro2005_original$N==1]
metro2005_original=metro2005_original[curp %in% unique,]
metro2005_fixed=metro2005_fixed[curp %in% unique,]
metro2005_MID=metro2005_MID[curp %in% unique,]
metro2005_pdelta=metro2005_pdelta[curp %in% unique,]

ENLACE=rbind(M08,M09)
CURP_ENLACE=unique(ENLACE$curp)

SchoolList=sort(unique(CutOff_School_2005$school_code))
RESULTADO=NULL
for(sc_temp in SchoolList){
  y = paste0("p_delta2_",sc_temp)
  CURP_margin=metro2005_pdelta$curp[which(metro2005_pdelta[[y]]==0.5)]
  resultado=c(NA,NA,NA,NA)
  Treated=(metro2005_original$copc_asi[match(CURP_margin,metro2005_original$curp)]==sc_temp)
  Outcome=(CURP_margin %in% CURP_ENLACE)
  if(length(Treated)>1 & mean(Treated)!=0 & mean(Treated)!=1){
  model=summary(lm(Outcome~Treated,model=F,x=F,y=F))
  resultado=c(model$coefficients[1,1],model$coefficients[1,2],
             model$coefficients[2,1],model$coefficients[2,2])
  }

  RESULTADO=rbind(RESULTADO,resultado)
}
INDEX_IPN=which(substr(SchoolList,1,1)=="5")
INDEX_UNAM=which(substr(SchoolList,1,1)=="6")

hist(RESULTADO[,3],freq =F,breaks =seq(-1,1,0.1))
hist(RESULTADO[INDEX_IPN,3],col=rgb(1,0,0,0.5),add=T,freq =F,breaks =seq(-1,1,0.1))

#hist(RESULTADO[INDEX_UNAM,3],col=rgb(0,0,1,0.5),add=T,freq =F,breaks =seq(-1,1,0.1))


Prop=RESULTADO[,3]/RESULTADO[,1]
Prop[Prop==-Inf]=NA
Prop[Prop>quantile(Prop,na.rm=T,prob=0.95)]=NA
Prop[Prop<quantile(Prop,na.rm=T,prob=0.05)]=NA
hist(Prop,freq =F,breaks =seq(-1,3.5,0.1))
hist(Prop[INDEX_IPN],col=rgb(1,0,0,0.5),add=T,freq =F,breaks=seq(-1,3.5,0.1))






