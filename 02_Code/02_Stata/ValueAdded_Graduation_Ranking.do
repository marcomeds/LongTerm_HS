use "$output/metro`ano'_pdelta2.dta", clear
	replace curp = stritrim(curp)
	replace curp = strtrim(curp)
	replace curp = subinstr(curp, " ", "", .)
	gen length_curp=strlen(curp)
	drop if length_curp!=16
	bys curp: gen N=_N
	drop if N>1
	drop N
	gen curp_short=curp


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


reghdfe ENLACE_ANY i.copc_asi, abs()
