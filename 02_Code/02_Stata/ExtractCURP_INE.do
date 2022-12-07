************************************************
************2005 *******************************
************************************************
use "$input/COMIPEMS_CURP/metro_2005/metro2005", clear
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

keep curp folio registro examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi asig_fin
gen anho=2005 
save "$output/CURP_INE_CROSSOVER.dta", replace

************************************************
************2006 *******************************
************************************************
use "$input/COMIPEMS_CURP/metro_2006/databases/metro2006", clear
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


keep folio curp registro examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi asig_fin
gen anho=2006

append using "$output/CURP_INE_CROSSOVER.dta"

save "$output/CURP_INE_CROSSOVER.dta", replace

/*
use "$input/COMIPEMS_CURP/metro_2006/base_nom", clear
bys curp: gen N=_N
/*
tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    626,518       83.79       83.79
          2 |      2,378        0.32       84.11
          3 |        123        0.02       84.13
          4 |         44        0.01       84.13
          5 |         40        0.01       84.14
          6 |         30        0.00       84.14
          7 |         35        0.00       84.15
          8 |         32        0.00       84.15
          9 |          9        0.00       84.15
         10 |         10        0.00       84.16
         11 |         22        0.00       84.16
         12 |         48        0.01       84.16
         13 |         26        0.00       84.17
         14 |         14        0.00       84.17
         15 |         15        0.00       84.17
         17 |         17        0.00       84.17
         18 |         18        0.00       84.18
         19 |         19        0.00       84.18
         20 |         40        0.01       84.18
         21 |         21        0.00       84.19
         23 |         46        0.01       84.19
         29 |         29        0.00       84.20
         32 |         32        0.00       84.20
         35 |         35        0.00       84.21
         36 |         36        0.00       84.21
         39 |         39        0.01       84.22
         40 |         80        0.01       84.23
         41 |         82        0.01       84.24
         44 |         88        0.01       84.25
         45 |         45        0.01       84.26
         46 |         46        0.01       84.26
         47 |         47        0.01       84.27
         49 |         49        0.01       84.27
         55 |         55        0.01       84.28
        781 |        781        0.10       84.39
     116739 |    116,739       15.61      100.00
------------+-----------------------------------
      Total |    747,688      100.00

*/
drop if N>1
drop N


keep nofolio curp
rename nofolio folio
gen anho=2006

append using "$output/CURP_INE_CROSSOVER.dta"

save "$output/CURP_INE_CROSSOVER.dta", replace

**OTHER
use "$input/COMIPEMS_CURP/metro_2006/base_c", clear
bys curp: gen N=_N
/*
tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    149,506       99.82       99.82
          2 |        272        0.18      100.00
------------+-----------------------------------
      Total |    149,778      100.00


*/
drop if N>1
drop N


keep folio curp
gen anho=2006

append using "$output/CURP_INE_CROSSOVER.dta"

save "$output/CURP_INE_CROSSOVER.dta", replace


*****LONG CURP

use "$input/COMIPEMS_CURP/metro_2006/base_nom", clear
bys curp_e: gen N=_N
/*
tab N

         N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    627,766       83.96       83.96
          2 |      1,818        0.24       84.20
          3 |        231        0.03       84.24
          4 |         68        0.01       84.24
          5 |         45        0.01       84.25
          6 |         24        0.00       84.25
          7 |         28        0.00       84.26
          8 |          8        0.00       84.26
         10 |         10        0.00       84.26
         11 |         11        0.00       84.26
         14 |         14        0.00       84.26
         17 |         17        0.00       84.27
         20 |         40        0.01       84.27
         32 |         32        0.00       84.27
         46 |         46        0.01       84.28
         47 |         47        0.01       84.29
        199 |        199        0.03       84.31
        781 |        781        0.10       84.42
     116503 |    116,503       15.58      100.00
------------+-----------------------------------
      Total |    747,688      100.00


*/
drop if N>1
drop N


keep nofolio curp_e
rename nofolio folio
gen anho=2006


save "$output/CURP_INE_CROSSOVER_long.dta", replace


**OTHER
use "$input/COMIPEMS_CURP/metro_2006/base_e", clear
bys curp: gen N=_N
/*
tab N


          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |     33,542       73.82       73.82
          2 |        190        0.42       74.24
          3 |          3        0.01       74.24
          6 |          6        0.01       74.26
          7 |          7        0.02       74.27
          9 |          9        0.02       74.29
       5321 |      5,321       11.71       86.00
       6361 |      6,361       14.00      100.00
------------+-----------------------------------
      Total |     45,439      100.00



*/
drop if N>1
drop N


keep nofolio curp
rename nofolio folio
gen anho=2006

append using "$output/CURP_INE_CROSSOVER_long.dta"

save "$output/CURP_INE_CROSSOVER_long.dta", replace
*/


************************************************
************2007 *******************************
************************************************
use "$input/COMIPEMS_CURP/metro_2007/databases/metro2007", clear
bys curp: gen N=_N
/*
. tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    296,342       99.85       99.85
          2 |        436        0.15      100.00
------------+-----------------------------------
      Total |    296,778      100.00

*/
drop if N>1
drop N


keep folio curp registro examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi 
gen anho=2007

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace


************************************************
************2007 2 *******************************
************************************************
/*
use "$input/COMIPEMS_CURP/metro_2007/databases/metro2007_a", clear
bys curp: gen N=_N
/*
. tab N


          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    296,342       99.85       99.85
          2 |        436        0.15      100.00
------------+-----------------------------------
      Total |    296,778      100.00

*/
drop if N>1
drop N


