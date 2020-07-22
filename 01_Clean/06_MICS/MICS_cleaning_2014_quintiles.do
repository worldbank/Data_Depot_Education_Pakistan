* MICS DATA CLEANING : 
* Author: Ahmed Raza
* Date: 30th September 2019
* Purpose: MICS data cleaning with quintiles:

		* Dropbox Globals
		
        include init.do
  	  
		

		* 2014:
		
		
		* HH: Household:
	
		use "$mics_raw\2014\hh.dta", clear 
		
		ren *, lower
		
		ren hh1 hh_cluster
		ren hh2 hh_number
		
		isid hh_cluster hh_number
		
		tempfile hh_2014
	    save `hh_2014', replace

	
		
		* HL: Household Members:
		
		use "$mics_raw\2014\hl.dta", clear 
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
	  
	   * note: code 0 shouldn't be assigned according to the instrument (data error)


	    fre ed4b if ed4a ==0
	
	    gen highest_grade = 0 if ed4a ==0
		
		*Primary:
		replace highest_grade = 1 if ed4a ==1 & ed4b ==1
		replace highest_grade = 2 if ed4a ==1 & ed4b ==2
		replace highest_grade = 3 if ed4a ==1 & ed4b ==3
		replace highest_grade = 4 if ed4a ==1 & ed4b ==4
		replace highest_grade = 5 if ed4a ==1 & ed4b ==5

		
		* Lower Secondary
		replace highest_grade = 6 if ed4a ==2 & ed4b ==1
		replace highest_grade = 7 if ed4a ==2 & ed4b ==2
		replace highest_grade = 8 if ed4a ==2 & ed4b ==3

		
		* Upper Secondary
	    * note: code 3 shouldn't be assigned according to the instrument (data error)
	
		replace highest_grade = 9 if ed4a ==3 & ed4b ==1
		replace highest_grade = 10 if ed4a ==3 & ed4b ==2
		
	
		* Higher
		replace highest_grade = 11 if ed4a ==4 & ed4b ==1
		replace highest_grade = 12 if ed4a ==4 & ed4b ==2
		replace highest_grade = 13 if ed4a ==4 & ed4b ==3
		replace highest_grade = 14 if ed4a ==4 & ed4b ==4
		replace highest_grade = 15 if ed4a ==4 & ed4b ==5
		replace highest_grade = 16 if ed4a ==4 & ed4b ==6
		replace highest_grade = 17 if ed4a ==4 & ed4b ==7

		* replace highest_grade =0 if in_school_ever ==0 
  
		la var highest_grade "Highest Grade Completed"	

	

		* Education vars:
		
		gen in_school = 1 if ed5 ==1 
		replace in_school = 0 if ed5 ==2
		replace in_school =. if ed5==9
		
		fre ed5
		fre in_school		
		
		
		la var in_school "Currently in School (Age:3-24)"
		
	
		* current grade
		
	    fre ed6b if ed6a ==0
	    gen cg = 0 if ed6a ==0
		
		*Primary:
		replace cg = 1 if ed6a ==1 & ed6b ==1
		replace cg = 2 if ed6a ==1 & ed6b ==2
		replace cg = 3 if ed6a ==1 & ed6b ==3
		replace cg = 4 if ed6a ==1 & ed6b ==4
		replace cg = 5 if ed6a ==1 & ed6b ==5

		
		* Lower Secondary
		replace cg = 6 if ed6a ==2 & ed6b ==1
		replace cg = 7 if ed6a ==2 & ed6b ==2
		replace cg = 8 if ed6a ==2 & ed6b ==3

		
		* Upper Secondary
	
		replace cg = 9 if ed6a ==3 & ed6b ==1
		replace cg = 10 if ed6a ==3 & ed6b ==2
		
		* higher
		replace cg = 11 if ed6a ==4 & ed6b ==1
		replace cg = 12 if ed6a ==4 & ed6b ==2
		replace cg = 13 if ed6a ==4 & ed6b ==3
		replace cg = 14 if ed6a ==4 & ed6b ==4
		replace cg = 15 if ed6a ==4 & ed6b ==5
		replace cg = 16 if ed6a ==4 & ed6b ==6
		replace cg = 17 if ed6a ==4 & ed6b ==7
		
        ren cg current_grade


		fre ed6b
		fre current_grade
		
		
		ta current_grade in_school
		
		
	
		* school type current
		gen school_type = 1 if ed6c ==1
		* replace school_type = 2 if ed6c==2
		replace school_type = 3 if ed6c==2
		replace school_type =4 if ed6c ==6
		
		la def st 1 "Public" 2 "Religious" 3 "Private" 4 "Other"
		la val school_type st
		
		
		fre ed6c
		fre school_type
		la var school_type "Type of School (current)"
		
		
		* Previous Year Vars:
		
		
		* school type previous year
		
		gen school_type_2013 = 1 if ed8c ==1
		*replace school_type_2013 = 2 if ed8c==2
		replace school_type_2013 = 3 if ed8c==2
		replace school_type_2013 =4 if ed8c ==6
		
		la val school_type_2013 st
		
		
		fre ed8c
		fre school_type_2013
		la var school_type_2013 "Type of School (year 2013)"
		
	
	
	********************************************************************************
	
	
		* last year's grade:
		
		gen in_school_2013 =1 if ed7 ==1 
		replace in_school_2013 = 0 if ed7 ==2
		
	
		fre ed7
		fre in_school_2013
		
		
	
	    fre ed8b if ed8a ==0
	    gen cg_13 = 0 if ed8a ==0
	
		*Primary:
		replace cg_13 = 1 if ed8a ==1 & ed8b ==1
		replace cg_13 = 2 if ed8a ==1 & ed8b ==2
		replace cg_13 = 3 if ed8a ==1 & ed8b ==3
		replace cg_13 = 4 if ed8a ==1 & ed8b ==4
		replace cg_13 = 5 if ed8a ==1 & ed8b ==5

		
		* Lower Secondary
		replace cg_13 = 6 if ed8a ==2 & ed8b ==1
		replace cg_13 = 7 if ed8a ==2 & ed8b ==2
		replace cg_13 = 8 if ed8a ==2 & ed8b ==3

		
		* Upper Secondary
	
		replace cg_13 = 9 if ed8a ==3 & ed8b ==1
		replace cg_13 = 10 if ed8a ==3 & ed8b ==2
		
		* higher
		replace cg_13 = 11 if ed8a ==4 & ed8b ==1
		replace cg_13 = 12 if ed8a ==4 & ed8b ==2
		replace cg_13 = 13 if ed8a ==4 & ed8b ==3
		replace cg_13 = 14 if ed8a ==4 & ed8b ==4
		replace cg_13 = 15 if ed8a ==4 & ed8b ==5
		replace cg_13 = 16 if ed8a ==4 & ed8b ==6
		replace cg_13 = 17 if ed8a ==4 & ed8b ==7
	
		* replace cg_13 =0 if in_school_2013 ==0

        ren cg_13 current_grade_2013
		
		fre current_grade_2013
		fre ed8b
		
		ta current_grade_2013 in_school_2013


	    * District level cleaning:
		
	   	decode hh7, gen(dist_nm)
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
		

	
********************************************************************************
		tempfile hl_2014
	    save `hl_2014', replace
	
		merge m:1 hh_cluster hh_number using `hh_2014'

		la var _merge "Merge HH members data with HH data (hh with hl)"
		
		
		
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
			

	
	
		recode   hc8a hc8b hc8c hc8d hc8e hc8f hc8g hc8h hc8i hc8j hc8k hc8l hc8m hc8n hc8o hc9a hc9b hc9c hc9d hc9e hc9f hc9g hc9h hc9i  hc11  hc13  (9=.) (2=0)
			
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
			
			gen WI_bus = hc9f
			
			* Boat
			
			gen WI_boat = hc9g
			
			* Car
			
			gen WI_car = hc9h
			
			
			* Tractor 
			
			gen WI_tractor = hc9i
			
		
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

			gen WI_handwash_soap = 1 if hw3a ==1
			replace WI_handwash_soap =0 if hw3a != 1 & hw3a != 9
	
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
	
	quiet: estpost sum  WI_ownership WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_fuel WI_electricity WI_radio WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_waterfilter WI_turbine WI_clock  WI_mobile WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_bankac WI_agriland  WI_animals

	
	esttab, cell("mean(label(Mean)fmt(%9.3f)) sd(label(S.D)) min(label(Min)fmt(%9.0f)) max(label(Max)fmt(%9.0f)) count(label(Obs.)fmt(%9.0f))") label nonumber noobs 

	/*
	WI_sleeping_rooms
	WI_landarea
	*/

		
	//Principal Component Analysis

		* SES 1: taking Yearly total income variable
	pca  WI_ownership WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_fuel WI_electricity WI_radio WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_waterfilter WI_turbine WI_clock  WI_mobile WI_tv WI_phone WI_refrigerator WI_gas WI_computer WI_ac WI_wm  WI_aircooler WI_cookingrange WI_sewing WI_iron WI_bankac WI_agriland  WI_animals

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
	
	
	reg 
	
		
	* regression to fix
	
	reg Asset_Level Asset_Level_urban Asset_Level_rural, r	
	predict AA
	
	
	
	*/
	
	
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

	table windex5 , c(mean in_school_ever)
	table windex5 if age>=6 & age<=10 , c(mean in_school_ever)
	
		
	
	table asset_quintiles , c(mean in_school_ever)
	table asset_quintiles if age>=6 & age<=10 , c(mean in_school_ever)
	
	
	
	table hh_educ_level , c(mean in_school)
	table hh_educ_level if age>=6 & age<=10 , c(mean in_school_ever)
	
	
			
	* region	
	gen region = 1 if  hh6r ==2
	replace region = 2 if  hh6r == 1
	
	fre region
	fre hh6r
	
		
		
		gen year = 2014
	
		order year	hh_cluster hh_number line_number dist_key dist_nm age gender in_school_ever in_school current_grade school_type in_school_2013 current_grade_2013 school_type_2013 highest_grade

				
		tempfile mics_2014
	    save `mics_2014', replace
		

	
