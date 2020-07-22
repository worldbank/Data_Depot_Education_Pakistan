
* DATASET: PSLM
* Author: Ahmed Raza
* Date: 3rd June, 2019 
* Purpose: Cleaning PSLM data : PSLM panel

clear all
set more off

		* Dropbox Globals
		
	    include init.do
	
		
	
		************************************************************************
     	use "$pslm_clean/PSLM_clean_2004.dta", clear
	
	
	
	* seq01 seq02 seq03 seq04 seq05 seq06 seq07 seq08 seq09 seq10 seq11 seq12 seq13 seq14 seq15 seq16
	
	
	
		ren weights weight
		
		keep   prov_AR year psu  hhcode dist_nm dist_key idc province read  math hh_educ_level highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age  Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income  weight region tot_income
		
		
		order  prov_AR year psu  hhcode  dist_nm dist_key idc year province read hh_educ_level math highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income weight region tot_income

		decode school_type, gen (st)
		decode province, gen(prov)
		
		
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
        tostring psu, replace

		tempfile pslm_2004
		save `pslm_2004', replace
		
		************************************************************************
		
		use "$pslm_clean/PSLM_clean_2006.dta", clear

		*seq01 seq02 seq03 seq04 seq05 seq06 seq07 seq08 seq09 seq10 seq11 seq12 seq13 seq14 seq15 seq16
		
		keep  prov_AR year psu  hhcode dist_nm dist_key idc province read  math hh_educ_level highest_grade  /// 
		current_grade in_school school_type in_school_ever relation_hh_head gender age  Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income  weight region tot_income
		
		
		order  prov_AR year psu  hhcode  dist_nm dist_key idc year province read hh_educ_level math highest_grade /// 
		current_grade in_school school_type in_school_ever relation_hh_head gender age Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income weight region tot_income

		decode school_type, gen (st)
		decode province, gen(prov)
		
		
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		
			
        tostring psu, replace
		
		tempfile pslm_2006
		save `pslm_2006', replace

		
		
		************************************************************************
		
		use "$pslm_clean/PSLM_clean_2008.dta", clear
		
		* seq01 seq02 seq03 seq04 seq05 seq06 seq07 seq08 seq09 seq10 seq11 seq12 seq13 seq14 seq15 seq16
		
		
		keep   prov_AR year psu  hhcode dist_nm dist_key idc province read  math hh_educ_level highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age  Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income  weight region tot_income
		
		
		order  prov_AR year psu  hhcode  dist_nm dist_key idc year province read hh_educ_level math highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age Asset_Level asset_quintiles /// 
		income_quintiles hh_income2 hh_income weight region tot_income

		decode school_type, gen (st)
		decode province, gen(prov)
		
				
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
			
        tostring psu, replace

		tempfile pslm_2008
		save `pslm_2008', replace
		
		
		************************************************************************

		use "$pslm_clean/PSLM_clean_2010.dta", clear
		
		
		* seq01 seq02 seq03 seq04 seq05 seq06 seq07 seq08 seq09 seq10 seq11 seq12 seq13 seq14 seq15 seq16 seq17 seq18 seq19 seq20 seq21 seq22 seq23 seq24 seq25 seq26
		
		
		keep   prov_AR year psu  hhcode dist_nm dist_key idc province read  math hh_educ_level highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age  Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income  weight  region tot_income
		
		
		order  prov_AR year psu  hhcode  dist_nm dist_key idc year province read hh_educ_level math highest_grade /// 
		current_grade in_school school_type in_school_ever relation_hh_head gender age Asset_Level asset_quintiles /// 
		income_quintiles hh_income2 hh_income weight region tot_income

		decode school_type, gen (st)
		decode province, gen(prov)
	
	
			
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		
			
        tostring psu, replace
		
		tempfile pslm_2010
		save `pslm_2010', replace
		
	
		************************************************************************
		use "$pslm_clean/PSLM_clean_2012.dta", clear
		
		* seq01 seq02 seq03 seq04 seq05 seq06 seq07 seq08 seq09 seq10 seq11 seq12 seq13 seq14 seq15 seq16 seq17 seq18 seq19 seq20 seq21 seq22 seq23 seq24 seq25 seq26
		
		
		keep   prov_AR year psu  hhcode dist_nm dist_key idc province read  math hh_educ_level highest_grade /// 
		current_grade in_school school_type in_school_ever relation_hh_head gender age  Asset_Level asset_quintiles /// 
		income_quintiles hh_income2 hh_income  weight region tot_income
		
		
		order  prov_AR year psu  hhcode  dist_nm dist_key idc year province read hh_educ_level math highest_grade /// 
		current_grade in_school school_type in_school_ever relation_hh_head gender age Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income weight region tot_income

		decode school_type, gen (st)
		decode province, gen(prov)
		
		
				
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
			
        tostring psu, replace
		
		
		
		tempfile pslm_2012
		save `pslm_2012', replace
		
		************************************************************************
		use "$pslm_clean/PSLM_clean_2014.dta", clear
		
	
	
	exit 
	
	
	
		keep   prov_AR year psu  hhcode dist_nm dist_key idc province read  math hh_educ_level highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age  Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income  weight region tot_income
		
		
		order  prov_AR year psu  hhcode  dist_nm dist_key idc year province read hh_educ_level math highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age Asset_Level asset_quintiles ///
		income_quintiles hh_income2 hh_income weight region tot_income

		decode school_type, gen (st)
		decode province, gen(prov)
		
		
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		
		
        tostring psu, replace
		
		
		tempfile pslm_2014
		save `pslm_2014', replace
		
		
		************************************************************************
		
		use "$pslm_clean/PSLM_clean_2018.dta", clear
		
	
		keep   prov_AR year psu  hhcode idc province read  math hh_educ_level highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age ///
		Asset_Level asset_quintiles income_quintiles  hh_income  weight region tot_income
		
		
		order   prov_AR year psu  hhcode idc province read  math hh_educ_level highest_grade ///
		current_grade in_school school_type in_school_ever relation_hh_head gender age ///
		Asset_Level asset_quintiles income_quintiles  hh_income  weight region tot_income
		
			


		decode school_type, gen (st)
		decode province, gen(prov)
		
		
		
		
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
			
			
		*	ren highest_grade highest_grade_18
		*	ren current_grade current_grade_18
			
        tostring psu, replace
		
		la drop _all
	
		fre read
		fre math
	
	
	   * hh_income:
	   
	   gen hh_icnome2 = hh_income 
	   
	
	   tempfile pslm_2018
	   save `pslm_2018', replace
	

********************************************************************************
		
		
		
		* APPEND:
		
		
		 use `pslm_2014', clear
		 
		 append using `pslm_2012'		 
		 
		 append using `pslm_2010'		 
		 
		 append using `pslm_2008'		 
		 
		 append using `pslm_2006'		 
		 
		 append using `pslm_2004'		 
		 
		 append using `pslm_2018'
		 
		 
		 la def educ1 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" ///
		 11 "polytechnic diploma/other diplomas" 12 "fa/fsc/i-com" 13 "ba/bsc/bed/bcs" 14 "ma/msc/med/mcs" 15 "degree in engineering" 16 "degree in medicine" ///
		 17 "degree in agriculture" 18 "degree in law" 19 "mphil/phd" 20 "others" 21 "Computer Science"
		 
		 la val highest_grade educ1
		 la val current_grade educ1
		 
		 
		 clean_lname prov
		 clean_lname st
		 
		 drop province
		 
		 gen province = "Punjab" if prov == "PUNJAB"
		 replace province = "Sindh" if prov == "SINDH"
		 replace province = "KPK" if prov == "KHYBER PAKHTUNKHWA" | prov== "KP" | prov == "KPK" | prov == "NWFP"
		 replace province = "Balochistan" if prov == "BALOCHISTAN"

		 la var province "Province"
		 
		 drop school_type
		 
		 
		 
		 gen school_category  = "Government" if st == "GOVERNMENT" | st == "GOV" | st == "GOVERNMENT INSTITUTE"
		 replace school_category = "Private" if st == "PRIVATE EXAM" | st == "PRIVATE SCHOOL" | st == "PRIVATE INSTITUTE" | st == "PRIVATELY"
		 replace school_category = "Religious Schooling" if st == "DEENI MADRISSA" | st == "MADRISSA" | st == "MASJID SCHOOL" | st == "MOSQUE SCHOOL" | st == "RELIGIOUS SCHOOL"
		 replace school_category = "NGO/Trust" if st == "NGO/TRUST" | st == "NGO,FOUNDATION,TRUST"
		 replace school_category = "NFBE" if st == "NFBE SCHOOL" | st == "NON FORMAL BASIC EDUCATION SCHOOL"
		 replace school_category = "OTHERS" if st == "OTHERS" 
		 
		 
		 la var school_category "Type of School"
		 
		 fre st if year == 2018
		 fre school_category if year == 2018
		 
		 
		 
		 

		 la drop province
		
		
		
	     * Standardization of variables:
	   
	     la var hhcode "Household Code"
		
		 * isid hhcode idc year
		 ren idc member_id
		
		 la var member_id "Member ID (IDC)"
		
		
		 * province:
		 
		 drop prov
		 ta province
		
		 ren province prov
		 
		 gen province = 1 if prov == "Punjab"
		 replace province = 2 if prov == "KPK"
		 replace province = 3 if prov == "Balochistan"
		 replace province = 4 if prov == "Sindh" 
		 
		 
		 la def province 1 "Punjab" 2 "KPK" 3 "Balochistan" 4 "Sindh" 5 "OTHER AREAS"
		 la val province province 
		 
		 drop prov
		 
		 la var province "Province"

		
		 * Year
		 
		 la var year "Year"
		 
		 
		 fre read if year == 2018
		 fre math if year == 2018
		 
		
		
		

		 * Learning Vars:
		 ren read read1
		 ren math math1
		 
		 gen read = 1 if read1 == 1
		 replace read = 0 if read1 == 2
		 
		 gen math = 1 if math1 == 1
		 replace math = 0 if math1 == 2
		 
		 drop math1 read1
		 
		 la var math "PSLM: Solve simple arithmatic questions " 
		 la var read "PSLM: Read or write in any language with understanding"
		 
		 la def yes 1 "Yes" 0 "No"
		 
		 la val math yes
		 la val read yes
		 
		 
		 ren math math_pslm
		 ren read read_pslm
		 
		 
		 * Education Vars:

		la def educ_pslm 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" ///
		10 "class 10" 11 "polytechnic diploma/other diplomas" 12 "fa/fsc/i-com" 13 "ba/bsc/bed/bcs" 14 "ma/msc/med/mcs" 15 "degree in engineering" /// 
		16 "degree in medicine" 17 "degree in agriculture" 18 "degree in law" 19 "mphil/phd" 20 "others" 21 "Computer Science"
		
		
		la def educ 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" ///
		8 "class 8" 9 "class 9" 10 "class 10" 11 "FA/FSc/Diplomas" 12 "Bachelors or Higher"

		 * Highest grade:  
		 
		 gen hg = highest_grade if highest_grade <= 10 & highest_grade !=.
		 replace hg = 11 if highest_grade == 12 | highest_grade == 11 & highest_grade !=.
		 replace hg = 12 if highest_grade >=12 & highest_grade !=.
		 replace hg = . if highest_grade ==20  & highest_grade !=. // others codes as missings 
		 
		
		ren highest_grade highest_grade_pslm
		
		ren hg highest_grade
	    la var highest_grade "Highest Grade"

		la val highest_grade educ
		la val highest_grade_pslm educ_pslm
		la var highest_grade_pslm "PSLM: Highest Grade"
		
		
		* Current grade:
		
		gen cg = current_grade if current_grade <= 10 & current_grade !=.
		
		replace cg = 11 if current_grade == 12 | current_grade == 11 & current_grade !=.
		replace cg = 12 if current_grade >=12 & current_grade !=.
		replace cg = . if current_grade ==20  & current_grade !=. // others codes as missings 
		 

		 
		ren current_grade current_grade_pslm
		ren cg current_grade
		la var current_grade "Current Grade"
		
		la val current_grade educ
		la val current_grade_pslm educ_pslm
		la var current_grade_pslm "PSLM: Current Grade"
		
		
		* School Category:
		ren st st2
		ren school_category st
		
		gen school_category = 2 if st == "Government"
		replace school_category = 6 if st == "NFBE"
		replace school_category = 4 if st == "NGO/Trust"
		replace school_category = 8 if st == "Others"
		replace school_category = 1 if st == "Private"
		replace school_category = 9 if st == "Religious	Schooling"	

	    la def sc 1 "Private" 2 "Public" 3 "Institutions:Army/Police/Navy/Wapda/Railways/LDA" 4 "Non-Profits" 5 "PEF" 6 "NFBE" 7 "Government Departments/Welfare Schools (both Public & Private)" 8 "Other" 9 "Religious"
	    la val school_category sc
	
	    
		fre st
		fre school_category
		la var school_category "School Category"
		

		* Gender
		ren gender gend
		gen gender = 1 if gend == 2
		replace gender = 0 if gend == 1
		
		drop gend
		
		la var gender "Gender"
		

		* weights:
		
		ren weight w1
		ren weights w2
		
		gen weight = w1
		replace weight = w2 if w1 ==.
		
		drop w1 w2
		
		ren weight weight_pslm
		
		la var weight_pslm  "Sampling Weights - PSLM"
	
		
		la val in_school yes
		la val in_school_ever yes
		
        la var age "Age"		
		
		* Drop other vars
		drop  st 
		
		
		
	    gen sex = 1 if gender == 0
		replace sex = 2 if gender ==1
	    la var sex "Sex"
	    la def sex 1 "Male" 2 "Female"
		la val sex sex 
		
	   
		ren gender female
		la def female 1 "Female" 0 "Male"	
		la val female female
		la var female "Female Dummy"
		
			
		drop dist_nm 
		  
		* District Level Cleaning:
		
		* Islamabad from 201 to 139
			  
		replace dist_key = 139 if dist_key ==201
		  
		  
	
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
		  replace dist_nm = "NAWABSHA" if dist_key == 200
		 
		  *  replace dist_nm = "ISLAMABAD" if dist_key == 201
	  
	      * Islamabad putting as Other Areas
	      replace province = 0 if dist_key ==139
	  
			  
		  drop province
			 
		  gen province = 1 if prov_AR == "PUNJAB"    // punjab
		  replace province =2 if prov_AR == "SINDH" // sindh
		  replace province = 3 if prov_AR == "BALOCHISTAN" // Balochistna 
		  replace province = 4 if prov_AR == "KP" // KP
		
		  la drop prov
		  la def prov 0 "OTHER AREAS" 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP"        
			
		  la val province prov
		  la var province "Province"
	
	
		  replace province =1 if dist_key ==33
		  replace province =1 if dist_key ==1
	
	      labmask dist_key, values(dist_nm)
		
	      * District key edit : for provinces other than punjab
	
		
		  la var dist_key "District Key"
		  la var dist_nm "District Name" 
		  la var psu "Primary Sampling Unit"
				   
	   
		  gen education_status = 1 if en ==1 
		  replace education_status = 2 if dp ==1
		  replace education_status = 3 if ne ==1 
		
			
          la def educ_status 1 "Child in school" 2 "Child dropped out" 3 "Child never enrolled"
		  la val education_status educ_status
		  la var education_status "Education Status"
		
		  drop dp en ne 
		
		  * hh_income adjustment  :
		
		  replace hh_income2 = hh_income if year == 2018
		
		  drop hh_income
		  ren hh_income2 hh_income
		
		  la var hh_income "HH income (yearly)"
		 
		  * Total income
		  
		  la var tot_income "Individual Income (yearly)"
		  
	
		  keep prov_AR psu hhcode member_id year province dist_key dist_nm age sex female education_status in_school_ever in_school ///
		school_category highest_grade current_grade  highest_grade_pslm current_grade_pslm  math_pslm read_pslm weight_pslm hh_educ_level ///
		relation_hh_head Asset_Level asset_quintiles income_quintiles hh_income region tot_income st2
		
		  order prov_AR psu hhcode member_id year province dist_key dist_nm region age sex female education_status in_school_ever ///
		in_school school_category highest_grade current_grade  highest_grade_pslm current_grade_pslm  math_pslm read_pslm weight_pslm  ///
		hh_educ_level relation_hh_head Asset_Level asset_quintiles income_quintiles hh_income tot_income st2
	
		 drop prov_AR

		gen dataset = "PSLM"
		la var dataset "Dataset"
		
		
		*adjustment 
		
		replace in_school_ever =1 if highest_grade !=.
		
		replace school_category = . if in_school ==0 & school_category !=.
		
	    ren education_status es
		 
		 
		fre es
		 
		 
		ta in_school_ever in_school
		
		gen education_status = 1 if in_school ==1
		replace education_status = 2 if in_school_ever ==1 & in_school ==0
		replace education_status = 3 if in_school_ever ==0
		
		la var education_status "Education Status"
		la val education_status educ_status
		
		
		fre es
		fre education_status
		ta in_school_ever in_school
		
		drop es
	
	
		la var income_quintiles "Income Quintile"
		la val income_quintiles quintiles

		la var asset_quintiles "PSLM: Asset Quintiles"
		la var income_quintiles "PSLM: Income Quintiles"

		  

		la drop region
		la def region 1 "Urban" 2 "Rural"
		la val region region
		la var region "Region - Rural/Urban"
		
		
		compress
		
	    note: dist_key is missing for 70 observations in Punjab. The raw data had missing ///
		values for these observations. 
	    
		note: Scale Relaiabilty coefficent for Asset Quintiles is above 0.80, except for the 2018 PSLM/HIES
		note: 2018 - PSLM/HIES doesn't have district vars. This round was conducted at Province-level. 
		
 
		ren *, lower
		 
		 
			
		* Share of children enrolled in private schools
		
		gen private_school = 1 if school_category == 1 | school_category ==9 | school_category ==6 // including NFBE & Religious
		
		replace private_school = 0 if school_category == 2 | school_category ==4
		
		la var private_school "Private School Dummy: No. of children enrolled in private schools"

		ta school_category in_school
		ta private_school in_school
		
		ren private_school ps

		gen country = 1
		lab def country 1 "Pakistan"
		lab val country country
		la var country "Country"
		
		
		
		isid hhcode member_id year
		
		* Change name of the asset quintiles to suit program

		ren asset_quintiles aq 
		la var aq "Asset Quintiles"
		
		
		ren read_pslm read
		ren math_pslm math
 
		ren relation_hh_head relation 
		
		ren st2 school_category_pslm 
		la var school_category_pslm "PSLM: School Category"
		
********************************************************************************

        * Check Identifiers:
		isid hhcode member_id year
		order hhcode member_id year
	
		* Save the panel
	    save "$panel/pslm_panel.dta", replace
	
	
	

		
	
