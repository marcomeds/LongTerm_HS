*ssc install find
*ssc install rcd
 
*******************************************************************************/
clear
set more off
 
 
rcd "$folder/02_Code/02_Stata"  : find *.do , match(metro_Reg_MARGINAL) show
