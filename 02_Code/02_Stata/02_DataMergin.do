clear
gen anho=.
foreach ano in 2005 2006 2007 2008 2009 2010{
	append using "$output/metro_`ano'_ENLACE.dta", keep(registro curp folio opc_ed01- opc_ed20)
	replace anho=`ano' if anho==.
	compress
}
replace curp = stritrim(curp)
	replace curp = strtrim(curp)
	replace curp = subinstr(curp, " ", "", .)
	gen length_curp=strlen(curp)
	drop if length_curp!=16
	bys anho curp: gen N=_N
	drop if N>1
	drop N length_curp
	egen strata_choice_year=group(anho opc_ed01- opc_ed20), missing
	egen strata_choice=group(opc_ed01- opc_ed20), missing
	gen curp_short=curp
	keep registro curp folio curp_short strata_choice strata_choice_year anho
	destring folio, replace force
drop if folio==.
save "$output/strata_choices", replace	

	
foreach ano in 2005 2006 2007 2008 2009 2010{
	use "$output/metro`ano'_pdelta1.dta", clear
	replace curp = stritrim(curp)
	replace curp = strtrim(curp)
	replace curp = subinstr(curp, " ", "", .)
	gen length_curp=strlen(curp)
	drop if length_curp!=16
	bys curp: gen N=_N
	drop if N>1
	drop N
	gen curp_short=curp
	gegen Total1=rowtotal(p_delta1_5* p_delta1_6*),missing
	gegen Total_IPN1=rowtotal(p_delta1_5*),missing
	gegen Total_UNAM1=rowtotal(p_delta1_6*),missing
	
	* This next section finds the minimum running variable for each obs
	* An observation can have several running variables because its around the cuttoff or MID of several schools (cutoff - score and/or MID - score)
	* We take the minimum in absolute value (the one closest to the MID)
	unab r_mid_delta1_all: r_mid_delta1*
	foreach r_mid_delta1 of local r_mid_delta1_all{
		gen abs_`r_mid_delta1'=abs(`r_mid_delta1')
	}
	gegen r_mid_IPN1=rowmin(abs_r_mid_delta1_5*)
	gegen r_mid_UNAM1=rowmin(abs_r_mid_delta1_6*)
	gegen r_mid_ELITE1=rowmin(r_mid_IPN1 r_mid_UNAM1)
	unab r_mid_delta1_IPN: r_mid_delta1_5*
	foreach r_mid_delta1 of local r_mid_delta1_IPN{
		replace r_mid_IPN1=`r_mid_delta1' if r_mid_IPN1 == abs_`r_mid_delta1'
	}
	unab r_mid_delta1_UNAM: r_mid_delta1_6*
	foreach r_mid_delta1 of local r_mid_delta1_UNAM{
		replace r_mid_UNAM1=`r_mid_delta1' if r_mid_UNAM1 == abs_`r_mid_delta1'
	}
	replace r_mid_ELITE1=r_mid_IPN1 if r_mid_ELITE1 == abs(r_mid_IPN1)
	replace r_mid_ELITE1=r_mid_UNAM1 if r_mid_ELITE1 == abs(r_mid_UNAM1)
	
	* We take the minimum in absolute value (the one closest to the cutoff)
	unab r_tau_delta1_all: r_tau_delta1*
	foreach r_tau_delta1 of local r_tau_delta1_all{
		gen abs_`r_tau_delta1'=abs(`r_tau_delta1')
	}
	gegen r_tau_IPN1=rowmin(abs_r_tau_delta1_5*)
	gegen r_tau_UNAM1=rowmin(abs_r_tau_delta1_6*)
	gegen r_tau_ELITE1=rowmin(r_tau_IPN1 r_tau_UNAM1)
	unab r_tau_delta1_IPN: r_tau_delta1_5*
	foreach r_tau_delta1 of local r_tau_delta1_IPN{
		replace r_tau_IPN1=`r_tau_delta1' if r_tau_IPN1 == abs_`r_tau_delta1'
	}
	unab r_tau_delta1_UNAM: r_tau_delta1_6*
	foreach r_tau_delta1 of local r_tau_delta1_UNAM{
		replace r_tau_UNAM1=`r_tau_delta1' if r_tau_UNAM1 == abs_`r_tau_delta1'
	}
	replace r_tau_ELITE1=r_tau_IPN1 if r_tau_ELITE1 == abs(r_tau_IPN1)
	replace r_tau_ELITE1=r_tau_UNAM1 if r_tau_ELITE1 == abs(r_tau_UNAM1)
	
	keep curp nglobal normalized_score curp_short Total1 Total_IPN1 Total_UNAM1 p_delta1_* ///
	r_mid_delta1_5* r_mid_delta1_6* r_mid_IPN1 r_mid_UNAM1 r_mid_ELITE1 ///
	r_tau_delta1_5* r_tau_delta1_6* r_tau_IPN1 r_tau_UNAM1 r_tau_ELITE1
	tempfile temp1
	save `temp1', replace


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
	gegen Total2=rowtotal(p_delta2_5* p_delta2_6*),missing
	gegen Total_IPN2=rowtotal(p_delta2_5*),missing
	gegen Total_UNAM2=rowtotal(p_delta2_6*),missing
	
	* This next section finds the minimum running variable for each obs
	* An observation can have several running variables because its around the cuttoff or MID of several schools (cutoff - score and/or MID - score)
	* We take the minimum in absolute value (the one closest to the MID)
	unab r_mid_delta2_all: r_mid_delta2*
	foreach r_mid_delta2 of local r_mid_delta2_all{
		gen abs_`r_mid_delta2'=abs(`r_mid_delta2')
	}
	gegen r_mid_IPN2=rowmin(abs_r_mid_delta2_5*)
	gegen r_mid_UNAM2=rowmin(abs_r_mid_delta2_6*)
	gegen r_mid_ELITE2=rowmin(r_mid_IPN2 r_mid_UNAM2)
	unab r_mid_delta2_IPN: r_mid_delta2_5*
	foreach r_mid_delta2 of local r_mid_delta2_IPN{
		replace r_mid_IPN2=`r_mid_delta2' if r_mid_IPN2 == abs_`r_mid_delta2'
	}
	unab r_mid_delta2_UNAM: r_mid_delta2_6*
	foreach r_mid_delta2 of local r_mid_delta2_UNAM{
		replace r_mid_UNAM2=`r_mid_delta2' if r_mid_UNAM2 == abs_`r_mid_delta2'
	}
	replace r_mid_ELITE2=r_mid_IPN2 if r_mid_ELITE2 == abs(r_mid_IPN2)
	replace r_mid_ELITE2=r_mid_UNAM2 if r_mid_ELITE2 == abs(r_mid_UNAM2)
	
	* We take the minimum in absolute value (the one closest to the cutoff)
	unab r_tau_delta2_all: r_tau_delta2*
	foreach r_tau_delta2 of local r_tau_delta2_all{
		gen abs_`r_tau_delta2'=abs(`r_tau_delta2')
	}
	gegen r_tau_IPN2=rowmin(abs_r_tau_delta2_5*)
	gegen r_tau_UNAM2=rowmin(abs_r_tau_delta2_6*)
	gegen r_tau_ELITE2=rowmin(r_tau_IPN2 r_tau_UNAM2)
	unab r_tau_delta2_IPN: r_tau_delta2_5*
	foreach r_tau_delta2 of local r_tau_delta2_IPN{
		replace r_tau_IPN2=`r_tau_delta2' if r_tau_IPN2 == abs_`r_tau_delta2'
	}
	unab r_tau_delta2_UNAM: r_tau_delta2_6*
	foreach r_tau_delta2 of local r_tau_delta2_UNAM{
		replace r_tau_UNAM2=`r_tau_delta2' if r_tau_UNAM2 == abs_`r_tau_delta2'
	}
	replace r_tau_ELITE2=r_tau_IPN2 if r_tau_ELITE2 == abs(r_tau_IPN2)
	replace r_tau_ELITE2=r_tau_UNAM2 if r_tau_ELITE2 == abs(r_tau_UNAM2)
	
	keep curp nglobal normalized_score curp_short Total2 Total_IPN2 Total_UNAM2 p_delta2_* ///
	r_mid_delta2_5* r_mid_delta2_6* r_mid_IPN2 r_mid_UNAM2 r_mid_ELITE2 ///
	r_tau_delta2_5* r_tau_delta2_6* r_tau_IPN2 r_tau_UNAM2 r_tau_ELITE2
	tempfile temp2
	save `temp2', replace

	use "$output/metro`ano'_pdelta3.dta", clear
	replace curp = stritrim(curp)
	replace curp = strtrim(curp)
	replace curp = subinstr(curp, " ", "", .)
	gen length_curp=strlen(curp) 
	drop if length_curp!=16
	bys curp: gen N=_N
	drop if N>1
	drop N
	gen curp_short=curp
	gegen Total3=rowtotal(p_delta3_5* p_delta3_6*),missing
	gegen Total_IPN3=rowtotal(p_delta3_5*),missing
	gegen Total_UNAM3=rowtotal(p_delta3_6*),missing
	
	* This next section finds the minimum running variable for each obs
	* An observation can have several running variables because its around the cuttoff or MID of several schools (cutoff - score and/or MID - score)
	* We take the minimum in absolute value (the one closest to the MID)
	unab r_mid_delta3_all: r_mid_delta3*
	foreach r_mid_delta3 of local r_mid_delta3_all{
		gen abs_`r_mid_delta3'=abs(`r_mid_delta3')
	}
	gegen r_mid_IPN3=rowmin(abs_r_mid_delta3_5*)
	gegen r_mid_UNAM3=rowmin(abs_r_mid_delta3_6*)
	gegen r_mid_ELITE3=rowmin(r_mid_IPN3 r_mid_UNAM3)
	unab r_mid_delta3_IPN: r_mid_delta3_5*
	foreach r_mid_delta3 of local r_mid_delta3_IPN{
		replace r_mid_IPN3=`r_mid_delta3' if r_mid_IPN3 == abs_`r_mid_delta3'
	}
	unab r_mid_delta3_UNAM: r_mid_delta3_6*
	foreach r_mid_delta3 of local r_mid_delta3_UNAM{
		replace r_mid_UNAM3=`r_mid_delta3' if r_mid_UNAM3 == abs_`r_mid_delta3'
	}
	replace r_mid_ELITE3=r_mid_IPN3 if r_mid_ELITE3 == abs(r_mid_IPN3)
	replace r_mid_ELITE3=r_mid_UNAM3 if r_mid_ELITE3 == abs(r_mid_UNAM3)
	
	* We take the minimum in absolute value (the one closest to the cutoff)
	unab r_tau_delta3_all: r_tau_delta3*
	foreach r_tau_delta3 of local r_tau_delta3_all{
		gen abs_`r_tau_delta3'=abs(`r_tau_delta3')
	}
	gegen r_tau_IPN3=rowmin(abs_r_tau_delta3_5*)
	gegen r_tau_UNAM3=rowmin(abs_r_tau_delta3_6*)
	gegen r_tau_ELITE3=rowmin(r_tau_IPN3 r_tau_UNAM3)
	unab r_tau_delta3_IPN: r_tau_delta3_5*
	foreach r_tau_delta3 of local r_tau_delta3_IPN{
		replace r_tau_IPN3=`r_tau_delta3' if r_tau_IPN3 == abs_`r_tau_delta3'
	}
	unab r_tau_delta3_UNAM: r_tau_delta3_6*
	foreach r_tau_delta3 of local r_tau_delta3_UNAM{
		replace r_tau_UNAM3=`r_tau_delta3' if r_tau_UNAM3 == abs_`r_tau_delta3'
	}
	replace r_tau_ELITE3=r_tau_IPN3 if r_tau_ELITE3 == abs(r_tau_IPN3)
	replace r_tau_ELITE3=r_tau_UNAM3 if r_tau_ELITE3 == abs(r_tau_UNAM3)
	
	keep curp nglobal normalized_score curp_short Total3 Total_IPN3 Total_UNAM3 p_delta3_* ///
	r_mid_delta3_5* r_mid_delta3_6* r_mid_IPN3 r_mid_UNAM3 r_mid_ELITE3 ///
	r_tau_delta3_5* r_tau_delta3_6* r_tau_IPN3 r_tau_UNAM3 r_tau_ELITE3
	tempfile temp3
	save `temp3', replace



	use "$output/metro_`ano'_ENLACE", clear
	keep  registro examino  curp cve_cct mun_cct folio sus_fnac cve_entnac sus_sexo sus_cp sus_prom sus_turn ano_cert edad_pad edad_mad nglobal- pnbio expl_asi nopc_sol nopc_asi copc_asi curp_short cct_* p_esp_* p_mat_* ENLACE_*
	merge 1:1 curp_short using `temp1'
	drop if _merge!=3
	drop _merge
	merge 1:1 curp_short using `temp2'
	drop if _merge!=3
	drop _merge
	merge 1:1 curp_short using `temp3'
	drop if _merge!=3
	drop _merge
	

	destring, replace
	destring edad_pad edad_mad ano_cert, replace force
	gen anho=`ano'
	compress
	save "$output/metro_`ano'_Reg", replace
	

}

