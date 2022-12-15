use "$output/metro_Reg_MARGINAL.dta", clear
gen Tipo=substr(cve_cct,3,1)
gen Secundaria_Privada=(Tipo=="P") if !missing(Tipo)
gen ENLACE_Privado=(substr(cct_grado,3,1)=="P") if !missing(cct_grado)
gen ENLACE_Privado_Un=(substr(cct_grado,3,1)=="P") 
gen Voto_Marcado=(voto_2018==1)*100 if !missing(voto_2018)


label var age2018 "Age(2018)"
label var hombre "Male"
label var sus_prom "GPA (middle school)"
label var ano_cert "Middle school graduation"
label var edad_pad "Father's age"
label var edad_mad "Mother's age"

label var ENLACE_Privado "Graduated from private  \$|\$ Graduation"
label var ENLACE_Privado_Un "Graduated from private"
label var ENLACE_ANY "Graduated (measured by ENLACE)"
label var p_esp "Spanish (ENLANCE  \$|\$ Graduation)"
label var p_mat "Math (ENLANCE  \$|\$ Graduation)"
label var Voto_Marcado "Voted (2018)"

*overall
eststo clear
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN1!=. & var_IPN1!=0, abs(strata_IPN1) cluster(curp_short)
estadd ysumm
estadd scalar Ftest=e(widstat)
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN2!=. & var_IPN2!=0, abs(strata_IPN2) cluster(curp_short)
estadd scalar Ftest=e(widstat)
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN3!=. & var_IPN3!=0, abs(strata_IPN3) cluster(curp_short)
estadd scalar Ftest=e(widstat)

esttab  using "$tables/LATE_Overall_Voted.tex", se ar2 booktabs label b(%9.2gc) se(%9.2gc) nocon nonumber /// 
star(* 0.10 ** 0.05 *** 0.01) fragment ///
replace mlabels(none)  collabels(none) nogaps nolines ///
keep(ENLACE_Privado_Un) ///
stats(N  Ftest, fmt(%9.0gc %9.2gc) ///
labels("N. of obs." "F test (first stage)"))

*private
eststo clear
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN1!=. & var_IPN1!=0 & Secundaria_Privada==1, abs(strata_IPN1) cluster(curp_short)
estadd scalar Ftest=e(widstat)
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN2!=. & var_IPN2!=0 & Secundaria_Privada==1, abs(strata_IPN2) cluster(curp_short)
estadd scalar Ftest=e(widstat)
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN3!=. & var_IPN3!=0 & Secundaria_Privada==1, abs(strata_IPN3) cluster(curp_short)
estadd scalar Ftest=e(widstat)

esttab  using "$tables/LATE_Private_Voted.tex", se ar2 booktabs label b(%9.2gc) se(%9.2gc) nocon nonumber /// 
star(* 0.10 ** 0.05 *** 0.01) fragment ///
replace mlabels(none)  collabels(none) nogaps nolines ///
keep(ENLACE_Privado_Un) ///
stats(N  Ftest, fmt(%9.0gc %9.2gc) ///
labels("N. of obs." "F test (first stage)"))


*public
eststo clear
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN1!=. & var_IPN1!=0 & Secundaria_Privada==0, abs(strata_IPN1) cluster(curp_short)
estadd scalar Ftest=e(widstat)
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN2!=. & var_IPN2!=0 & Secundaria_Privada==0, abs(strata_IPN2) cluster(curp_short)
estadd scalar Ftest=e(widstat)
eststo:ivreghdfe Voto_Marcado (ENLACE_Privado_Un=IPN_assig) if var_IPN3!=. & var_IPN3!=0 & Secundaria_Privada==0, abs(strata_IPN3) cluster(curp_short)
estadd scalar Ftest=e(widstat)


esttab  using "$tables/LATE_Public_Voted.tex", se ar2 booktabs label b(%9.2gc) se(%9.2gc) nocon nonumber /// 
star(* 0.10 ** 0.05 *** 0.01) fragment ///
replace mlabels(none)  collabels(none) nogaps nolines ///
keep(ENLACE_Privado_Un) ///
stats(N  Ftest, fmt(%9.0gc %9.2gc) ///
labels("N. of obs." "F test (first stage)"))
