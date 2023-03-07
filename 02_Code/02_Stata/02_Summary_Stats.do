use "$output/metro_Reg.dta", clear
drop if expl_asi == "BI" | expl_asi == "SC"

gen hombre=(sus_sexo=="H")
gen copc_asi_string = string(copc_asi,"%06.0f")
gen IPN_assig=(substr(copc_asi_string,1,1)=="5")
gen UNAM_assig=(substr(copc_asi_string,1,1)=="6")
gen Elite_assig=UNAM_assig+IPN_assig
gen perc_score = nglobal / 128

label var nopc_sol "Num. requested schools"
label var perc_score "Test score (\%)"
label var hombre "Male"
label var IPN_assig "IPN assignment"
label var UNAM_assig "UNAM assignment"
label var Elite_assig "Elite assignment"
label var anho "Cohort"

global vars_summ_stats nopc_sol perc_score hombre IPN_assig UNAM_assig Elite_assig

est clear
* Create summary statistics table for COMIPEMS data
foreach ano in 2005 2006 2007 2008 2009 2010{
	eststo grp`ano': estpost summ $vars_summ_stats if anho == `ano'	
}

esttab grp* using "$tables/summ_stats.tex" , replace ///
main(mean %6.2f) aux(sd %6.2f) mtitle("2005" "2006" "2007" "2008" "2009" "2010") ///
label nonotes nonum fragment stats(N, labels("Applicants") fmt(%9.0fc))
