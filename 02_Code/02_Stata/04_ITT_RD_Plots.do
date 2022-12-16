use "$output/metro_Reg_MARGINAL.dta", clear
gen Tipo=substr(cve_cct,3,1)
gen Secundaria_Privada=(Tipo=="P") if !missing(Tipo)
gen ENLACE_Privado=100*(substr(cct_3,3,1)=="P" | substr(cct_4,3,1)=="P") if (!missing(cct_3) | !missing(cct_4))
gen ENLACE_Privado_Un=100*(substr(cct_3,3,1)=="P" | substr(cct_4,3,1)=="P")
gen Voto_Marcado_2012=(voto_2012=="S")*100 
gen Voto_Marcado_2015=(voto_2015==1)*100 
gen Voto_Marcado_2018=(voto_2018==1)*100 

egen ENLACE_ANY=rowmax(ENLACE_3 ENLACE_4)
replace ENLACE_ANY=ENLACE_ANY*100

gen Suspencion_INE=(tipo_baja_INE=="SUSPENSION")*100 
gen Death_INE=(tipo_baja_INE=="DEFUNCION")*100 
gen Expired_INE=(tipo_baja_INE=="PERDIDA DE VIGENCIA")*100 

gen bachillerato_mas=100*(escolaridad_2018=="LICENCIATURA" | escolaridad_2018=="POSGRADO O DOCTORADO" | escolaridad_2018=="TECNICO" | escolaridad_2018=="BACHILLERATO") if !missing(escolaridad_2018)
								
gen licenciatura_mas=100*(escolaridad_2018=="LICENCIATURA" | escolaridad_2018=="POSGRADO O DOCTORADO") if !missing(escolaridad_2018)


gen Unemployed=100*(ocupacion_2018=="DESEMPLEADO") if !missing(ocupacion_2018)
gen Housewife=100*(ocupacion_2018=="AMA DE CASA") if !missing(ocupacion_2018)
gen Selfemployed=100*(ocupacion_2018=="TRABAJADOR POR SU CUENTA") if !missing(ocupacion_2018)


label var age2018 "Age(2018)"
label var hombre "Male"
label var sus_prom "GPA (middle school)"
label var ano_cert "Middle school graduation"
label var edad_pad "Father's age"
label var edad_mad "Mother's age"


label var ENLACE_Privado_Un "Graduated from private (\%)"
label var ENLACE_Privado "Grad from private (\%)  \$|\$ Grad"
label var ENLACE_ANY "Graduated (\%)"
label var p_esp_3 "Spanish (ENLACE  \$|\$ Grad)"
label var p_mat_3 "Math (ENLACE  \$|\$ Grad)"
label var Voto_Marcado_2018 "\% Voted (2018)"
label var Voto_Marcado_2015 "\% Voted (2015)"
label var Voto_Marcado_2012 "\% Voted (2012)"


label var Suspencion_INE "\% Crime (INE)"
label var Death_INE "\% Death (INE)"
label var Expired_INE "\% INE expired"

label var bachillerato_mas "\% Completed HS"
label var licenciatura_mas "\% Post-secondary education"
label var Unemployed "\% Unemployed"
label var Housewife "\% Housewife"
label var Selfemployed "\% Self-employed"


global vars_outcomes ENLACE_ANY ENLACE_Privado_Un ENLACE_Privado p_esp_3 p_mat_3 Voto_Marcado_2012 Voto_Marcado_2015 Voto_Marcado_2018 Suspencion_INE Death_INE Expired_INE bachillerato_mas licenciatura_mas Unemployed Housewife Selfemployed

* Remove invalid values from running variables
replace r_mid_ELITE3 = . if inlist(r_mid_ELITE3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_ELITE3 = . if inlist(r_tau_ELITE3, -3, -2, -1, 0, 1, 2, 3)

replace r_mid_IPN3 = . if inlist(r_mid_IPN3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_IPN3 = . if inlist(r_tau_IPN3, -3, -2, -1, 0, 1, 2, 3)

replace r_mid_UNAM3 = . if inlist(r_mid_UNAM3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_UNAM3 = . if inlist(r_tau_UNAM3, -3, -2, -1, 0, 1, 2, 3)

*overall
foreach var in $vars_outcomes {
	
	my_rdplot_mid `var' r_mid_ELITE3
	graph export "$figures/rd_plot_mid_`var'_pdelta3.pdf", replace
	
	my_rdplot_tau `var' r_tau_ELITE3
	graph export "$figures/rd_plot_tau_`var'_pdelta3.pdf", replace
	
}

*IPN
foreach var in $vars_outcomes {
	
	my_rdplot_mid `var' r_mid_IPN3
	graph export "$figures/rd_plot_mid_`var'_IPN3.pdf", replace
	
	my_rdplot_tau `var' r_tau_IPN3
	graph export "$figures/rd_plot_tau_`var'_IPN3.pdf", replace
	
}

*UNAM
foreach var in $vars_outcomes {
	
	my_rdplot_mid `var' r_mid_UNAM3
	graph export "$figures/rd_plot_mid_`var'_UNAM3.pdf", replace
	
	my_rdplot_tau `var' r_tau_UNAM3
	graph export "$figures/rd_plot_tau_`var'_UNAM3.pdf", replace
	
}
