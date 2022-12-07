****************************************
****************************************
****************************************
*************** ENLACE *****************
****************************************
use "$input/02_ENLACE/M08", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)

gen curp_short=substr(curp,1,16)

gen length_curp=strlen(curp_short)
drop if length_curp!=16
*(114,934 observations deleted)
bys curp_short: gen N=_N
/*
       N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    690,198       99.32       99.32
          2 |      3,788        0.55       99.86
          3 |         93        0.01       99.88
          4 |         44        0.01       99.88
          5 |         15        0.00       99.89
          6 |          6        0.00       99.89
          9 |          9        0.00       99.89
         10 |         30        0.00       99.89
         11 |         22        0.00       99.90
         12 |         12        0.00       99.90
         13 |         91        0.01       99.91
         14 |        182        0.03       99.94
         17 |         17        0.00       99.94
         35 |         35        0.01       99.94
         42 |         42        0.01       99.95
         50 |         50        0.01       99.96
        291 |        291        0.04      100.00
------------+-----------------------------------
      Total |    694,925      100.00


*/
drop if N>1
drop N
tempfile temp1
save "$output/M08", replace

/*
import delim "$input/Contexto ENLACE EMS/enl_2008.csv", clear
keep nofolio curp
gen curp_short=substr(curp,1,16)
gen length_curp=strlen(curp_short)
drop if length_curp!=16
bys curp_short: gen N=_N
drop if N>1
drop N
drop curp

compress
merge 1:1 curp_short using "$output/M08"
drop if _merge!=3
save "$output/M08", replace


import delim "$input/Contexto ENLACE EMS/contexto_2008.csv", clear
keep nofolio r24 r50 r52
rename r24 aspiraciones
rename r50 fuma
rename r52 alcohol
*/

use "$input/02_ENLACE/M09", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)

gen curp_short=substr(curp,1,16)

gen length_curp=strlen(curp_short)
drop if length_curp!=16
*(123,748 observations deleted)
bys curp_short: gen N=_N
/*
tab N

            N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    699,987       98.72       98.72
          2 |      2,466        0.35       99.07
          3 |         66        0.01       99.08
          4 |          4        0.00       99.08
          5 |          5        0.00       99.08
          6 |          6        0.00       99.08
          7 |          7        0.00       99.08
          8 |          8        0.00       99.09
         17 |         17        0.00       99.09
         25 |         25        0.00       99.09
         32 |         32        0.00       99.10
         47 |         47        0.01       99.10
       6361 |      6,361        0.90      100.00
------------+-----------------------------------
      Total |    709,031      100.00


*/
drop if N>1
drop N
tempfile temp2
save "$output/M09", replace



use "$input/02_ENLACE/M10", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)

gen curp_short=substr(curp,1,16)

gen length_curp=strlen(curp_short)
drop if length_curp!=16
*(84,410 observations deleted)
bys curp_short: gen N=_N
/*
tab N

         N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    797,379       99.64       99.64
          2 |      2,374        0.30       99.94
          3 |        264        0.03       99.97
          4 |         60        0.01       99.98
          5 |         15        0.00       99.98
          6 |          6        0.00       99.98
          7 |          7        0.00       99.98
          8 |          8        0.00       99.98
          9 |          9        0.00       99.98
         10 |         10        0.00       99.98
         11 |         11        0.00       99.99
         15 |         30        0.00       99.99
         19 |         19        0.00       99.99
         62 |         62        0.01      100.00
------------+-----------------------------------
      Total |    800,254      100.00



*/
drop if N>1
drop N
tempfile temp2
save "$output/M10", replace



use "$input/02_ENLACE/M11", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)

gen curp_short=substr(curp,1,16)

gen length_curp=strlen(curp_short)
drop if length_curp!=16
*(109,760 observations deleted)
bys curp_short: gen N=_N
/*
tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    797,017       99.24       99.24
          2 |      2,636        0.33       99.57
          3 |         78        0.01       99.58
          4 |         28        0.00       99.58
          5 |         10        0.00       99.58
          6 |          6        0.00       99.58
          8 |          8        0.00       99.58
          9 |          9        0.00       99.59
         12 |         36        0.00       99.59
         14 |         28        0.00       99.59
         19 |         19        0.00       99.60
         22 |         22        0.00       99.60
         56 |         56        0.01       99.61
         63 |         63        0.01       99.61
         72 |         72        0.01       99.62
       3032 |      3,032        0.38      100.00
------------+-----------------------------------
      Total |    803,120      100.00




*/
drop if N>1
drop N
tempfile temp2
save "$output/M11", replace



use "$input/02_ENLACE/M12", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)

gen curp_short=substr(curp,1,16)

gen length_curp=strlen(curp_short)
drop if length_curp!=16
*(97,276 observations deleted)
bys curp_short: gen N=_N
/*
tab N


          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    864,783       99.64       99.64
          2 |      2,846        0.33       99.97
          3 |        168        0.02       99.99
          4 |          4        0.00       99.99
          9 |          9        0.00       99.99
         14 |         14        0.00       99.99
         17 |         17        0.00      100.00
         18 |         36        0.00      100.00
------------+-----------------------------------
      Total |    867,877      100.00


*/
drop if N>1
drop N
tempfile temp2
save "$output/M12", replace


