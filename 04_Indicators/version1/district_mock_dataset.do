
* DATASETS: ASER, MICS, PSLM 
* Author: Koen Geven & Ahmed Raza
* Date: 9th December, 2019 
* Purpose: To create district-level mock dataset


clear all
set more off

		* Dropbox Globals
		
		
	    include init.do
	 
		gl panel "$output\Panel"
		gl pe "$output\Point_Estimates" 
	
        * include programs do file for Point Estimates
	    include pe_program.do
		
		
********************************************************************************		



 use "$pe\DD_Pak_pe_district_with_spending_indicators_version1.1.dta", clear
 
 
 keep province dist_key dist_nm year dataset reading_9_11 reading_9_11_se reading_boys_9_11 reading_boys_9_11_se reading_girls_9_11 reading_girls_9_11_se in_school_6_10 in_school_6_10_se in_school_11_16 in_school_11_16_se in_school_boys_6_10 in_school_boys_6_10_se in_school_boys_11_16 in_school_boys_11_16_se in_school_girls_6_10 in_school_girls_6_10_se in_school_girls_11_16 in_school_girls_11_16_se  totalpopulation area population_den gdp gdp_pc poverty_rate urban_share total_usd total_develop_us total_current_us
 order province dist_key dist_nm year dataset reading_9_11 reading_9_11_se reading_boys_9_11 reading_boys_9_11_se reading_girls_9_11 reading_girls_9_11_se in_school_6_10 in_school_6_10_se in_school_11_16 in_school_11_16_se in_school_boys_6_10 in_school_boys_6_10_se in_school_boys_11_16 in_school_boys_11_16_se in_school_girls_6_10 in_school_girls_6_10_se in_school_girls_11_16 in_school_girls_11_16_se  totalpopulation area population_den gdp gdp_pc poverty_rate urban_share total_usd total_develop_us total_current_us

 
 
 /*
* Demographic vars: 
 province dist_key dist_nm year dataset 
 
* Reading & in_schoo vars: 
 reading_9_11 reading_9_11_se reading_boys_9_11 reading_boys_9_11_se reading_girls_9_11 reading_girls_9_11_se in_school_6_10 in_school_6_10_se in_school_11_16 in_school_11_16_se in_school_boys_6_10 in_school_boys_6_10_se in_school_boys_11_16 in_school_boys_11_16_se in_school_girls_6_10 in_school_girls_6_10_se in_school_girls_11_16 in_school_girls_11_16_se
 
 * Other covariates:
 totalpopulation area population_den gdp gdp_pc poverty_rate urban_share total_usd total_develop_us total_current_us
 */
 
 
 * Mock data:
 
 
 ren total_usd spending_total_usd 
 ren total_develop_us spending_total_develop_us
 ren total_current_us spending_total_current_us
 
  * We don't use ASER estimates for in_school vars: Recode them to missing for aser 
 
 replace in_school_6_10 = . if dataset == "aser"
 replace in_school_6_10_se = . if dataset == "aser"
 replace in_school_11_16 = . if dataset == "aser"
 replace in_school_11_16_se = . if dataset == "aser"
 replace in_school_boys_6_10 = . if dataset == "aser"
 replace in_school_boys_6_10_se = . if dataset == "aser"
 replace in_school_boys_11_16 = . if dataset == "aser"
 replace in_school_boys_11_16_se = . if dataset == "aser"
 replace in_school_girls_6_10 = . if dataset == "aser"
 replace in_school_girls_6_10_se = . if dataset == "aser"
 replace in_school_girls_11_16 = . if dataset == "aser"
 replace in_school_girls_11_16_se = . if dataset == "aser"
 
 
sort dataset year
 
 export excel using "$pe\district_level_mockdataset.xls", firstrow(variables) replace
 
 
 ex

 