use "$output/metro_2005_Reg", clear
destring edad_pad edad_mad, replace force
append using "$output/metro_2006_Reg"
append using "$output/metro_2007_Reg"
append using "$output/metro_2008_Reg"
append using "$output/metro_2009_Reg"
append using "$output/metro_2010_Reg"
save "$output/metro_Reg", replace


***GET ID CIUDADANO
import delim "$input/03_INE/CIUDADANO_ID_CROSSOVER/CIUDADANO_ID_CROSSOVER.txt", clear
rename  opc_edu folio
keep ciudadano_id anho  folio
merge 1:1 folio anho using "$output/metro_Reg"
drop if _merge!=3
drop _merge
destring ciudadano_id, replace
compress
save "$output/metro_Reg", replace


***ESTE CODIGO ES MUY lento, solo correrlo una vez
/*


import delim "$input/Padron/lndef_2018_nacional.txt", clear
rename v1 ciudadano_id
rename v8 localidad_2018
rename v9 manzana_2018
rename v10 inscripcion_ine_2018
rename v11 entidad_2018
rename v15 anhos_residencia_2018
rename v17 ocupacion_id_2018
rename v18 ocupacion_2018
rename v19 escolaridad_id_2018
rename v20 escolaridad_2018
rename v21 voto_2018
keep ciudadano_id localidad_2018 manzana_2018 inscripcion_ine_2018 entidad_2018 anhos_residencia_2018 ocupacion_id_2018 ocupacion_2018 escolaridad_id_2018 escolaridad_2018 voto_2018 v4
*to speed things up keep only those born between 1975 and 2005 (this is over 99.9% of the COMIPEMS data)
gen ano=substr(v4,7,4)
destring ano, replace
keep if ano>=1975 & ano<=2005
drop ano
drop v4

compress
hashsort ciudadano_id
save "$output/Padron2018", replace


import delim "$input/Padron/PADRON_2015_ITAM.txt", clear
rename v1 ciudadano_id
rename v8 localidad_2015
rename v9 manzana_2015
rename v10 inscripcion_ine_2015
rename v11 entidad_2015
rename v15 anhos_residencia_2015
rename v17 ocupacion_id_2015
rename v18 ocupacion_2015
rename v19 escolaridad_id_2015
rename v20 escolaridad_2015
rename v21 voto_2015
keep ciudadano_id localidad_2015 manzana_2015 inscripcion_ine_2015 entidad_2015 anhos_residencia_2015 ocupacion_id_2015 ocupacion_2015 escolaridad_id_2015 escolaridad_2015 voto_2015 v4
*to speed things up keep only those born between 1975 and 2005 (this is over 99.9% of the COMIPEMS data)
gen ano=substr(v4,7,4)
destring ano, replace
keep if ano>=1975 & ano<=2005
drop ano
drop v4

compress
hashsort ciudadano_id
save "$output/Padron2015", replace


import delim "$input/Padron/padron_completo_2012.txt", clear
rename v1 ciudadano_id
rename v8 localidad_2012
rename v9 manzana_2012
rename v10 inscripcion_ine_2012
rename v11 entidad_2012
rename v15 anhos_residencia_2012
rename v17 ocupacion_id_2012
rename v18 ocupacion_2012
rename v19 escolaridad_id_2012
rename v20 escolaridad_2012
rename v21 voto_2012
keep ciudadano_id localidad_2012 manzana_2012 inscripcion_ine_2012 entidad_2012 anhos_residencia_2012 ocupacion_id_2012 ocupacion_2012 escolaridad_id_2012 escolaridad_2012 voto_2012 v4
*to speed things up keep only those born between 1975 and 2005 (this is over 99.9% of the COMIPEMS data)
gen ano=substr(v4,7,4)
destring ano, replace
keep if ano>=1975 & ano<=2005
drop ano
drop v4

compress
hashsort ciudadano_id
save "$output/Padron2012", replace

import delim "$input/Padron/bajas_ITAM_310520.txt", clear
drop claveunicaciudadano_id
gen fecha_baja2 = date(fecha_baja, "DMY",2021)
format fecha_baja2 %td 
drop fecha_baja
rename fecha_baja2 fecha_baja
compress
fsort ciudadano_id
rename tipo_baja tipo_baja_INE
rename fecha_baja fecha_baja_INE
drop if ciudadano_id==.
fsort ciudadano_id fecha_baja_INE

gduplicates drop  ciudadano_id tipo_baja_INE fecha_baja_INE, force 
by ciudadano_id fecha_baja_INE: gen N=_N
by ciudadano_id fecha_baja_INE: gen n=_n
*many cases, same date, often migracion vs defuncion
*going to delete them
drop if N==2
drop N n

by ciudadano_id : gen N=_N
by ciudadano_id : gen n=_n
drop if n>1
drop N n
compress
save "$output/bajas_ITAM_310520", replace

*/


