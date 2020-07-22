* MICS DATA CLEANING : 
* Author: Ahmed Raza
* Date: 30th September 2019
* Purpose: MICS data cleaning with quintiles:

		* Dropbox Globals
		
        include init.do
  	  
		
********************************************************************************
		
		* 2017:
		
		
		* HH: Household:		
		
		use "$mics_raw\2017\hh.dta", clear 

		
		ren *, lower
		
		ren hh1 hh_cluster
		ren hh2 hh_number
		
		isid hh_cluster hh_number
		
		tempfile hh_2017
	    save `hh_2017', replace

		
		* HL: Household Members:
		
		
		use "$mics_raw\2017\hl.dta", clear 
		

		
		ren *, lower
		
		
		
		* Variable cleaning: 
	
		ren hh1 hh_cluster
		ren hh2 hh_number
		ren hl1 line_number
		
		isid hh_cluster hh_number line_number 
		
		
		gen age = da2b 
		gen gender = hl4
		la val gender HL4
		
		* ever attended school:
	    gen in_school_ever =1 if ed4 ==1
		replace in_school_ever =0 if ed4 ==2
		replace in_school_ever =. if ed4 ==9
		
		fre ed4
		fre in_school_ever
		
	
		la var in_school_ever "Ever attended school (Age: 3 and above)"
	
	
	
	    * highest grade completed
	
	
	    fre ed5b if ed5a ==0
	
	    gen highest_grade = 0 if ed5a ==0
		*Primary:
		replace highest_grade = 1 if ed5a ==1 & ed5b ==1
		replace highest_grade = 2 if ed5a ==1 & ed5b ==2
		replace highest_grade = 3 if ed5a ==1 & ed5b ==3
		replace highest_grade = 4 if ed5a ==1 & ed5b ==4
		replace highest_grade = 5 if ed5a ==1 & ed5b ==5

		
		* Lower Secondary
		replace highest_grade = 6 if ed5a ==2 & ed5b ==1
		replace highest_grade = 7 if ed5a ==2 & ed5b ==2
		replace highest_grade = 8 if ed5a ==2 & ed5b ==3

		
		* Upper Secondary
	    * note: code 3 shouldn't be assigned according to the instrument (data error)
	
		replace highest_grade = 9 if ed5a ==3 & ed5b ==1
		replace highest_grade = 10 if ed5a ==3 & ed5b ==2
		
		* higher
		replace highest_grade = 11 if ed5a ==4 & ed5b ==1
		replace highest_grade = 12 if ed5a ==4 & ed5b ==2
		replace highest_grade = 13 if ed5a ==4 & ed5b ==3
		replace highest_grade = 14 if ed5a ==4 & ed5b ==4
		replace highest_grade = 15 if ed5a ==4 & ed5b ==5
		replace highest_grade = 16 if ed5a ==4 & ed5b ==6
		replace highest_grade = 17 if ed5a ==4 & ed5b ==7
		
		* replace highest_grade =0 if in_school_ever ==0 

	
	
	

	    gen hg_completed = highest_grade if ed6==1
		gen hg_attended = highest_grade if ed6==2
		
		fre hg_attended
		recode hg_attended (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (10=9) (11=10) (12=11) (13=12) (14=13) (15=14) (16=15) (17=16)
		fre hg_attended
		
		
		gen highest_grade_completed = hg_completed if ed6==1
		replace highest_grade_completed = hg_attended if ed6==2
		
		fre highest_grade_completed
		  
		  
		ren highest_grade hg  
		ren highest_grade_completed highest_grade
		  
		la var highest_grade "Highest Grade Completed"
		la var hg "Highest grade ever attended/completed"
		la var hg_attended "Highest Grade attended"
		la var hg_completed "Highest Grade completed"
	
	
	
		* Education vars:
		
		ge x =1 if age>=3 & age <=24
		fre x
		fre ed7
		
		
		gen in_school = 1 if ed9 ==1 
		replace in_school = 0 if ed9 ==2		
		replace in_school = . if ed9 ==9 
		
		fre in_school
		fre ed9
	
		
		drop x

		la var in_school "Currently in School (Age:3-24)"
		
	
		
		* current grade	
	
	    fre ed10b if ed10a ==0
	
	    gen cg = 0 if ed10a ==0
		
		*Primary:
		replace cg = 1 if ed10a ==1 & ed10b ==1
		replace cg = 2 if ed10a ==1 & ed10b ==2
		replace cg = 3 if ed10a ==1 & ed10b ==3
		replace cg = 4 if ed10a ==1 & ed10b ==4
		replace cg = 5 if ed10a ==1 & ed10b ==5

		
		* Lower Secondary
		replace cg = 6 if ed10a ==2 & ed10b ==1
		replace cg = 7 if ed10a ==2 & ed10b ==2
		replace cg = 8 if ed10a ==2 & ed10b ==3

		
		* Upper Secondary
	
		replace cg = 9 if ed10a ==3 & ed10b ==1
		replace cg = 10 if ed10a ==3 & ed10b ==2
		
		* higher
		replace cg = 11 if ed10a ==4 & ed10b ==1
		replace cg = 12 if ed10a ==4 & ed10b ==2
		replace cg = 13 if ed10a ==4 & ed10b ==3
		replace cg = 14 if ed10a ==4 & ed10b ==4
		replace cg = 15 if ed10a ==4 & ed10b ==5
		replace cg = 16 if ed10a ==4 & ed10b ==6
		replace cg = 17 if ed10a ==4 & ed10b ==7
	
		
		* replace cg =0 if in_school ==0
        
		ren cg current_grade

		fre ed10b
		fre current_grade
		
	
	****************************************************************************
		
		* school type
		
		gen school_type = 1 if ed11 ==1
		replace school_type = 2 if ed11==2
		replace school_type = 3 if ed11==3
		replace school_type =4 if ed11 ==6
		
		la def st 1 "Public" 2 "Religious" 3 "Private" 4 "Other"
		la val school_type st
		
		
		fre ed11
		fre school_type
		la var school_type "Type of School (current)"
		
		
		
		la var in_school "Currently in School (Age:3-24)"
		
		************************************************************************
		
		* last year's grade:
	
	
		gen in_school_2016 =1 if ed15 ==1 
		replace in_school_2016 = 0 if ed15 ==2
		replace in_school_2016 = . if  ed15 ==8 | ed15==9
		
	
		
			* current grade	
	
	    fre ed16b if ed16a ==0
	
	    gen cg_16 = 0 if ed16a ==0
		
		*Primary:
		replace cg_16 = 1 if ed16a ==1 & ed16b ==1
		replace cg_16 = 2 if ed16a ==1 & ed16b ==2
		replace cg_16 = 3 if ed16a ==1 & ed16b ==3
		replace cg_16 = 4 if ed16a ==1 & ed16b ==4
		replace cg_16 = 5 if ed16a ==1 & ed16b ==5

		
		* Lower Secondary
		replace cg_16 = 6 if ed16a ==2 & ed16b ==1
		replace cg_16 = 7 if ed16a ==2 & ed16b ==2
		replace cg_16 = 8 if ed16a ==2 & ed16b ==3

		
		* Upper Secondary
	
		replace cg_16 = 9 if ed16a ==3 & ed16b ==1
		replace cg_16 = 10 if ed16a ==3 & ed16b ==2
		
		* higher
		replace cg_16 = 11 if ed16a ==4 & ed16b ==1
		replace cg_16 = 12 if ed16a ==4 & ed16b ==2
		replace cg_16 = 13 if ed16a ==4 & ed16b ==3
		replace cg_16 = 14 if ed16a ==4 & ed16b ==4
		replace cg_16 = 15 if ed16a ==4 & ed16b ==5
		replace cg_16 = 16 if ed16a ==4 & ed16b ==6
		replace cg_16 = 17 if ed16a ==4 & ed16b ==7
		
		* replace cg_16 = 0 if in_school_2016 ==0
	
        ren cg_16 current_grade_2016
		
		
		fre ed16b
		fre current_grade_2016
		
        ta current_grade_2016 in_school_2016
		
	    * District level cleaning:
		
	   	decode hh7, gen(dist_nm)
		clean_lname dist_nm
		
	
		ta dist_nm
		
	    gen dist_key= 1 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGAR"
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
		replace dist_key = 20 if dist_nm == "MANDI BAHAUDDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "MUZAFFARGARH"
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
		replace dist_key = 36 if dist_nm == "NANKANA SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 

		*check:
		ta dist_nm if dist_key ==1
	
	
********************************************************************************
		tempfile hl_2017
	    save `hl_2017', replace
	
		merge m:1 hh_cluster hh_number using `hh_2017'

		la var _merge "Merge HH members data with HH data (hh with hl)"
		
		
		gen year = 2017
	
		order year	hh_cluster hh_number line_number dist_key dist_nm age gender in_school_ever in_school current_grade in_school_2016 current_grade_2016 school_type highest_grade


		
	
***************************************************************************************************************************************************************
* Addtional code for quintiles to be incorporated in the master file
		
		* relation : hl3
		* mother educ level: melevel
		* father educ level: felevel		
				
				
		********************************************************************************
		* HH EDUC STATUS

        drop if line_number ==.
     	
		drop hg
		
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
		 
		 isid hh_cluster hh_number 
				
		gen hg = highest_grade 
		recode hg (12=11) (13=12) (14=12) (15=12) (16=12) (17=12)
		ta hg
		la def hg 0 "Less than grade 1" 1 "Grade1" 2 "Grade 2" 3 "Grade 4" 5 "Grade 5" 6 "Grade 6" 7 " Grade 7" 8 "Grade 8" 9 "Grade 9" 10 "Grade 10" 11 "FSC" 12 "Higher Education"
		la val hg hg 
        ren hg father_educ
			
	
	    tempfile father_educ 
		save `father_educ', replace
		
		 restore
		
		
		
				
	     preserve		
	 
		* Parent : Mother
		 keep hh_cluster hh_number line_number hl3 highest_grade gender in_school_ever in_school
		 keep if hl3 ==6
		 fre highest_grade
		 keep if gender ==2
		 
		 isid hh_cluster hh_number 
				
		gen hg = highest_grade 
		recode hg (12=11) (13=12) (14=12) (15=12) (16=12) (17=12)
		ta hg
		la def hg 0 "Less than grade 1" 1 "Grade1" 2 "Grade 2" 3 "Grade 4" 5 "Grade 5" 6 "Grade 6" 7 " Grade 7" 8 "Grade 8" 9 "Grade 9" 10 "Grade 10" 11 "FSC" 12 "Higher Education"
		la val hg hg 
        ren hg mother_educ
	
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
		
		gen sleeping_rooms = hc3
		
		recode sleeping_rooms (99=.)
		
		bysort hh_cluster hh_number: gen x=_N
		
		gen WI_sleeping_rooms = sleeping_rooms/x
		
		
		
		
		* type of floor (no floor or dung floor coded as 0)
		/*
		gen WI_floor = 0 if hc4	==11 | hc4 == 12
		replace WI_floor = 1 if hc4 != 11 | hc4 !=12 | hc4 != 99
		*/
		
		gen WI_floor = 1 if hc4 ==11| hc4 == 12  // no floor
		replace WI_floor = 2 if hc4 == 34 | hc4 == 36 // cement or bricked
		replace WI_floor = 3 if hc4 == 33 // titles or marbles
		replace WI_floor = 4 if hc4 ==35 | hc4 ==32  // carpet 
		replace WI_floor = 5 if hc4 == 32 | hc4 ==31 // Wooden or asphalt strips 

		
		/*
		replace WI_floor = 5 if hc4 ==31 // Wooden or asphalt strips 
		*/
	
  	
	
	
		* type of roof
				/*
		gen WI_roof = 0 if hc5 ==11
		replace WI_roof = 1 if hc5 !=11 | hc5 != 99
         */
		 
		 
		 gen WI_roof = 1 if hc5==11 | hc5==12 | hc5 == 13   // no/raw  (or  kacha) roof
		 replace WI_roof =2 if hc5==21 | hc5 == 22  | hc5 ==23 // semi finsihed roof
		 replace WI_roof =3 if hc5==31 | hc5 == 32  | hc5 ==33 | hc5 ==34 | hc5==35 // finsihed or pakka roof
		 
		 
			
			
		* type of wall
			
			/*
		gen WI_walls = 0 if hc6	==11
		replace WI_walls = 1 if hc6 != 11 | hc6 != 99
		*/
		
		gen WI_walls = 1 if hc6==11 | hc6==12 | hc6==13 // no /raw or kachi wall
		replace WI_walls = 2 if hc6==21 | hc6==22 | hc6==23 | hc6==24 | hc6==25 | hc6==26  // semi finished
		replace WI_walls = 3 if hc6==31 | hc6==32 | hc6==33 | hc6 ==34 | hc6==35 // paki
			
			
		* Fixed telephone line
		 
		 gen WI_telephone = 1 if  hc7a	==1 
		 replace WI_telephone = 0 if hc7a != 1 & hc7a !=9
	
	
			
		* Radio
		 gen WI_radio = 1 if  hc7b	==1 
		 replace WI_radio = 0 if hc7b != 1 & hc7b !=9

			
		* Gas Heater
		
		 gen WI_heater = 1 if  hc7c	==1 
		 replace WI_heater = 0 if hc7c != 1 & hc7c !=9

			
		* Cooking range
		
		gen WI_cookingrange = 1 if  hc7d	==1 
		replace WI_cookingrange = 0 if hc7d != 1 & hc7d !=9

			
		* Sewing Machine
		
		gen WI_sewingmachine = 1 if  hc7e	==1 
		replace WI_sewingmachine = 0 if hc7e != 1 & hc7e !=9

			
		* Iron (Gas/Coal)
		
		
		 gen WI_iron_gc = 1 if  hc7f	==1 
		 replace WI_iron_gc = 0 if hc7f != 1 & hc7f !=9 & hc7f !=.

		
		* Bed
		
		gen WI_bed = 1 if  hc7g	==1 
		replace WI_bed = 0 if hc7g != 1 & hc7g !=9

		
		* Sofa
	
	    gen WI_sofa = 1 if  hc7h ==1 
		replace WI_sofa = 0 if hc7h != 1 & hc7h !=9

		
		* Cupboard
		
		gen WI_cupboard = 1 if  hc7i ==1 
		replace WI_cupboard = 0 if hc7i != 1 & hc7i !=9

		
		* Wall clock
		
		gen WI_clock = 1 if  hc7j	==1 
		replace WI_clock = 0 if hc7j != 1 & hc7j !=9

	
		* 	electricity
		
		
		gen WI_electricity = 0 if hc8  ==3 
		replace WI_electricity = 1 if hc8 != 3 & hc8 != 9
	
				
		* Television	
		
		gen WI_television = 0 if hc9a   == 2
		replace WI_television = 1 if hc9a ==1 & hc9a != 9
		
		
		* Refrigerator
		
		gen WI_refrigerator = 0 if hc9b   == 2
		replace WI_refrigerator = 1 if hc9b ==1 & hc9b != 9
		
			
		* Washing machine / dryer
			
		gen WI_washingmachine = 0 if hc9c == 2
		replace WI_washingmachine = 1 if hc9c ==1 & hc9c != 9
		
		 
		* Air cooler/ Fan
		 
		gen WI_fan = 0 if hc9d == 2
		replace WI_fan = 1 if hc9d ==1 & hc9d != 9
		
			
		* Microwave oven
		 
		gen WI_microwave = 0 if hc9e == 2
		replace WI_microwave = 1 if hc9e ==1 & hc9e != 9
			
		* Iron
		 
		gen WI_iron_electric = 0 if hc9f == 2
		replace WI_iron_electric = 1 if hc9f ==1 & hc9f != 9
			
		* Water filter
		
		gen WI_waterfilter = 0 if hc9g == 2
		replace WI_waterfilter = 1 if hc9g ==1 & hc9g != 9
			
		
		* Dunky punp/turbine
		
		gen WI_turbine = 0 if hc9h == 2
		replace WI_turbine = 1 if hc9h ==1 & hc9h != 9
		

		* Air conditioner
 
		gen WI_ac = 0 if hc9i == 2
		replace WI_ac = 1 if hc9i ==1 & hc9i != 9
		
			
		* Sewing /knitting machine

		gen WI_sewing = 0 if hc9j == 2
		replace WI_sewing = 1 if hc9j ==1 & hc9j != 9
					
			
		* Watch
		
		gen WI_watch = 0 if hc10a == 2
		replace WI_watch = 1 if hc10a ==1 & hc10a != 9
		

		* Bicycle
		
		gen WI_bicycle = 0 if hc10b == 2
		replace WI_bicycle = 1 if hc10b ==1 & hc10b != 9
		

		* Motorcycle / scooter
		
		gen WI_motorcycle = 0 if hc10c == 2
		replace WI_motorcycle = 1 if hc10c ==1 & hc10c != 9
	
	
		* Animal drawn cart
		
		gen WI_cart = 0 if hc10d == 2
		replace WI_cart = 1 if hc10d ==1 & hc10d != 9
		
			
		* Car /van/bus/truck
		
		gen WI_car = 0 if hc10e == 2
		replace WI_car = 1 if hc10e ==1 & hc10e != 9
	
			
		* Boat with motor
		
		gen WI_boat = 0 if hc10f == 2
		replace WI_boat = 1 if hc10f ==1 & hc10f != 9

			
		* Tractor/trolly
	
		gen WI_tractor = 0 if hc10g == 2
		replace WI_tractor = 1 if hc10g ==1 & hc10g != 9
		
		* Auto rickshaw / Chinghi	
		
		gen WI_rickshaw = 0 if hc10h == 2
		replace WI_rickshaw = 1 if hc10h ==1 & hc10h != 9

		
		* Computer
		
		gen WI_computer = 0 if hc11 == 2
		replace WI_computer = 1 if hc11 ==1 & hc11 != 9

		
		* Mobilephone
		
		gen WI_mobile = 0 if hc12 == 2
		replace WI_mobile = 1 if hc12 ==1 & hc12 != 9

			
		* Internet
		
		gen WI_internet = 0 if hc13 == 2
		replace WI_internet = 1 if hc13 ==1 & hc13 != 9

			
		* Land owernship
		
		gen WI_land = 0 if hc15 == 2
		replace WI_land = 1 if hc15 ==1 & hc15 != 9

		
		* Land area (continous)

		gen WI_landarea = hc16		
		recode WI_landarea (99=.) (98=.)	
			
			
			
			
		* bank account
		
		gen WI_bankac = 0 if hc19 == 2
		replace WI_bankac = 1 if hc19 ==1 & hc19 != 9

		
		
		* type of cooking stove (gasstove dummy created)
		
		gen WI_gas_stove = 1 if eu1 == 97 
		replace WI_gas_stove = 2 if  eu1 ==9 | eu1 ==8 | eu1 ==7
		replace WI_gas_stove = 3 if eu1 ==6 | eu1 ==5 
		replace WI_gas_stove = 4 if eu1==4 | eu1 ==3
		replace WI_gas_stove = 5 if eu1 ==2 | eu1 ==1
		

			
		* type of energy used at cooking stove
		* eu4	
		
		gen WI_energy_type = 1 if eu4 == 13 | eu4 == 12 | eu4 == 11 | eu4 == 10
		replace WI_energy_type = 2 if eu4 == 9 | eu4 == 8 
		replace WI_energy_type = 3 if eu4 ==7 | eu4 ==6 |eu4 ==5
		replace WI_energy_type = 4 if eu4 == 4 | eu4 ==3 | eu4 ==2
		replace WI_energy_type = 5 if eu4 ==1
			
		* type of space heating in HH		
		 gen WI_heating = 0 if eu6 == 97
		 replace WI_heating = 1 if eu6 != 97 & eu6 != 99
			
			
			
			
		* type of energy source for heating 	
		
		* eu8	

		 gen WI_heatingsource = 1 if eu8 ==16 | eu8 ==14 | eu8 ==13 | eu8 ==12
		 replace WI_heatingsource =2 if eu8 ==11 | eu8 ==10 | eu8 == 9
		 replace WI_heatingsource =3 if eu8 == 8 |eu8 ==7 | eu8 ==5 | eu8==4
		 replace WI_heatingsource =4 if eu8 == 3 | eu8==2 | eu8 ==1 
		 
		 

			
			
		* Type of lightning in HH	
		
		* eu9
		
		ge WI_lt = 1 if eu9 == 97
		replace WI_lt = 2 if eu9 == 13 | eu9 ==12 | eu9 ==11 | eu9 ==10
		replace WI_lt = 3 if eu9 == 9 | eu9 ==8 
		replace WI_lt = 4 if eu9 == 7 | eu9 == 6 | eu9 ==5 
	    replace WI_lt = 5 if eu9 == 4 | eu9 == 3 | eu9 ==2
		replace WI_lt = 6 if eu9 ==1

		
		
			
		* main source of drinking water	
		* ws1	
		
			
			
				
		* Type of cookstove	
			
		* eu1	
			
			
		* location of water source
		* ws3	
	
	    gen  WI_ws = 1 if ws3 ==3
		replace WI_ws = 2 if ws3 ==2
		replace  WI_ws = 3 if ws3 ==1 
		
	
	
		* Sufficient water
			
		gen WI_water=1 if ws7 == 2
		replace WI_water = 0 if ws7 != 2 & ws7 !=8 & ws7 !=9
			
			
		* Toilet facility
		 
		 gen WI_toilet = 0 if ws11 == 95
		replace WI_toilet = 1 if ws11 != 95 & ws11 != 99
		
			
				
			
		* location of toilet 
			
		gen WI_tl = 1 if ws14==3
		replace WI_tl = 2 if ws14==2
		replace WI_tl = 3 if ws14==1
	
	
	
		* Sharing toilet facility
			
			* ws15	
			
			gen WI_toiletnotshared = 1 if ws15 ==2
			replace WI_toiletnotshared = 0 if ws15 ==1

			
			
		* No. households using this toilet facility
				
			* ws17	
			
			gen WI_tf = 9 if ws17 ==10
			replace WI_tf = 8 if ws17 ==9
			replace WI_tf = 7 if ws17 ==8
			replace WI_tf = 6 if ws17 ==7
			replace WI_tf = 5 if ws17 ==6
			replace WI_tf = 4 if ws17 ==5
			replace WI_tf = 3 if ws17 ==4
			replace WI_tf = 2 if ws17 ==3
			replace WI_tf = 1 if ws17 ==2


			
		* water available at the place handwashing
			
			gen WI_handwash_water = 1 if hw2 ==1
			replace WI_handwash_water =0 if hw2 != 1 & hw2 != 9
			
		* availabilty of soap at the place of handwash

			gen WI_handwash_soap = 1 if hw3 ==1
			replace WI_handwash_soap =0 if hw3 != 1 & hw3 != 9
   

      * ownership
	  
	  
			gen WI_ownership = 0 if hc14 ==6
			replace WI_ownership = 0 if hc14 ==2
			replace WI_ownership = 1 if hc14 ==1
			
	****************************************************************************	
	
	* ASSET VARS:
	
	quiet: estpost sum  WI_ownership WI_lt WI_ws WI_heatingsource WI_energy_type WI_tf  WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_telephone WI_radio WI_heater WI_cookingrange WI_sewingmachine WI_iron_gc WI_bed WI_sofa WI_cupboard WI_clock WI_electricity WI_television WI_refrigerator WI_washingmachine WI_fan WI_microwave WI_iron_electric WI_waterfilter WI_turbine WI_ac WI_sewing WI_watch WI_bicycle WI_motorcycle WI_cart WI_car WI_boat WI_tractor WI_rickshaw WI_computer WI_mobile WI_internet WI_land  WI_bankac WI_gas_stove WI_heating WI_water WI_toilet WI_handwash_water WI_handwash_soap
	esttab, cell("mean(label(Mean)fmt(%9.3f)) sd(label(S.D)) min(label(Min)fmt(%9.0f)) max(label(Max)fmt(%9.0f)) count(label(Obs.)fmt(%9.0f))") label nonumber noobs 

	/*
	WI_sleeping_rooms
	WI_landarea
	*/

		
	//Principal Component Analysis

	
	
		* SES 1: taking Yearly total income variable
	pca   WI_ownership WI_lt  WI_ws WI_heatingsource WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_telephone WI_radio WI_heater WI_cookingrange WI_sewingmachine WI_iron_gc WI_bed WI_sofa WI_cupboard WI_clock WI_electricity WI_television WI_refrigerator WI_washingmachine WI_fan WI_microwave WI_iron_electric WI_waterfilter WI_turbine WI_ac WI_sewing WI_watch WI_bicycle WI_motorcycle WI_cart WI_car WI_boat WI_tractor WI_rickshaw WI_computer WI_mobile WI_internet WI_land  WI_bankac WI_gas_stove WI_heating WI_water WI_toilet WI_handwash_water WI_handwash_soap 
	predict Asset_Level

	alpha  WI_ownership WI_lt WI_ws  WI_heatingsource WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_telephone WI_radio WI_heater WI_cookingrange WI_sewingmachine WI_iron_gc WI_bed WI_sofa WI_cupboard WI_clock WI_electricity WI_television WI_refrigerator WI_washingmachine WI_fan WI_microwave WI_iron_electric WI_waterfilter WI_turbine WI_ac WI_sewing WI_watch WI_bicycle WI_motorcycle WI_cart WI_car WI_boat WI_tractor WI_rickshaw WI_computer WI_mobile WI_internet WI_land  WI_bankac WI_gas_stove WI_heating WI_water WI_toilet WI_handwash_water WI_handwash_soap 

	
	/*
	****************************************************************************
	
	* urban 
		
		* SES 1: taking Yearly total income variable
	pca   WI_lt  WI_ws WI_heatingsource WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_telephone WI_radio WI_heater WI_cookingrange WI_sewingmachine WI_iron_gc WI_bed WI_sofa WI_cupboard WI_clock WI_electricity WI_television WI_refrigerator WI_washingmachine WI_fan WI_microwave WI_iron_electric WI_waterfilter WI_turbine WI_ac WI_sewing WI_watch WI_bicycle WI_motorcycle WI_cart WI_car WI_boat WI_tractor WI_rickshaw WI_computer WI_mobile WI_internet WI_land  WI_bankac WI_gas_stove WI_heating WI_water WI_toilet WI_handwash_water WI_handwash_soap if hh6 ==1
	predict Asset_Level_urban

	alpha  WI_lt WI_ws  WI_heatingsource WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_telephone WI_radio WI_heater WI_cookingrange WI_sewingmachine WI_iron_gc WI_bed WI_sofa WI_cupboard WI_clock WI_electricity WI_television WI_refrigerator WI_washingmachine WI_fan WI_microwave WI_iron_electric WI_waterfilter WI_turbine WI_ac WI_sewing WI_watch WI_bicycle WI_motorcycle WI_cart WI_car WI_boat WI_tractor WI_rickshaw WI_computer WI_mobile WI_internet WI_land  WI_bankac WI_gas_stove WI_heating WI_water WI_toilet WI_handwash_water WI_handwash_soap if hh6 ==1

	* rural
	
	
		* SES 1: taking Yearly total income variable
	pca   WI_lt  WI_ws WI_heatingsource WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_telephone WI_radio WI_heater WI_cookingrange WI_sewingmachine WI_iron_gc WI_bed WI_sofa WI_cupboard WI_clock WI_electricity WI_television WI_refrigerator WI_washingmachine WI_fan WI_microwave WI_iron_electric WI_waterfilter WI_turbine WI_ac WI_sewing WI_watch WI_bicycle WI_motorcycle WI_cart WI_car WI_boat WI_tractor WI_rickshaw WI_computer WI_mobile WI_internet WI_land  WI_bankac WI_gas_stove WI_heating WI_water WI_toilet WI_handwash_water WI_handwash_soap if hh6 ==2
	predict Asset_Level_rural

	alpha  WI_lt WI_ws  WI_heatingsource WI_sleeping_rooms  WI_floor WI_roof WI_walls WI_telephone WI_radio WI_heater WI_cookingrange WI_sewingmachine WI_iron_gc WI_bed WI_sofa WI_cupboard WI_clock WI_electricity WI_television WI_refrigerator WI_washingmachine WI_fan WI_microwave WI_iron_electric WI_waterfilter WI_turbine WI_ac WI_sewing WI_watch WI_bicycle WI_motorcycle WI_cart WI_car WI_boat WI_tractor WI_rickshaw WI_computer WI_mobile WI_internet WI_land  WI_bankac WI_gas_stove WI_heating WI_water WI_toilet WI_handwash_water WI_handwash_soap if hh6 ==2
	

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

	
	table windex5 , c(mean in_school)
	table windex5 if age>=6 & age<=10 , c(mean in_school)
	
		
	
	table asset_quintiles , c(mean in_school)
	table asset_quintiles if age>=6 & age<=10 , c(mean in_school)
	
	
	
	table hh_educ_level , c(mean in_school)
	table hh_educ_level if age>=6 & age<=10 , c(mean in_school)
		
		
		
		tempfile mics_2017
	    save `mics_2017', replace
		
	
********************************************************************************
		save "$mics_clean\MICS_HH_clean_2017.dta", replace		
********************************************************************************	


ex
