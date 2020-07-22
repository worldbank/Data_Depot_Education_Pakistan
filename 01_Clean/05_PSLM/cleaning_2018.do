* DATASET: PSLM
* Author: Ahmed Raza
* Date: 3rd June, 2019 
* Purpose: Cleaning PSLM data : Strategy: Combine HH data with Education data on unique identifiers "hhcode" and "idc" and merge with other files using "hhcode".

		* Dropbox Globals
		
	    include init.do
	  
	    ************************************************************************
	    *2018
	    ************************************************************************

**** Step 1: Get Raw Data Files & check for unique identifiers: 
		
		
		use "$pslm_raw\2018\plist.dta", clear
		count 
		isid hhcode idc 
		 
		tempfile plist_18
		save `plist_18', replace

**** Step 2: Check administrative data vars and create a clean dist_key:
				
	* NOTE: PSLM/HIES - 18 is doesn't have district variable and is at province level.

	
	
**** Step 3: Merge different sections 
		
        use "$pslm_raw\2018\sec 1a.dta", clear

		isid hhcode idc 
		
		merge 1:1 hhcode idc using `plist_18', nogen
		merge 1:1 hhcode idc using "$pslm_raw\2018\sec_1b (2).dta", nogen
		merge m:1 hhcode using "$pslm_raw\2018\sec_00.dta", nogen
		
		
**** Step 4: Clean/harmonize variables:
		
		* education vars:
		
		merge 1:1 hhcode idc using "$pslm_raw\2018\sec_2ab.dta", nogen
	
		
		clonevar relation_hh_head = s1aq02 
		clonevar gender = s1aq04
		
		fre gender 
		
		
		gen in_school_ever = 1 if s2bq01 ==2 | s2bq01 ==3
		replace in_school_ever = 0 if s2bq01 ==1
		
		gen in_school = 1 if s2bq01 ==3
		replace in_school = 0 if s2bq01 != 3 & s2bq01 !=.
		
		
		fre s2bq01
		fre in_school
		
		clonevar school_type = s2bq03
		replace school_type = s2bq11 if in_school ==1
		
		ta school_type in_school
	
		clonevar hg = s2bq05
		clonevar cg = s2bq14
		
					
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		* current grade: 
		* Fixing current grade var: 3 values were entered for cg for which in school =0 
		
		
		ta cg if in_school ==0
		replace cg =. if in_school ==0	
		ta cg if in_school ==0

		* Checking highest grade var: 
		
		 ta hg if in_school_ever ==0

		 
		#delimit ;
		
		 la def educ1 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5"
		 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "polytechnic diploma/other diplomas"
		 12 "fa/fsc/i-com" 13 "ba/bsc/bed/bcs" 14 "ma/msc/med/mcs" 15 "degree in engineering" 16 "degree in medicine" 
		 17 "degree in agriculture" 18 "degree in law" 19 "mphil/phd" 20 "others" 21 "Computer Science";
		
		#delimit cr
		
		
		* Formatting Educ vars:
	
		gen highest_grade = . 	
		replace highest_grade = 0 if hg == 25 | hg ==26 | hg ==27
		replace highest_grade = 20 if hg ==28  	
		replace highest_grade = hg if hg >=1 & hg <=12
		
		replace highest_grade = 13 if hg ==13 | hg == 14 | hg == 15 | hg ==21
		
		replace highest_grade = 14 if hg == 16 | hg ==24 
		replace highest_grade = 15 if hg == 20 
		replace highest_grade = 16 if hg == 17
		replace highest_grade = 17 if hg == 18
		replace highest_grade = 18 if hg == 19
		
		replace highest_grade = 19 if hg == 22 | hg == 23
		replace highest_grade = 20 if hg == 28

		
		
		la val highest_grade educ1
		fre highest_grade
		
		
		
		gen current_grade = . 	
		
		replace current_grade = 0 if cg == 25 | cg ==26 | cg ==27
		replace current_grade = 20 if cg ==28  	
		replace current_grade = cg if cg >=1 & cg <=12
		
		replace current_grade = 13 if cg ==13 | cg == 14 | cg == 15 | cg ==21
		
		replace current_grade = 14 if cg == 16 | cg ==24 
		replace current_grade = 15 if cg == 20 
		replace current_grade = 16 if cg == 17
		replace current_grade = 17 if cg == 18
		replace current_grade = 18 if cg == 19
		
		replace current_grade = 19 if cg == 22 | cg == 23
		replace current_grade = 20 if cg == 28

		
		
		la val highest_grade educ1
		fre highest_grade

		

	    la val current_grade educ1
		fre cg 
		fre current_grade
		 
	
		
		gen prov_AR = "KP" if  province ==1
		replace prov_AR = "PUNJAB" if province ==2
		replace prov_AR = "SINDH" if province ==3
		replace prov_AR = "BALOCHISTAN" if province ==4
		replace prov_AR = "OTHER AREAS" if province ==7 | province ==8
			
		gen prov = 1 if prov_AR =="PUNJAB"    // punjab
		replace prov =2 if prov_AR =="SINDH" // sindh
		replace prov = 3 if prov_AR =="BALOCHISTAN" // Balochistan 
		replace prov = 4 if prov_AR == "KP" // KP
		replace prov = 0 if prov_AR == "OTHER AREAS"  // Other Areas
		
			
		
		* Get HH ASSETS:
		
		merge m:1 hhcode using "$pslm_raw\2018\sec_5a.dta", nogen
		
		* AGRICULTURE
		
		* merge m:1 hhcode using "$rawdata\PSLM 18-19\sec_9a.dta", nogen 
		
		* INCOME:
		
		merge 1:1 hhcode idc using "$pslm_raw\2018\sec_12a.dta", nogen 
		
		* CONSUMPTION:

		merge m:1 hhcode using  "$pslm_raw\2018\sec_12ce.dta", nogen
		
		* LAND
		preserve
		
		use "$pslm_raw\2018\sec_9a.dta", clear
		
		keep if code == 901
		isid hhcode 
		 
		tempfile agri_land 
		save `agri_land', replace
	 
		restore
			
		merge m:1 hhcode using `agri_land', nogen 
		
		* ICT: Individual level: (age 10 and above)
		merge 1:1 hhcode idc using "$pslm_raw\2018\sec 2c.dta", nogen 

		************************************************************************
		
