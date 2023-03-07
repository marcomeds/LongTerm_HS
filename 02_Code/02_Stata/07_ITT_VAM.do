use "$output/metro_Reg_MARGINAL.dta", clear
gen Tipo=substr(cve_cct,3,1)
gen Secundaria_Privada=(Tipo=="P") if !missing(Tipo)
gen ENLACE_Privado=(substr(cct_3,3,1)=="P" | substr(cct_4,3,1)=="P") if (!missing(cct_3) | !missing(cct_4))

gen Voto_Marcado=(voto_2018==1)*100 if !missing(voto_2018)

label var age2018 "Age(2018)"
label var hombre "Male"
label var sus_prom "GPA (middle school)"
label var ano_cert "Middle school graduation"
label var edad_pad "Father's age"
label var edad_mad "Mother's age"
label var Secundaria_Privada "Private (middle school)"

label var age2018 "Age(2018)"
label var hombre "Male"
label var sus_prom "GPA (middle school)"
label var ano_cert "Middle school graduation"
label var edad_pad "Father's age"
label var edad_mad "Mother's age"


label var Voto_Marcado "Voted (2018)"

global vars_balance age2018  hombre Secundaria_Privada sus_prom ano_cert  edad_pad edad_mad

reghdfe Voto_Marcado i.copc_asi c.normalized_score##c.normalized_score##c.normalized_score##c.normalized_score##c.normalized_score if var_treat3!=. & var_treat3!=0, absorb(Total3 $vars_balance )
