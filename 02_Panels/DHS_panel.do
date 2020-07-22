* Author: Ahmed Raza
* Date: 5th Feburary 2020
* Purpose: To create DHS HH level panel 

********************************************************************************

	    * Dropbox Globals
		
        include init.do
	 
		
********************************************************************************
				
		use "$dhs_clean/DHS_HH_clean_2017.dta", clear
	
	
		ren hv001 hh_cluster
		ren hv002 hhcode 
		ren hvidx member_id
		ren hv021 psu


		
		clonevar relation = hv101
		
		keep hh_cluster hhcode member_id year province dist_key dist_nm age sex female education_status in_school_ever in_school /// 
		highest_grade current_grade highest_grade_dhs current_grade_dhs wealth_quintiles weight_dhs relation hh_educ_level region psu
		
		
		order hh_cluster hhcode member_id year province dist_key dist_nm age sex female education_status in_school_ever in_school /// 
		highest_grade current_grade highest_grade_dhs current_grade_dhs wealth_quintiles weight_dhs relation hh_educ_level region psu

		tempfile dhs_2017
		save `dhs_2017', replace
		
	
		
		use "$dhs_clean/DHS_HH_clean_2012.dta", clear
		
		
		ren hv001 hh_cluster
		ren hv002 hhcode 
		ren hvidx member_id
		ren hv021 psu
		
		clonevar relation = hv101
		
		
		keep hh_cluster hhcode member_id year province dist_key dist_nm age sex female education_status in_school_ever in_school ///
		highest_grade current_grade highest_grade_dhs current_grade_dhs wealth_quintiles weight_dhs relation hh_educ_level region psu
		
		order hh_cluster hhcode member_id year province dist_key dist_nm age sex female education_status in_school_ever in_school ///
		highest_grade current_grade highest_grade_dhs current_grade_dhs wealth_quintiles weight_dhs relation  hh_educ_level region psu

		tempfile dhs_2012
		save `dhs_2012', replace
		
			
		* Append the data
		
		append using `dhs_2017'
		
		
		gen dataset = "dhs"
		gen country = "Pakistan"
		
		
		compress
		
		note: DHS Panel doesn't have school category variable
		
		
		drop country 
		
		gen country = 1
		lab def country 1 "Pakistan"
		lab val country country
		
		
		* Unique identifiers
		isid hhcode hh_cluster member_id year	
		
		
		* Change name of the asset quintiles to suit program
		
		ren wealth_quintiles aq 
		
		la var sex "Sex"
		la var aq "Wealth/Asset Quintiles"
		la var age "Age"
		la var dist_key "District - Key"
		la var country "Country"
		la var province "Province"
		
		la var year "Year"
		la var weight_dhs "Weight: DHS"
		la var education_status "Education Status of the Member"
		la var member_id "Member ID"
		
		la var hh_educ_level "HH's Education level (Head/Parents)"
		la var region "Region"
		la var dataset "Data Source"
		
		la var in_school "Currently Enrolled In School"
		la var in_school_ever "Ever Enrolled in School"
		
		gen ps=.
		la var ps "Private School Dummy"
		
		la var current_grade "Current grade (0-10)"
		la var highest_grade "Highest grade (0-10)"
		
		* Unique Indentifier check:
		
		isid hh_cluster hhcode member_id year
		
		
		
		* Save the panel:
	
		save "$panel/dhs_panel.dta", replace
	
	