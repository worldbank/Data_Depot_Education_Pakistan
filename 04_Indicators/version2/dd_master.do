
* Author: Koen Geven & Ahmed Raza
* Date: 10th June, 2020
* Purpose: Combine estimations to create a master DD dataset
	   
	   
	   
	   * Init Globals:
		
	    include init.do
	 

**** Switches

local switch_estimations 1
local switch_combine_estimations 1
local switch_labelling 1


**** Calculate Estimations from the Panel 

if `switch_estimations'==1 {
	include dd_estimations.do
	}
	
**** Combine Estimations 

if `switch_combine_estimations'==1 {
	include dd_combine.do
	}

	
**** Format & Label the master file and save it.

if `switch_labelling'==1 {
	include dd_label.do
	}
	
	
	
*  compress and save the dataset 

	 compress
	 save "$pe\DD_Pak_master_version2.dta", replace
	
		
* Country level

	preserve 

		keep if country_tag != 0
		save "$pe\DD_Pak_country_level_version2.dta", replace
	    export delimited using "$pe\DD_Pak_country_level_version2.csv", replace

	restore


* Province level

	preserve 

		keep if province_tag != 0
		save "$pe\DD_Pak_province_level_version2.dta", replace
	    export delimited using "$pe\DD_Pak_province_level_version2.csv", replace

	restore


* District level

	preserve 

		keep if district_tag != 0
		save "$pe\DD_Pak_district_level_version2.dta", replace
	    export delimited using "$pe\DD_Pak_district_level_version2.csv", replace

	restore

		
	
	
	