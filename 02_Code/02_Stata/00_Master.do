/*
cap ado uninstall ftools
net install ftools, from("https://raw.githubusercontent.com/sergiocorreia/ftools/master/src/") replace
cap ado uninstall reghdfe
net install reghdfe, from("https://raw.githubusercontent.com/sergiocorreia/reghdfe/master/src/") replace
cap ado uninstall ivreg2
ssc install ivreg2
cap ssc install moremata
cap ado uninstall ivreghdfe
net install ivreghdfe, from("https://raw.githubusercontent.com/sergiocorreia/ivreghdfe/master/src/") replace
ssc install mipolate
*/

clear all
set more off, permanently
*version 14

	*** Mauricio's laptop
	if "`c(username)'" == "Mauricio"  {
		global folder "C:/Users/Mauricio/Dropbox/Research/LongTerm_HS/"
	}
	
	*** Mauricio's laptop #2
	if "`c(username)'" == "mauri"  {
		global folder "C:/Users/mauri/Dropbox/Research/LongTerm_HS/"
	}
	
	*** Mauricio's ITAM desktop
	if "`c(username)'" == "MROMEROLO"  {
		global folder "D:/Dropbox/Research/LongTerm_HS/"
	}
	
	*** Marco's laptop
	if "`c(username)'" == "marcomedina" {
		global folder "/Users/marcomedina/ITAM Seira Research Dropbox/Marco Alejandro Medina/LongTerm_HS"
	}
	
	*** Marco's desktop
	if "`c(username)'" == "Guest" {
		global folder "C:/Users/Guest/ITAM Seira Research Dropbox/Marco Alejandro Medina/LongTerm_HS"
	}
	
	
	
	
	*Define globals
	global codes 			"$folder/02_Code/02_Stata"
	global input 			"$folder/01_Data/01_Raw"
	global output 			"$folder/01_Data/02_Created"
	global tables 			"$folder/03_Tables"
	global figures 			"$folder/04_Figures"
	
	*Run program to make pretty tables
	*do "$codes/programs/TvC_Tables.do"
	
	*How to show stars
	global stars			"label nolines nogaps fragment nomtitle nonumbers noobs nodep star(* 0.10 ** 0.05 *** 0.01) collabels(none) booktabs"			// used with esttab
	global stars2			"style(tex) starl(* 0.10 ** 0.05 *** 0.01) label cells(b(star fmt(a2)) se(par fmt(a2))) mlabels(none) collabels(none)"			// used with estout

	
	
	*** Produces means by treatment arm, differences with pair FE, and p-values 
		capt prog drop my_ptest_strata
		*Based on a program written by  Ben Jann
		program my_ptest_strata, eclass
		*clus(clus_var)
		syntax varlist [if] [in], treatment(varname) clus_id(varname) strata(string) [ * ] 

		marksample touse
		markout `touse' `by'
		tempname c_1 t_1  cse_1 tse_1  cN_1 tN_1  p_1   

		foreach var of local varlist {
			***REG WITH strata FIXED EFFECTS ***
			reghdfe `var'  `treatment'   `if',  vce(cluster `clus_id') abs(`strata')
			test (_b[`treatment']== 0)
			mat `p_1'  = nullmat(`p_1'),r(p)
			*Treatment effect and SD
			lincom (`treatment' )
			mat `t_1' = nullmat(`t_1'), r(estimate)
			mat `tse_1' = nullmat(`tse_1'), r(se)
			
			*Control mean and SD
			sum `var' if `treatment'==0 & e(sample)==1
			mat `c_1' = nullmat(`c_1'), r(mean)
			mat `cse_1' = nullmat(`cse_1'), r(sd)
			*Sample sizes
			count if `treatment'==0 & e(sample)==1
			mat `cN_1' = nullmat(`cN_1'), r(N)
			count if `treatment'==1 & e(sample)==1
			mat `tN_1' = nullmat(`tN_1'), r(N)
			
			
		}
		
		foreach mat in c_1 t_1  cse_1 tse_1  cN_1 tN_1  p_1   {
			mat coln ``mat'' = `varlist'
		}
		
		local cmd "my_ptest_strata"
		foreach mat in  c_1 t_1  cse_1 tse_1  cN_1 tN_1  p_1  {
			eret mat `mat' = ``mat''
		}
		
	end
	
	
		*** Produces means by treatment arm, differences with pair FE, and p-values 
		capt prog drop my_ptest_strata_running
		*Based on a program written by  Ben Jann
		program my_ptest_strata_running, eclass
		*clus(clus_var)
		syntax varlist [if] [in], treatment(varname) clus_id(varname) strata(string) running(varname) [ * ] 

		marksample touse
		markout `touse' `by'
		tempname c_1 t_1  cse_1 tse_1  cN_1 tN_1  p_1   

		foreach var of local varlist {
			***REG WITH strata FIXED EFFECTS ***
			reghdfe `var'  `treatment'  c.`running' c.`running'#c.`treatment' `if',  vce(cluster `clus_id') abs(`strata')
			test (_b[`treatment']== 0)
			mat `p_1'  = nullmat(`p_1'),r(p)
			*Treatment effect and SD
			lincom (`treatment' )
			mat `t_1' = nullmat(`t_1'), r(estimate)
			mat `tse_1' = nullmat(`tse_1'), r(se)
			
			*Control mean and SD
			sum `var' if `treatment'==0 & e(sample)==1
			mat `c_1' = nullmat(`c_1'), r(mean)
			mat `cse_1' = nullmat(`cse_1'), r(sd)
			*Sample sizes
			count if `treatment'==0 & e(sample)==1
			mat `cN_1' = nullmat(`cN_1'), r(N)
			count if `treatment'==1 & e(sample)==1
			mat `tN_1' = nullmat(`tN_1'), r(N)
			
			
		}
		
		foreach mat in c_1 t_1  cse_1 tse_1  cN_1 tN_1  p_1   {
			mat coln ``mat'' = `varlist'
		}
		
		local cmd "my_ptest_strata_running"
		foreach mat in  c_1 t_1  cse_1 tse_1  cN_1 tN_1  p_1  {
			eret mat `mat' = ``mat''
		}
		
	end
	
	*** Produces rd_plots
	capt prog drop my_rdplot
	program my_rdplot, rclass
	syntax varlist(min=2 max=2) [if] [in] [, cutoff(real 0) delta(real 3)] 
	
	marksample touse
	markout `touse' `by'
	gettoken var running_var : varlist
	
	* Below threshold
	*reg `var' `running_var' if `touse' & inrange(`running_var',`cutoff',`=`cutoff'+`delta'')
	
	
	*	RD graph
	twoway (lfitci `var' `running_var' if `touse' & inrange(`running_var',`cutoff',`=`cutoff'+`delta''), range(`cutoff',`=`cutoff'+`delta'')) ///
		   (lfitci `var' `running_var' if `touse' & inrange(`running_var',`=`cutoff'-`delta'',`cutoff'), range(`=`cutoff'-`delta'',`cutoff'))
	end
	
	exit
	
