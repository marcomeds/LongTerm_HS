use "$output/metro_Reg_TODOS.dta", clear
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


global vars_outcomes ENLACE_ANY ENLACE_Privado_Un ENLACE_Privado p_esp_3 p_mat_3 Voto_Marcado* Suspencion_INE Death_INE Expired_INE bachillerato_mas licenciatura_mas Unemployed Housewife Selfemployed


reghdfe bachillerato_mas i.copc_asi c.nglobal##c.nglobal##c.nglobal##c.nglobal##c.nglobal , abs(strata_choice_year) vce(cluster curp)


reghdfe bachillerato_mas IPN_assig , abs(strata_pdelta1) vce(cluster curp)
reghdfe bachillerato_mas IPN_assig , abs(strata_IPN1) vce(cluster curp)
reghdfe bachillerato_mas IPN_assig  if var_IPN1!=. & var_IPN1!=0, abs(strata_IPN1) vce(cluster curp)
