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
	gegen Total1=rowtotal(p_delta1*),missing
	gegen Total_IPN1=rowtotal(p_delta1_5*),missing
	gegen Total_UNAM1=rowtotal(p_delta1_6*),missing
	
	* This next section finds the minimum running variable for each obs
	* An observation can have several running variables (normalized_score - cutoff)
	* We take the minimum in absolute value (the one closest to the cutoff)
	unab r_delta1_all: r_delta1*
	foreach r_delta1 of local r_delta1_all{
		gen abs_`r_delta1'=abs(`r_delta1')
	}
	gegen r_IPN1=rowmin(abs_r_delta1_5*)
	gegen r_UNAM1=rowmin(abs_r_delta1_6*)
	gegen r_ELITE1=rowmin(r_IPN1 r_UNAM1)
	unab r_delta1_IPN: r_delta1_5*
	foreach r_delta1 of local r_delta1_IPN{
		replace r_IPN1=`r_delta1' if r_IPN1 == abs_`r_delta1'
	}
	unab r_delta1_UNAM: r_delta1_6*
	foreach r_delta1 of local r_delta1_UNAM{
		replace r_UNAM1=`r_delta1' if r_UNAM1 == abs_`r_delta1'
	}
	replace r_ELITE1=r_IPN1 if r_ELITE1 == abs(r_IPN1)
	replace r_ELITE1=r_UNAM1 if r_ELITE1 == abs(r_UNAM1)
	
	keep curp nglobal normalized_score curp_short Total1 Total_IPN1 Total_UNAM1 p_delta1_5* p_delta1_6* r_delta1_5* r_delta1_6* r_IPN1 r_UNAM1 r_ELITE1
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
	gegen Total2=rowtotal(p_delta2*),missing
	gegen Total_IPN2=rowtotal(p_delta2_5*),missing
	gegen Total_UNAM2=rowtotal(p_delta2_6*),missing
	
	* This next section finds the minimum running variable for each obs
	* An observation can have several running variables (normalized_score - cutoff)
	* We take the minimum in absolute value (the one closest to the cutoff)
	unab r_delta2_all: r_delta2*
	foreach r_delta2 of local r_delta2_all{
		gen abs_`r_delta2'=abs(`r_delta2')
	}
	gegen r_IPN2=rowmin(abs_r_delta2_5*)
	gegen r_UNAM2=rowmin(abs_r_delta2_6*)
	gegen r_ELITE2=rowmin(r_IPN2 r_UNAM2)
	unab r_delta2_IPN: r_delta2_5*
	foreach r_delta2 of local r_delta2_IPN{
		replace r_IPN2=`r_delta2' if r_IPN2 == abs_`r_delta2'
	}
	unab r_delta2_UNAM: r_delta2_6*
	foreach r_delta2 of local r_delta2_UNAM{
		replace r_UNAM2=`r_delta2' if r_UNAM2 == abs_`r_delta2'
	}
	replace r_ELITE2=r_IPN2 if r_ELITE2 == abs(r_IPN2)
	replace r_ELITE2=r_UNAM2 if r_ELITE2 == abs(r_UNAM2)
	
	keep curp nglobal normalized_score curp_short Total2 Total_IPN2 Total_UNAM2 p_delta2_5* p_delta2_6* r_delta2_5* r_delta2_6* r_IPN2 r_UNAM2 r_ELITE2
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
	gegen Total3=rowtotal(p_delta3*),missing
	gegen Total_IPN3=rowtotal(p_delta3_5*),missing
	gegen Total_UNAM3=rowtotal(p_delta3_6*),missing
	
	* This next section finds the minimum running variable for each obs
	* An observation can have several running variables (normalized_score - cutoff)
	* We take the minimum in absolute value (the one closest to the cutoff)
	unab r_delta3_all: r_delta3*
	foreach r_delta3 of local r_delta3_all{
		gen abs_`r_delta3'=abs(`r_delta3')
	}
	gegen r_IPN3=rowmin(abs_r_delta3_5*)
	gegen r_UNAM3=rowmin(abs_r_delta3_6*)
	gegen r_ELITE3=rowmin(r_IPN3 r_UNAM3)
	unab r_delta3_IPN: r_delta3_5*
	foreach r_delta3 of local r_delta3_IPN{
		replace r_IPN3=`r_delta3' if r_IPN3 == abs_`r_delta3'
	}
	unab r_delta3_UNAM: r_delta3_6*
	foreach r_delta3 of local r_delta3_UNAM{
		replace r_UNAM3=`r_delta3' if r_UNAM3 == abs_`r_delta3'
	}
	replace r_ELITE3=r_IPN3 if r_ELITE3 == abs(r_IPN3)
	replace r_ELITE3=r_UNAM3 if r_ELITE3 == abs(r_UNAM3)

	keep curp nglobal normalized_score curp_short Total3 Total_IPN3 Total_UNAM3 p_delta3_5* p_delta3_6* r_delta3_5* r_delta3_6* r_IPN3 r_UNAM3 r_ELITE3
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




**FINAL BASIC MANIPULATIONS **

use "$output/metro_Reg.dta", clear
egen marginal=anycount(p_delta* ), values(5)
drop if marginal==0
egen strata_pdelta1=group(anho p_delta1_*), missing
egen strata_pdelta2=group(anho p_delta2_*), missing
egen strata_pdelta3=group(anho p_delta3_*), missing

egen strata_IPN1=group(anho p_delta1_5*), missing
egen strata_IPN2=group(anho p_delta2_5*), missing
egen strata_IPN3=group(anho p_delta3_5*), missing

egen strata_UNAM1=group(anho p_delta1_6*), missing
egen strata_UNAM2=group(anho p_delta2_6*), missing
egen strata_UNAM3=group(anho p_delta3_6*), missing

gen age2018 = (td(1jan2018)-sus_fnac)/365.25
replace age2018=. if age2018<0
gen hombre=(sus_sexo=="H")
gen copc_asi_string = string(copc_asi,"%06.0f")
gen IPN_assig=(substr(copc_asi_string,1,1)=="5")
gen UNAM_assig=(substr(copc_asi_string,1,1)=="6")
gen Elite_assig=UNAM_assig+IPN_assig

egen var_treat1=sd(Elite_assig), by(strata_pdelta1)
egen var_treat2=sd(Elite_assig), by(strata_pdelta2)
egen var_treat3=sd(Elite_assig), by(strata_pdelta3)

egen var_IPN1=sd(IPN_assig), by(strata_IPN1)
egen var_IPN2=sd(IPN_assig), by(strata_IPN2)
egen var_IPN3=sd(IPN_assig), by(strata_IPN3)

egen var_UNAM1=sd(UNAM_assig), by(strata_UNAM1)
egen var_UNAM2=sd(UNAM_assig), by(strata_UNAM2)
egen var_UNAM3=sd(UNAM_assig), by(strata_UNAM3)

compress
save "$output/metro_Reg_MARGINAL", replace