use "$output/metro_Reg", clear
hashsort ciudadano_id
fmerge m:1 ciudadano_id using "$output/Padron2018",  nolabel nonotes keep(1 3)
gen Padron2018=(_merge==3)
drop _merge
fmerge m:1 ciudadano_id using "$output/Padron2015",  nolabel nonotes keep(1 3)
gen Padron2015=(_merge==3)
drop _merge
fmerge m:1 ciudadano_id using "$output/Padron2012",  nolabel nonotes keep(1 3)
gen Padron2012=(_merge==3)
drop _merge
compress
save "$output/metro_Reg", replace





use "$output/metro_Reg", clear
fmerge m:1 ciudadano_id using "$output/bajas_ITAM_310520",  nolabel nonotes keep(1 3)
gen Bajas2020=(_merge==3)
drop _merge
compress
save "$output/metro_Reg", replace



* Create database for RD_plots
use "$output/metro_Reg.dta", clear

gen age2018 = (td(1jan2018)-sus_fnac)/365.25
replace age2018=. if age2018<0
gen hombre=(sus_sexo=="H")
gen copc_asi_string = string(copc_asi,"%06.0f")
gen IPN_assig=(substr(copc_asi_string,1,1)=="5")
gen UNAM_assig=(substr(copc_asi_string,1,1)=="6")
gen Elite_assig=UNAM_assig+IPN_assig