********************************************************************************
		save "$mics_clean\MICS_HH_clean_2014.dta", replace		
********************************************************************************	


exit





/*

* MICS Report on Quintiles
********************************************************************************

- The wealth index is a composite indicator of wealth. 
To construct the wealth index, principal components analysis is performed by using information on the:
ownership of consumer goods, dwelling characteristics, water and sanitation, and other characteristics 
that are related to the household’s wealth, to generate weights (factor scores) for each of the items used. 

- First, initial factor scores are calculated for the total sample. 
Then, separate factor scores are calculated for households in urban and rural areas. 
Finally, the urban and rural factor scores are regressed on the initial factor scores to obtain the combined, final factor scores for the total sample. 
This is carried out to minimize the urban bias in the wealth index values. 
 
- Each household in the total sample is then assigned a wealth score based on the assets owned by that household and on the final factor scores obtained 
as described above. The survey household population is then ranked according to the wealth score of the household they are living in, and is finally 
divided into 5 equal parts (quintiles) from lowest (poorest) to highest (richest).  
 
- In MICS Punjab, 2014 the following assets are used in these calculations: 
Main material of the dwelling floor, Main material of the roof, Main material of the exterior walls, type of fuel used for cocking, 
Household possessions (Electricity, Radio, Television, Non-mobile telephone, Refrigerator/Freezer, Gas, Computer, Air conditioner, Washing machine/Dryer, Air cooler/ Fan, Cooking Range/Micro wave, Sewing/knitting machine, Iron, Water Filter and Dunky pump/Turbine), utilities owned by household members (Watch, Mobile telephone, Bicycle, Motorcycle / Scooter, Animal drawn-cart, Bus / Truck, Boat with motor, Car / Van, Tractor/Trolley),  household ownership, ownership of land, having animals (Cattle, milk cows, Buffaloes or bulls, Horses, donkeys, mules or camels, Goats, Sheep and Chickens/ Ducks/ Turkey), possession of bank account,
 main source of drinking water and type of toilet.  
 
- The wealth index is assumed to capture the underlying long-term wealth through information on the household assets, and is intended to produce a ranking of households by wealth, from lowest to highest. The wealth index does not provide information on absolute poverty, current income or expenditure levels. The wealth scores calculated are applicable for only the particular data set they are based on.  
 
- Further information on the construction of the wealth index can be found in Filmer, D. and Pritchett, L., 2001. “Estimating wealth effects without expenditure data – or tears: An application to educational enrolments in mstates of India”. Demography 38(1): 115-132. Rutstein, S.O. and Johnson, K., 2004. The DHS Wealth Index. DHS Comparative Reports No. 6. Calverton, Maryland: ORC Macro and Rutstein, S.O., 2008. 
The DHS Wealth Index: Approaches for Rural and Urban Areas. DHS Working Papers No. 60. Calverton, Maryland: Macro International Inc. 
 
- When describing survey results by wealth quintiles, appropriate terminology is used when referring to individual household members, such as for instance “women in the richest population quintile”, which is used interchangeably with “women in the wealthiest survey population”, “women living in households in the highest population wealth quintile”, and similar. 
