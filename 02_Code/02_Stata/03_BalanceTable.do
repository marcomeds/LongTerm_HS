use "$output/metro_Reg_Marginal.dta", clear
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



*overall
eststo clear
qui my_ptest_strata $vars_balance if var_ELITE1!=. & var_ELITE1!=0, strata(strata_ELITE1) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/Balance_NoRun_ELITE1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_ELITE1!=. & var_ELITE1!=0, strata(strata_ELITE1) clus_id(curp_short) treatment(Elite_assig) running(nglobal)
esttab  using "$tables/Balance_Run_ELITE1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_balance if var_ELITE2!=. & var_ELITE2!=0, strata(strata_ELITE2) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/Balance_NoRun_ELITE2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_ELITE2!=. & var_ELITE2!=0, strata(strata_ELITE2) clus_id(curp_short) treatment(Elite_assig) running(nglobal)
esttab  using "$tables/Balance_Run_ELITE2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_balance if var_ELITE3!=. & var_ELITE3!=0, strata(strata_ELITE3) clus_id(curp_short) treatment(Elite_assig)
esttab  using "$tables/Balance_NoRun_ELITE3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_ELITE3!=. & var_ELITE3!=0, strata(strata_ELITE3) clus_id(curp_short) treatment(Elite_assig) running(nglobal)
esttab  using "$tables/Balance_Run_ELITE3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")

		
		
		
		
****IPN

eststo clear
qui my_ptest_strata $vars_balance if var_IPN1!=. & var_IPN1!=0, strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/Balance_NoRun_IPN1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_IPN1!=. & var_IPN1!=0, strata(strata_IPN1) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/Balance_Run_IPN1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_balance if var_IPN2!=. & var_IPN2!=0, strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/Balance_NoRun_IPN2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_IPN2!=. & var_IPN2!=0, strata(strata_IPN2) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/Balance_Run_IPN2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_balance if var_IPN3!=. & var_IPN3!=0, strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig)
esttab  using "$tables/Balance_NoRun_IPN3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_IPN3!=. & var_IPN3!=0, strata(strata_IPN3) clus_id(curp_short) treatment(IPN_assig) running(nglobal)
esttab  using "$tables/Balance_Run_IPN3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		
			
****UNAM

eststo clear
qui my_ptest_strata $vars_balance if var_UNAM1!=. & var_UNAM1!=0, strata(strata_UNAM1) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/Balance_NoRun_UNAM1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_UNAM1!=. & var_UNAM1!=0, strata(strata_UNAM1) clus_id(curp_short) treatment(UNAM_assig) running(nglobal)
esttab  using "$tables/Balance_Run_UNAM1.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_balance if var_UNAM2!=. & var_UNAM2!=0, strata(strata_UNAM2) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/Balance_NoRun_UNAM2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_UNAM2!=. & var_UNAM2!=0, strata(strata_UNAM2) clus_id(curp_short) treatment(UNAM_assig) running(nglobal)
esttab  using "$tables/Balance_Run_UNAM2.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		

eststo clear
qui my_ptest_strata $vars_balance if var_UNAM3!=. & var_UNAM3!=0, strata(strata_UNAM3) clus_id(curp_short) treatment(UNAM_assig)
esttab  using "$tables/Balance_NoRun_UNAM3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))") 
		
		
eststo clear
qui my_ptest_strata_running $vars_balance if var_UNAM3!=. & var_UNAM3!=0, strata(strata_UNAM3) clus_id(curp_short) treatment(UNAM_assig) running(nglobal)
esttab  using "$tables/Balance_Run_UNAM3.tex", replace $stars			///
		cells("c_1(fmt(%9.2fc)) t_1(fmt(%9.2fc) star pvalue(p_1))" "cse_1(fmt(%9.2fc) par) tse_1(fmt(%9.2fc) par)" "cN_1(par([ ]) fmt(%9.0gc)) tN_1(par([ ]) fmt(%9.0gc))")
		
		