keep folio curp registro examino cve_cct mun_cct  expl_asi copc_asi 
rename curp_07 curp 
rename folio_07 folio
gen anho=2007

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace
*/

************************************************
************2008 *******************************
************************************************


use "$input/COMIPEMS_CURP/metro_2008/metro2008_2", clear
bys curp: gen N=_N
/*
. tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    289,771       99.84       99.84
          2 |        460        0.16      100.00
          3 |          6        0.00      100.00
------------+-----------------------------------
      Total |    290,237      100.00


*/
drop if N>1
drop N


keep folio curp registro examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi 
gen anho=2008

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace


use "$input/COMIPEMS_CURP/metro_2008/metro2008", clear
bys curp: gen N=_N
/*
. tab N

         N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    302,746       99.84       99.84
          2 |        472        0.16      100.00
          3 |          6        0.00      100.00
------------+-----------------------------------
      Total |    303,224      100.00


*/
drop if N>1
drop N


keep folio curp registro examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi 
gen anho=2008

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace



import dbase "$input/COMIPEMS_CURP/metro_2008/Metro2008.dbf", clear
bys CURP: gen N=_N
/*
. tab N


          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    302,746       99.84       99.84
          2 |        472        0.16      100.00
          3 |          6        0.00      100.00
------------+-----------------------------------
      Total |    303,224      100.00



*/
drop if N>1
drop N
rename *, lower

keep folio curp examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi 
gen anho=2008

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace




************************************************
************2009 *******************************
************************************************

use "$input/COMIPEMS_CURP/metro_2009/COMIPEMS 2009", clear
bys curp: gen N=_N
/*
. tab N

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    314,773       99.11       99.11
          2 |      1,692        0.53       99.64
          3 |         66        0.02       99.66
          4 |         96        0.03       99.69
          5 |         50        0.02       99.71
          6 |         60        0.02       99.73
          7 |         28        0.01       99.74
          8 |         32        0.01       99.75
          9 |         18        0.01       99.75
         10 |         10        0.00       99.76
         12 |         24        0.01       99.76
         13 |         13        0.00       99.77
         17 |         17        0.01       99.77
         19 |         95        0.03       99.80
         22 |         44        0.01       99.82
         31 |         62        0.02       99.84
         32 |         64        0.02       99.86
        459 |        459        0.14      100.00
------------+-----------------------------------
      Total |    317,603      100.00



*/
drop if N>1
drop N


keep folio curp examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi 
gen anho=2009

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace



import dbase "$input/COMIPEMS_CURP/metro_2009/Metro.dbf", clear
bys CURP: gen N=_N
/*
. tab N



          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    317,064       99.83       99.83
          2 |        536        0.17      100.00
          3 |          3        0.00      100.00
------------+-----------------------------------
      Total |    317,603      100.00




*/
drop if N>1
drop N

rename *, lower

keep folio curp examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi 
gen anho=2009

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace



************************************************
************2010 *******************************
************************************************
use "$input/COMIPEMS_CURP/metro_2010/metro_10", clear
bys curp: gen N=_N
/*
. tab N


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


keep folio curp
gen anho=2010

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace



import dbase "$input/COMIPEMS_CURP/metro_2010/Metro.dbf", clear
bys CURP: gen N=_N
/*
. tab N


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

rename *, lower

keep folio curp examino cve_cct mun_cct sus_prom nglobal expl_asi copc_asi 
gen anho=2010

append using "$output/CURP_INE_CROSSOVER.dta"
save "$output/CURP_INE_CROSSOVER.dta", replace


***CLEAN UP

use "$output/CURP_INE_CROSSOVER.dta", clear
bys curp folio anho: gen N=_n
tab N
/*

          N |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |  1,818,016       54.50       54.50
          2 |  1,228,114       36.82       91.31
          3 |    289,766        8.69      100.00
------------+-----------------------------------
      Total |  3,335,896      100.00


*/
drop if N>1
tab anho
/*

       anho |      Freq.     Percent        Cum.
------------+-----------------------------------
       2005 |    287,461       15.81       15.81
       2006 |    297,861       16.38       32.20
       2007 |    296,368       16.30       48.50
       2008 |    302,751       16.65       65.15
       2009 |    318,180       17.50       82.65
       2010 |    315,395       17.35      100.00
------------+-----------------------------------
      Total |  1,818,016      100.00


*/

drop N
compress


gen nchar=strlen(curp)
/*
tab nchar

      nchar |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |          7        0.00        0.00
          2 |         34        0.00        0.00
          3 |         55        0.00        0.01
          4 |         51        0.00        0.01
          5 |         58        0.00        0.01
          6 |         41        0.00        0.01
          7 |         50        0.00        0.02
          8 |         38        0.00        0.02
          9 |         33        0.00        0.02
         10 |         24        0.00        0.02
         11 |         30        0.00        0.02
         12 |         31        0.00        0.02
         13 |         35        0.00        0.03
         14 |         21        0.00        0.03
         15 |         24        0.00        0.03
         16 |  1,817,484       99.97      100.00
------------+-----------------------------------
      Total |  1,818,016      100.00
*/
drop if nchar<16
gen format=regexm(curp,"[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][0-9][0-9][0-9][0-9][0-9][0-9][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]")
/*
tab format

     format |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |        629        0.03        0.03
          1 |  1,816,855       99.97      100.00
------------+-----------------------------------
      Total |  1,817,484      100.00
*/
drop if format==0
drop nchar
drop format
compress

rename folio opc_edu
save "$output/CURP_INE_CROSSOVER.dta", replace


export delimited "$output/CURP_INE_CROSSOVER.txt", replace
