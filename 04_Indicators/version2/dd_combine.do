

********************************************************************************
**** Merging Point Estimates to Create DD_Master File:	
********************************************************************************	
	
	* In School and Private Share:

	use "$pe/point_estimates2/results_5_10.dta", clear
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_11_16.dta", nogen 
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_5_16.dta", nogen 
	
	ta dataset if country ==1
	
********************************************************************************
	
	* Reading/Division - ASER
	
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_9_11.dta", nogen 
	
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_6_8.dta", nogen 
	
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_12_14.dta", nogen 
	
	ta dataset if country ==1
	
********************************************************************************
	
	* Literacy/Numercay - PSLM, HIES
	
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_12_18.dta", nogen 
	
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_19_25.dta", nogen 
	
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_26_32.dta", nogen 
	
	ta dataset if country ==1

********************************************************************************
	
	* EGRA :
		
	merge 1:1 country province district year dataset using "$pe\point_estimates2\results_6_10.dta", nogen 
	
	ta dataset if country ==1
	
	
********************************************************************************

	tempfile dd_master
	save `dd_master', replace
	