gegen marginal=anycount(p_delta*_*), values(5) /*who is marginal for at least one school, with any bandwith*/
drop p_delta*
drop if marginal==0
save "$output/metro_Reg_plots", replace



**FINAL BASIC MANIPULATIONS **
use "$output/metro_Reg.dta", clear

gen age2018 = (td(1jan2018)-sus_fnac)/365.25
replace age2018=. if age2018<0
gen hombre=(sus_sexo=="H")
gen copc_asi_string = string(copc_asi,"%06.0f")
gen IPN_assig=(substr(copc_asi_string,1,1)=="5")
gen UNAM_assig=(substr(copc_asi_string,1,1)=="6")
gen Elite_assig=UNAM_assig+IPN_assig

gegen marginal=anycount(p_delta*_*), values(5) /*who is marginal for at least one school, with any bandwith*/

drop r_mid_delta* 
drop r_tau_delta*

gegen strata_pdelta1=group(anho p_delta1_*), missing
gegen strata_pdelta2=group(anho p_delta2_*), missing
gegen strata_pdelta3=group(anho p_delta3_*), missing

gegen strata_ELITE1=group(anho p_delta1_5* p_delta1_6*), missing
gegen strata_ELITE2=group(anho p_delta2_5* p_delta1_6*), missing
gegen strata_ELITE3=group(anho p_delta3_5* p_delta1_6*), missing

