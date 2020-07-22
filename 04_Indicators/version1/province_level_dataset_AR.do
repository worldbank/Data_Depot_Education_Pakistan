
* DATASETS: ASER, MICS, PSLM 
* Author: Koen Geven & Ahmed Raza
* Date: 12th November, 2019 
* Purpose: To create point estimates from Panels and create a province level dataset
* Version: 1


clear all
set more off

		* Dropbox Globals
		
	    include init.do
	 
		gl panel "$output\Panel"
		gl pe "$output\Point_Estimates" 
	
        * include programs do file for Point Estimates
	    include pe_program.do
		
		
	
	************************************************************************
	* Calculate Points Estimates for DHS
	use "$panel\dhs_panel.dta", clear
	************************************************************************
	
	
	* Share of kids aged 6-10 curently in school (Point Estimates & SE) - in_school_6_10
	pe in_school , tv("in_school_6_10") ds("dhs") restrict("age >= 6 & age <= 10") level("province")
	
	* Share of kids aged 11-16 curently in school (Point Estimates & SE)- in_school_11_16
	pe in_school , tv("in_school_11_16") ds("dhs") restrict("age >= 11 & age <= 16") level("province")
		
   * Share of boys aged 6-10 curently in school (Point Estimates & SE) - in_school_boys_6_10
   	pe in_school , tv("in_school_boys_6_10") ds("dhs") restrict("age >= 6 & age <= 10 & sex==1") level("province")
	
	* Share of boys aged 11-16 curently in school (Point Estimates & SE) - in_school_boys_11_16
	pe in_school , tv("in_school_boys_11_16") ds("dhs") restrict("age >= 11 & age <= 16 & sex==1") level("province")
	
	* Share of girls aged 6-10 curently in school (Point Estimates & SE) - in_school_girls_6_10
   	pe in_school , tv("in_school_girls_6_10") ds("dhs") restrict("age >= 6 & age <= 10 & sex==2") level("province")

	* Share of girls aged 11-16 curently in school (Point Estimates & SE) - in_school_girls_11_16
	pe in_school , tv("in_school_girls_11_16") ds("dhs") restrict("age >= 11 & age <= 16 & sex==2") level("province")
	
	
	* Add indicator school enrollment 6-15:
	
			* Share of kids aged 6-15 curently in school (Point Estimates & SE) - in_school_6_15
	pe in_school , tv("in_school_6_15") ds("dhs") restrict("age >= 6 & age <= 15") level("province")
		
   * Share of boys aged 6-15 curently in school (Point Estimates & SE) - in_school_boys_6_15
   	pe in_school , tv("in_school_boys_6_15") ds("dhs") restrict("age >= 6 & age <= 15 & sex==1") level("province")

		* Share of girls aged 6-15 curently in school (Point Estimates & SE) - in_school_girls_6_15
   	pe in_school , tv("in_school_girls_6_15") ds("dhs") restrict("age >= 6 & age <= 15 & sex==2") level("province")
	
	
	
	************************************************************************
	* Calculate Points Estimates for PSLM
	use "$panel\pslm_panel.dta", clear
	************************************************************************

	
	gen  private_share = 1 if in_school ==1 & school_category ==1
	replace private_share =0 if in_school ==1 & school_category != 1

	
	* Share of kids aged 6-10 curently in school (Point Estimates & SE) - in_school_6_10
	pe in_school , tv("in_school_6_10") ds("pslm") restrict("age >= 6 & age <= 10") level("province")
	
	* Share of kids aged 11-16 curently in school (Point Estimates & SE)- in_school_11_16
	pe in_school , tv("in_school_11_16") ds("pslm") restrict("age >= 11 & age <= 16") level("province")
		
   * Share of boys aged 6-10 curently in school (Point Estimates & SE) - in_school_boys_6_10
   	pe in_school , tv("in_school_boys_6_10") ds("pslm") restrict("age >= 6 & age <= 10 & sex==1") level("province")
	
	* Share of boys aged 11-16 curently in school (Point Estimates & SE) - in_school_boys_11_16
	pe in_school , tv("in_school_boys_11_16") ds("pslm") restrict("age >= 11 & age <= 16 & sex==1") level("province")
	
	* Share of girls aged 6-10 curently in school (Point Estimates & SE) - in_school_girls_6_10
   	pe in_school , tv("in_school_girls_6_10") ds("pslm") restrict("age >= 6 & age <= 10 & sex==2") level("province")

	* Share of girls aged 11-16 curently in school (Point Estimates & SE) - in_school_girls_11_16
	pe in_school , tv("in_school_girls_11_16") ds("pslm") restrict("age >= 11 & age <= 16 & sex==2") level("province")

    ****************************************************************************
   
	* Share of kids aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_9_11
	* Share of kids aged 9-11 who can do division (Point Estimates & SE) - division_9_11
	
	* Share of boys aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_boys_9_11
	* Share of boys aged 9-11 who can do division (Point Estimates & SE) - division_boys_9_11

	
	* Share of girls aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_girls_9_11
	* Share of girls aged 9-11 who can do division (Point Estimates & SE) - division_girls_9_11

	****************************************************************************

	* Share of adolescents who are literate (self-reported) - literacy_12_18
	pe read_pslm , tv("literacy_12_18") ds("pslm") restrict("age >= 12 & age <= 18") level("province")
	
	* Share of adolescents who are numerate (self-reported) - numeracy_12_18
	pe math_pslm , tv("numeracy_12_18") ds("pslm") restrict("age >= 12 & age <= 18") level("province")
	
	* Share of adolescent boys (aged 12-18) who are literate (self-reported) - literacy_boys_12_18
	pe read_pslm , tv("literacy_boys_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==1") level("province")
	
	* Share of adolescent boys (aged 12-18) who are numerate (self-reported) - numeracy_boys_12_18
	pe math_pslm , tv("numeracy_boys_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==1") level("province")
  
	* Share of adolescent girls (aged 12-18) who are literate (self-reported) -  literacy_girls_12_18
	pe read_pslm , tv("literacy_girls_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==2") level("province")
	
	* Share of adolescent girls (aged 12-18) who are numerate (self-reported) - numeracy_girls_12_18
	pe math_pslm , tv("numeracy_girls_12_18") ds("pslm") restrict("age >= 12 & age <= 18 & sex ==2") level("province")

    * Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
	pe private_share , tv("share_private_6_10") ds("pslm") restrict("age >= 6 & age <= 10") level("province")

    * Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
	pe private_share , tv("share_private_11_16") ds("pslm") restrict("age >= 11 & age <= 16") level("province")
	 

	* Add indicator school enrollment 6-15:
	
			* Share of kids aged 6-15 curently in school (Point Estimates & SE) - in_school_6_15
	pe in_school , tv("in_school_6_15") ds("pslm") restrict("age >= 6 & age <= 15") level("province")
		
   * Share of boys aged 6-15 curently in school (Point Estimates & SE) - in_school_boys_6_15
   	pe in_school , tv("in_school_boys_6_15") ds("pslm") restrict("age >= 6 & age <= 15 & sex==1") level("province")

		* Share of girls aged 6-15 curently in school (Point Estimates & SE) - in_school_girls_6_15
   	pe in_school , tv("in_school_girls_6_15") ds("pslm") restrict("age >= 6 & age <= 15 & sex==2") level("province")
	
	
  
	************************************************************************
	* Calculate Points Estimates for MICS
	use "$panel\mics_panel.dta", clear
	************************************************************************
    
	gen  private_share = 1 if in_school ==1 & school_category ==1
	replace private_share =0 if in_school ==1 & school_category != 1

	
	* Share of kids aged 6-10 curently in school (Point Estimates & SE) - in_school_6_10
	pe in_school , tv("in_school_6_10") ds("mics") restrict("age >= 6 & age <= 10") level("province")

	* Share of kids aged 11-16 curently in school (Point Estimates & SE)- in_school_11_16
	pe in_school , tv("in_school_11_16") ds("mics") restrict("age >= 11 & age <= 16") level("province")
		
   * Share of boys aged 6-10 curently in school (Point Estimates & SE) - in_school_boys_6_10
   	pe in_school , tv("in_school_boys_6_10") ds("mics") restrict("age >= 6 & age <= 10 & sex==1") level("province")
	
	* Share of boys aged 11-16 curently in school (Point Estimates & SE) - in_school_boys_11_16
	pe in_school , tv("in_school_boys_11_16") ds("mics") restrict("age >= 11 & age <= 16 & sex==1") level("province")
	
	* Share of girls aged 6-10 curently in school (Point Estimates & SE) - in_school_girls_6_10
   	pe in_school , tv("in_school_girls_6_10") ds("mics") restrict("age >= 6 & age <= 10 & sex==2") level("province")

	* Share of girls aged 11-16 curently in school (Point Estimates & SE) - in_school_girls_11_16
	pe in_school , tv("in_school_girls_11_16") ds("mics") restrict("age >= 11 & age <= 16 & sex==2") level("province")

    ****************************************************************************
   
	* Share of kids aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_9_11
	* Share of kids aged 9-11 who can do division (Point Estimates & SE) - division_9_11
	* Share of boys aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_boys_9_11
	* Share of boys aged 9-11 who can do division (Point Estimates & SE) - division_boys_9_11
	* Share of girls aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_girls_9_11
	* Share of girls aged 9-11 who can do division (Point Estimates & SE) - division_girls_9_11
	* Share of adolescents who are literate (self-reported) - literacy_12_18
	* Share of adolescents who are numerate (self-reported) - numeracy_12_18
	* Share of adolescent boys (aged 12-18) who are literate (self-reported) - literacy_boys_12_18
	* Share of adolescent boys (aged 12-18) who are numerate (self-reported) - numeracy_boys_12_18
	* Share of adolescent girls (aged 12-18) who are literate (self-reported) -  literacy_girls_12_18
	* Share of adolescent girls (aged 12-18) who are numerate (self-reported) - numeracy_girls_12_18
	
	****************************************************************************

    * Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
	pe private_share , tv("share_private_6_10") ds("mics") restrict("age >= 6 & age <= 10") level("province")

    * Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
	pe private_share , tv("share_private_11_16") ds("mics") restrict("age >= 11 & age <= 16") level("province")


	
		* Add indicator school enrollment 6-15:
	
			* Share of kids aged 6-15 curently in school (Point Estimates & SE) - in_school_6_15
	pe in_school , tv("in_school_6_15") ds("mics") restrict("age >= 6 & age <= 15") level("province")
		
   * Share of boys aged 6-15 curently in school (Point Estimates & SE) - in_school_boys_6_15
   	pe in_school , tv("in_school_boys_6_15") ds("mics") restrict("age >= 6 & age <= 15 & sex==1") level("province")

		* Share of girls aged 6-15 curently in school (Point Estimates & SE) - in_school_girls_6_15
   	pe in_school , tv("in_school_girls_6_15") ds("mics") restrict("age >= 6 & age <= 15 & sex==2") level("province")
	
	
	************************************************************************
	* Calculate Points Estimates for ASER
	use "$panel\aser_panel.dta", clear
	************************************************************************
	
	gen  private_share = 1 if in_school ==1 & school_category ==1
	replace private_share =0 if in_school ==1 & school_category != 1


	gen reading = 1 if reading_aser == 5
    replace reading = 0 if reading_aser < 5
   
	gen division = 1 if math_aser == 6
    replace division = 0 if math_aser < 6
   
	gen weight_aser = 1 
		
	
	* Share of kids aged 6-10 curently in school (Point Estimates & SE) - in_school_6_10
	pe in_school , tv("in_school_6_10") ds("aser") restrict("age >= 6 & age <= 10") level("province")

	
	
	* Share of kids aged 11-16 curently in school (Point Estimates & SE)- in_school_11_16
	pe in_school , tv("in_school_11_16") ds("aser") restrict("age >= 11 & age <= 16") level("province")
	
   * Share of boys aged 6-10 curently in school (Point Estimates & SE) - in_school_boys_6_10
   	pe in_school , tv("in_school_boys_6_10") ds("aser") restrict("age >= 6 & age <= 10 & sex==1") level("province")
	
	* Share of boys aged 11-16 curently in school (Point Estimates & SE) - in_school_boys_11_16
	pe in_school , tv("in_school_boys_11_16") ds("aser") restrict("age >= 11 & age <= 16 & sex==1") level("province")
	
	* Share of girls aged 6-10 curently in school (Point Estimates & SE) - in_school_girls_6_10
   	pe in_school , tv("in_school_girls_6_10") ds("aser") restrict("age >= 6 & age <= 10 & sex==2") level("province")

	* Share of girls aged 11-16 curently in school (Point Estimates & SE) - in_school_girls_11_16
	pe in_school , tv("in_school_girls_11_16") ds("aser") restrict("age >= 11 & age <= 16 & sex==2") level("province")

    ****************************************************************************
   
	* Share of kids aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_9_11
	pe reading , tv("reading_9_11") ds("aser") restrict("age >= 9 & age <= 11") level("province")

	
	* Share of kids aged 9-11 who can do division (Point Estimates & SE) - division_9_11
	pe division , tv("division_9_11") ds("aser") restrict("age >= 9 & age <= 11") level("province")

	* Share of boys aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_boys_9_11
	pe reading , tv("reading_boys_9_11") ds("aser") restrict("age >= 9 & age <= 11 & sex ==1") level("province")

	* Share of boys aged 9-11 who can do division (Point Estimates & SE) - division_boys_9_11
	pe division , tv("division_boys_9_11") ds("aser") restrict("age >= 9 & age <= 11 & sex ==1") level("province")

	
	* Share of girls aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_girls_9_11
	pe reading , tv("reading_girls_9_11") ds("aser") restrict("age >= 9 & age <= 11 & sex ==2") level("province")

	* Share of girls aged 9-11 who can do division (Point Estimates & SE) - division_girls_9_11
	pe division , tv("division_girls_9_11") ds("aser") restrict("age >= 9 & age <= 11 & sex ==2") level("province")

    * Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
	pe private_share , tv("share_private_6_10") ds("aser") restrict("age >= 6 & age <= 10") level("province")

    * Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
	pe private_share , tv("share_private_11_16") ds("aser") restrict("age >= 11 & age <= 16") level("province")
	


	* Add indicator school enrollment 6-15:
	
			* Share of kids aged 6-15 curently in school (Point Estimates & SE) - in_school_6_15
	pe in_school , tv("in_school_6_15") ds("aser") restrict("age >= 6 & age <= 15") level("province")
		
   * Share of boys aged 6-15 curently in school (Point Estimates & SE) - in_school_boys_6_15
   	pe in_school , tv("in_school_boys_6_15") ds("aser") restrict("age >= 6 & age <= 15 & sex==1") level("province")

		* Share of girls aged 6-15 curently in school (Point Estimates & SE) - in_school_girls_6_15
   	pe in_school , tv("in_school_girls_6_15") ds("aser") restrict("age >= 6 & age <= 15 & sex==2") level("province")
	
			
	************************************************************************
	* Calculate Points Estimates for HIES
	use "$panel\hies_panel.dta", clear
	************************************************************************
    
	gen  private_share = 1 if in_school ==1 & school_category ==1
	replace private_share =0 if in_school ==1 & school_category != 1


		
	* Share of kids aged 6-10 curently in school (Point Estimates & SE) - in_school_6_10
	pe in_school , tv("in_school_6_10") ds("hies") restrict("age >= 6 & age <= 10") level("province")
	
	* Share of kids aged 11-16 curently in school (Point Estimates & SE)- in_school_11_16
	pe in_school , tv("in_school_11_16") ds("hies") restrict("age >= 11 & age <= 16") level("province")
		
   * Share of boys aged 6-10 curently in school (Point Estimates & SE) - in_school_boys_6_10
   	pe in_school , tv("in_school_boys_6_10") ds("hies") restrict("age >= 6 & age <= 10 & sex==1") level("province")
	
	* Share of boys aged 11-16 curently in school (Point Estimates & SE) - in_school_boys_11_16
	pe in_school , tv("in_school_boys_11_16") ds("hies") restrict("age >= 11 & age <= 16 & sex==1") level("province")
	
	* Share of girls aged 6-10 curently in school (Point Estimates & SE) - in_school_girls_6_10
   	pe in_school , tv("in_school_girls_6_10") ds("hies") restrict("age >= 6 & age <= 10 & sex==2") level("province")

	* Share of girls aged 11-16 curently in school (Point Estimates & SE) - in_school_girls_11_16
	pe in_school , tv("in_school_girls_11_16") ds("hies") restrict("age >= 11 & age <= 16 & sex==2") level("province")

    ****************************************************************************
   
	* Share of kids aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_9_11
	* Share of kids aged 9-11 who can do division (Point Estimates & SE) - division_9_11
	
	* Share of boys aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_boys_9_11
	* Share of boys aged 9-11 who can do division (Point Estimates & SE) - division_boys_9_11

	
	* Share of girls aged 9-11 who can read a basic paragraph (Point Estimates & SE) - reading_girls_9_11
	* Share of girls aged 9-11 who can do division (Point Estimates & SE) - division_girls_9_11

	****************************************************************************

	* Share of adolescents who are literate (self-reported) - literacy_12_18
	pe read_hies , tv("literacy_12_18") ds("hies") restrict("age >= 12 & age <= 18") level("province")
	
	* Share of adolescents who are numerate (self-reported) - numeracy_12_18
	pe math_hies , tv("numeracy_12_18") ds("hies") restrict("age >= 12 & age <= 18") level("province")
	
	* Share of adolescent boys (aged 12-18) who are literate (self-reported) - literacy_boys_12_18
	pe read_hies , tv("literacy_boys_12_18") ds("hies") restrict("age >= 12 & age <= 18 & sex ==1") level("province")
	
	* Share of adolescent boys (aged 12-18) who are numerate (self-reported) - numeracy_boys_12_18
	pe math_hies , tv("numeracy_boys_12_18") ds("hies") restrict("age >= 12 & age <= 18 & sex ==1") level("province")
  
	* Share of adolescent girls (aged 12-18) who are literate (self-reported) -  literacy_girls_12_18
	pe read_hies , tv("literacy_girls_12_18") ds("hies") restrict("age >= 12 & age <= 18 & sex ==2") level("province")
	
	* Share of adolescent girls (aged 12-18) who are numerate (self-reported) - numeracy_girls_12_18
	pe math_hies , tv("numeracy_girls_12_18") ds("hies") restrict("age >= 12 & age <= 18 & sex ==2") level("province")

    * Share of kids (aged 6-10) in private schools, among those enrolled - share_private_6_10
	pe private_share , tv("share_private_6_10") ds("hies") restrict("age >= 6 & age <= 10") level("province")

    * Share of kids (aged 11-16) in private schools, among those enrolled - share_private_11_16
	pe private_share , tv("share_private_11_16") ds("hies") restrict("age >= 11 & age <= 16") level("province")



		
			
		* Add indicator school enrollment 6-15:
	
			* Share of kids aged 6-15 curently in school (Point Estimates & SE) - in_school_6_15
	pe in_school , tv("in_school_6_15") ds("hies") restrict("age >= 6 & age <= 15") level("province")
		
   * Share of boys aged 6-15 curently in school (Point Estimates & SE) - in_school_boys_6_15
   	pe in_school , tv("in_school_boys_6_15") ds("hies") restrict("age >= 6 & age <= 15 & sex==1") level("province")

		* Share of girls aged 6-15 curently in school (Point Estimates & SE) - in_school_girls_6_15
   	pe in_school , tv("in_school_girls_6_15") ds("hies") restrict("age >= 6 & age <= 15 & sex==2") level("province")
	
	
	
	
	************************************************************************
	* Calculate Points Estimates for EGRA
	use "$panel\egra_panel_baseline.dta", clear
	************************************************************************
   

   
      * Oral reading fluency
	  
	  	pe orf , tv("egra_orf") ds("egra") restrict("country ==1") level("province")

		
	  * Oral reading fluency - by grade 
	  
	  	pe orf , tv("egra_orf_g3") ds("egra") restrict("grade ==3") level("province")
	    pe orf , tv("egra_orf_g5") ds("egra") restrict("grade ==5") level("province")

	
	  * Oral reading fluency - by gender
	  
	  	pe orf , tv("egra_orf_boys") ds("egra") restrict("female ==0") level("province")
	    pe orf , tv("egra_orf_girls") ds("egra") restrict("female ==1") level("province")
	  
	  
	  
	  * correct letters per minute 
	  	  
	  	pe clpm , tv("egra_clpm") ds("egra") restrict("country==1") level("province")

	  * correct letters per minute - by grade 
	  
	  	pe clpm , tv("egra_clpm_g3") ds("egra") restrict("grade ==3") level("province")
	    pe clpm , tv("egra_clpm_g5") ds("egra") restrict("grade ==5") level("province")

	
	  * correct letters per minute - by gender
	  
	  	pe clpm , tv("egra_clpm_boys") ds("egra") restrict("female ==0") level("province")
	    pe clpm , tv("egra_clpm_girls") ds("egra") restrict("female ==1") level("province")
	  
	  
	  
   
	
	****************************************************************************
	
	* CREATE DIST-LEVEL DATASET
	
	* ASER:
	local aser_estimates "in_school_11_16  in_school_boys_6_10 in_school_boys_11_16 in_school_girls_6_10 in_school_girls_11_16 reading_9_11 division_9_11 reading_boys_9_11 division_boys_9_11 reading_girls_9_11 division_girls_9_11 share_private_6_10 share_private_11_16 in_school_6_15 in_school_boys_6_15 in_school_girls_6_15"
	
	use "$output/point_estimates/province/aser/in_school_6_10.dta", clear
	foreach x of local aser_estimates{
	
	merge 1:1 province year using "$output/point_estimates/province/aser/`x'.dta", nogen
	
	}

	tempfile aser_prov
	save `aser_prov', replace
	
	
	* PSLM:
	
	
	local pslm_estimates "in_school_11_16  in_school_boys_6_10 in_school_boys_11_16 in_school_girls_6_10 in_school_girls_11_16 literacy_12_18 numeracy_12_18  literacy_boys_12_18 numeracy_boys_12_18 literacy_girls_12_18 numeracy_girls_12_18  share_private_6_10 share_private_11_16 in_school_6_15 in_school_boys_6_15 in_school_girls_6_15"

	use "$pe/point_estimates/province/pslm/in_school_6_10.dta", clear
	
	foreach x of local pslm_estimates{
	
	merge 1:1 province year using "$pe/point_estimates/province/pslm/`x'.dta", nogen
	
	}

	tempfile pslm_prov
	save `pslm_prov', replace
	
	
		
	* DHS:
	
	
	local dhs_estimates "in_school_11_16  in_school_boys_6_10 in_school_boys_11_16 in_school_girls_6_10 in_school_girls_11_16 in_school_6_15 in_school_boys_6_15 in_school_girls_6_15"
	
	
	use "$pe/point_estimates/province/dhs/in_school_6_10.dta", clear
	
	foreach x of local dhs_estimates{
	
	merge 1:1 province year using "$pe/point_estimates/province/dhs/`x'.dta", nogen
	
	}

	tempfile dhs_prov
	save `dhs_prov', replace
	
	
	
		
		
	* HIES:
	
	
	local hies_estimates "in_school_11_16  in_school_boys_6_10 in_school_boys_11_16 in_school_girls_6_10 in_school_girls_11_16 literacy_12_18 numeracy_12_18  literacy_boys_12_18 numeracy_boys_12_18 literacy_girls_12_18 numeracy_girls_12_18  share_private_6_10 share_private_11_16 in_school_6_15 in_school_boys_6_15 in_school_girls_6_15"

	use "$pe/point_estimates/province/hies/in_school_6_10.dta", clear
	
	foreach x of local hies_estimates{
	
	merge 1:1 province year using "$pe/point_estimates/province/hies/`x'.dta", nogen
	
	}

	tempfile hies_prov
	save `hies_prov', replace
	
	
	
	* EGRA
	
	
	local egra_estimates "egra_orf_g3 egra_orf_g5 egra_orf_boys egra_orf_girls egra_clpm egra_clpm_g3 egra_clpm_g5 egra_clpm_boys egra_clpm_girls"
	use "$pe/point_estimates/province/egra/egra_orf.dta", clear
	
	foreach x of local egra_estimates{
	
	merge 1:1 province year using "$pe/point_estimates/province/egra/`x'.dta", nogen
	
	}

	tempfile egra_prov
	save `egra_prov', replace
	
	
	
	* MICS
	
	
	local mics_estimates "in_school_11_16  in_school_boys_6_10 in_school_boys_11_16 in_school_girls_6_10 in_school_girls_11_16 share_private_6_10 share_private_11_16 in_school_6_15 in_school_boys_6_15 in_school_girls_6_15"

	use "$pe/point_estimates/province/mics/in_school_6_10.dta", clear
	
	foreach x of local mics_estimates{
	
	merge 1:1 province year using "$pe/point_estimates/province/mics/`x'.dta", nogen
	
	}

	tempfile mics_prov
	save `mics_prov', replace
	
	
	***************************************************************************
	
	append using `pslm_prov'
	append using `aser_prov'
	append using `hies_prov'
	append using `egra_prov'
	append using `dhs_prov'

	
	***************************************************************************
	* value labels:
	
	* Province Codes:
	
	la def prov 0 "Other Areas" 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP"
	la val province prov
	
	
	****************************************************************************
	* var labels:
	
	la var dataset "Dataset"
	la var year "Year"
		
	la var in_school_6_10 "Share of kids aged 6-10 curently in school (Point Estimate)"	
	la var in_school_6_10_se "Standard for point estimate - in_school_6_10"	
	la var in_school_11_16 "Share of kids aged 11-16 curently in school (Point Estimate)"	
	la var in_school_11_16_se "Standard error for point estimate - in_school_11_16"	
	la var in_school_boys_6_10 "Share of boys aged 6-10 curently in school (Point Estimate)"	
	la var in_school_boys_6_10_se "Standard error for point estimate - in_school_boys_6_10"	
	la var in_school_girls_6_10	"Share of girls aged 6-10 curently in school (Point Estimate)"	
	la var in_school_girls_6_10_se "Standard error for point estimate - in_school_girls_6_10"	
	la var in_school_boys_11_16	"Share of boys aged 11-16 curently in school (Point Estimate)"	
	la var in_school_boys_11_16_se "Standard error for point estimate - in_school_boys_11_16"	
	la var in_school_girls_11_16 "Share of girls aged 11-16 curently in school (Point Estimate)"	
	la var in_school_girls_11_16_se	"Standard error for point estimate - in_school_girls_11_16"	
	la var reading_9_11	"Share of kids aged 9-11 who can read a basic paragraph"	
	la var reading_9_11_se "Standard error for point estimate - reading_9_11"	
	la var division_9_11 "Share of kids aged 9-11 who can do division"	
    la var division_9_11_se "Standard error for point estimate - division_9_11" 		

	   
	la var reading_boys_9_11 "Share of boys aged 9-11 who can read a basic paragraph"	
	la var reading_boys_9_11_se "Standard error for point estimate - reading_boys_9_11"		
	la var division_boys_9_11 "Share of boys aged 9-11 who can do division"
	la var division_boys_9_11_se "Standard error for point estimate - division_boys_9_11"		
	la var reading_girls_9_11	"Share of girls aged 9-11 who can read a basic paragraph"	
	la var reading_girls_9_11_se "Standard error for point estimate - reading_girls_9_11"		
	la var division_girls_9_11	"Share of girls aged 9-11 who can do division"	
	la var division_girls_9_11_se "Standard error for point estimate - division_girls_9_11"		
	la var literacy_12_18	"Share of adolescents who are literate (self-reported)"	
	la var literacy_12_18_se "Standard error for point estimate - literacy_12_18"
	la var numeracy_12_18	"Share of adolescents who are numerate (self-reported)"	
	la var numeracy_12_18_se "Standard error for point estimate - numeracy_12_18"
	la var literacy_boys_12_18	"Share of adolescent boys (aged 12-18) who are literate (self-reported)"	
	la var literacy_boys_12_18_se "Standard error for point estimate - literacy_boys_12_18"
	la var numeracy_boys_12_18 "Share of adolescent boys (aged 12-18) who are numerate (self-reported)"	
	la var numeracy_boys_12_18_se "Standard error for point estimate - numeracy_boys_12_18"
	la var literacy_girls_12_18 "Share of adolescent girls (aged 12-18) who are literate (self-reported)"	
	la var literacy_girls_12_18_se "Standard error for point estimate - literacy_girls_12_18"
	la var numeracy_girls_12_18 "Share of adolescent girls (aged 12-18) who are numerate (self-reported)"	
	la var numeracy_girls_12_18_se "Standard error for point estimate - numeracy_girls_12_18"
	la var share_private_6_10 "Share of kids (aged 6-10) in private schools, among those enrolled"
	la var share_private_6_10_se "Standard error for point estimate - share_private_6_10"
	la var share_private_11_16	"Share of kids (aged 11-16) in private schools, among those enrolled"	
	la var share_private_11_16_se "Standard error for point estimate - share_private_11_16"



	* EGRA
	
	la var egra_orf "EGRA: oral reading fluency (Point Estimate)"
	la var egra_orf_se "Standard error for point estimate - egra_orf"	
	la var egra_clpm "EGRA: correct letters per minute (Point Estimate)"
	la var egra_clpm_se "Standard error for point estimate - egra_clpm"
	la var egra_orf_g3 "EGRA: oral reading fluency - Grade 3  (Point Estimate)"
	la var egra_orf_g3_se "Standard error for point estimate - egra_orf_g3" 
	la var egra_orf_g5 "EGRA: oral reading fluency - Grade 5  (Point Estimate)"
	la var egra_orf_g5_se "Standard error for point estimate - egra_orf_g5" 
	la var egra_clpm_g3 "EGRA: correct letters per minute - Grade 3 (Point Estimate)"
    la var egra_clpm_g3_se "Standard error for point estimate - egra_clpm_g3" 
	la var egra_clpm_g5 "EGRA: correct letters per minute - Grade 5 (Point Estimate)"
    la var egra_clpm_g5_se "Standard error for point estimate - egra_clpm_g5"
	la var egra_orf_boys "EGRA: oral reading fluency - Boys (Point Estimate)"
    la var egra_orf_boys_se "Standard error for point estimate - egra_orf_boys" 
	la var egra_orf_girls "EGRA: oral reading fluency - Girls (Point Estimate)"
    la var egra_orf_girls_se "Standard error for point estimate - egra_orf_girls" 
	la var egra_clpm_boys "EGRA: correct letters per minute - Boys (Point Estimate)"
	la var egra_clpm_boys_se "Standard error for point estimate - egra_clpm_boys" 
	la var egra_clpm_girls "EGRA: correct letters per minute - Girls (Point Estimate)"
    la var egra_clpm_girls_se "Standard error for point estimate - egra_clpm_girls" 
	
	
	
		
	* Added indicator:
	
	la var in_school_6_15 "Share of kids aged 6-15 curently in school (Point Estimate)"	
	la var in_school_6_15_se "Standard for point estimate - in_school_6_15"
	
	la var in_school_boys_6_15 "Share of boys aged 6-15 curently in school (Point Estimate)"	
	la var in_school_boys_6_15_se "Standard error for point estimate - in_school_boys_6_15"
	
	la var in_school_girls_6_15	"Share of girls aged 6-15 curently in school (Point Estimate)"	
	la var in_school_girls_6_15_se "Standard error for point estimate - in_school_girls_6_15"


	gen country = 1
	la def country 1 "Pakistan"
	la var country "country"
	la val country country
	
	fre country
	
	la var province "Province"
		 
		 order year country province 
	
	isid dataset year province
	
	
	save "$pe/DD_Pak_pe_province_version1.1.dta", replace
	
	  export delimited using "$pe\DD_Pak_pe_province_version1.1.csv", replace

	
		  exit
		  
	