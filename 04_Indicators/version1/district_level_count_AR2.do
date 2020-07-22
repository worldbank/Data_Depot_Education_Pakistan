
* Author: Koen Geven & Ahmed Raza
* Date: 12th November, 2019 
* Purpose: To create point estimates from Panels and create a district level dataset
* Version: 1.3

	   * Init Globals:
		
	    include init.do
	 
		gl panel "$output\Panel"
		gl pe "$output\Point_Estimates" 
	
        * include programs do file for Point Estimates
	    include n_program.do
		
		
********************************************************************************
* Set Restrictions for Point Estimates:
********************************************************************************

		* Set age restrictions:		 
		local age1 age >= 6 & age <= 10
		local age2 age >= 11 & age <= 16
		local age3 age >= 6 & age <= 16
		
		* Set Gender restrictions:
		local boys sex==1
		local girls sex==2
		
		* Region:
		local rural region == 2
		local urban region == 1
		
		* Wealth/Asset Quintiles:
		local wq1 wealth_quintiles ==1
		local wq2 wealth_quintiles ==2
		local wq3 wealth_quintiles ==3
		local wq4 wealth_quintiles ==4
		local wq5 wealth_quintiles ==5

		local aq1 asset_quintiles ==1
		local aq2 asset_quintiles ==2
		local aq3 asset_quintiles ==3
		local aq4 asset_quintiles ==4
		local aq5 asset_quintiles ==5
		
		
		
		
********************************************************************************
	    *  DHS Panels