gegen strata_IPN1=group(anho p_delta1_5*), missing
gegen strata_IPN2=group(anho p_delta2_5*), missing
gegen strata_IPN3=group(anho p_delta3_5*), missing

gegen strata_UNAM1=group(anho p_delta1_6*), missing
gegen strata_UNAM2=group(anho p_delta2_6*), missing
gegen strata_UNAM3=group(anho p_delta3_6*), missing

*gegen var_treat1=sd(Elite_assig), by(strata_pdelta1)
*gegen var_treat2=sd(Elite_assig), by(strata_pdelta2)
*gegen var_treat3=sd(Elite_assig), by(strata_pdelta3)

gegen var_ELITE1=sd(Elite_assig), by(strata_ELITE1)
gegen var_ELITE2=sd(Elite_assig), by(strata_ELITE2)
gegen var_ELITE3=sd(Elite_assig), by(strata_ELITE3)

gegen var_IPN1=sd(IPN_assig), by(strata_IPN1)
gegen var_IPN2=sd(IPN_assig), by(strata_IPN2)
gegen var_IPN3=sd(IPN_assig), by(strata_IPN3)

gegen var_UNAM1=sd(UNAM_assig), by(strata_UNAM1)
gegen var_UNAM2=sd(UNAM_assig), by(strata_UNAM2)
gegen var_UNAM3=sd(UNAM_assig), by(strata_UNAM3)

merge 1:1 curp anho using "$output/strata_choices", keepus(strata_choice_year strata_choice) nolabel nonotes keep(1 3)
compress

save "$output/metro_Reg_TODOS", replace
drop if marginal==0
save "$output/metro_Reg_Marginal", replace
