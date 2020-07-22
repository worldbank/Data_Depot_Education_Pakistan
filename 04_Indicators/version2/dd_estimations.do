
* Author: Koen Geven & Ahmed Raza
* Date: 10th June, 2020 
* Purpose: To create point estimates from Panels and create DD master dataset
* Version: 2


* Init Globals:

include init.do


* Include dd_indicator program 

include dd_indicator_AR2.do

/*

* Program output:
 Path: "\WBG\Ayesha Tahir - Data Depot_Education_Pakistan\03_Processed_Data\Point_Estimates\point_estimates2"

*/


********************************************************************************
**** Calculating Point Estimates:	()Means, SDs, Ns)
********************************************************************************	

		
********************************************************************************	
 * 1 - Indicator(s): In School & Private Share (Age: 6-10, 6-16, 11-16)
********************************************************************************	
	
	* Load datset:
	
	use "$panel\pslm_panel.dta", clear

	set trace off

    local k = 0
    foreach min of numlist 5 5 11 {
	local max1 = `min' + 5
	local max2 = `min' + 11 
	local ++k
	
	if `k' == 1 & `max2' < 17 {
		local max = `max2'
		dd_indicator in_school ps, agegroup(`min' `max') disaggregation(sex aq region) ds(aser mics pslm hies dhs) 
	
	}
	
	else {
		local max = `max1'
		dd_indicator in_school ps, agegroup(`min' `max') disaggregation(sex aq region) ds(aser mics pslm hies dhs) 
	
	}	
 }



		
********************************************************************************	
 * 2 - Indicator(s): Reading & Division Share (Age: 6-8, 9-11, 12-14)
********************************************************************************	

	* Load datset:
	
	use "$panel\aser_panel.dta", clear

	set trace off

	local k = 0
	foreach min of numlist 6 9 12 {
		local max = `min' + 2 
		local ++k
		
		dd_indicator reading division, agegroup(`min' `max') disaggregation(sex aq region) ds(aser) 


 }
	

	
********************************************************************************	
* 3 - Indicator(s): Literacy & Numeracy (Age: 12-18, 19-25, 26-32)
********************************************************************************	
	
	
	* Load datset:
		
	use "$panel\pslm_panel.dta", clear

	set trace off

	local k = 0
	foreach min of numlist 12 19 26 {
	local max = `min' + 6 
	local ++k
		
	dd_indicator read math, agegroup(`min' `max') disaggregation(sex aq region) ds(pslm hies) 

 }
		
	
********************************************************************************	
* 4 - Indicator(s) : EGRA Oral Reading Fluency 
********************************************************************************	

* Note: EGRA dataset has no age variable. For the sake of estimation a false age variable was generated. We are not showcasing EGRA data by age but by grade and other disaggregations. 
	
		
	* Load datset:
	
	use "$panel\egra_panel.dta", clear

	set trace off

	local k = 0
	foreach min of numlist 6 {
	local max = `min' + 4 
	local ++k
	
	dd_indicator clpm orf, agegroup(`min' `max') disaggregation(sex region grade) ds(egra) 
		
	}
	


	* Datasets:

	* Share Private & In School
	use "$pe/point_estimates2/results_5_10.dta", clear
	use "$pe/point_estimates2/results_11_16.dta", clear
	use "$pe/point_estimates2/results_5_16.dta", clear


    * ASER - Reading & Division
	use "$pe/point_estimates2/results_6_8.dta", clear
	use "$pe/point_estimates2/results_9_11.dta", clear
	use "$pe/point_estimates2/results_12_14.dta", clear


    * PSLM/HIES - Literacy & Numeracy 	
	use "$pe/point_estimates2/results_12_18.dta", clear
	use "$pe/point_estimates2/results_19_25.dta", clear
	use "$pe/point_estimates2/results_26_32.dta", clear

	* EGRA
	use "$pe/point_estimates2/results_6_10.dta", clear



		
	
	