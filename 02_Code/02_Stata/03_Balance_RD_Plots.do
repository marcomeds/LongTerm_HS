use "$output/metro_Reg_plots.dta", clear
gen Tipo=substr(cve_cct,3,1)
gen Secundaria_Privada=(Tipo=="P") if !missing(Tipo)
gen ENLACE_Privado=(substr(cct_3,3,1)=="P" | substr(cct_4,3,1)=="P") if (!missing(cct_3) | !missing(cct_4))

label var age2018 "Age(2018)"
label var hombre "Male"
label var sus_prom "GPA (middle school)"
label var ano_cert "Middle school graduation"
label var edad_pad "Father's age"
label var edad_mad "Mother's age"
label var Secundaria_Privada "Private (middle school)"

global vars_balance age2018  hombre Secundaria_Privada sus_prom ano_cert  edad_pad edad_mad

* Remove invalid values from running variables
replace r_mid_ELITE3 = . if inlist(r_mid_ELITE3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_ELITE3 = . if inlist(r_tau_ELITE3, -3, -2, -1, 0, 1, 2, 3)

replace r_mid_IPN3 = . if inlist(r_mid_IPN3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_IPN3 = . if inlist(r_tau_IPN3, -3, -2, -1, 0, 1, 2, 3)

replace r_mid_UNAM3 = . if inlist(r_mid_UNAM3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_UNAM3 = . if inlist(r_tau_UNAM3, -3, -2, -1, 0, 1, 2, 3)

*overall
foreach var in $vars_balance {
	
	my_rdplot_mid `var' r_mid_ELITE3
	graph export "$figures/rd_plot_mid_`var'_ELITE3.pdf", replace
	
	my_rdplot_tau `var' r_tau_ELITE3
	graph export "$figures/rd_plot_tau_`var'_ELITE3.pdf", replace
	
}

*IPN
foreach var in $vars_balance {
	
	my_rdplot_mid `var' r_mid_IPN3
	graph export "$figures/rd_plot_mid_`var'_IPN3.pdf", replace
	
	my_rdplot_tau `var' r_tau_IPN3
	graph export "$figures/rd_plot_tau_`var'_IPN3.pdf", replace
	
}

*UNAM
foreach var in $vars_balance {
	
	my_rdplot_mid `var' r_mid_UNAM3
	graph export "$figures/rd_plot_mid_`var'_UNAM3.pdf", replace
	
	my_rdplot_tau `var' r_tau_UNAM3
	graph export "$figures/rd_plot_tau_`var'_UNAM3.pdf", replace
	
}