********************************************************************************
		
		use "$panel\dhs_panel.dta", clear


		* Set input Vars
		local iv in_school
		
		* Loop
		
		foreach i of local iv {
		
		* Aggregate
		
		* By Age Group
		pe `iv' , tv("`iv'_6_10") ds("dhs") restrict ("`age1'") level("district")
		pe `iv' , tv("`iv'_11_16") ds("dhs") restrict("`age2'") level("district")
		pe `iv' , tv("`iv'_6_16") ds("dhs") restrict ("`age3'") level("district")
		
		* By Region
		pe `iv' , tv("`iv'_rural") ds("dhs") restrict ("`rural'") level("district")
		pe `iv' , tv("`iv'_urban") ds("dhs") restrict ("`urban'") level("district")

		* By quintiles
		
		pe `iv' , tv("`iv'_wq1") ds("dhs") restrict ("`wq1'") level("district")
		pe `iv' , tv("`iv'_wq2") ds("dhs") restrict ("`wq2'") level("district")
		pe `iv' , tv("`iv'_wq3") ds("dhs") restrict ("`wq3'") level("district")
		pe `iv' , tv("`iv'_wq4") ds("dhs") restrict ("`wq4'") level("district")
		pe `iv' , tv("`iv'_wq5") ds("dhs") restrict ("`wq5'") level("district")

		
	   * Interaction 1: Age-Groups by Gender:
	   
		* Boys
		
		pe `iv' , tv("`iv'_boys_6_10") ds("dhs") restrict ("`age1' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_11_16") ds("dhs") restrict("`age2' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_6_16") ds("dhs") restrict ("`age3' & `boys'") level("district")
		
		* Girls
		
		pe `iv' , tv("`iv'_girls_6_10") ds("dhs") restrict ("`age1' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_11_16") ds("dhs") restrict("`age2' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_6_16") ds("dhs") restrict ("`age3' & `girls'") level("district")


		* Interaction 2: Age-Groups by Region:
		
		* Rural
		
		pe `iv' , tv("`iv'_rural_6_10") ds("dhs") restrict ("`age1' & `rural'") level("district")
		pe `iv' , tv("`iv'_rural_11_16") ds("dhs") restrict("`age2' & `rural'") level("district")
		pe `iv' , tv("`iv'_rural_6_16") ds("dhs") restrict ("`age3' & `rural'") level("district")
		
		* Urban
		
		pe `iv' , tv("`iv'_urban_6_10") ds("dhs") restrict ("`age1' & `urban'") level("district")
		pe `iv' , tv("`iv'_urban_11_16") ds("dhs") restrict("`age2' & `urban'") level("district")
		pe `iv' , tv("`iv'_urban_6_16") ds("dhs") restrict ("`age3' & `urban'") level("district")
		
		
		* Interaction 3: Age-Groups by Wealth/Asset Quintiles:
		
		* 6-10
		
		pe `iv' , tv("`iv'_wq1_6_10") ds("dhs") restrict ("`age1' & `wq1'") level("district")
		pe `iv' , tv("`iv'_wq2_6_10") ds("dhs") restrict ("`age1' & `wq2'") level("district")
		pe `iv' , tv("`iv'_wq3_6_10") ds("dhs") restrict ("`age1' & `wq3'") level("district")
		pe `iv' , tv("`iv'_wq4_6_10") ds("dhs") restrict ("`age1' & `wq4'") level("district")
		pe `iv' , tv("`iv'_wq5_6_10") ds("dhs") restrict ("`age1' & `wq5'") level("district")

		* 11-16

		pe `iv' , tv("`iv'_wq1_11_16") ds("dhs") restrict ("`age2' & `wq1'") level("district")
		pe `iv' , tv("`iv'_wq2_11_16") ds("dhs") restrict ("`age2' & `wq2'") level("district")
		pe `iv' , tv("`iv'_wq3_11_16") ds("dhs") restrict ("`age2' &`wq3'") level("district")
		pe `iv' , tv("`iv'_wq4_11_16") ds("dhs") restrict ("`age2' & `wq4'") level("district")
		pe `iv' , tv("`iv'_wq5_11_16") ds("dhs") restrict ("`age2' & `wq5'") level("district")

		* 6-16:
		
		pe `iv' , tv("`iv'_wq1_6_16") ds("dhs") restrict ("`age3' & `wq1'") level("district")
		pe `iv' , tv("`iv'_wq2_6_16") ds("dhs") restrict ("`age3' & `wq2'") level("district")
		pe `iv' , tv("`iv'_wq3_6_16") ds("dhs") restrict ("`age3' & `wq3'") level("district")
		pe `iv' , tv("`iv'_wq4_6_16") ds("dhs") restrict ("`age3' & `wq4'") level("district")
		pe `iv' , tv("`iv'_wq5_6_16") ds("dhs") restrict ("`age3' & `wq5'") level("district")

		}	
		
			
********************************************************************************	
		*  PSLM Panel
		use "$panel\pslm_panel.dta", clear
********************************************************************************
		
		* Create Private Share:
		
		gen  private_share = 1 if in_school ==1 & school_category ==1
		replace private_share =0 if in_school ==1 & school_category != 1

			
		* Set input Vars
		local iv in_school

		foreach i of local iv {
		
		* Aggregate
		
		* By Age Group
		pe `iv' , tv("`iv'_6_10") ds("pslm") restrict ("`age1'") level("district")
		pe `iv' , tv("`iv'_11_16") ds("pslm") restrict("`age2'") level("district")
		pe `iv' , tv("`iv'_6_16") ds("pslm") restrict ("`age3'") level("district")
		
		* By Region
		pe `iv' , tv("`iv'_rural") ds("pslm") restrict ("`rural'") level("district")
		pe `iv' , tv("`iv'_urban") ds("pslm") restrict ("`urban'") level("district")

		* By quintiles
		
		pe `iv' , tv("`iv'_wq1") ds("pslm") restrict ("`aq1'") level("district")
		pe `iv' , tv("`iv'_wq2") ds("pslm") restrict ("`aq2'") level("district")
		pe `iv' , tv("`iv'_wq3") ds("pslm") restrict ("`aq3'") level("district")
		pe `iv' , tv("`iv'_wq4") ds("pslm") restrict ("`aq4'") level("district")
		pe `iv' , tv("`iv'_wq5") ds("pslm") restrict ("`aq5'") level("district")

		
	   * Interaction 1: Age-Groups by Gender:
	   
		* Boys
		
		pe `iv' , tv("`iv'_boys_6_10") ds("pslm") restrict ("`age1' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_11_16") ds("pslm") restrict("`age2' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_6_16") ds("pslm") restrict ("`age3' & `boys'") level("district")
		
		* Girls
		
		pe `iv' , tv("`iv'_girls_6_10") ds("pslm") restrict ("`age1' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_11_16") ds("pslm") restrict("`age2' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_6_16") ds("pslm") restrict ("`age3' & `girls'") level("district")


		* Interaction 2: Age-Groups by Region:
		
		* Rural
		
		pe `iv' , tv("`iv'_rural_6_10") ds("pslm") restrict ("`age1' & `rural'") level("district")
		pe `iv' , tv("`iv'_rural_11_16") ds("pslm") restrict("`age2' & `rural'") level("district")
		pe `iv' , tv("`iv'_rural_6_16") ds("pslm") restrict ("`age3' & `rural'") level("district")
		
		* Urban
		
		pe `iv' , tv("`iv'_urban_6_10") ds("pslm") restrict ("`age1' & `urban'") level("district")
		pe `iv' , tv("`iv'_urban_11_16") ds("pslm") restrict("`age2' & `urban'") level("district")
		pe `iv' , tv("`iv'_urban_6_16") ds("pslm") restrict ("`age3' & `urban'") level("district")
		
		
		* Interaction 3: Age-Groups by Wealth/Asset Quintiles:
		
		* 6-10
		
		pe `iv' , tv("`iv'_wq1_6_10") ds("pslm") restrict ("`age1' & `aq1'") level("district")
		pe `iv' , tv("`iv'_wq2_6_10") ds("pslm") restrict ("`age1' & `aq2'") level("district")
		pe `iv' , tv("`iv'_wq3_6_10") ds("pslm") restrict ("`age1' & `aq3'") level("district")
		pe `iv' , tv("`iv'_wq4_6_10") ds("pslm") restrict ("`age1' & `aq4'") level("district")
		pe `iv' , tv("`iv'_wq5_6_10") ds("pslm") restrict ("`age1' & `aq5'") level("district")

		* 11-16

		pe `iv' , tv("`iv'_wq1_11_16") ds("pslm") restrict ("`age2' & `aq1'") level("district")
		pe `iv' , tv("`iv'_wq2_11_16") ds("pslm") restrict ("`age2' & `aq2'") level("district")
		pe `iv' , tv("`iv'_wq3_11_16") ds("pslm") restrict ("`age2' & `aq3'") level("district")
		pe `iv' , tv("`iv'_wq4_11_16") ds("pslm") restrict ("`age2' & `aq4'") level("district")
		pe `iv' , tv("`iv'_wq5_11_16") ds("pslm") restrict ("`age2' & `aq5'") level("district")

		* 6-16:
		
		pe `iv' , tv("`iv'_wq1_6_16") ds("pslm") restrict ("`age3' & `aq1'") level("district")
		pe `iv' , tv("`iv'_wq2_6_16") ds("pslm") restrict ("`age3' & `aq2'") level("district")
		pe `iv' , tv("`iv'_wq3_6_16") ds("pslm") restrict ("`age3' & `aq3'") level("district")
		pe `iv' , tv("`iv'_wq4_6_16") ds("pslm") restrict ("`age3' & `aq4'") level("district")
		pe `iv' , tv("`iv'_wq5_6_16") ds("pslm") restrict ("`age3' & `aq5'") level("district")

		}	
	

	
********************************************************************************
		
		* Indicators without the interactions:
			
		* Share of adolescents who are literate (self-reported) - literacy_12_18
		pe read_pslm , tv("literacy_12_18") ds("pslm") restrict("age >= 12 & age <= 18") level("district")
		
		* Share of adolescents who are numerate (self-reported) - numeracy_12_18
		pe math_pslm , tv("numeracy_12_18") ds("pslm") restrict("age >= 12 & age <= 18") level("district")
		
		* Share of adolescent boys (aged 12-18) who are literate (self-reported) - literacy_boys_12_18
		pe read_pslm , tv("literacy_boys_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==1") level("district")
		
		* Share of adolescent boys (aged 12-18) who are numerate (self-reported) - numeracy_boys_12_18
		pe math_pslm , tv("numeracy_boys_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==1") level("district")
	  
		* Share of adolescent girls (aged 12-18) who are literate (self-reported) -  literacy_girls_12_18
		pe read_pslm , tv("literacy_girls_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==2") level("district")
		
		* Share of adolescent girls (aged 12-18) who are numerate (self-reported) - numeracy_girls_12_18
		pe math_pslm , tv("numeracy_girls_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==2") level("district")

		
		* Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
		pe private_share , tv("share_private_6_10") ds("pslm") restrict("age >= 6 & age <= 10") level("district")

		* Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
		pe private_share , tv("share_private_11_16") ds("pslm") restrict("age >= 11 & age <= 16") level("district")
		
		* Share of kids (aged 6-16) in private schools, among those enrolled - share_private_6_16
		pe private_share , tv("share_private_6_16") ds("pslm") restrict("age >= 6 & age <= 16") level("district")

	
	