use "$input/02_ENLACE/M13", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)

gen curp_short=substr(curp,1,16)

gen length_curp=strlen(curp_short)
drop if length_curp!=16
*(14,963 observations deleted)
bys curp_short: gen N=_N
/*
tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    994,037       99.60       99.60
          2 |      3,448        0.35       99.95
          3 |         42        0.00       99.95
          4 |         28        0.00       99.96
          5 |         10        0.00       99.96
          8 |          8        0.00       99.96
         36 |         36        0.00       99.96
        118 |        118        0.01       99.97
        268 |        268        0.03      100.00
------------+-----------------------------------
      Total |    997,995      100.00


*/
drop if N>1
drop N
tempfile temp2
save "$output/M13", replace




use "$input/02_ENLACE/M14", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)

gen curp_short=substr(curp,1,16)

gen length_curp=strlen(curp_short)
drop if length_curp!=16
*(17,773 observations deleted)
bys curp_short: gen N=_N
/*
tab N


          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |  1,007,511       99.64       99.64
          2 |      2,998        0.30       99.93
          3 |         54        0.01       99.94
          4 |          4        0.00       99.94
          5 |         10        0.00       99.94
          6 |         12        0.00       99.94
          8 |          8        0.00       99.94
          9 |          9        0.00       99.94
         12 |         12        0.00       99.94
         16 |         16        0.00       99.95
         17 |         17        0.00       99.95
         18 |         18        0.00       99.95
         20 |         20        0.00       99.95
         21 |         21        0.00       99.95
         30 |         30        0.00       99.96
         33 |         33        0.00       99.96
         38 |         38        0.00       99.96
         43 |         43        0.00       99.97
        332 |        332        0.03      100.00
------------+-----------------------------------
      Total |  1,011,186      100.00



*/
drop if N>1
drop N
tempfile temp2
save "$output/M14", replace


****************************************
******* PARA 2005 **********************
****************************************




use "$input/01_COMIPEMS_CURP/metro_2005/metro2005", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)
gen length_curp=strlen(curp)
drop if length_curp!=16
bys curp: gen N=_N
/*
tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    287,461       99.85       99.85
          2 |        422        0.15      100.00
          3 |          3        0.00      100.00
------------+-----------------------------------
      Total |    287,886      100.00
*/
drop if N>1
drop N

gen curp_short=curp

merge 1:1 curp_short using "$output/M08", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_3=(_merge==3)
drop _merge
rename cct cct_3
rename p_esp p_esp_3
rename p_mat p_mat_3

merge 1:1 curp_short using "$output/M09", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_4=(_merge==3)
drop _merge
rename cct cct_4
rename p_esp p_esp_4
rename p_mat p_mat_4


 
save "$output/metro_2005_ENLACE", replace



****************************************
******* PARA 2006 **********************
****************************************




use "$input/01_COMIPEMS_CURP/metro_2006/databases/metro2006", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)
gen length_curp=strlen(curp)
drop if length_curp!=16
bys curp: gen N=_N
/*
tab N

         N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    297,861       99.86       99.86
          2 |        430        0.14      100.00
------------+-----------------------------------
      Total |    298,291      100.00

*/
drop if N>1
drop N

gen curp_short=curp

merge 1:1 curp_short using "$output/M08", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_2=(_merge==3)
drop _merge
rename cct cct_2
rename p_esp p_esp_2
rename p_mat p_mat_2

merge 1:1 curp_short using "$output/M09", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_3=(_merge==3)
drop _merge
rename cct cct_3
rename p_esp p_esp_3
rename p_mat p_mat_3

merge 1:1 curp_short using "$output/M10", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_4=(_merge==3)
drop _merge
rename cct cct_4
rename p_esp p_esp_4
rename p_mat p_mat_4

 
save "$output/metro_2006_ENLACE", replace


****************************************
******* PARA 2007 **********************
****************************************



use "$input/01_COMIPEMS_CURP/metro_2007/databases/metro2007", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)
gen length_curp=strlen(curp)
drop if length_curp!=16
bys curp: gen N=_N
/*
tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    296,341       99.85       99.85
          2 |        436        0.15      100.00
------------+-----------------------------------
      Total |    296,777      100.00


*/
drop if N>1
drop N

gen curp_short=curp

merge 1:1 curp_short using "$output/M08", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_1=(_merge==3)
drop _merge
rename cct cct_1
rename p_esp p_esp_1
rename p_mat p_mat_1

merge 1:1 curp_short using "$output/M09", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_2=(_merge==3)
drop _merge
rename cct cct_2
rename p_esp p_esp_2
rename p_mat p_mat_2

merge 1:1 curp_short using "$output/M10", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_3=(_merge==3)
drop _merge
rename cct cct_3
rename p_esp p_esp_3
rename p_mat p_mat_3

