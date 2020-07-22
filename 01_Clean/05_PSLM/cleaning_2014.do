* DATASET: PSLM
* Author: Ahmed Raza
* Date: 3rd June, 2019 
* Purpose: Cleaning PSLM data : Strategy: Combine HH data with Education data on unique identifiers "hhcode" and "idc" and merge with other files using "hhcode".


		* Dropbox Globals
		
	    include init.do
	  
	    ************************************************************************
	    *2012
	    ************************************************************************

**** Step 1: Get Raw Data Files & check for unique identifiers: 

		use "$pslm_raw/2014/sec_a.dta"
		
		gen prov_AR = "KP" if  province ==1
		replace prov_AR = "PUNJAB" if province ==2
		replace prov_AR = "SINDH" if province ==3
		replace prov_AR = "BALOCHISTAN" if province ==4
		

**** Step 2: Check administrative data vars and create a clean dist_key:

		decode district, gen(dist_nm)
		clean_lname dist_nm
		ta dist_nm
		
		gen dist = dist_nm
		
	
		gen prov = 1 if prov_AR =="PUNJAB"    // punjab
		replace prov =2 if prov_AR =="SINDH" // sindh
		replace prov = 3 if prov_AR =="BALOCHISTAN" // Balochistna 
		replace prov = 4 if prov_AR == "KP" // KP
		

		* Dist_key for punjab:
		
		gen dist_key= 1 if prov ==1
		replace dist_key = 1 if dist_nm == "ATTOCK"	& prov ==1
		replace dist_key = 2 if dist_nm == "BAHAWALNAGAR" & prov ==1
		replace dist_key = 3 if dist_nm == "BAHAWALPUR" & prov ==1
		replace dist_key = 4 if dist_nm == "BHAKKAR" & prov ==1
		replace dist_key = 5 if dist_nm == "CHAKWAL" & prov ==1
		replace dist_key = 6 if dist_nm == "D. G. KHAN" & prov ==1
		replace dist_key = 7 if dist_nm == "FAISALABAD" & prov ==1
		replace dist_key = 8 if dist_nm == "GUJRANWALA" & prov ==1
		replace dist_key = 9 if dist_nm == "GUJRAT" & prov ==1
		replace dist_key = 10 if dist_nm == "HAFIZABAD" & prov ==1
		replace dist_key = 11 if dist_nm == "JHELUM" & prov ==1
		replace dist_key = 12 if dist_nm == "JHANG" & prov ==1
		replace dist_key = 13 if dist_nm == "KASUR" & prov ==1
		replace dist_key = 14 if dist_nm == "KHANEWAL" & prov ==1
		replace dist_key = 15 if dist_nm == "KHUSHAB" & prov ==1		 
		replace dist_key = 16 if dist_nm == "LAHORE" & prov ==1
		replace dist_key = 17 if dist_nm == "LAYYAH" & prov ==1
		replace dist_key = 18 if dist_nm == "LODHRAN" & prov ==1
		replace dist_key = 19 if dist_nm == "MANDI BAHAUDDIN" & prov ==1
		replace dist_key = 20 if dist_nm == "MIANWALI" & prov ==1
		replace dist_key = 21 if dist_nm == "MULTAN" & prov ==1
		replace dist_key = 22 if dist_nm == "MUZAFFARGARH" & prov ==1
		replace dist_key = 23 if dist_nm == "NAROWAL" & prov ==1
		replace dist_key = 24 if dist_nm == "OKARA" & prov ==1
		replace dist_key = 25 if dist_nm == "PAKPATTAN" & prov ==1
		replace dist_key = 26 if dist_nm == "RAHIM YAR KHAN" & prov ==1
		replace dist_key = 27 if dist_nm == "RAJANPUR" & prov ==1
		replace dist_key = 28 if dist_nm == "RAWALPINDI" & prov ==1
		replace dist_key = 29 if dist_nm == "SAHIWAL" & prov ==1
		replace dist_key = 30 if dist_nm == "SARGODHA" & prov ==1
		replace dist_key = 31 if dist_nm == "SHEIKHUPURA" & prov ==1
		replace dist_key = 32 if dist_nm == "SIALKOT" & prov ==1
		replace dist_key = 33 if dist_nm == "T.T. SINGH" & prov ==1
		replace dist_key = 34 if dist_nm == "VEHARI" & prov ==1
		replace dist_key = 35 if dist_nm == "NANKANA SAHIB" & prov ==1
        replace dist_key = 36 if dist_nm == "CHINIOT"  & prov ==1
	
		ta dist_key
		ta dist_nm
	

	
	    replace dist_key = 201 if dist_nm == "ISLAMABAD" 
	   
		ta dist_nm if dist_key ==. & prov==1

	
		* Dist_key for KP:
	

		*KP:
		
		replace dist_nm = "PESHAWAR" if dist_nm == "PESHAWAR URBAN" & prov ==4 

  
		replace dist_key = 37 if dist_nm == "ABBOTTABAD" & prov ==4 
 		replace dist_key = 38 if dist_nm == "BANNU" & prov ==4
		replace dist_key = 39 if dist_nm == "BATAGRAM" & prov ==4
		replace dist_key = 40 if dist_nm == "BUNER" & prov ==4
		replace dist_key = 41 if dist_nm == "CHARSADDA" & prov ==4
		replace dist_key = 42 if dist_nm == "CHITRAL" & prov ==4
		replace dist_key = 43 if dist_nm == "D. I. KHAN" & prov ==4
		replace dist_key = 44 if dist_nm == "HANGU" & prov ==4
		replace dist_key = 45 if dist_nm == "HARIPUR" & prov ==4
		replace dist_key = 46 if dist_nm == "KARAK" & prov ==4
		replace dist_key = 47 if dist_nm == "KOHAT" & prov ==4
		replace dist_key = 48 if dist_nm == "KOHISTAN" & prov ==4
		replace dist_key = 49 if dist_nm == "LAKKI MARWAT" & prov ==4
		replace dist_key = 50 if dist_nm == "LOWER DIR" & prov ==4
		replace dist_key = 51 if dist_nm == "MALAKAND" & prov ==4
		replace dist_key = 52 if dist_nm == "MANSEHRA" & prov ==4
		replace dist_key = 53 if dist_nm == "MARDAN" & prov ==4
		replace dist_key = 54 if dist_nm == "NOWSHERA" & prov ==4
		 
		replace dist_key = 55 if dist_nm == "PESHAWAR" & prov ==4
		replace dist_key = 56 if dist_nm == "SHANGLA" & prov ==4
		replace dist_key = 57 if dist_nm == "SWABI" & prov ==4
		replace dist_key = 58 if dist_nm == "SWAT" & prov ==4
		replace dist_key = 59 if dist_nm == "TANK" & prov ==4
		replace dist_key = 60 if dist_nm == "TOR GHAR" & prov ==4
		replace dist_key = 61 if dist_nm == "UPPER DIR" & prov ==4
		 
		ta dist_key if prov ==4
		ta dist_nm if prov ==4
		ta dist_nm if dist_key ==. & prov==4

		* Dist_key for SINDH:
	
		* Sindh:
		 	  
	    replace dist_nm = "KARACHI" if dist_nm == "KARACHI MALIR RURAL"
	    replace dist_nm = "KARACHI" if dist_nm == "KARACHI WEST RURAL"
	    replace dist_nm = "KARACHI" if dist_nm == "KARACHI CENTRAL"
	    replace dist_nm = "KARACHI" if dist_nm == "KARACHI EAST"
	    replace dist_nm = "KARACHI" if dist_nm == "KARACHI MALIR"
		  
		replace dist_nm = "KARACHI" if dist_nm == "KARACHI SOUTH"
		replace dist_nm = "KARACHI" if dist_nm == "KARACHI WEST"
	    replace dist_nm = "KARACHI" if dist_nm == "KARACHI MALIR"
		replace dist_nm = "KARACHI" if dist_nm == "KARACHI URBAN"
 
		replace dist_nm = "HYDERABAD" if dist_nm == "HYDERABAD URBAN"
		replace dist_nm = "LARKANA" if dist_nm == "LARKANA URBAN"
		replace dist_nm = "SUKKUR" if dist_nm == "SUKKUR URBAN"
		  
		replace dist_key = 62 if dist_nm == "BADIN" & prov ==2 
 		replace dist_key = 63 if dist_nm == "DADU" & prov ==2
		replace dist_key = 64 if dist_nm == "GHOTKI" & prov ==2
		replace dist_key = 65 if dist_nm == "HYDERABAD" & prov ==2
		replace dist_key = 66 if dist_nm == "JACOBABAD" & prov ==2
		replace dist_key = 67 if dist_nm == "JAMSHORO" & prov ==2
		 
		replace dist_key = 68 if dist_nm == "KARACHI" & prov ==2
		replace dist_key = 69 if dist_nm == "KASHMORE" & prov ==2
		replace dist_key = 70 if dist_nm == "KHAIRPUR" & prov ==2
		replace dist_key = 71 if dist_nm == "LARKANA" & prov ==2
		replace dist_key = 72  if dist_nm == "MATIARI" & prov ==2
		 
		 
		replace dist_key = 73 if dist_nm == "MIRPUR KHAS" & prov ==2
		replace dist_key = 74 if dist_nm == "NAUSHAHRO FEROZE" & prov ==2
		replace dist_key = 75 if dist_nm == "SANGHAR" & prov ==2
		replace dist_key = 76 if dist_nm == "SHAHDADKOT" & prov ==2
		replace dist_key = 77 if dist_nm == "SHAHEED BENAZIR ABAD" & prov ==2
		replace dist_key = 78 if dist_nm == "SHIKARPUR" & prov ==2
		 
		replace dist_key = 79 if dist_nm == "SUJAWAL" & prov ==2
		replace dist_key = 80 if dist_nm == "SUKKUR" & prov ==2 
		replace dist_key = 81 if dist_nm == "TANDO ALLAH YAR" & prov ==2
		replace dist_key = 82 if dist_nm == "TANDO MOHAMMAD KHAN" & prov ==2
		replace dist_key = 83 if dist_nm == "THARPARKAR" & prov ==2
		replace dist_key = 84 if dist_nm == "TANK" & prov ==2
		replace dist_key = 85 if dist_nm == "THATTA" & prov ==2
		replace dist_key = 86 if dist_nm == "UMER KOT" & prov ==2
		 
		replace dist_key = 87 if dist_nm == "MITHI" & prov ==2

		ta dist_key if prov ==2
		ta dist_nm if prov ==2
		ta dist_nm if dist_key ==. & prov==2	
	
	
		* Dist_key for BALOCHISTAN:
			 
		   
	    replace dist_nm = "MARDAN" if dist_nm == "MARDAN URBAN"
	    replace dist_nm = "PESHAWAR" if dist_nm == "PESHAWAR URBAN"
	    replace dist_nm = "SWAT" if dist_nm == "SWAT URBAN"

	    replace dist_nm = "KHUZDAR" if dist_nm == "KHUZDAR URBAN"
	    replace dist_nm = "QUETTA" if dist_nm == "QUETTA URBAN"

		replace dist_key = 88 if dist_nm == "AWARAN" & prov ==3
 		replace dist_key = 89 if dist_nm == "BARKHAN" & prov ==3
		replace dist_key = 90 if dist_nm == "BOLAN/ KACHHI" & prov ==3
		replace dist_key = 91 if dist_nm == "CHAGAI" & prov ==3
		replace dist_key = 92 if dist_nm == "DERA BUGTI" & prov ==3
	    replace dist_key = 93 if dist_nm == "GWADAR" & prov ==3
		 
		replace dist_key = 94 if dist_nm == "HARNAI" & prov ==3
		replace dist_key = 95 if dist_nm == "JAFFARABAD" & prov ==3
		replace dist_key = 96 if dist_nm == "JHAL MAGSI" & prov ==3
		replace dist_key = 97 if dist_nm == "KALAT" & prov ==3
		replace dist_key = 98 if dist_nm == "KHARAN" & prov ==3
		replace dist_key = 99  if dist_nm == "KHUZDAR" & prov ==3
		 
		 
		replace dist_key = 100 if dist_nm == "KILLA ABDULLAH" & prov ==3
		replace dist_key = 101 if dist_nm == "KILLA SAIFULLAH" & prov ==3
		replace dist_key = 102 if dist_nm == "KOHLU" & prov ==3
		replace dist_key = 103 if dist_nm == "LASBELA" & prov ==3
		replace dist_key = 104 if dist_nm == "LORALAI" & prov ==3
		replace dist_key = 105 if dist_nm == "MASTUNG" & prov ==3
		 
		replace dist_key = 106 if dist_nm == "MUSAKHEL" & prov ==3
		replace dist_key = 107 if dist_nm == "NASIRABAD/ TAMBOO" & prov ==3
		replace dist_key = 108 if dist_nm == "NUSHKI" & prov ==3
		replace dist_key = 109 if dist_nm == "PISHIN" & prov ==3
		replace dist_key = 110 if dist_nm == "QUETTA" & prov ==3
		replace dist_key = 111 if dist_nm == "SHEERANI" & prov ==3
		replace dist_key = 112 if dist_nm == "SIBBI" & prov ==3
		 
		replace dist_key = 113 if dist_nm == "WASHUK" & prov ==3

		 
		replace dist_key = 114 if dist_nm == "ZHOB" & prov ==3
		replace dist_key = 115 if dist_nm == "ZIARAT" & prov ==3
		 
		 
		 	 
		replace dist_key = 116 if dist_nm == "DUKI" & prov ==3
		replace dist_key = 117 if dist_nm == "LEHRI" & prov ==3	 
		replace dist_key = 118 if dist_nm == "KECH (TURBAT)" & prov ==3
		replace dist_key = 119 if dist_nm == "PANJGUR" & prov ==3	 
		
	    replace dist_key = 120 if dist_nm == "SOHBATPUR" & prov ==3
		replace dist_key = 121 if dist_nm == "SURAB" & prov ==3
		  
		ta dist_key if prov ==3
		ta dist_nm if prov ==3
		ta dist_nm if dist_key ==. & prov==3
		
		ta dist_nm if dist_key ==. & prov==4
		ta dist_nm if dist_key ==. & prov==3
		ta dist_nm if dist_key ==. & prov==2

		ta dist_nm if dist_key ==. & prov==1
	
		************************************************************************

