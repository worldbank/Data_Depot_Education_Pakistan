* ASAER DATA CLEANING : 
* Author: Ahmed Raza
* Date: 18th Nov 2019
* Purpose: To create the panel of EGRA datasets to be merged with the country level and province level datasets.

		* Dropbox Globals
			
		include init.do
			
		
		************************************************************************
		
		use "$egra_clean/EGRA_clean_2013-2017.dta", clear
		
		************************************************************************
	
		
		* keep baseline data
		
		keep if year ==2013
		keep panelid year province country grade female clpm orf weight_egra region
				
		isid panelid
		
		note: EGRA Panel doesn't have school category variable, asset quintiles, and district key. False age variable is generated and coded as 6 for the analysis. 
		
		

		drop country 
		
		gen country = 1
		lab def country 1 "Pakistan"
		lab val country country
		 
		gen sex = 1 if female == 0
		replace sex = 2 if female == 1
		 
		la def sex 1 "male" 2 "female"
		la val sex sex
		 
		
		gen aq =.
		
		gen age = 6
		
		gen dist_key =. 
		
		la var sex "Sex"
		la var aq "Wealth/Asset Quintiles"
		la var age "False Age not included in the EGRA dataset"
		la var dist_key "District - Key"
		la var country "Country"
		la var province "Province"
		la var region "Region"
		
		save "$panel/egra_panel.dta", replace
		
		save "$panel/egra_panel_baseline.dta", replace
		
		************************************************************************

		
