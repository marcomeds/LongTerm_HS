use "$output/metro_Reg_Marginal.dta", clear
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

global vars_outcomes_ine Voto_Marcado* Suspencion_INE Death_INE Expired_INE bachillerato_mas licenciatura_mas Unemployed Housewife Selfemployed

*overall
eststo clear
qui my_ptest_strata $vars_outcomes if var_ELITE1!=. & var_ELITE1!=0, strata(strata_ELITE1) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_EffectNoRun_ELITE1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_ELITE1!=. & var_ELITE1!=0, strata(strata_ELITE1) clus_id(curp_short) treatment(Elite_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_ELITE1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_ELITE2!=. & var_ELITE2!=0, strata(strata_ELITE2) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_EffectNoRun_ELITE2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_ELITE2!=. & var_ELITE2!=0, strata(strata_ELITE2) clus_id(curp_short) treatment(Elite_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_ELITE2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_ELITE3!=. & var_ELITE3!=0, strata(strata_ELITE3) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_EffectNoRun_ELITE3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_ELITE3!=. & var_ELITE3!=0, strata(strata_ELITE3) clus_id(curp_short) treatment(Elite_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_ELITE3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")

		
		
		
		
****IPN

eststo clear
qui my_ptest_strata $vars_outcomes if var_IPN1!=. & var_IPN1!=0, strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_EffectNoRun_IPN1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_IPN1!=. & var_IPN1!=0, strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_IPN1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_IPN2!=. & var_IPN2!=0, strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_EffectNoRun_IPN2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_IPN2!=. & var_IPN2!=0, strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_IPN2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_IPN3!=. & var_IPN3!=0, strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_EffectNoRun_IPN3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_IPN3!=. & var_IPN3!=0, strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_IPN3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

				
****IPN if PRIVATE

eststo clear
qui my_ptest_strata $vars_outcomes if var_IPN1!=. & var_IPN1!=0 & Secundaria_Privada==1, strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_EffectNoRun_IPN1_Private.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_IPN1!=. & var_IPN1!=0 & Secundaria_Privada==1, strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_IPN1_Private.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_IPN2!=. & var_IPN2!=0 & Secundaria_Privada==1, strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_EffectNoRun_IPN2_Private.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_IPN2!=. & var_IPN2!=0 & Secundaria_Privada==1, strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_IPN2_Private.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_IPN3!=. & var_IPN3!=0 & Secundaria_Privada==1, strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_EffectNoRun_IPN3_Private.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_IPN3!=. & var_IPN3!=0 & Secundaria_Privada==1, strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_IPN3_Private.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		
		
****UNAM

eststo clear
qui my_ptest_strata  $vars_outcomes if var_UNAM1!=. & var_UNAM1!=0, strata(strata_UNAM1) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_EffectNoRun_UNAM1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_UNAM1!=. & var_UNAM1!=0, strata(strata_UNAM1) clus_id(curp_short) treatment(UNAM_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_UNAM1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_UNAM2!=. & var_UNAM2!=0, strata(strata_UNAM2) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_EffectNoRun_UNAM2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_UNAM2!=. & var_UNAM2!=0, strata(strata_UNAM2) clus_id(curp_short) treatment(UNAM_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_UNAM2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_outcomes if var_UNAM3!=. & var_UNAM3!=0, strata(strata_UNAM3) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_EffectNoRun_UNAM3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_outcomes if var_UNAM3!=. & var_UNAM3!=0, strata(strata_UNAM3) clus_id(curp_short) treatment(UNAM_assig) running(nglobal)
esttab  using "$tables/ITT_EffectRun_UNAM3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

		
****************
* INE Outcomes *
****************


*-------*
* Elite *
*-------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE1!=. & var_ELITE1!=0, strata(strata_ELITE1) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE2!=. & var_ELITE2!=0, strata(strata_ELITE2) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE3!=. & var_ELITE3!=0, strata(strata_ELITE3) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

*-----------*
* Elite TAU *
*-----------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE1!=. & var_ELITE1!=0 & !missing(r_tau_ELITE1), strata(strata_ELITE1) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE1_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE2!=. & var_ELITE2!=0 & !missing(r_tau_ELITE2), strata(strata_ELITE2) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE2_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE3!=. & var_ELITE3!=0 & !missing(r_tau_ELITE3), strata(strata_ELITE3) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE3_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

*-----------*
* Elite MID *
*-----------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE1!=. & var_ELITE1!=0 & !missing(r_mid_ELITE1), strata(strata_ELITE1) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE1_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE2!=. & var_ELITE2!=0 & !missing(r_mid_ELITE2), strata(strata_ELITE2) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE2_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_ELITE3!=. & var_ELITE3!=0 & !missing(r_mid_ELITE3), strata(strata_ELITE3) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_ELITE3_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
			
		
*-----*
* IPN *
*-----*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN1!=. & var_IPN1!=0, strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN2!=. & var_IPN2!=0, strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN3!=. & var_IPN3!=0, strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
*---------*
* IPN TAU *
*---------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN1!=. & var_IPN1!=0 & !missing(r_tau_IPN1), strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN1_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN2!=. & var_IPN2!=0 & !missing(r_tau_IPN2), strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN2_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN3!=. & var_IPN3!=0 & !missing(r_tau_IPN3), strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN3_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
*---------*
* IPN MID *
*---------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN1!=. & var_IPN1!=0 & !missing(r_mid_IPN1), strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN1_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN2!=. & var_IPN2!=0 & !missing(r_mid_IPN2), strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN2_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_IPN3!=. & var_IPN3!=0 & !missing(r_mid_IPN3), strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_IPN3_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
			
*------*
* UNAM *
*------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM1!=. & var_UNAM1!=0, strata(strata_UNAM1) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM2!=. & var_UNAM2!=0, strata(strata_UNAM2) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM3!=. & var_UNAM3!=0, strata(strata_UNAM3) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

*----------*
* UNAM TAU *
*----------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM1!=. & var_UNAM1!=0 & !missing(r_tau_UNAM1), strata(strata_UNAM1) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM1_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM2!=. & var_UNAM2!=0 & !missing(r_tau_UNAM2), strata(strata_UNAM2) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM2_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM3!=. & var_UNAM3!=0 & !missing(r_tau_UNAM3), strata(strata_UNAM3) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM3_tau.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
*----------*
* UNAM MID *
*----------*

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM1!=. & var_UNAM1!=0 & !missing(r_mid_UNAM1), strata(strata_UNAM1) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM1_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM2!=. & var_UNAM2!=0 & !missing(r_mid_UNAM2), strata(strata_UNAM2) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM2_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		

eststo clear
qui my_ptest_strata $vars_outcomes_ine if var_UNAM3!=. & var_UNAM3!=0 & !missing(r_mid_UNAM3), strata(strata_UNAM3) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/ITT_Effect_INE_NoRun_UNAM3_mid.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		


		