**** Step 3: Merge Education data with administrative data & clean/harmonize variables:
		
		merge 1:1 hhcode using "$pslm_raw/2014/weights_by_hhcode.dta"
		
		keep hhcode psu province region district sec dist_nm dist_key weight prov_AR
		
		* HH code
		
		merge 1:m hhcode using "$pslm_raw/2014/sec_b.dta"
		drop _merge 
		tostring psu, replace
		
		* Education
		
		merge 1:1 hhcode idc using "$pslm_raw/2014/sec_c.dta"
		ren _merge _merge1
		
		ren sbq02 relation_hh_head
		ren sbq04 gender
		ren scq01 read
		ren scq02 math
		
		
		* Construction of "in_school" vars:
		
		gen in_school_ever = 1 if scq03 ==1
		replace in_school_ever = 0 if scq03 ==2
		
		gen in_school = 1 if scq05 == 1
		replace in_school=0 if scq05 == 2
		
		* adjusting in_school var to recode dropouts as 0
		
		replace in_school =0 if in_school_ever ==0 & in_school ==.
		
         * Highest Grade and Current Grade:		
		 
		gen highest_grade = scq04
		la val highest_grade scq04
		gen current_grade = scq06
		la val current_grade scq06
		
		
		fre in_school_ever
		fre highest_grade  

		*Current Grade adjustment
		
		replace current_grade =. if in_school == 0
		
		* Highest Grade adjustment
		* replace highest_grade = 0 if in_school_ever ==0
	
		
		
		ta in_school_ever
		ta highest_grade
		
		ta in_school
		ta current_grade
		
	
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		ren scq07 school_type
		
		
		************************************************************************
		
