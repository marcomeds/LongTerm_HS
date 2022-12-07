import delim "$folder/RawData/SIGDEP/concentrado_escuelas_df.csv", clear
drop if nombredelturno==""
keep clavedelcentrodetrabajo clavedelturno nombredelturno nombredelcentrodetrabajo tipoeducativo niveleducativo servicioeducativo nombredelcontrolpúblicooprivado v39 v40 clavedelaentidadfederativa nombredelaentidad clavedelmunicipioodelegación nombredelmunicipioodelegación clavedelalocalidad nombredelocalidad
tempfile temp1
save `temp1'

import delim "$folder/RawData/SIGDEP/concentrado_escuelas_mx.csv", clear
drop if nombredelturno==""
keep clavedelcentrodetrabajo clavedelturno nombredelturno nombredelcentrodetrabajo tipoeducativo niveleducativo servicioeducativo nombredelcontrolpúblicooprivado v39 v40 clavedelaentidadfederativa nombredelaentidad clavedelmunicipioodelegación nombredelmunicipioodelegación clavedelalocalidad nombredelocalidad

keep if nombredelmunicipioodelegación=="ACOLMAN" | nombredelmunicipioodelegación=="ATIZAPÁN DE ZARAGOZA" | nombredelmunicipioodelegación=="COACALCO DE BERRIOZÁBAL" | ///
nombredelmunicipioodelegación=="CUAUTITLÁN" |nombredelmunicipioodelegación=="CHALCO" | nombredelmunicipioodelegación=="CHICOLOAPAN"  | nombredelmunicipioodelegación=="CHIMALHUACÁN" | ///
nombredelmunicipioodelegación=="ECATEPEC DE MORELOS" | nombredelmunicipioodelegación=="HUIXQUILUCAN" | nombredelmunicipioodelegación=="IXTAPALUCA"  ///
| nombredelmunicipioodelegación=="NAUCALPAN DE JUÁREZ" | nombredelmunicipioodelegación=="NEZAHUALCÓYOTL" | nombredelmunicipioodelegación=="NICOLÁS ROMERO" | ///
nombredelmunicipioodelegación=="LA PAZ" | nombredelmunicipioodelegación=="TECÁMAC" | nombredelmunicipioodelegación=="TEPOTZOTLÁN" | ///
nombredelmunicipioodelegación=="TEXCOCO" | nombredelmunicipioodelegación=="TLALNEPANTLA DE BAZ" | nombredelmunicipioodelegación=="TULTEPEC" | ///
nombredelmunicipioodelegación=="TULTITLÁN" | nombredelmunicipioodelegación=="CUAUTITLÁN IZCALLI" | nombredelmunicipioodelegación=="VALLE DE CHALCO SOLIDARIDAD" 



append using `temp1'

drop if nombredelcentrodetrabajo==""

rename clavedelcentrodetrabajo CCT
rename v39 latitud
rename v40 longitud

compress
save "$folder/CreatedData/SIGDEP.dta",replace

bys CCT: gen N=_n
drop if N>1
drop N
drop if nombredelcontrolpúblicooprivado=="PRIVADO"

keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
replace nombredelcentrodetrabajo=ustrto(ustrnormalize(nombredelcentrodetrabajo, "nfd"), "ascii", 2)
replace nombredelcentrodetrabajo=upper(nombredelcentrodetrabajo)
save "$folder/CreatedData/SIGDEP_CCT_Unique.dta",replace


***BASIC NAME MATCH

use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=upper(nombredelcentrodetrabajo)
joinby nombredelcentrodetrabajo using "$folder/CreatedData/SIGDEP_CCT_Unique.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace

***BASIC NAME MATCH + NUMBER

use "$folder/CreatedData/SIGDEP_CCT_Unique.dta", clear
merge m:m CCT using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_SIGDEP
keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
gen idusing=_n
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
save  `leftover_SIGDEP'

use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=upper(nombredelcentrodetrabajo)
merge m:m CVE_OPC using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_COMIPEMS
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
save  `leftover_COMIPEMS'



use `leftover_COMIPEMS'
gen idmaster=_n
reclink2 nombredelcentrodetrabajo num_prepa using `leftover_SIGDEP',  idmaster(idmaster) idusing(idusing) gen(puntaje) required(num_prepa)
drop if puntaje==.
keep if puntaje>0.99
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST CCT
append using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace


***REPLACE CECy FPR "CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS"

use "$folder/CreatedData/SIGDEP_CCT_Unique.dta", clear
merge m:m CCT using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_SIGDEP
keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
gen idusing=_n
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
save  `leftover_SIGDEP'

use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=upper(nombredelcentrodetrabajo)
merge m:m CVE_OPC using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_COMIPEMS
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
save  `leftover_COMIPEMS'



use `leftover_COMIPEMS'
gen idmaster=_n
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CECY","CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS")
reclink2 nombredelcentrodetrabajo num_prepa using `leftover_SIGDEP',  idmaster(idmaster) idusing(idusing) gen(puntaje) required(num_prepa)
drop if puntaje==.
keep if puntaje>0.99
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST CCT
append using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace


**TRY TO IDENTIFY SYSTEM + delte word PLANTEL + delete "CENTRO DE"

use "$folder/CreatedData/SIGDEP_CCT_Unique.dta", clear
merge m:m CCT using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_SIGDEP
keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
gen idusing=_n
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
gen NOM_INST="CONALEP_DF" if regexm(nombredelcentrodetrabajo,"CONALEP")
replace NOM_INST="COLBACH" if regexm(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES")
replace NOM_INST="UNAM" if regexm(nombredelcentrodetrabajo,"UNAM")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
save  `leftover_SIGDEP'

use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=upper(nombredelcentrodetrabajo)
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
merge m:m CVE_OPC using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_COMIPEMS
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
save  `leftover_COMIPEMS'





use `leftover_COMIPEMS'
gen idmaster=_n
reclink2 nombredelcentrodetrabajo num_prepa NOM_INST using `leftover_SIGDEP',  idmaster(idmaster) idusing(idusing) gen(puntaje) required(num_prepa NOM_INST)
drop if puntaje==.
sort puntaje
keep if puntaje>0.90
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST CCT
append using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace





***DELETE CONALEP AND COLEGIO DE BACHILLERES and UNAM

use "$folder/CreatedData/SIGDEP_CCT_Unique.dta", clear
merge m:m CCT using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_SIGDEP
keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
gen idusing=_n
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
gen NOM_INST="CONALEP_DF" if regexm(nombredelcentrodetrabajo,"CONALEP")
replace NOM_INST="COLBACH" if regexm(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES")
replace NOM_INST="UNAM" if regexm(nombredelcentrodetrabajo,"UNAM")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
save  `leftover_SIGDEP'


use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=upper(nombredelcentrodetrabajo)
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
merge m:m CVE_OPC using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_COMIPEMS
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
save  `leftover_COMIPEMS'



use `leftover_COMIPEMS'
gen idmaster=_n
reclink2 nombredelcentrodetrabajo num_prepa NOM_INST using `leftover_SIGDEP',  idmaster(idmaster) idusing(idusing) gen(puntaje) required(num_prepa NOM_INST)
drop if puntaje==.
sort puntaje
keep if puntaje>0.94
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST CCT
append using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace




***replace CBT FOR BACHIERATO TECNOLOGICO

use "$folder/CreatedData/SIGDEP_CCT_Unique.dta", clear
merge m:m CCT using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_SIGDEP
keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
gen idusing=_n
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
gen NOM_INST="CONALEP_DF" if regexm(nombredelcentrodetrabajo,"CONALEP")
replace NOM_INST="COLBACH" if regexm(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES")
replace NOM_INST="UNAM" if regexm(nombredelcentrodetrabajo,"UNAM")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CBT"," BACHILLERATO TECNOLOGICO")
save  `leftover_SIGDEP'


use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CBT"," BACHILLERATO TECNOLOGICO")
merge m:m CVE_OPC using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_COMIPEMS
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
save  `leftover_COMIPEMS'



use `leftover_COMIPEMS'
gen idmaster=_n
reclink2 nombredelcentrodetrabajo num_prepa using `leftover_SIGDEP',  idmaster(idmaster) idusing(idusing) gen(puntaje) required(num_prepa)
drop if puntaje==.
sort puntaje
keep if puntaje>0.95
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST CCT
append using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace



***REMOVE COMILLAS AND ? and do very specific matches
use "$folder/CreatedData/SIGDEP_CCT_Unique.dta", clear
merge m:m CCT using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_SIGDEP
keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
gen idusing=_n
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
gen NOM_INST="CONALEP_DF" if regexm(nombredelcentrodetrabajo,"CONALEP")
replace NOM_INST="COLBACH" if regexm(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES")
replace NOM_INST="UNAM" if regexm(nombredelcentrodetrabajo,"UNAM")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CBT"," BACHILLERATO TECNOLOGICO")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
save  `leftover_SIGDEP'


use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CBT"," BACHILLERATO TECNOLOGICO")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
merge m:m CVE_OPC using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_COMIPEMS
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
save  `leftover_COMIPEMS'



use `leftover_COMIPEMS'
keep if nombredelcentrodetrabajo=="PREPARATORIA ANEXA A LA NORMAL DE LOS REYES LA PAZ" | ///
nombredelcentrodetrabajo=="PREPARATORIA ANEXA A LA NORMAL DE ATIZAPAN" | ///
nombredelcentrodetrabajo=="BACHILLERATO TECNOLOGICO MARIA LUISA MARINA DE SUAREZ" | ///
nombredelcentrodetrabajo=="BACHILLERATO TECNOLOGICO DR. EDUARDO SUAREZ A." | ///
nombredelcentrodetrabajo=="BACHILLERATO TECNOLOGICO ALBERT EINSTEIN" | ///
nombredelcentrodetrabajo=="BACHILLERATO TECNOLOGICO JUAN GUTENBERG" | ///
nombredelcentrodetrabajo=="BACHILLERATO TECNOLOGICO GABRIEL V. ALCOCER" | ///
nombredelcentrodetrabajo=="BACHILLERATO TECNOLOGICO LIC. ADOLFO LOPEZ MATEOS" 
gen idmaster=_n
reclink2 nombredelcentrodetrabajo num_prepa using `leftover_SIGDEP',  idmaster(idmaster) idusing(idusing) gen(puntaje) required(num_prepa)
drop if puntaje==.
sort puntaje
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST CCT
append using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace






***
use "$folder/CreatedData/SIGDEP_CCT_Unique.dta", clear
merge m:m CCT using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_SIGDEP
keep CCT nombredelcentrodetrabajo nombredelmunicipioodelegación
gen idusing=_n
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
gen NOM_INST="CONALEP_DF" if regexm(nombredelcentrodetrabajo,"CONALEP")
replace NOM_INST="COLBACH" if regexm(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES")
replace NOM_INST="UNAM" if regexm(nombredelcentrodetrabajo,"UNAM")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CBT"," BACHILLERATO TECNOLOGICO")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
save  `leftover_SIGDEP'


use "$folder/CreatedData/COMIPEMS/opciones_educativas_2005.dta", clear
rename NOM_OPC nombredelcentrodetrabajo
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PLANTEL","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CENTRO DE","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"COLEGIO DE BACHILLERES","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CONALEP","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"UNAM","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"NO\.","NUM.")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"ESCUELA PREPARATORIA","PREPARATORIA")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"PREPARATORIA OFICIAL"," PREPARATORIA")
replace nombredelcentrodetrabajo=strtrim(stritrim(nombredelcentrodetrabajo))
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"CBT"," BACHILLERATO TECNOLOGICO")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,`"""',"")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
replace nombredelcentrodetrabajo=regexr(nombredelcentrodetrabajo,"\?","")
merge m:m CVE_OPC using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
drop if _merge!=1
drop _merge
tempfile leftover_COMIPEMS
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST
gen num_prepa=ustrregexs(0) if ustrregexm(nombredelcentrodetrabajo,"[0-9]+")
destring num_prepa, replace
save  `leftover_COMIPEMS'



use `leftover_COMIPEMS'
exit
gen idmaster=_n
reclink2 nombredelcentrodetrabajo num_prepa using `leftover_SIGDEP',  idmaster(idmaster) idusing(idusing) gen(puntaje) required(num_prepa)
drop if puntaje==.
sort puntaje
exit
keep CVE_OPC nombredelcentrodetrabajo ESPECIAL NOM_INST CCT
append using "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta"
save "$folder/CreatedData/COMIPEMS/opciones_educativas_2005_CCT.dta", replace