********************************************************************************

		
		************************************************************************
		* MICS Panel
		use "$panel\mics_panel.dta", clear
		************************************************************************
	 
		gen  private_share = 1 if in_school ==1 & school_category ==1
		replace private_share =0 if in_school ==1 & school_category != 1
		
		
		* Set input Vars
		local iv in_school

		foreach i of local iv {
		
		* Aggregate
		
		* By Age Group
		pe `iv' , tv("`iv'_6_10") ds("mics") restrict ("`age1'") level("district")
		pe `iv' , tv("`iv'_11_16") ds("mics") restrict("`age2'") level("district")
		pe `iv' , tv("`iv'_6_16") ds("mics") restrict ("`age3'") level("district")
		
		* By Region
		pe `iv' , tv("`iv'_rural") ds("mics") restrict ("`rural'") level("district")
		pe `iv' , tv("`iv'_urban") ds("mics") restrict ("`urban'") level("district")

		* By quintiles
		
		pe `iv' , tv("`iv'_wq1") ds("mics") restrict ("`aq1'") level("district")
		pe `iv' , tv("`iv'_wq2") ds("mics") restrict ("`aq2'") level("district")
		pe `iv' , tv("`iv'_wq3") ds("mics") restrict ("`aq3'") level("district")
		pe `iv' , tv("`iv'_wq4") ds("mics") restrict ("`aq4'") level("district")
		pe `iv' , tv("`iv'_wq5") ds("mics") restrict ("`aq5'") level("district")

		
	   * Interaction 1: Age-Groups by Gender:
	   
		* Boys
		
		pe `iv' , tv("`iv'_boys_6_10") ds("mics") restrict ("`age1' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_11_16") ds("mics") restrict("`age2' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_6_16") ds("mics") restrict ("`age3' & `boys'") level("district")
		
		* Girls
		
		pe `iv' , tv("`iv'_girls_6_10") ds("mics") restrict ("`age1' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_11_16") ds("mics") restrict("`age2' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_6_16") ds("mics") restrict ("`age3' & `girls'") level("district")


		* Interaction 2: Age-Groups by Region:
		
		* Rural
		
		pe `iv' , tv("`iv'_rural_6_10") ds("mics") restrict ("`age1' & `rural'") level("district")
		pe `iv' , tv("`iv'_rural_11_16") ds("mics") restrict("`age2' & `rural'") level("district")
		pe `iv' , tv("`iv'_rural_6_16") ds("mics") restrict ("`age3' & `rural'") level("district")
		
		* Urban
		
		pe `iv' , tv("`iv'_urban_6_10") ds("mics") restrict ("`age1' & `urban'") level("district")
		pe `iv' , tv("`iv'_urban_11_16") ds("mics") restrict("`age2' & `urban'") level("district")
		pe `iv' , tv("`iv'_urban_6_16") ds("mics") restrict ("`age3' & `urban'") level("district")
		
		
		* Interaction 3: Age-Groups by Wealth/Asset Quintiles:
		
		* 6-10
		
		pe `iv' , tv("`iv'_wq1_6_10") ds("mics") restrict ("`age1' & `aq1'") level("district")
		pe `iv' , tv("`iv'_wq2_6_10") ds("mics") restrict ("`age1' & `aq2'") level("district")
		pe `iv' , tv("`iv'_wq3_6_10") ds("mics") restrict ("`age1' & `aq3'") level("district")
		pe `iv' , tv("`iv'_wq4_6_10") ds("mics") restrict ("`age1' & `aq4'") level("district")
		pe `iv' , tv("`iv'_wq5_6_10") ds("mics") restrict ("`age1' & `aq5'") level("district")

		* 11-16

		pe `iv' , tv("`iv'_wq1_11_16") ds("mics") restrict ("`age2' & `aq1'") level("district")
		pe `iv' , tv("`iv'_wq2_11_16") ds("mics") restrict ("`age2' & `aq2'") level("district")
		pe `iv' , tv("`iv'_wq3_11_16") ds("mics") restrict ("`age2' & `aq3'") level("district")
		pe `iv' , tv("`iv'_wq4_11_16") ds("mics") restrict ("`age2' & `aq4'") level("district")
		pe `iv' , tv("`iv'_wq5_11_16") ds("mics") restrict ("`age2' & `aq5'") level("district")

		* 6-16:
		
		pe `iv' , tv("`iv'_wq1_6_16") ds("mics") restrict ("`age3' & `aq1'") level("district")
		pe `iv' , tv("`iv'_wq2_6_16") ds("mics") restrict ("`age3' & `aq2'") level("district")
		pe `iv' , tv("`iv'_wq3_6_16") ds("mics") restrict ("`age3' & `aq3'") level("district")
		pe `iv' , tv("`iv'_wq4_6_16") ds("mics") restrict ("`age3' & `aq4'") level("district")
		pe `iv' , tv("`iv'_wq5_6_16") ds("mics") restrict ("`age3' & `aq5'") level("district")

		}	
	
	

********************************************************************************
		* Indicators without the interactions:

		* Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
		pe private_share , tv("share_private_6_10") ds("mics") restrict("age >= 6 & age <= 10") level("district")

		* Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
		pe private_share , tv("share_private_11_16") ds("mics") restrict("age >= 11 & age <= 16") level("district")

		* Share of kids (aged 6-16) in private schools, among those enrolled - share_private_6_16
		pe private_share , tv("share_private_6_16") ds("mics") restrict("age >= 6 & age <= 16") level("district")
		
********************************************************************************	
		
		


********************************************************************************
	* ASER Panel
	use "$panel\aser_panel.dta", clear
********************************************************************************

		gen  private_share = 1 if in_school ==1 & school_category ==1
		replace private_share =0 if in_school ==1 & school_category != 1

		
		
		gen reading = 1 if reading_aser == 5
		replace reading = 0 if reading_aser < 5
	   
		gen division = 1 if math_aser == 6
		replace division = 0 if math_aser < 6
	   
		gen weight_aser = 1 
			
********************************************************************************				
		* Set input Vars
		
		local iv in_school 
	
	    set trace on
		foreach i of local iv {
		
		* Aggregate
		
		* By Age Group
		pe `iv' , tv("`iv'_6_10") ds("aser") restrict ("`age1'") level("district")
		pe `iv' , tv("`iv'_11_16") ds("aser") restrict("`age2'") level("district")
		pe `iv' , tv("`iv'_6_16") ds("aser") restrict ("`age3'") level("district")
		
		/*
		* By Region
		- Not done in case of ASER because urban / rural var is not clean enough
		
		* By quintiles
		- Wealth/Asset Quintiles not included as ASER asset data is limited. Aplha less than 0.80
		
		*/
	   
	    * Interaction 1: Age-Groups by Gender:
	   
		* Boys
		
		pe `iv' , tv("`iv'_boys_6_10") ds("aser") restrict ("`age1' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_11_16") ds("aser") restrict("`age2' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_6_16") ds("aser") restrict ("`age3' & `boys'") level("district")
		
		* Girls
		
		pe `iv' , tv("`iv'_girls_6_10") ds("aser") restrict ("`age1' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_11_16") ds("aser") restrict("`age2' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_6_16") ds("aser") restrict ("`age3' & `girls'") level("district")


		}	
	
********************************************************************************
		
		local iv reading

	
		foreach i of local iv {
		
		* Aggregate
		
		* By Age Group
		pe `iv' , tv("`iv'_6_10") ds("aser") restrict ("`age1'") level("district")
		pe `iv' , tv("`iv'_11_16") ds("aser") restrict("`age2'") level("district")
		pe `iv' , tv("`iv'_6_16") ds("aser") restrict ("`age3'") level("district")
		
		/*
		* By Region
		- Not done in case of ASER because urban / rural var is not clean enough
		
		* By quintiles
		- Wealth/Asset Quintiles not included as ASER asset data is limited. Aplha less than 0.80
		
		*/
	   
	    * Interaction 1: Age-Groups by Gender:
	   
		* Boys
		
		pe `iv' , tv("`iv'_boys_6_10") ds("aser") restrict ("`age1' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_11_16") ds("aser") restrict("`age2' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_6_16") ds("aser") restrict ("`age3' & `boys'") level("district")
		
		* Girls
		
		pe `iv' , tv("`iv'_girls_6_10") ds("aser") restrict ("`age1' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_11_16") ds("aser") restrict("`age2' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_6_16") ds("aser") restrict ("`age3' & `girls'") level("district")


		}	
	

********************************************************************************
	
		local iv division

	
		foreach i of local iv {
		
		* Aggregate
		
		* By Age Group
		pe `iv' , tv("`iv'_6_10") ds("aser") restrict ("`age1'") level("district")
		pe `iv' , tv("`iv'_11_16") ds("aser") restrict("`age2'") level("district")
		pe `iv' , tv("`iv'_6_16") ds("aser") restrict ("`age3'") level("district")
		
		/*
		* By Region
		- Not done in case of ASER because urban / rural var is not clean enough
		
		* By quintiles
		- Wealth/Asset Quintiles not included as ASER asset data is limited. Aplha less than 0.80
		
		*/
	   
	    * Interaction 1: Age-Groups by Gender:
	   
		* Boys
		
		pe `iv' , tv("`iv'_boys_6_10") ds("aser") restrict ("`age1' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_11_16") ds("aser") restrict("`age2' & `boys'") level("district")
		pe `iv' , tv("`iv'_boys_6_16") ds("aser") restrict ("`age3' & `boys'") level("district")
		
		* Girls
		
		pe `iv' , tv("`iv'_girls_6_10") ds("aser") restrict ("`age1' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_11_16") ds("aser") restrict("`age2' & `girls'") level("district")
		pe `iv' , tv("`iv'_girls_6_16") ds("aser") restrict ("`age3' & `girls'") level("district")


		}	
	
	
		
		
********************************************************************************		
	   * Indicators without the interactions:

       * Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
       pe private_share , tv("share_private_6_10") ds("aser") restrict("age >= 6 & age <= 10") level("district")

       * Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
	   pe private_share , tv("share_private_11_16") ds("aser") restrict("age >= 11 & age <= 16") level("district")
	
       * Share of kids (aged 6-16) in private schools, among those enrolled - share_private_6_16
	   pe private_share , tv("share_private_6_16") ds("aser") restrict("age >= 6 & age <= 16") level("district")
		
		
********************************************************************************
	
	
	   ********************************************************************************		
		* Indicators without the interactions:

		* Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
		pe private_share , tv("share_private_6_10") ds("aser") restrict("age >= 6 & age <= 10") level("district")

		* Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
		pe private_share , tv("share_private_11_16") ds("aser") restrict("age >= 11 & age <= 16") level("district")
		
		* Share of kids (aged 6-16) in private schools, among those enrolled - share_private_6_16
		pe private_share , tv("share_private_6_16") ds("aser") restrict("age >= 6 & age <= 16") level("district")
		
		
********************************************************************************
		
		
		
			* CREATE DIST-LEVEL DATASET
			
			* ASER:
			local aser_estimates "in_school_11_16 in_school_6_16 in_school_boys_6_10 in_school_boys_11_16 in_school_boys_6_16 in_school_girls_6_10 in_school_girls_11_16 in_school_girls_6_16 share_private_6_10 share_private_11_16 share_private_6_16 division_6_10 division_11_16 division_6_16 division_boys_6_10 division_boys_11_16 division_boys_6_16 division_girls_6_10 division_girls_11_16 division_girls_6_16 reading_6_10 reading_11_16 reading_6_16 reading_boys_6_10 reading_boys_11_16 reading_boys_6_16 reading_girls_6_10 reading_girls_11_16 reading_girls_6_16"
			
			
			use "$pe/count/district/aser/in_school_6_10.dta", clear
			foreach x of local aser_estimates{
			
			merge 1:1 dist_key year using "$pe/count/district/aser/`x'.dta", nogen
			
			}

			tempfile aser_dist
			save `aser_dist', replace
		
			
			
			* PSLM:
			
			local pslm_estimates "in_school_11_16 in_school_6_16 in_school_boys_6_10 in_school_boys_11_16 in_school_boys_6_16 in_school_girls_6_10 in_school_girls_11_16 in_school_girls_6_16 in_school_rural in_school_rural_6_10 in_school_rural_11_16 in_school_rural_6_16 in_school_urban in_school_urban_6_10 in_school_urban_11_16 in_school_urban_6_16 in_school_wq1 in_school_wq1_6_10 in_school_wq1_11_16 in_school_wq1_6_16 in_school_wq2 in_school_wq2_6_10 in_school_wq2_11_16 in_school_wq2_6_16 in_school_wq3 in_school_wq3_6_10 in_school_wq3_11_16 in_school_wq3_6_16 in_school_wq4 in_school_wq4_6_10 in_school_wq4_11_16 in_school_wq4_6_16 in_school_wq5 in_school_wq5_6_10 in_school_wq5_11_16 in_school_wq5_6_16 share_private_6_10 share_private_11_16 share_private_6_16 literacy_12_18 literacy_boys_12_18 literacy_girls_12_18 numeracy_12_18 numeracy_boys_12_18 numeracy_girls_12_18"


			use "$pe/count/district/pslm/in_school_6_10.dta", clear
			
			foreach x of local pslm_estimates{
			
			merge 1:1 dist_key year using "$pe/count/district/pslm/`x'.dta", nogen
			
			}

			tempfile pslm_dist
			save `pslm_dist', replace
			
			

			
			* DHS:
			
			local dhs_estimates "in_school_11_16 in_school_6_16 in_school_boys_6_10 in_school_boys_11_16 in_school_boys_6_16 in_school_girls_6_10 in_school_girls_11_16 in_school_girls_6_16 in_school_rural in_school_rural_6_10 in_school_rural_11_16 in_school_rural_6_16 in_school_urban in_school_urban_6_10 in_school_urban_11_16 in_school_urban_6_16 in_school_wq1 in_school_wq1_6_10 in_school_wq1_11_16 in_school_wq1_6_16 in_school_wq2 in_school_wq2_6_10 in_school_wq2_11_16 in_school_wq2_6_16 in_school_wq3 in_school_wq3_6_10 in_school_wq3_11_16 in_school_wq3_6_16 in_school_wq4 in_school_wq4_6_10 in_school_wq4_11_16 in_school_wq4_6_16 in_school_wq5 in_school_wq5_6_10 in_school_wq5_11_16 in_school_wq5_6_16"
			
			use "$pe/count/district/dhs/in_school_6_10.dta", clear
			
			foreach x of local dhs_estimates{
			
			merge 1:1 dist_key year using "$pe/count/district/dhs/`x'.dta", nogen
			
			}

			tempfile dhs_dist
			save `dhs_dist', replace
			
			
				
			* MICS
			
			
			local mics_estimates "in_school_11_16 in_school_6_16 in_school_boys_6_10 in_school_boys_11_16 in_school_boys_6_16 in_school_girls_6_10 in_school_girls_11_16 in_school_girls_6_16 in_school_rural in_school_rural_6_10 in_school_rural_11_16 in_school_rural_6_16 in_school_urban in_school_urban_6_10 in_school_urban_11_16 in_school_urban_6_16 in_school_wq1 in_school_wq1_6_10 in_school_wq1_11_16 in_school_wq1_6_16 in_school_wq2 in_school_wq2_6_10 in_school_wq2_11_16 in_school_wq2_6_16 in_school_wq3 in_school_wq3_6_10 in_school_wq3_11_16 in_school_wq3_6_16 in_school_wq4 in_school_wq4_6_10 in_school_wq4_11_16 in_school_wq4_6_16 in_school_wq5 in_school_wq5_6_10 in_school_wq5_11_16 in_school_wq5_6_16 share_private_6_10 share_private_11_16 share_private_6_16"

			use "$pe/count/district/mics/in_school_6_10.dta", clear
			
			foreach x of local mics_estimates{
			
			merge 1:1 dist_key year using "$pe/count/district/mics/`x'.dta", nogen
			
			}

			tempfile mics_dist
			save `mics_dist', replace
			
	
	
	
	***************************************************************************
		
			append using `pslm_dist'
			append using `aser_dist'
			append using `dhs_dist'


	***************************************************************************
	
	
	        * value labels:
	
			* DIST KEY
		
			* Punjab
		
			gen dist_nm = ""
			la var dist_nm "Clean: District Name"
			
			replace dist_nm = "ATTOCK" if dist_key ==1 
			replace dist_nm = "BAHAWALNAGER" if dist_key ==2	
			replace dist_nm = "BAHAWALPUR" if dist_key ==3 
			replace dist_nm = "BHAKKAR" if dist_key ==4
			replace dist_nm = "CHAKWAL" if dist_key ==5 
			replace dist_nm = "DERA GHAZI KHAN" if dist_key ==6 
			replace dist_nm = "FAISALABAD" if dist_key ==7
			replace dist_nm = "GUJRANWALA" if dist_key ==8 
			replace dist_nm = "GUJRAT" if dist_key ==9
			replace dist_nm = "HAFIZABAD" if dist_key ==10 
			replace dist_nm = "JEHLUM" if dist_key ==11 
			replace dist_nm = "JHANG" if dist_key ==12 
			replace dist_nm = "KASUR" if dist_key ==13 
			replace dist_nm = "KHANEWAL" if dist_key ==14 
			replace dist_nm = "KHUSHAB" if dist_key ==15 
				 
			replace dist_nm = "LAHORE" if dist_key ==16
			replace dist_nm = "LAYYAH" if dist_key ==17
			replace dist_nm = "LODHRAN" if dist_key ==18
			replace dist_nm = "MANDI BAHUDDIN" if dist_key ==19
			replace dist_nm = "MIANWALI" if dist_key ==20
			replace dist_nm = "MULTAN" if dist_key ==21
			replace dist_nm = "MUZAFFAR GARH" if dist_key ==22
			replace dist_nm = "NAROWAL" if dist_key ==23
			replace dist_nm = "OKARA" if dist_key ==24
			replace dist_nm = "PAKPATTAN" if dist_key ==25
			replace dist_nm = "RAHIM YAR KHAN" if dist_key ==26
			replace dist_nm = "RAJANPUR" if dist_key ==27
			replace dist_nm = "RAWALPINDI" if dist_key ==28
			replace dist_nm = "SAHIWAL" if dist_key ==29
			replace dist_nm = "SARGODHA" if dist_key ==30
			replace dist_nm = "SHEIKHUPURA" if dist_key ==31
			replace dist_nm = "SIALKOT" if dist_key ==32
			replace dist_nm = "T.T.SINGH" if dist_key ==33
			replace dist_nm = "VEHARI" if dist_key ==34
			replace dist_nm = "NANKANA SAHIB" if dist_key ==35
			replace dist_nm = "CHINIOT" if dist_key ==36
					
			


			*KP:
			
	  
			replace dist_nm = "ABBOTABAD" if dist_key ==37
			replace dist_nm = "BANNU" if dist_key ==38
			replace dist_nm = "BATAGRAM" if dist_key ==39
			replace dist_nm = "BUNER" if dist_key ==40
			replace dist_nm = "CHARSADAHA" if dist_key ==41
			replace dist_nm = "CHITRAL" if dist_key ==42
			replace dist_nm = "D.I.KHAN" if dist_key ==43
			replace dist_nm = "HANGU" if dist_key ==44
			replace dist_nm = "HARIPUR" if dist_key ==45
			replace dist_nm = "KARAK" if dist_key ==46
			replace dist_nm = "KOHAT" if dist_key ==47
			replace dist_nm = "KOHISTAN" if dist_key ==48
			replace dist_nm = "LAKKI MARWAT" if dist_key ==49
			replace dist_nm = "LOWER DIR" if dist_key ==50
			replace dist_nm = "MALAKAND" if dist_key ==51
			replace dist_nm = "MANSEHRA" if dist_key ==52
			replace dist_nm = "MARDAN" if dist_key ==53
			replace dist_nm = "NOWSHERA" if dist_key ==54
			 
			replace dist_nm = "PESHAWAR" if dist_key ==55
			replace dist_nm = "SHANGLA" if dist_key ==56
			replace dist_nm = "SWABI" if dist_key ==57
			replace dist_nm = "SWAT" if dist_key ==58
			replace dist_nm = "TANK" if dist_key ==59
			replace dist_nm = "TOR GHAR" if dist_key ==60
			replace dist_nm = "UPPER DIR" if dist_key ==61
			 
			 
			 * Sindh:
			 
			 replace dist_nm = "BADIN" if dist_key ==62
			 replace dist_nm = "DADU" if dist_key ==63
			 replace dist_nm = "GOTKI" if dist_key ==64
			 replace dist_nm = "HYDERABAD" if dist_key ==65
			 replace dist_nm = "JACOBABAD" if dist_key ==66
			 replace dist_nm = "JAMSHORO" if dist_key ==67
			 
			 replace dist_nm = "KARACHI" if dist_key ==68
			 replace dist_nm = "KASHMORE" if dist_key ==69
			 replace dist_nm = "KHAIRPUR" if dist_key ==70
			 replace dist_nm = "LARKANA" if dist_key ==71
			 replace dist_nm = "MATIARI" if dist_key ==72
			 
			 
			 replace dist_nm = "MIRPURKHAS" if dist_key ==73
			 replace dist_nm = "NOWSHERO FEROZE" if dist_key ==74
			 replace dist_nm = "SANGHAR" if dist_key ==75
			 replace dist_nm = "QAMBAR SHAHDADKOT" if dist_key ==76
			 replace dist_nm = "SHAHEED BENAZIRABAD" if dist_key ==77
			 replace dist_nm = "SHIKARPUR" if dist_key ==78
			 
			 replace dist_nm = "SAJAWAL" if dist_key ==79
			 replace dist_nm = "SUKKHAR" if dist_key ==80
			 replace dist_nm = "TANDO ALLAH YAR" if dist_key ==81
			 replace dist_nm = "TANDO MUHD KHAN" if dist_key ==82
			 replace dist_nm = "THARPARKAR" if dist_key ==83
			 replace dist_nm = "TANK" if dist_key ==84
			 replace dist_nm = "THATTA" if dist_key ==85
			 replace dist_nm = "UMER KOT" if dist_key ==86
			 
			 replace dist_nm = "MITHI" if dist_key ==87


			* BALOCHISTAN:
			 
		  
			 replace dist_nm = "AWARAN" if dist_key ==88
			 replace dist_nm = "BARKHAN" if dist_key ==89
			 replace dist_nm = "BOLAN" if dist_key ==90
			 replace dist_nm = "CHAGHI" if dist_key ==91
			 replace dist_nm = "DERA BUGTI" if dist_key ==92
			 replace dist_nm = "GWADAR" if dist_key ==93
			 
			 replace dist_nm = "HARNAI" if dist_key ==94
			 replace dist_nm = "JAFFAR ABAD" if dist_key ==95
			 replace dist_nm = "JHAL MAGSI" if dist_key ==96
			 replace dist_nm = "KALLAT" if dist_key ==97
			 replace dist_nm = "KHARAN" if dist_key ==98
			 replace dist_nm = "KHUZDAR" if dist_key ==99
			 
			 
			 replace dist_nm = "QILLA ABDULLAH" if dist_key ==100
			 replace dist_nm = "QILLA SAIFULLAH" if dist_key ==101
			 replace dist_nm = "KOHLU" if dist_key ==102
			 replace dist_nm = "LASBELA" if dist_key ==103
			 replace dist_nm = "LORALAI" if dist_key ==104
			 replace dist_nm = "MASTONG" if dist_key ==105
			 
			 replace dist_nm = "MUSA KHEL" if dist_key ==106
			 replace dist_nm = "NASIRABAD" if dist_key ==107
			 replace dist_nm = "NUSHKI" if dist_key ==108
			 replace dist_nm = "PASHIN" if dist_key ==109
			 replace dist_nm = "QUETTA" if dist_key ==110
			 replace dist_nm = "SHERANI" if dist_key ==111
			 replace dist_nm = "SIBI" if dist_key ==112
			 
			 replace dist_nm = "WASHUK" if dist_key ==113

			 
			 replace dist_nm = "ZHOB" if dist_key ==114
			 replace dist_nm = "ZIARAT" if dist_key ==115
			 
			 
				 
			 replace dist_nm = "DUKI" if dist_key ==116
			 replace dist_nm = "LEHRI" if dist_key ==117	 
			 replace dist_nm = "KETCH" if dist_key ==118
			 replace dist_nm = "PANJGUR" if dist_key ==119
			
			 replace dist_nm = "SOHBATPUR" if dist_key ==120
			 replace dist_nm = "SURAB" if dist_key ==121
			 
			 
			 * OTHER AREAS
					 
			 replace dist_nm = "ASTORE" if dist_key ==122
			
			 replace dist_nm = "BAGH" if dist_key ==123
			 replace dist_nm = "BAJAUR" if dist_key ==124
			 replace dist_nm = "BHIMBER" if dist_key ==125
			 replace dist_nm = "DIYAMER" if dist_key ==126

			 replace dist_nm = "FATA BANNU" if dist_key ==127
			 replace dist_nm = "TRIBAL AREA ADJ D.I.KHAN" if dist_key ==128
			 replace dist_nm = "FATA KOHAT" if dist_key ==129
			 replace dist_nm = "FATA LAKKI MARWAT" if dist_key ==130
			 replace dist_nm = "FATA PESHAWAR" if dist_key ==131
			 replace dist_nm = "FATA TANK" if dist_key ==132
			 replace dist_nm = "GHANCHE" if dist_key ==133
			 replace dist_nm = "GHIZER" if dist_key ==134
			 replace dist_nm = "GILGIT" if dist_key ==135
			 replace dist_nm = "HATTIAN" if dist_key ==136
			 replace dist_nm = "HAVELI" if dist_key ==137
			 replace dist_nm = "HUNZA NAGAR" if dist_key ==138
			 replace dist_nm = "ICT" if dist_key ==139
			 replace dist_nm = "KHARMANG" if dist_key ==140
			 replace dist_nm = "KHYBER AGENCY" if dist_key ==141
			 replace dist_nm = "KOTLI" if dist_key ==142
			 replace dist_nm = "KURRAM" if dist_key ==143
			 replace dist_nm = "MOHMAND" if dist_key ==144
			 replace dist_nm = "MIRPUR" if dist_key ==145

			 replace dist_nm = "MUZAFARABAD" if dist_key ==146
			 replace dist_nm = "NAGAR" if dist_key ==147
			 replace dist_nm = "NEELUM" if dist_key ==148
			

			 replace dist_nm = "NORTH WAZIRISTAN" if dist_key ==149
			 replace dist_nm = "ORAKZAI" if dist_key ==150
			 replace dist_nm = "POONCH" if dist_key ==151
			 replace dist_nm = "SKARDU" if dist_key ==152
			 replace dist_nm = "SOUTH WAZIRISTAN" if dist_key ==153
			 replace dist_nm = "SUDHNATI" if dist_key ==154
			 replace dist_nm = "SHIGAR" if dist_key ==155
			 
				 
			 replace dist_nm = "DARIAL" if dist_key == 156
			 replace dist_nm = "GUPIS YASIN" if dist_key == 157
			 replace dist_nm = "RONDU" if dist_key == 158
			 replace dist_nm = "TANGIR" if dist_key == 159
			 

			 replace dist_nm = "NAWABSHA" if dist_key == 200

			  
			 labmask dist_key, val(dist_nm)
		
	
