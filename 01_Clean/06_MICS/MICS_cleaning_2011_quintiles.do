* MICS DATA CLEANING : 
* Author: Ahmed Raza
* Date: 30th September 2019
* Purpose: MICS data cleaning with quintiles:

		* Dropbox Globals
		
        include init.do
  	  

	

********************************************************************************		

		* 2011:
		
		
		* HH: Household:
	
		use "$mics_raw\2011\hh.dta", clear 
		
		ren *, lower
		
		ren hh1 hh_cluster
		ren hh2 hh_number
		
		isid hh_cluster hh_number
		
		tempfile hh_2011
	    save `hh_2011', replace

		
		* HL: Household Members:
		
		use "$mics_raw\2011\hl.dta", clear 
		ren *, lower
			
		
		* Variable cleaning: 

		
		ren hh1 hh_cluster
		ren hh2 hh_number
		ren hl1 line_number
		
		isid hh_cluster hh_number line_number 
		
		
		
		gen age = hl6 
		gen gender = hl4
		la val gender HL4
		
		
		* ever attended school:
	    gen in_school_ever =1 if ed3 ==1
		replace in_school_ever =0 if ed3 ==2
		replace in_school_ever =. if ed3 ==9
		
		fre ed3
		fre in_school_ever
		la var in_school_ever "Ever attended school (Age: 3 and above)"
		
		
		
		
	    * highest grade completed
		
	
	    gen highest_grade = ed4b 
		la var highest_grade "Highest Grade Completed"	
	
	    fre highest_grade
		recode highest_grade (97=.) (98=.) (99=.)
		
		
		replace highest_grade = 0 if ed4a ==0
		
		* replace highest_grade = 0 if in_school_ever ==0

		
	    ta highest_grade in_school_ever

		
		
		* Education vars:
		
		gen in_school = 1 if ed5 ==1 
		replace in_school = 0 if ed5 ==2
		
		fre ed5
		fre in_school		
		la var in_school "Currently in School (Age:3-24)"
		
	
		* current grade
		
		
		
		gen current_grade = 1 if ed6b ==1
		
		replace current_grade = 2 if ed6b ==2
		replace current_grade = 3 if ed6b ==3
		replace current_grade = 4 if ed6b ==4
		replace current_grade = 5 if ed6b ==5
		replace current_grade = 6 if ed6b ==6	
		replace current_grade = 7 if ed6b ==7
	
	    replace current_grade = 8 if ed6b ==8
		replace current_grade = 9 if ed6b ==9
		replace current_grade = 10 if ed6b ==10
		replace current_grade = 11 if ed6b ==11
		replace current_grade = 12 if ed6b ==12
		replace current_grade = 13 if ed6b ==13
		replace current_grade = 14 if ed6b ==14
		replace current_grade = 15 if ed6b ==15
		replace current_grade = 16 if ed6b ==16
		replace current_grade = 17 if ed6b ==17
		

		replace current_grade =0 if ed6a ==0
	
		fre ed6b
		fre current_grade
		
		
		ta  current_grade in_school
		fre in_school
		
		
	
		
		* school type current
		
		gen school_type = 1 if ed6c ==1
		replace school_type = 2 if ed6c==3
		replace school_type = 3 if ed6c==2
		replace school_type =5 if ed6c == 4
		
		la def st 1 "Public" 2 "Religious" 3 "Private" 4 "Other" 5 "NFBE"
		la val school_type st
		
		
		fre ed6c
		fre school_type
		la var school_type "Type of School (current)"
		
	
		* Previous Year Vars:
		
		
		* school type previous year
		
		gen school_type_2010 = 1 if ed8c ==1
		replace school_type_2010 = 2 if ed8c==3
		replace school_type_2010 = 3 if ed8c==2
		replace school_type_2010 =5 if ed8c ==4
		
		la val school_type_2010 st
		
		
		fre ed8c
		fre school_type_2010
		la var school_type_2010 "Type of School (year 2010)"
		
	
		* last year's grade:
		
		gen in_school_2010 =1 if ed7 ==1 
		replace in_school_2010 = 0 if ed7==2
		
		fre ed7
		fre in_school_2010
		
		
		gen current_grade_2010 = 0 if ed8b ==0
		replace current_grade_2010 = 1 if ed8b ==1
		replace current_grade_2010 = 2 if ed8b ==2
		replace current_grade_2010 = 3 if ed8b ==3
		replace current_grade_2010 = 4 if ed8b ==4
		replace current_grade_2010 = 5 if ed8b ==5
		replace current_grade_2010 = 6 if ed8b ==6
		replace current_grade_2010 = 7 if ed8b ==7
		
		
		replace current_grade_2010 = 8 if ed8b ==8
		replace current_grade_2010 = 9 if ed8b ==9
		replace current_grade_2010 = 10 if ed8b ==10
		replace current_grade_2010 = 11 if ed8b ==11
		replace current_grade_2010 = 12 if ed8b ==12
		replace current_grade_2010 = 13 if ed8b ==13
		replace current_grade_2010 = 14 if ed8b ==14
		replace current_grade_2010 = 15 if ed8b ==15
		replace current_grade_2010 = 16 if ed8b ==16
		replace current_grade_2010 = 17 if ed8b ==17
		

		replace current_grade_2010 = 0 if ed8a ==0
		
		
		fre ed8b
		fre current_grade_2010
		

		
		
	    * District level cleaning:
		
	   	decode hh1a, gen(dist_nm)
		clean_lname dist_nm
		
	
	
		ta dist_nm
		
	    gen dist_key= 1 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "B. NAGAR"
		replace dist_key = 3 if dist_nm == "BAHAWALPUR"
		replace dist_key = 4 if dist_nm == "BHAKKAR"
		replace dist_key = 5 if dist_nm == "CHAKWAL"
		replace dist_key = 6 if dist_nm == "DG KHAN"
		replace dist_key = 7 if dist_nm == "FAISALABAD"
		replace dist_key = 8 if dist_nm == "GUJRANWALA"
		replace dist_key = 9 if dist_nm == "GUJRAT"
		replace dist_key = 10 if dist_nm == "HAFIZABAD"
		replace dist_key = 11 if dist_nm == "JHELUM"
		replace dist_key = 12 if dist_nm == "JHANG"
		replace dist_key = 13 if dist_nm == "KASUR"
		replace dist_key = 14 if dist_nm == "KHANEWAL"
		replace dist_key = 15 if dist_nm == "KHUSHAB"
	
		replace dist_key = 17 if dist_nm == "LAHORE"
		replace dist_key = 18 if dist_nm == "LAYYAH"
		replace dist_key = 19 if dist_nm == "LODHRAN"
		replace dist_key = 20 if dist_nm == "M. BAHAUDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "M. GARH"
		replace dist_key = 24 if dist_nm == "NAROWAL"
		replace dist_key = 25 if dist_nm == "OKARA"
		replace dist_key = 26 if dist_nm == "PAKPATTAN"
		replace dist_key = 27 if dist_nm == "RY KHAN"
		replace dist_key = 28 if dist_nm == "RAJANPUR"
		replace dist_key = 29 if dist_nm == "RAWALPINDI"
		replace dist_key = 30 if dist_nm == "SAHIWAL"
		replace dist_key = 31 if dist_nm == "SARGODHA"
		replace dist_key = 32 if dist_nm == "SHEIKHUPURA"
		replace dist_key = 33 if dist_nm == "SIALKOT"
		replace dist_key = 34 if dist_nm == "TT SINGH"
		replace dist_key = 35 if dist_nm == "VEHARI"
		replace dist_key = 36 if dist_nm == "N. SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 

		*check:
		ta dist_nm if dist_key ==1
		

		
		
		
		
		tempfile hl_2011
	    save `hl_2011', replace
	
		merge m:1 hh_cluster hh_number using `hh_2011'

		la var _merge "Merge HH members data with HH data (hh with hl)"

	****************************************************************************
	
	
		* Addtional code for quintiles to be incorporated in the master file
		
		* relation : hl3
		* mother educ level: melevel
		* father educ level: felevel		
				
				
		********************************************************************************
		* HH EDUC STATUS
	

		
        drop if line_number ==.
     	
		* drop hg
		
	
		preserve		
		* Head:
		 keep hh_cluster hh_number line_number hl3 highest_grade in_school_ever in_school
		 
		 keep if hl3 ==1
		 fre highest_grade
		 isid hh_cluster hh_number line_number
		 isid hh_cluster hh_number
		
		gen hg = highest_grade 
		recode hg (12=11) (13=12) (14=12) (15=12) (16=12) (17=12)
		ta hg
		la def hg 0 "Less than grade 1" 1 "Grade1" 2 "Grade 2" 3 "Grade 4" 5 "Grade 5" 6 "Grade 6" 7 " Grade 7" 8 "Grade 8" 9 "Grade 9" 10 "Grade 10" 11 "FSC" 12 "Higher Education"
		la val hg hg 
        ren hg head_educ
			
		tempfile head_educ 
		save `head_educ', replace
		
		 restore
		
		
	  preserve		
	 
		* Parent : Father
		 keep hh_cluster hh_number line_number hl3 highest_grade gender in_school_ever in_school
		 keep if hl3 ==6
		 fre highest_grade
		 keep if gender ==1
		
		
		* Check duplicates and drop:
		
	* 	duplicates drop hh_cluster hh_number, force
		
		
				
		gen hg = highest_grade 
		recode hg (12=11) (13=12) (14=12) (15=12) (16=12) (17=12)
		ta hg
		la def hg 0 "Less than grade 1" 1 "Grade1" 2 "Grade 2" 3 "Grade 4" 5 "Grade 5" 6 "Grade 6" 7 " Grade 7" 8 "Grade 8" 9 "Grade 9" 10 "Grade 10" 11 "FSC" 12 "Higher Education"
		la val hg hg 
        * ren hg father_educ


		bysort hh_cluster hh_number: gen x =_n

		keep hh_cluster hh_number hg x
		ren hg hg_father
	
		
		reshape wide hg_father, i(hh_cluster hh_number) j(x) 

		egen hg_dad = rowmax (hg_father1 hg_father2)
		
		 isid hh_cluster hh_number 

	
		 keep  hh_cluster hh_number  hg_dad
		 
		  ren hg_dad father_educ

		 
	    tempfile father_educ 
		save `father_educ', replace
		
		
		 restore
		
		
		
		 preserve		
	 
		* Parent : Mother
		 keep hh_cluster hh_number line_number hl3 highest_grade gender in_school_ever in_school
		 keep if hl3 ==6
		 fre highest_grade
		 keep if gender ==2

						
		gen hg = highest_grade 
		recode hg (12=11) (13=12) (14=12) (15=12) (16=12) (17=12)
		ta hg
		la def hg 0 "Less than grade 1" 1 "Grade1" 2 "Grade 2" 3 "Grade 4" 5 "Grade 5" 6 "Grade 6" 7 " Grade 7" 8 "Grade 8" 9 "Grade 9" 10 "Grade 10" 11 "FSC" 12 "Higher Education"
		la val hg hg 
       * ren hg mother_educ

		
		

		bysort hh_cluster hh_number: gen x =_n

		keep hh_cluster hh_number hg x
	
		ren hg hg_mother

		reshape wide hg_mother, i(hh_cluster hh_number) j(x) 

		egen hg_mom = rowmax (hg_mother1 hg_mother2)
		
	
	   keep  hh_cluster hh_number  hg_mom

	   ren hg_mom  mother_educ
	   
	   isid hh_cluster hh_number
		
	    tempfile mother_educ 
		save `mother_educ', replace
		 restore
			
	*****************************************************************************
	
	    preserve 
		
		
		use `head_educ', clear
		merge 1:1 hh_cluster hh_number using `father_educ', nogen
		merge 1:1 hh_cluster hh_number using `mother_educ', nogen
		
		
		keep hh_cluster hh_number head_educ father_educ mother_educ in_school_ever in_school
		
		egen hh_es = rowmax (head_educ father_educ mother_educ)
		
		fre hh_es
		ta in_school_ever if hh_es ==.
		
		fre hh_es
	
	/*
	* adjust hh_education_level according to the in_school_ever variable:
		replace hh_es = 0 if in_school_ever ==0
		
	*/
	
		fre hh_es
		
		
	    *   la def hg 0 "Less than grade 1" 1 "Grade1" 2 "Grade 2" 3 "Grade 4" 5 "Grade 5" 6 "Grade 6" 7 " Grade 7" 8 "Grade 8" 9 "Grade 9" 10 "Grade 10" 11 "FSC" 12 "Higher Education"
		la val hh_es hg
		fre hh_es

		
		gen hh_educ_status = 0 if hh_es ==1   // less than 1 
		replace hh_educ_status = 1 if hh_es >= 1 & hh_es<=5 // primary
		replace hh_educ_status = 2 if hh_es >=6 & hh_es <=8 // secondary
		replace hh_educ_status = 3 if hh_es>=9 & hh_es <=10 //  higher secondary
		replace hh_educ_status = 4 if hh_es==11  // FA/FSC
		replace hh_educ_status =5 if hh_es == 12  // higher education
		
		la def hh_educ_status 0 "Less than grade 1" 1 "Primary (1-5)" 2 "Secondary (6-8)" 3 "Higher Secondary (9-10)" 4 "FA/FSc/Diploma" 5 "Bachelors or Higher Education"
		la val hh_educ_status hh_educ_status
		
		drop in_school in_school_ever
		
		ren hh_educ_status hh_educ_level
		
		
	    tempfile hh_es 
		save `hh_es', replace
		
		restore 
		
		
		*****************************************************************************

		merge m:1 hh_cluster hh_number using `hh_es', nogen
		
		
		**********************************************************************************
		
		
		* Cleaning HH ASSETS for asset quintiles:
		
		
		* Persons per sleeping rooms(continous)
		
		gen sleeping_rooms = hc2
		recode sleeping_rooms (99=.)
		
		bysort hh_cluster hh_number: gen x=_N
		
		gen WI_sleeping_rooms = sleeping_rooms/x
	
	
		* type of roof (no floor or dung floor coded as 0)
		
		
		 gen WI_roof = 1 if hc4==11 | hc4==12 | hc4 == 13   // no/raw  (or  kacha) roof
		 replace WI_roof =2 if hc4==21 | hc4 == 22  | hc4 ==23 // semi finsihed roof
		 replace WI_roof =3 if hc4==31 | hc4 == 32  | hc4 ==33 | hc4 ==34 | hc4==35 // finsihed or pakka roof
		 
		
		* type of FLOOR:
		
		/*
		gen WI_floor = 0 if hc4	==11 | hc4 == 12
		replace WI_floor = 1 if hc4 != 11 | hc4 !=12 | hc4 != 99
		*/
		
		gen WI_floor = 1 if hc3 ==11| hc3 == 12  // no floor
		replace WI_floor = 2 if hc3 == 34 | hc3 == 36 // cement or bricked
		replace WI_floor = 3 if hc3 == 33 // titles or marbles
		replace WI_floor = 4 if hc3 ==35 | hc3 ==32  // carpet 
		replace WI_floor = 5 if hc3 == 32 | hc3 ==31 // Wooden or asphalt strips 

		

			
		* type of wall
			
			/*
		gen WI_walls = 0 if hc6	==11
		replace WI_walls = 1 if hc6 != 11 | hc6 != 99
		*/
		
		gen WI_walls = 1 if hc5==11 | hc5==12 | hc5==13 // no /raw or kachi wall
		replace WI_walls = 2 if hc5==21 | hc5==22 | hc5==23 | hc5==24 | hc5==25 | hc5==26  // semi finished
		replace WI_walls = 3 if hc5==31 | hc5==32 | hc5==33 | hc5 ==34 | hc5==35 // paki
			

	
	
		recode   hc8a hc8b hc8c hc8d hc8e hc8f hc8g hc8h hc8i hc8j hc8k hc8l hc8m hc8n hc8o hc9j hc9i hc9h hc9g hc9e hc9d hc9c hc9b hc9a  hc11  hc13  (9=.) (2=0)
			
			* electricity
			
			
			gen WI_electricity = hc8a 
			
			* radio
			
			gen WI_radio = hc8b
			
			* Tv
			
			gen WI_tv = hc8c
			
		
			
			* refrigerator
			
			gen WI_refrigerator = hc8e
			
			* GAs
			
			gen WI_gas = hc8f
			
			
			* Computer
			gen WI_computer = hc8g
			
			* AC
			
			gen WI_ac = hc8h
			
			
			* Washing machine
			
			gen WI_wm = hc8i
			
			
			* Air cooler
			
			gen WI_aircooler = hc8j
			
			* Cooking range
			
			gen WI_cookingrange = hc8k
			
			* sewing machine
			
			gen WI_sewing = hc8l
			
			
			
			* Iron
			
			gen WI_iron = hc8m
			
			* Water filter
			gen WI_waterfilter = hc8n
			
			
			* Dunky pump/ Turbine
			
			gen WI_turbine = hc8o
			
			
			* Watch
			
			gen WI_clock = hc9a
			
			
			* mobile
			
			gen WI_mobile = hc9b
			
			* bicylce
			
			gen WI_bicycle = hc9c
			
			* motorcycle
			
			gen WI_motorcycle = hc9d
			
			* Animal cart 
			
			gen WI_animalcart = hc9e
			
			
			* Bus or truck 
			
			gen WI_bus = hc9h
			
			* Boat
			
			gen WI_boat = hc9g
			
			* Car
			
			gen WI_car = hc9i
			
			
			* Tractor 
			
			gen WI_tractor = hc9j
			
			
			* Ownership of hh
			
			gen WI_ownership = 0 if hc10 ==6
			replace WI_ownership = 0 if hc10 ==2
			replace WI_ownership = 1 if hc10 ==1
			
	
			* agricultural land

			gen WI_agriland = hc11
			
			
		* Land area (continous)

		gen WI_landarea = hc12	
		recode WI_landarea (99=.) (98=.)	
			
			
			
			* HH animals
			
			gen WI_animals = hc13
		
		
		recode hc14a hc14b hc14c hc14d hc14e (98=.) (99=.)

		* horses
		
		clonevar WI_cattle = hc14a
		clonevar WI_horses = hc14b
		clonevar WI_goats = hc14c 
		clonevar WI_sheeps = hc14d 
		clonevar WI_chicken = hc14e
		
		
		
			
		* bank account
		
		gen WI_bankac = 0 if hc15 == 2
		replace WI_bankac = 1 if hc15 ==1 & hc15 != 9
		
		
		
		* toilet
		
		gen WI_toilet = 0 if ws8 ==95
		replace WI_toilet = 1 if ws8 != 95 & ws8 != 96 & ws8 != 99 
		
	
         *  HH using toilet
		
		
		
			gen WI_tf = 9 if ws11 ==10
			replace WI_tf = 8 if ws11 ==9
			replace WI_tf = 7 if ws11 ==8
			replace WI_tf = 6 if ws11 ==7
			replace WI_tf = 5 if ws11 ==6
			replace WI_tf = 4 if ws11 ==5
			replace WI_tf = 3 if ws11 ==4
			replace WI_tf = 2 if ws11 ==3
			replace WI_tf = 1 if ws11 ==2

	
		* water available at the place handwashing
			
			gen WI_handwash_water = 1 if hw2 ==1
			replace WI_handwash_water =0 if hw2 != 1 & hw2 != 9
			
		* availabilty of soap at the place of handwash

			gen WI_handwash_soap = 1 if hw4 ==1
			replace WI_handwash_soap =0 if hw4 != 1 & hw4 != 9
	
	  * non mobile
	  
	  gen WI_phone = hc8d
	  
	  
	  * fuel
	  
	  gen WI_fuel = 1 if hc6 ==96 |hc6 ==95
	  replace WI_fuel = 2 if hc6==10 | hc6 ==9 
	  replace WI_fuel = 3 if hc6 == 8 | hc6 ==7 | hc6 == 6
	  replace WI_fuel = 4 if hc6 ==5 | hc6 ==4 
	  replace WI_fuel = 5 if hc6 ==3| hc6 ==2 | hc6 ==1
	  
	  
	****************************************************************************	
	
	* ASSET VARS:
	
	quiet: estpost sum WI_ownership  WI_sleeping_rooms WI_floor WI_roof WI_walls WI_fuel WI_electricity WI_radio WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_waterfilter WI_turbine WI_clock  WI_mobile WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_bankac	WI_agriland WI_ownership 
	esttab, cell("mean(label(Mean)fmt(%9.3f)) sd(label(S.D)) min(label(Min)fmt(%9.0f)) max(label(Max)fmt(%9.0f)) count(label(Obs.)fmt(%9.0f))") label nonumber noobs 

	/*
	WI_sleeping_rooms
	WI_landarea
	*/

		
	//Principal Component Analysis

		* SES 1: taking Yearly total income variable
	pca WI_ownership WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_fuel WI_electricity WI_radio WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_waterfilter WI_turbine WI_clock  WI_mobile WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_bankac WI_agriland  WI_animals

	predict Asset_Level

	alpha  WI_ownership WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_fuel WI_electricity WI_radio WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_waterfilter WI_turbine WI_clock  WI_mobile WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_bankac WI_agriland  WI_animals


	
	
		/*
	****************************************************************************
	
	
	* Urban
	pca WI_* if hh6 ==1
	predict Asset_level_urban
	alpha  WI_* if hh6 ==1
	

	
	****************************************************************************
	
	* Rural 
	pca WI_* if hh6 ==2
	
	predict Asset_level_rural

	alpha  WI_* if hh6 ==2
	
	
	
	****************************************************************************
	
	
 
	
		
	* regression to fix
	
	reg Asset_Level Asset_Level_urban Asset_Level_rural, r	
	predict AA
	
	
	
	*/
	
	
	***************************************************************************
	

	
	cap drop asset_quintiles
	xtile asset_quintiles = Asset_Level , n(5)
	
	
	la def quintiles 1 "Bottom 20" 2 "20-40" 3 "40-60" 4 "60-80" 5 "Upper 20", modify
	la val asset_quintiles quintiles 

		
	la var asset_quintiles "Asset Quintiles from Wealth Index"

	* Created Asset Quintiles using HH-assets:	
	fre asset_quintiles
	* Existing Quintiles (already part of the dataset) 
	fre windex5
	* HH education status:
	
	fre hh_educ_level
	
	corr asset_quintiles hh_educ_level
	
	
	* created vs existing quantiles in the dataset:
	
	fre windex5
	fre asset_quintiles

	ta asset_quintiles windex5 , row col
	corr asset_quintiles windex5

			
    corr Asset_Level wscore 
		
	* region	
	gen region = 1 if hh6u ==1
	replace region = 2 if hh6u ==0
	
	
	
	
		gen year = 2011
	
		order year	hh_cluster hh_number line_number dist_key dist_nm age gender in_school_ever in_school current_grade school_type in_school_2010 current_grade_2010 school_type_2010 highest_grade

		
		
				
		tempfile mics_2011
	    save `mics_2011', replace
		

		
		
	
********************************************************************************
		save "$mics_clean\MICS_HH_clean_2011.dta", replace		
********************************************************************************	

exit