**** Step 4: Merge other data sections: 
		
		destring psu, replace
		
		* Get income vars:
		merge 1:1 hhcode idc using"$pslm_raw/2014\sec_e.dta"
		drop _merge
	
		* Get Asset Vars:
		merge m:1 hhcode using"$pslm_raw/2014\sec_f2.dta"
		drop _merge
		
		* Get Other asset Vars:
		merge m:1 hhcode using"$pslm_raw/2014\sec_g.dta"
		drop _merge		
 		
		* Agricultural land (Personal):
        preserve
		
		use "$pslm_raw/2014\sec_f1.dta", clear
	
		keep if itc==1
		keep hhcode sf1c01 sf1c02
		
		tempfile save f1
		save `f1', replace
		
		restore
		
		merge m:1 hhcode using `f1'
		drop _merge
	     
	    ************************************************************************

**** Step 5: Create relevant vars for the panel:
	  
	    * HH EDUCATION STATUS: 
	   	   
	    *  HH Head:  Highest Education:

	    preserve
		keep  hhcode idc relation_hh_head highest_grade in_school_ever
		
		* hh head's education:
		
		keep if relation_hh_head ==1
		
		keep hhcode  relation_hh_head highest_grade in_school_ever
		
		* recode others as missing 
		replace highest_grade =. if highest_grade ==20
		drop if highest_grade ==.
		
	    ren highest_grade highest_grade_head

		isid hhcode

			
		tempfile save head_educ
		save `head_educ', replace
	
		restore
		
	    ************************************************************************
		
		* Parent's : Highest Education:
		
	    preserve

		keep  hhcode idc relation_hh_head highest_grade in_school_ever
		
	    * parent's education:
		
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
		
		br highest_grade_head highest_grade_parent hh_es
		
		isid hhcode

		
	    tempfile save educ
		save `educ', replace
	
	    restore
		
	
		
	    ************************************************************************
		
		merge m:1 hhcode using `educ'
		
		
		la val hh_es scq04
		
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
		
		* monthly income:
		 gen yr_seq08 = seq08 * seq09
		 
		* Total yearly income (including remittances (domestic & foreign), rent & all other sources of income)
		
		egen year_income = rsum (yr_seq08 seq10 seq15 seq17 seq19 seq21 seq23 seq24 seq25 seq26), missing
		
		
		* Total
		egen hh_income = total(year_income), by(hhcode)
		la var hh_income "Household's Yearly Income"
		
		clonevar tot_income = year_income
	   
	    ************************************************************************
		* Adjusting missing values after total:
		
		gen x=1 if hh_income ==0 & year_income ==.
		gen hh_income2 = hh_income 
		replace hh_income2 =. if x==1
		
		drop x
		
	    ************************************************************************
	  
		* Creating Income quintiles from the HH income:
		
		
		cap drop income_quintiles
		xtile income_quintiles = hh_income2 , n(5)
		
		
		la var income_quintiles "Income Quintiles from HH's Yearly Income (missing adjusted)"
		la def quintiles 1 "Bottom 20" 2 "20-40" 3 "40-60" 4 "60-80" 5 "Upper 20", modify
		la val income_quintiles  quintiles 
		
		
		fre income_quintiles

		
		************************************************************************
		
		
		* Other assets:
		
		
		* Occupancy status :
		   
		gen WI_occupancy = 1 if sgq01 ==5 // no rent 
		replace WI_occupancy =2 if sgq01 ==3 | sgq01 ==4  // rent
		replace WI_occupancy = 3 if sgq01 ==2 | sgq01 ==1  // owner
		  
		  
		 
			 
		* Rooms:
		 
		bysort hhcode : gen members =_n
		
		gen  WI_rooms = members/ sgq02
		 
		* rooms: sgq02 
		 
	 
	    * Roof material:
		
	    gen WI_roof_cement = 1 if sgq03 ==3 | sgq03 ==1  // pakka
	    replace WI_roof_cement = 0 if sgq03 ==5 | sgq03 ==4 |sgq03 ==2 // kacha or other
	 
	 
	    * walls material:
	    gen WI_brickedwalls = 1 if sgq04 ==1 
	    replace  WI_brickedwalls = 0 if sgq04 !=1 & sgq04 !=.
	 
	 
	    * Toilet Facility:
	  
	    gen WI_toilet = 0 if sgq06 ==1
	    replace WI_toilet = 1 if sgq06 != 1 & sgq06 !=.
	 
	 
	    * Fuel for cooking:

	    gen WI_energytype_cook = 1 if sgq07 ==4 | sgq07 ==6  // crop residue, dung
	    replace WI_energytype_cook =2 if sgq07 ==1 | sgq07 ==7 | sgq07 ==3 // wood , charcoal, oil
	    replace WI_energytype_cook = 3 if sgq07 ==2 | sgq07 ==5 // gas, electricity 
	 
	    * Fuel for lighting:
	
	    gen WI_energytype_light = 1 if sgq08 ==5 | sgq08 ==4 // fire wood candle
	    replace WI_energytype_light =2 if sgq08 ==3 | sgq08 ==2 // oil, gas
	    replace WI_energytype_light = 3 if sgq08 ==1 // electricity
	
	
	    * telephone
	
	    gen WI_phone = 0 if sgq09 ==1
	    replace WI_phone =1 if sgq09 !=1 & sgq09 !=.
	
	
	    * Cleaning HH assets:
	
	    * agriculture land:
	  
	    gen WI_agriculture_land = 1 if sf1c01 ==1
	    replace WI_agriculture_land = 0 if sf1c01 ==2

	 
	    * Var cleaning:
	 
	    recode sf2q11a sf2q11b sf2q11c sf2q11d sf2q11e sf2q11f sf2q11g sf2q11h sf2q11i ///
	    sf2q11j sf2q11k sf2q11l sf2q11m sf2q11n sf2q11o sf2q11p sf2q11q sf2q11r sf2q11s ///
	    sf2q11t sf2q11u sf2q11v sf2q11w sf2q11x (2=0)
	 
	    * iron
	    gen WI_iron = sf2q11a

	    * Fan
	    gen WI_fan = sf2q11b 

	    * Sewing machine:
	    gen WI_sewing_machine = sf2q11c 
	
	    * radio
	    gen WI_radio = sf2q11d 

	    * table
	    gen WI_tablechair = sf2q11e 

	    * clock
	    gen WI_clock = sf2q11f 

        * Tv
	    gen WI_tv = sf2q11g 

        * vcr
	    gen WI_vcr = sf2q11h 

        * refrigerator
	    gen WI_refrigerator = sf2q11i 

        * Air cooler
	    gen WI_air_cooler = sf2q11j 

        * AC
	    gen WI_ac =	sf2q11k 

        * computer
	    gen WI_computer = sf2q11l 
		
        * bicycle
	    gen WI_bicycle = sf2q11m

        * motorcycle
	    gen WI_motorcycle = sf2q11n

        * Car	
	    gen WI_car = sf2q11o

        * Tractor
        gen WI_tractor = sf2q11p 

        * Mobile
	    gen WI_mobile = sf2q11q

        * cooking range
	    gen WI_cooking_range = sf2q11r 

        * Stove
	    gen WI_stove = sf2q11s 

	    * washing machine
	    gen WI_washingmachine = sf2q11t

	    * heater
	    gen WI_heater = sf2q11u 

	    * rickshaw
	    gen WI_rickshaw = sf2q11v 
		 
	    * Microwave
	    gen WI_microwave =	sf2q11w 
 
	    * UPS	
	    gen WI_ups	= sf2q11x		

	    //Final Income Variable for PCA analysis to create a Wealth Index
	   
	    quiet: estpost sum   WI_energytype_light WI_toilet WI_occupancy WI_energytype_light WI_phone WI_ac WI_agriculture_land ///
	    WI_air_cooler WI_bicycle WI_car WI_clock WI_computer WI_cooking_range WI_fan WI_heater WI_iron WI_microwave ///
	    WI_mobile WI_motorcycle WI_radio WI_refrigerator WI_rickshaw WI_sewing_machine WI_stove WI_tablechair WI_tractor ///
	    WI_tv WI_ups WI_vcr WI_washingmachine
	   
	    #delimit ;
		
	    esttab, cell("mean(label(Mean)fmt(%9.3f)) sd(label(S.D)) min(label(Min)fmt(%9.0f)) 
	    max(label(Max)fmt(%9.0f)) count(label(Obs.)fmt(%9.0f))") label nonumber noobs ; 
	
	    #delimit cr
	
		
	   // Principal Component Analysis

	   * SES 1: taking Yearly total income variable
	   pca WI_energytype_light WI_toilet WI_occupancy WI_energytype_light WI_phone WI_ac  WI_agriculture_land WI_air_cooler WI_bicycle WI_car WI_clock  ///
	   WI_computer WI_cooking_range WI_fan WI_heater WI_iron WI_microwave WI_mobile WI_motorcycle WI_radio WI_refrigerator WI_rickshaw WI_sewing_machine ///
	   WI_stove WI_tablechair WI_tractor WI_tv WI_ups WI_vcr WI_washingmachine
	  
	   predict Asset_Level

	   alpha WI_roof_cement WI_energytype_light WI_toilet WI_occupancy WI_energytype_light WI_phone WI_ac WI_agriculture_land ///
	   WI_air_cooler WI_bicycle WI_car WI_clock WI_computer WI_cooking_range WI_fan WI_heater WI_iron WI_microwave WI_mobile /// 
	   WI_motorcycle WI_radio WI_refrigerator WI_rickshaw WI_sewing_machine WI_stove WI_tablechair WI_tractor WI_tv WI_ups WI_vcr WI_washingmachine
	

	   cap drop asset_quintiles
	   xtile asset_quintiles = Asset_Level , n(5)
	
	   la var asset_quintiles "Asset Quintiles from Wealth Index"
	   la val asset_quintiles quintiles
	   
	

	****************************************************************************
		
	
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
	
	   gen year = 2014
		
		* Add a harmonized region variable for rural/urban
       
	   fre region
	   
	   ren region region_old
	   gen region = 1 if region_old ==2
	   replace region = 2 if region_old ==1
	   
		
**** Step 6: Save clean cross-sectional dataset:
		
	   save "$pslm_clean/PSLM_clean_2014.dta", replace 

	
	
	