merge 1:1 curp_short using "$output/M11", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_4=(_merge==3)
drop _merge
rename cct cct_4
rename p_esp p_esp_4
rename p_mat p_mat_4


 
save "$output/metro_2007_ENLACE", replace


****************************************
******* PARA 2008 **********************
****************************************



use "$input/01_COMIPEMS_CURP/metro_2008/metro2008", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)
gen length_curp=strlen(curp)
drop if length_curp!=16
*(2 observations deleted)
bys curp: gen N=_N
/*
tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    302,744       99.84       99.84
          2 |        472        0.16      100.00
          3 |          6        0.00      100.00
------------+-----------------------------------
      Total |    303,222      100.00



*/
drop if N>1
drop N

gen curp_short=curp

merge 1:1 curp_short using "$output/M08", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_0=(_merge==3)
drop _merge
rename cct cct_0
rename p_esp p_esp_0
rename p_mat p_mat_0

merge 1:1 curp_short using "$output/M09", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_1=(_merge==3)
drop _merge
rename cct cct_1
rename p_esp p_esp_1
rename p_mat p_mat_1

merge 1:1 curp_short using "$output/M10", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_2=(_merge==3)
drop _merge
rename cct cct_2
rename p_esp p_esp_2
rename p_mat p_mat_2

merge 1:1 curp_short using "$output/M11", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_3=(_merge==3)
drop _merge
rename cct cct_3
rename p_esp p_esp_3
rename p_mat p_mat_3

merge 1:1 curp_short using "$output/M12", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_4=(_merge==3)
drop _merge
rename cct cct_4
rename p_esp p_esp_4
rename p_mat p_mat_4


 
save "$output/metro_2008_ENLACE", replace



****************************************
******* PARA 2009 **********************
****************************************



use "$input/01_COMIPEMS_CURP/metro_2009/COMIPEMS 2009", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)
gen length_curp=strlen(curp)
drop if length_curp!=16
*(2,868 observations deleted)
bys curp: gen N=_N
/*
tab N


          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    313,856       99.72       99.72
          2 |        774        0.25       99.97
          3 |          3        0.00       99.97
          4 |          4        0.00       99.97
         19 |         76        0.02       99.99
         22 |         22        0.01      100.00
------------+-----------------------------------
      Total |    314,735      100.00




*/
drop if N>1
drop N

gen curp_short=curp



merge 1:1 curp_short using "$output/M09", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_0=(_merge==3)
drop _merge
rename cct cct_0
rename p_esp p_esp_0
rename p_mat p_mat_0

merge 1:1 curp_short using "$output/M10", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_1=(_merge==3)
drop _merge
rename cct cct_1
rename p_esp p_esp_1
rename p_mat p_mat_1

merge 1:1 curp_short using "$output/M11", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_2=(_merge==3)
drop _merge
rename cct cct_2
rename p_esp p_esp_2
rename p_mat p_mat_2

merge 1:1 curp_short using "$output/M12", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_3=(_merge==3)
drop _merge
rename cct cct_3
rename p_esp p_esp_3
rename p_mat p_mat_3

merge 1:1 curp_short using "$output/M13", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_4=(_merge==3)
drop _merge
rename cct cct_4
rename p_esp p_esp_4
rename p_mat p_mat_4
 
save "$output/metro_2009_ENLACE", replace



****************************************
******* PARA 2010 **********************
****************************************


use "$input/01_COMIPEMS_CURP/metro_2010/metro_10", clear
replace curp = stritrim(curp)
replace curp = strtrim(curp)
replace curp = subinstr(curp, " ", "", .)
gen length_curp=strlen(curp)
drop if length_curp!=16
bys curp: gen N=_N
/*
tab N



          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    315,395       99.86       99.86
          2 |        450        0.14      100.00
          3 |          3        0.00      100.00
------------+-----------------------------------
      Total |    315,848      100.00


*/
drop if N>1
drop N

gen curp_short=curp

merge 1:1 curp_short using "$output/M10", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_0=(_merge==3)
drop _merge
rename cct cct_0
rename p_esp p_esp_0
rename p_mat p_mat_0

merge 1:1 curp_short using "$output/M11", keepus(cct p_esp p_mat)
drop if _merge==2
gen ENLACE_1=(_merge==3)
drop _merge
rename cct cct_1
rename p_esp p_esp_1
rename p_mat p_mat_1

merge 1:1 curp_short using "$output/M12", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_2=(_merge==3)
drop _merge
rename cct cct_2
rename p_esp p_esp_2
rename p_mat p_mat_2

merge 1:1 curp_short using "$output/M13", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_3=(_merge==3)
drop _merge
rename cct cct_3
rename p_esp p_esp_3
rename p_mat p_mat_3

merge 1:1 curp_short using "$output/M14", keepus(cct p_esp p_mat) update
drop if _merge==2
gen ENLACE_4=(_merge==3)
drop _merge
rename cct cct_4
rename p_esp p_esp_4
rename p_mat p_mat_4

 
save "$output/metro_2010_ENLACE", replace