********************************************************************************
			 * var labels:
			
			 order dataset dist_key dist_nm year 
			
				
			 la var dataset "Dataset"
			 la var dist_key "District-Key"
			 la var dist_nm "District-Name"
			 la var year "Year"
			
			
			 la var in_school_6_10 "Share of children (aged 6-10) curently in school - (N)"
			
			 la var in_school_11_16 "Share of children (aged 11-16) curently in school - (N)"
			
			 la var in_school_6_16 "Share of children (aged 6-16) curently in school - (N)"
			
			 la var in_school_boys_6_10 "Share of boys (aged 6-10) curently in school - (N)"
 					
			 la var in_school_boys_11_16 "Share of boys (aged 11-16) curently in school - (N)"
 		
			 la var in_school_boys_6_16 "Share of boys (aged 6-16) curently in school - (N)"
 		
			 la var in_school_girls_6_10 "Share of girls (aged 6-10) curently in school - (N)"
 		
			
			 la var in_school_girls_11_16 "Share of girls (aged 11-16) curently in school - (N)"
 					
			 la var in_school_girls_6_16 "Share of girls (aged 6-16) curently in school - (N)"
		
		 
			 la var in_school_rural "Share of rural children curently in school - (N)"
			
			 la var in_school_rural_6_10 "Share of rural children (aged 6-10) curently in school - (N)"
			 
			 la var in_school_rural_11_16 "Share of rural children (aged 11-16) curently in school - (N)"
 					
			 la var in_school_rural_6_16 "Share of rural children (aged 6-16) curently in school - (N)"
			
			 la var in_school_urban "Share of urban children curently in school - (N)"
			
			 la var in_school_urban_6_10 "Share of urban children (aged 6-10) curently in school - (N)"
 					
			 la var in_school_urban_11_16 "Share of urban children (aged 11-16) curently in school - (N)"
 					
			 la var in_school_urban_6_16 "Share of urban children (aged 6-16) curently in school  - (N)"
 					
			 la var in_school_wq1 "Share of children currently in school - asset/wealth quintile : Bottom 20  - (N)"
			
			 la var in_school_wq1_6_10 "Share of children (aged 6-10) currently in school - asset/wealth quintile : Bottom 20  - (N)" 
			
			 la var in_school_wq1_11_16 "Share of children (aged 11-16) currently in school - asset/wealth quintile : Bottom 20  - (N)" 
 		
			
			 la var in_school_wq1_6_16 "Share of children (aged 11-16) currently in school - asset/wealth quintile : Bottom 20  - (N)"
			
			 la var in_school_wq2 "Share of children currently in school - asset/wealth quintile : 20-40  - (N)"
			
			 la var in_school_wq2_6_10 "Share of children (aged 6-10) currently in school - asset/wealth quintile : 20-40  - (N)"
			
			 la var in_school_wq2_11_16 "Share of children (aged 11-16 currently in school - asset/wealth quintile : 20-40  - (N)"
 		
			
			 la var in_school_wq2_6_16 "Share of children (aged 6-16) currently in school - asset/wealth quintile : 20-40  - (N)" 
			
			 la var in_school_wq3 "Share of children currently in school - asset/wealth quintile : 40-60  - (N)"
			
			 la var in_school_wq3_6_10 "Share of children (aged 6-10) currently in school - asset/wealth quintile : 40-60  - (N)" 
			
			 la var in_school_wq3_11_16 "Share of children (aged 11-16) currently in school - asset/wealth quintile : 40-60  - (N)"
 					
			 la var in_school_wq3_6_16 "Share of children (aged 6-16) currently in school - asset/wealth quintile : 40-60  - (N)"
			
			 la var in_school_wq4 "Share of children currently in school - asset/wealth quintile : 60-80  - (N)"
			
			 la var in_school_wq4_6_10 "Share of children (aged 6-10) currently in school - asset/wealth quintile : 60-80  - (N)"
			
			 la var in_school_wq4_11_16 "Share of children (aged 11-16) currently in school - asset/wealth quintile : 60-80  - (N)" 
 		

			 la var in_school_wq4_6_16 "Share of children (aged 6-16) currently in school - asset/wealth quintile : 60-80  - (N)"
			
			 			
			 la var in_school_wq5 "Share of children currently in school - asset/wealth quintile : Upper 20  - (N)"
			
			 la var in_school_wq5_6_10 "Share of children (aged 6-10) currently in school - asset/wealth quintile : Upper 20  - (N)"
			
		
			 la var in_school_wq5_11_16 "Share of children (aged 11-16) currently in school - asset/wealth quintile : Upper 20  - (N)"
	
			 la var in_school_wq5_6_16 "Share of children (aged 6-16) currently in school - asset/wealth quintile : Upper 20  - (N)"
			
			 la var share_private_6_10 "Share of children (aged 6-10) in private schools, among those enrolled - (N)"
			
			 la var share_private_11_16 "Share of children (aged 11-16) in private schools, among those enrolled - (N)"
			
			 la var share_private_6_16 "Share of children (aged 6-16) in private schools, among those enrolled - (N)"
			
			 la var literacy_12_18 "Share of adolescents (aged 12-18) who are literate (self-reported) - (N)"
			
			 la var literacy_boys_12_18 "Share of adolescent boys (aged 12-18) who are literate (self-reported) - (N)"
 		
			 la var literacy_girls_12_18 "Share of adolescent girls (aged 12-18) who are literate (self-reported) - (N)"
 					
			 la var numeracy_12_18 "Share of adolescents (aged 12-18) who are numerate (self-reported) - (N)"
			
			 la var numeracy_boys_12_18 "Share of adolescent boys (aged 12-18) who are numerate (self-reported) - (N)"
 					
			 la var numeracy_girls_12_18 "Share of adolescent girls (aged 12-18) who are numerate (self-reported) - (N)"
 					
			 la var division_6_10 "Share of children (aged 6-10) who can do division - (N)"
			
			 la var division_11_16 "Share of children (aged 11-16) who can do division - (N)"
			
			 la var division_6_16 "Share of children (aged 6-16) who can do division - (N)"
			
			 la var division_boys_6_10 "Share of boys (aged 6-10) who can do division - (N)"
			 
			 la var division_boys_11_16 "Share of boys (aged 11-16) who can do division - (N)"
 		
			 la var division_boys_6_16 "Share of boys (aged 6-16) who can do division - (N)"
 				
			 la var division_girls_6_10 "Share of girls (aged 6-10) who can do division - (N)"
 		
			 la var division_girls_11_16 "Share of girls (aged 11-16) who can do division - (N)"
 		
			 la var division_girls_6_16 "Share of girls (aged 6-16) who can do division - (N)"
		
			 la var reading_6_10 "Share of chilren (aged 6-10) who can read a basic paragraph - (N)"
			
			 la var reading_11_16 "Share of chilren (aged 11-16) who can read a basic paragraph - (N)"
			
			 la var reading_6_16 "Share of chilren (aged 6-16) who can read a basic paragraph - (N)"
			
			 la var reading_boys_6_10 "Share of boys (aged 6-10) who can read a basic paragraph - (N)"
			
			 la var reading_boys_11_16 "Share of boys (aged 11-16) who can read a basic paragraph - (N)"
			
			 la var reading_boys_6_16 "Share of boys (aged 6-16) who can read a basic paragraph - (N)"
			
			 la var reading_girls_6_10 "Share of girls (aged 6-10) who can read a basic paragraph - (N)"
			
			 la var reading_girls_11_16 "Share of girls (aged 11-16) who can read a basic paragraph - (N)"
 		
			 la var reading_girls_6_16 "Share of chilren (aged 6-16) who can read a basic paragraph - (N)"

		
********************************************************************************

			 gen country = 1
			
			 la def country 1 "Pakistan"
			 la var country "country"
			 la val country country
			
			 * Province Codes:
			
			 gen province = 1 if dist_key >=1 & dist_key <= 36
			 replace province = 4 if dist_key >=37 & dist_key <= 61
			 replace province = 2 if dist_key >= 62 & dist_key <= 87 | dist_key ==200
			 replace province = 3 if dist_key >=88 & dist_key <= 121
			 replace province = 0 if dist_key >= 122 & dist_key <= 155
			
			
			 la def prov 0 "Other Areas" 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP"
			 la val province prov
			 la var province "Province"
			
			
			 order year country province dist_key dist_nm
				  
		
		     * Droppping PSLM - 2018 observation for which dist_key is missing:
		   
		     drop if dist_key ==.
	
********************************************************************************	
		  
		     save "$pe/DD_Pak_pe_district_temp_count.dta", replace

		  
		  exit