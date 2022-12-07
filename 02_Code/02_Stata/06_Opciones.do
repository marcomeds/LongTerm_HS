import delim using "C:\Users\mauri\Dropbox\Research\LongTerm_HS\RawData\COMIPEMS\OPCIONES_CSV\opciones_educativas_2005.csv", clear
gen anho=2005
tempfile temp2005
rename cve_opcc6 cve_opc
rename nom_opcc100  nom_opc
rename especialc254 especial
rename nom_instc15 nom_inst
gen cve_opc2 = string(cve_opc,"%06.0f")
drop cve_opc
rename cve_opc2 cve_opc
gen prim_num=substr( cve_opc,1,1)
gen cve_plantel=substr( cve_opc,1,3)
keep cve_opc nom_opc especial nom_inst cve_plantel anho
save `temp2005'




import delim using "C:\Users\mauri\Dropbox\Research\LongTerm_HS\RawData\COMIPEMS\OPCIONES_CSV\opciones_educativas_2006.csv", clear
gen anho=2006
tempfile temp2006
rename clavec6 cve_opc
rename plantelc115  nom_opc
rename especialc55 especial
rename instituc45 nom_inst
gen cve_opc2 = string(cve_opc,"%06.0f")
drop cve_opc
rename cve_opc2 cve_opc
gen prim_num=substr( cve_opc,1,1)
gen cve_plantel=substr( cve_opc,1,3)
keep cve_opc nom_opc especial nom_inst cve_plantel anho
save `temp2006'



import delim using "C:\Users\mauri\Dropbox\Research\LongTerm_HS\RawData\COMIPEMS\OPCIONES_CSV\opciones_educativas_2007.csv", clear
gen anho=2007
tempfile temp2007

rename clavec6 cve_opc
rename plantelc115  nom_opc
rename especialc55 especial
rename instituc45 nom_inst
gen cve_opc2 = string(cve_opc,"%06.0f")
drop cve_opc
rename cve_opc2 cve_opc
gen prim_num=substr( cve_opc,1,1)
gen cve_plantel=substr( cve_opc,1,3)
keep cve_opc nom_opc especial nom_inst cve_plantel anho
save `temp2007'


import delim using "C:\Users\mauri\Dropbox\Research\LongTerm_HS\RawData\COMIPEMS\OPCIONES_CSV\opciones_educativas_2008.csv", clear
gen anho=2008
tempfile temp2008
rename clavec6 cve_opc
rename plantelc115  nom_opc
rename especialc55 especial
rename instituc42 nom_inst
gen cve_opc2 = string(cve_opc,"%06.0f")
drop cve_opc
rename cve_opc2 cve_opc
gen prim_num=substr( cve_opc,1,1)
gen cve_plantel=substr( cve_opc,1,3)
keep cve_opc nom_opc especial nom_inst cve_plantel anho
save `temp2008'




import delim using "C:\Users\mauri\Dropbox\Research\LongTerm_HS\RawData\COMIPEMS\OPCIONES_CSV\opciones_educativas_2009.csv", clear
gen anho=2009
tempfile temp2009
rename clavec6 cve_opc
rename plantelc115  nom_opc
rename especialc55 especial
rename instituc45 nom_inst
gen cve_opc2 = string(cve_opc,"%06.0f")
drop cve_opc
rename cve_opc2 cve_opc
gen prim_num=substr( cve_opc,1,1)
gen cve_plantel=substr( cve_opc,1,3)
keep cve_opc nom_opc especial nom_inst cve_plantel anho
save `temp2009' 



import delim using "C:\Users\mauri\Dropbox\Research\LongTerm_HS\RawData\COMIPEMS\OPCIONES_CSV\opciones_educativas_2010.csv", clear
gen anho=2010
tempfile temp2010
rename clavec6 cve_opc
rename plantelc115  nom_opc
rename especialc55 especial
rename instituc45 nom_inst
gen cve_opc2 = string(cve_opc,"%06.0f")
drop cve_opc
rename cve_opc2 cve_opc
gen prim_num=substr( cve_opc,1,1)
gen cve_plantel=substr( cve_opc,1,3)
keep cve_opc nom_opc especial nom_inst cve_plantel anho
save `temp2010'


use  `temp2005'
append using  `temp2006'
append using `temp2007'
append using `temp2008'
append using `temp2009'
append using `temp2010'
save "$output/OPCIONES_CONSOLIDADO.dta",replace