**** Step 5: Create relevant vars for the panel:
				
       *  HH Head:  Highest Education:

	     preserve
	 
		keep  hhcode idc relation_hh_head highest_grade in_school_ever
		
		* hh head's education:
	    fre relation_hh_head	
		
		keep if relation_hh_head ==1
		
		keep hhcode relation_hh_head highest_grade in_school_ever
		
		
	    ren highest_grade highest_grade_head_head

		duplicates drop hhcode, force
			
		tempfile save head_educ
		save `head_educ', replace
		
		restore 

		 
		* Parent's : Highest Education:
		
	    preserve

		keep  hhcode relation_hh_head highest_grade in_school_ever
		
	   * parent's education:
	   
	  
	     fre relation_hh_head
		
		keep if relation_hh_head ==5
	
		keep hhcode relation_hh_head highest_grade in_school_ever
		
		
		* recode others as missing 
		
		replace  highest_grade =. if highest_grade ==20
		drop if highest_grade ==. 		
		
		ren highest_grade hg_par
		
		
		* keeping the highest grade parents:
		
	    bysort hhcode: egen highest_grade_parent = max(hg_par)
		
		duplicates tag hhcode, gen (x)
		egen rank = rank( highest_grade_parent), by(hhcode)
		bysort hhcode: gen members=_n
	
        duplicates drop hhcode, force
        isid hhcode 
	    
		
		la val highest_grade_parent scq04
		
	
		drop hg_par members rank x
		
		tempfile save par_educ
		save `par_educ', replace
		
		
	    ***********************************************************************

		merge 1:1 hhcode using `head_educ'
		drop _merge
				
		
		egen hh_es = rowmax(highest_grade_head highest_grade_parent)
		
		* br highest_grade_head highest_grade_parent hh_es
		
		isid hhcode

		
	    tempfile save educ
		save `educ', replace
	
	    restore
		
	    ************************************************************************
		
		merge m:1 hhcode using `educ'
		
		
		la val hh_es educ1
		
		gen hh_educ_status = 1 if hh_es ==0
		replace hh_educ_status = 2 if hh_es >=1 & hh_es<=5 // primary
		replace hh_educ_status = 3 if hh_es >=6 & hh_es<=8 // secondary
		replace hh_educ_status = 4 if hh_es >=9 & hh_es<=10 // higher secondary (matric)
		replace hh_educ_status = 5 if hh_es ==11 // diplomas
		replace hh_educ_status = 5 if hh_es ==12 // fa/fsc
		replace hh_educ_status = 6 if hh_es == 13 // Bachelors
		replace hh_educ_status = 6 if hh_es == 14 // masters
		replace hh_educ_status = 6 if hh_es == 15 | hh_es == 16 |hh_es == 17 | hh_es == 18 // degrees in engineering , law, medicine, agriculture
		replace hh_educ_status = 6 if hh_es == 19 // phd
		replace hh_educ_status = . if hh_es==20 // others
		
		#delimit ;
		
		la def hh_educ_status 1 "Less than grade 1" 2 "Primary(1-5)"
		3 "Secondary(6-8)" 4 "Higher Secondary (9-10)" 5 "Fa/Fsc/Diploma"
		6 "Bachelors or Higher";
		
		#delimit cr
		
		la val hh_educ_status hh_educ_status
		la var hh_educ_status "HH's Education Level"
		
	    ren hh_educ_status hh_educ_level

		
	    ************************************************************************
	
		* Income Quintiles:	
		* Total
	
		egen hh_income = total(s12aq08), by(hhcode)
		la var hh_income "Household's Yearly Income"

  		clonevar tot_income = s12aq08

		
	    ************************************************************************
  
		* Creating Income quintiles from the HH income:
			
		cap drop income_quintiles
		xtile income_quintiles = hh_income, n(5)
		
		
		la var income_quintiles "Income Quintiles from HH's Yearly Income (missing adjusted)"
		

		la def quintiles 1 "Bottom 20" 2 "20-40" 3 "40-60" 4 "60-80" 5 "Upper 20", modify
		la val income_quintiles  quintiles 
		
		fre income_quintiles
		

		****************************************************************************
		
		
		* Asset Vars for Asset Quintiles: 

		
		gen WI_dwellingtype = 1 if s5aq03 ==3 | s5aq03 ==4 | s5aq03 ==5 // shared or other 
		replace WI_dwellingtype = 2 if s5aq03 ==2  // apartment /flat
		replace WI_dwellingtype = 3 if s5aq03 == 1 // independent house       
		
		
		* Occupancy status :	
		clonevar sgq01 = s5aq01
	
	    gen WI_occupancy = 1 if sgq01 ==5 // no rent 
	    replace WI_occupancy =2 if sgq01 ==3 | sgq01 ==4  // rent
	    replace WI_occupancy = 3 if sgq01 ==2 | sgq01 ==1  // owner
	 
	 
	    * Rooms:
	 	clonevar sgq02 = s5aq04
	    bysort hhcode : gen members =_n
	
		
		gen  WI_rooms = members/ sgq02


	*    gen  WI_rooms = sgq02
 
	 
	    * Roof material:

	    clonevar sgq03 = s5aq06
	 
	    gen WI_roof_cement = 1 if sgq03 ==3 | sgq03 ==1  // pakka
	    replace WI_roof_cement = 0 if sgq03 ==5 | sgq03 ==4 |sgq03 ==2 // kacha or other
	 
	    clonevar sgq04 = s5aq07	 
	 
	    * walls material:
	    gen WI_brickedwalls = 1 if sgq04 ==1 
	    replace  WI_brickedwalls = 0 if sgq04 !=1 & sgq04 !=.
	 
	    * Toilet Facility:
	 
	    clonevar sgq06 = s5aq21
	
	
	    gen WI_toilet = 0 if s5aq21 ==1
	    replace WI_toilet = 1 if s5aq21 ==8
	    replace WI_toilet = 2 if s5aq21 == 7 | s5aq21 ==6
	    replace WI_toilet = 3 if s5aq21 == 5 | s5aq21 ==4 | s5aq21==3 | s5aq21 ==2
	  

	  /*
	  	gen WI_toilet = 0 if sgq06 ==1
	    replace WI_toilet = 1 if sgq06 != 1 & sgq06 !=.
      */
	 	 
	    * Fuel for cooking:
        clonevar sgq07 = s5aq08
	 
	    gen WI_energytype_cook = 1 if sgq07 ==4 | sgq07 ==6  // crop residue, dung
	    replace WI_energytype_cook =2 if sgq07 ==1 | sgq07 ==7 | sgq07 ==3 // wood , charcoal, oil
	    replace WI_energytype_cook = 3 if sgq07 ==2 | sgq07 ==5 // gas, electricity 
	 
	    * Fuel for lighting:
        clonevar sgq08 = s5aq10
	
	    gen WI_energytype_light = 1 if sgq08 ==5 | sgq08 ==4 // fire wood candle
	    replace WI_energytype_light =2 if sgq08 ==3 | sgq08 ==2 // oil, gas
	    replace WI_energytype_light = 3 if sgq08 ==1 // electricity
	
	
	    * Main source of heating s5aq09
	
	    gen WI_heating = 0 if s5aq09 ==10
	    replace WI_heating = 1 if s5aq09 == 9 // dung cake
	    replace WI_heating = 2 if s5aq09 == 8  // coal
	    replace WI_heating = 3 if s5aq09 == 7 // oil 
	    replace WI_heating = 4 if s5aq09 == 6 | s5aq09 ==2 // crop residue solar
	    replace WI_heating = 5 if s5aq09 == 5 | s5aq09 ==4 // gas
	    replace WI_heating = 6 if s5aq09 == 3 // lpg
	    replace WI_heating = 7 if s5aq09 == 1 // solar electricity
	
	
	   * Drinking water avaiable inside the hh s5aq13
	
	   fre s5aq13
	
	   gen WI_water = 1 if s5aq13 ==0
	   replace WI_water = 0 if s5aq13 !=0 & s5aq13 !=.
	
	   * Sufficient drinking water 
	   
	   gen WI_water_suff = 1 if s5aq17 ==1
	   replace WI_water_suff = 0 if s5aq17 != 1 & s5aq17 !=. 

	   * Drainage s5aq24

	   fre s5aq24
	
	   gen WI_drainage = 0 if s5aq24 == 4
	   replace WI_drainage = 1 if s5aq24 ==3
	   replace WI_drainage = 2 if s5aq24 == 2 
	   replace WI_drainage = 3 if s5aq24 == 1
	
	   * Handwash facility avaialble in hh  -  s5aq27a 
	
	   gen WI_handwash = 1 if s5aq27a  ==1
	   replace WI_handwash = 0 if s5aq27a  ==2
	
	   gen WI_handwash_agent = 1 if s5aq27b == 1  
	   replace WI_handwash_agent = 0 if s5aq27b ==2
	
	   * Garbage 
	
	   gen WI_garbage = 1 if s5aq28a == 1 | s5aq28a ==2 
	   replace WI_garbage = 0 if s5aq28a ==3
	
	   * Internet 
	
	   gen WI_internet = 1 if s5aq30_1a ==1
	   replace WI_internet = 2 if s5aq30_1a ==2
	
	 
	   * Computer 
	   
	   gen WI_computer = 1 if s5aq30_4a ==1
	   replace WI_computer = 0 if s5aq30_4a ==2
	
	   * Laptop
	   
 	   gen WI_laptop = 1 if s5aq30_5a ==1
	   replace WI_laptop = 0 if s5aq30_5a ==2
	 
	   * Tablet 
	
	   gen WI_tablet = 1 if s5aq30_6a ==1
	   replace WI_tablet = 0 if s5aq30_6a ==2
	   
	   drop sgq01 sgq02 sgq03 sgq04 sgq06 sgq07 sgq08 
	
		
	   * Land
		
	   gen WI_agriland = 1 if s9aq01 ==1 
	   replace WI_agriland =0 if s9aq01 ==2
		
		
		
	   * Mobile
		
	   gen WI_mobile = 1 if s2cq05 ==1 | s2cq05 ==2
	   replace WI_mobile = 0 if s2cq05 ==3
		
	   * Smart phone 
		
	   gen WI_smartphone = 1 if s2cq05 ==2
	   replace WI_smartphone = 0 if s2cq05 != 2 & s2cq05 !=.
	
	
	
	
	   //Final ASSET Variable for PCA analysis to create a Wealth Index
	
	   quiet: estpost sum   WI_*
	   
	   
	   	#delimit ;
	
		esttab, cell("mean(label(Mean)fmt(%9.3f)) sd(label(S.D)) min(label(Min)fmt(%9.0f))
		max(label(Max)fmt(%9.0f)) count(label(Obs.)fmt(%9.0f))") label nonumber noobs ; 
		
		#delimit cr
		
	
	    // Principal Component Analysis

		* SES 1: taking Yearly total income variable
		
		pca WI_*
		predict Asset_Level
		alpha WI_*
		
		cap drop asset_quintiles		
		xtile asset_quintiles = Asset_Level , n(5)
			
		la var asset_quintiles "Asset Quintiles from Wealth Index"
		la val asset_quintiles quintiles 
			
			
			
	    ************************************************************************
		
		fre hh_educ_level
		fre asset_quintiles
		fre income_quintiles		

		corr asset_quintiles hh_educ_level
		corr income_quintiles hh_educ_level
		corr income_quintiles  asset_quintiles
	
		table income_quintiles , c(mean in_school)	
		table income_quintiles if age>=6 & age<=10 , c(mean in_school)
			
		table asset_quintiles , c(mean in_school)	
		table asset_quintiles if age>=6 & age<=10 , c(mean in_school)
	    table hh_educ_level , c(mean in_school)
	    table hh_educ_level if age>=6 & age<=10 , c(mean in_school)
	
		
		clonevar read = s2aq01
		clonevar math = s2aq03
		
		fre read
		fre math
		
		* region (urban/rural)
		
		
		ren region region_old
		gen region = 1 if region_old ==2
		replace region = 2 if region_old ==1
		
		
		* drop missing obs with blank member idc
		
		drop if idc ==.
		isid hhcode idc
		
		
		gen year = 2018
		
		
		
**** Step 6: Save clean cross-sectional dataset:

     	save "$pslm_clean/PSLM_clean_2018.dta", replace 

	
	
