use "$output/metro_Reg_plots.dta", clear

label var Elite_assig "IPN or UNAM assignment"
label var IPN_assig "IPN assignment"
label var UNAM_assig "UNAM assignment"

* Remove invalid values from running variables
replace r_mid_ELITE3 = . if inlist(r_mid_ELITE3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_ELITE3 = . if inlist(r_tau_ELITE3, -3, -2, -1, 0, 1, 2, 3)

replace r_mid_IPN3 = . if inlist(r_mid_IPN3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_IPN3 = . if inlist(r_tau_IPN3, -3, -2, -1, 0, 1, 2, 3)

replace r_mid_UNAM3 = . if inlist(r_mid_UNAM3, -3, -2, -1, 0, 1, 2, 3)
replace r_tau_UNAM3 = . if inlist(r_tau_UNAM3, -3, -2, -1, 0, 1, 2, 3)



*overall
my_rdplot_mid Elite_assig r_mid_ELITE3
graph export "$figures/rd_plot_mid_Elite_assig_ELITE3.pdf", replace
	
my_rdplot_tau Elite_assig r_tau_ELITE3
graph export "$figures/rd_plot_tau_Elite_assig_ELITE3.pdf", replace
	
	
	
*IPN
my_rdplot_mid IPN_assig r_mid_IPN3
graph export "$figures/rd_plot_mid_IPN_assig_IPN3.pdf", replace
	
my_rdplot_tau IPN_assig r_tau_IPN3
graph export "$figures/rd_plot_tau_IPN_assig_IPN3.pdf", replace



*UNAM	
my_rdplot_mid UNAM_assig r_mid_UNAM3
graph export "$figures/rd_plot_mid_UNAM_assig_UNAM3.pdf", replace
	
my_rdplot_tau UNAM_assig r_tau_UNAM3
graph export "$figures/rd_plot_tau_UNAM_assig_UNAM3.pdf", replace


