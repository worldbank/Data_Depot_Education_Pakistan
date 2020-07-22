* ASER DATA CLEANING : 
* Author: Ahmed Raza
* Date: 18th June 2019
* Purpose: To create the panel of ASER HH data (ONLY PUNJAB):
	

		* Init for Globals
		
        include init.do
		
********************************************************************************

	    use "$aser_clean/ASER_HH_2012.dta", clear 

		
		/*		
		gen prov = 1 if pcode == "01" 
		replace prov = 2 if pcode == "02"
		replace prov = 3 if pcode == "03"
		replace prov = 4 if pcode == "04"

			
		la def prov 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP"
		la val prov prov		
		
		gender_male in_school
		
		*/
		
		* keep if prov ==1 
		
		
		*Learning Outcome:
		
		gen reading = 1 if childnotavailable !=1 &  readingbeginner ==1
		replace reading = 2 if childnotavailable !=1 &  readingletter ==1
		replace reading = 3 if childnotavailable !=1 &  readingword ==1
		replace reading = 4 if childnotavailable !=1 &  readingsentance ==1
		replace reading = 5 if childnotavailable !=1 &  readingstory ==1
	
			
		* MATH:
		
		
		gen math =  1 if childnotavailable !=1 &  mathbeginner ==1
		replace math = 2 if childnotavailable !=1 &  math1_9 ==1
		replace math = 3 if childnotavailable !=1 &  math11_99 ==1
		replace math = 5 if childnotavailable !=1 &  mathsubstration ==1
		replace math = 6 if childnotavailable !=1 &  mathdivision ==1

		
				
		* English:		
				
		gen english = 1 if childnotavailable !=1 &  englishbeginner ==1
		replace english = 2 if childnotavailable !=1 &  englishcletter ==1
		replace english = 3 if childnotavailable !=1 &  englishsletter ==1
		replace english = 4 if childnotavailable !=1 &  englishword ==1
		replace english = 5 if childnotavailable !=1 &  englishsentance ==1

		

********************************************************************************
		
		gen out_of_school =1 if in_school ==0 
		
				
		la def grade  1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" 12"12" 13"13" 14"BA" 0"ECE, KACHI, KG, PAKI,PG, PREP" 100 "HIFZ"

		la val current_grade grade
		la val dropout_grade grade
		la val highest_grade grade
		
		
		gen child_school_type =1 if childschoolgov ==1
		replace child_school_type =2 if childschoolprivate ==1
		replace child_school_type=3 if childschoolmadrs ==1
		replace child_school_type=4 if childschoolnfe ==1
		replace child_school_type=5 if childschoolother==1

		
		la def schooltype 1 "Government School" 2 "Private" 3 "Madaras" 4 "NFE" 5 "Other"
		la val child_school_type schooltype
		
	
		
		drop private private_a
	
	
		gen private_share_a = 1 if child_school_type ==2
		replace private_share_a =0 if child_school_type !=2 & child_school_type !=.
		la var private_share_a "Private Share: 1 = Private , 0 = All Other"
		
		
		gen private_share = 1 if child_school_type ==2
		replace private_share =0 if child_school_type ==1
		la var private_share "Private Share: 1 = Private , 0 = Government"

		
		la var reading "Learning Outcome: Urdu"
		la var math  "Learning Outcome: Mathematics"
		la var english "Learning Outome: English"
		
		gen education_status = 1 if childeducationen ==1 
		replace education_status =2 if childeducationdp ==1
		replace education_status =3  if childeducationne ==1
		
   	    ren hhid hhcode
	    ren childid member_id
	   
	   
	    drop province 
	
	    ren prov province
	
	    * Check with ASER team regarding the reading language var in year 2012
	
	    gen reading_language = preferredschoolmedium
        replace reading_language =. if reading ==.
	
	
	    keep hhcode member_id dist_nm2 dist_key year province age gender_male education_status child_school_type in_school in_school_ever hh_educ_level current_grade highest_grade reading math english Asset_Level asset_quintiles reading_language
	   
	   
	    tostring hhcode, replace
	   
	    tempfile 2012
        save `2012', replace
	
	
	
********************************************************************************

	    use "$aser_clean/ASER_HH_2013.dta", clear 

		
		* LEARNING OUTCOMES:
					 
		* READING
		
		ren readinghighestlevel reading
			
		* MATH:
			
		ren	mathhighestlevel math
		recode math (4=5)(5=6)
		
		* English:		
		
		ren englishreading english

		la var reading "Learning Outcome: Urdu"
		la var math  "Learning Outcome: Mathematics"
		la var english "Learning Outome: English"

		
		gen out_of_school =1 if in_school ==0 
					
			
		la def grade  1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" 12"12" 13"13" 14"BA" 0"ECE, KACHI, KG, PAKI,PG, PREP" 100 "HIFZ"

		la val current_grade grade
		la val dropout_grade grade
		la val highest_grade grade
		
	
		gen child_school_type =1 if institutetype ==1
		replace child_school_type =2 if institutetype ==2
		replace child_school_type=3 if institutetype ==3
		replace child_school_type=5 if institutetype ==4


				
		la def schooltype 1 "Government School" 2 "Private" 3 "Madaras" 4 "NFE" 5 "Other"
		la val child_school_type schooltype

		drop private private_a
	
	
		gen private_share_a = 1 if child_school_type ==2
		replace private_share_a =0 if child_school_type !=2 & child_school_type !=.
		la var private_share_a "Private Share: 1 = Private , 0 = All Other"
		
		
		gen private_share = 1 if child_school_type ==2
		replace private_share =0 if child_school_type ==1
		la var private_share "Private Share: 1 = Private , 0 = Government"
		
		ren educationstatus es
		
		gen education_status = 1 if es ==3
		replace education_status = 2 if es ==2
		replace education_status = 3 if es ==1 
		
		
		isid childid 
	
	    ren hhid hhcode
	    ren childid member_id
	      
	    drop province 
		
	    ren prov province
		
	    gen reading_language = languagetested
		
	    keep hhcode member_id dist_nm2 dist_key year province age gender_male education_status child_school_type ///
		in_school in_school_ever hh_educ_level current_grade highest_grade reading math english Asset_Level ///
		asset_quintiles reading_language
		   
	   
	    tostring hhcode, replace
	     
	    tempfile 2013
	    save `2013', replace

	
********************************************************************************

	    use "$aser_clean/ASER_HH_2014.dta", clear 

		
	    * LEARNING OUTCOMES:
					 
	    * READING
			
	    ren readinghighestlevel reading
				
	    * MATH:
			
	    ren	mathhighestlevel math
	    recode math (4=5)(5=6)
										
	    * English:		
		
	    ren englishreading english

	    la var reading "Learning Outcome: Urdu"
        la var math  "Learning Outcome: Mathematics"
	    la var english "Learning Outome: English"

	    gen out_of_school =1 if in_school ==0 
					
	    la def grade  1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" 12"12" 13"13" ///
		14"BA" 0"ECE, KACHI, KG, PAKI,PG, PREP" 100 "HIFZ"

        la val current_grade grade
	    la val dropout_grade grade
	    la val highest_grade grade
		
	
	    gen child_school_type =1 if institutetype ==1
	    replace child_school_type =2 if institutetype ==2
	    replace child_school_type=3 if institutetype ==3
	    replace child_school_type=5 if institutetype ==4
			
	    la def schooltype 1 "Government School" 2 "Private" 3 "Madaras" 4 "NFE" 5 "Other"
	    la val child_school_type schooltype

	    drop private_a
		
		
	    gen private_share_a = 1 if child_school_type ==2
	    replace private_share_a =0 if child_school_type !=2 & child_school_type !=.
	    la var private_share_a "Private Share: 1 = Private , 0 = All Other"
		
	    gen private_share = 1 if child_school_type ==2
	    replace private_share =0 if child_school_type ==1
	    la var private_share "Private Share: 1 = Private , 0 = Government"
		
	    ren educationstatus es
		
	    gen education_status = 1 if es ==3
	    replace education_status = 2 if es ==2
	    replace education_status = 3 if es ==1 
		
        ren hhid hhcode
	    ren childid member_id
	   
	    drop province 

	    ren prov province  
	  
	    gen reading_language = languagetested

	    keep hhcode member_id dist_nm2 dist_key year province age gender_male education_status ///
		child_school_type in_school in_school_ever hh_educ_level current_grade highest_grade ///
		reading math english Asset_Level asset_quintiles reading_language
	   
	    tostring hhcode, replace
	   	
	    tempfile 2014
	    save `2014', replace

		
********************************************************************************

	    use "$aser_clean/ASER_HH_2015.dta", clear 
	
	    drop if childid ==.
	
	    * LEARNING OUTCOMES:
				 
	    * READING
	    ren readinghighestlevel reading
	    
	    * MATH:
		
	    ren mathhighestlevel math
        recode math (4=5)(5=6)
				
	    * English:		
		
		ren englishreading english

		la var reading "Learning Outcome: Urdu"
		la var math  "Learning Outcome: Mathematics"
		la var english "Learning Outome: English"

		gen out_of_school =1 if in_school ==0 				
			
		la def grade  1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" ///
		12"12" 13"13" 14"BA" 0"ECE, KACHI, KG, PAKI,PG, PREP" 100 "HIFZ"

		la val current_grade grade
		la val dropout_grade grade
		la val highest_grade grade
			
	    gen child_school_type =1 if institutetype ==1
	    replace child_school_type =2 if institutetype ==2
	    replace child_school_type=3 if institutetype ==3
	    replace child_school_type=5 if institutetype ==4
			
	    la def schooltype 1 "Government School" 2 "Private" 3 "Madaras" 4 "NFE" 5 "Other"
	    la val child_school_type schooltype

	    drop private_a	
	
	    gen private_share_a = 1 if child_school_type ==2
	    replace private_share_a =0 if child_school_type !=2 & child_school_type !=.
	    la var private_share_a "Private Share: 1 = Private , 0 = All Other"
	
	    gen private_share = 1 if child_school_type ==2
	    replace private_share =0 if child_school_type ==1
	    la var private_share "Private Share: 1 = Private , 0 = Government"
			
	    ren educationstatus es
	    fre es
		
	    gen education_status = 1 if es ==3
	    replace education_status = 2 if es ==2
	    replace education_status = 3 if es ==1 
		
	    ren hhid hhcode
	    ren childid member_id 
	    ren prov province
	  
	    gen reading_language = languagetested
		
	    fre reading_language
	   
	    keep hhcode member_id dist_nm2 dist_key year province age gender_male education_status ///
		child_school_type in_school in_school_ever hh_educ_level current_grade highest_grade ///
		reading math english Asset_Level asset_quintiles reading_language
	   
	    tostring hhcode, replace
	   	
	    tempfile 2015
	    save `2015', replace

		
********************************************************************************

        use "$aser_clean/ASER_HH_2016.dta", clear 
	
	    * Error in institution type variable 0 = missing (check with ASER)
	
	    gen ischildwasavailable =1 if c019 == -1
	    replace ischildwasavailable =0 if c019 == 0
	
	    ren c010 readinghighestlevel
	    ren c012 mathhighestlevel	
	    ren c013 englishreading
		
	    * LEARNING OUTCOMES:
				 
	    * READING
	    ren readinghighestlevel reading
	    
	    * MATH:
	  
	    ren	mathhighestlevel math
	    recode math (4=5)(5=6)
				
	    * English:		
	
	    ren englishreading english

	    la var reading "Learning Outcome: Urdu"
	    la var math  "Learning Outcome: Mathematics"
	    la var english "Learning Outome: English"

	    gen out_of_school =1 if in_school ==0 				
		
	    la def grade  1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" ///
		11"11" 12"12" 13"13" 14"BA" 0"ECE, KACHI, KG, PAKI,PG, PREP" 100 "HIFZ"

        la val current_grade grade
	    la val dropout_grade grade
	    la val highest_grade grade
		
	    gen child_school_type =1 if institutetype ==1
	    replace child_school_type =2 if institutetype ==2
	    replace child_school_type=3 if institutetype ==3
	    replace child_school_type=5 if institutetype ==4

	    la def schooltype 1 "Government School" 2 "Private" 3 "Madaras" 4 "NFE" 5 "Other"
	    la val child_school_type schooltype
	
	    drop private_a	
	
	    gen private_share_a = 1 if child_school_type ==2
	    replace private_share_a =0 if child_school_type !=2 & child_school_type !=.
	    la var private_share_a "Private Share: 1 = Private , 0 = All Other"
	
	    gen private_share = 1 if child_school_type ==2
	    replace private_share =0 if child_school_type ==1
	    la var private_share "Private Share: 1 = Private , 0 = Government"
	
	    ren educationstatus es
	    fre es
			
	    gen education_status = 1 if es ==3
	    replace education_status = 2 if es ==2
	    replace education_status = 3 if es ==1 
   
	    ren hhid hhcode
	    ren childid member_id
	   
	    ren prov province
	   
	    ren c011 languagetested
	    gen reading_language = languagetested
		
	    fre reading_language
	    recode reading_language (0=.)
	   
	    keep hhcode member_id dist_nm2 dist_key year province age gender_male education_status ///
		child_school_type in_school in_school_ever hh_educ_level current_grade highest_grade /// 
		reading math english Asset_Level asset_quintiles reading_language
	   
	    drop if member_id ==.
	   
	    tostring hhcode, replace
	   
	    tempfile 2016
        save `2016', replace

	
********************************************************************************

	    use "$aser_clean/ASER_HH_2018.dta", clear 
	
		* Error in institution type variable 0 = missing (check with ASER)
	
	
	    ren c010 readinghighestlevel
		ren c012 mathhighestlevel	
		ren c013 englishreading
	
		
	    * LEARNING OUTCOMES:
				 
	    * READING
	
	    ren readinghighestlevel reading
	    
	    * MATH:
		
	    ren	mathhighestlevel math
				
				
	    * English:		
		
		ren englishreading english

		la var reading "Learning Outcome: Urdu"
		la var math  "Learning Outcome: Mathematics"
		la var english "Learning Outome: English"

	
		gen out_of_school =1 if in_school ==0 				
		
		la def grade  1"1" 2"2" 3"3" 4"4" 5"5" 6"6" 7"7" 8"8" 9"9" 10"10" 11"11" 12"12" 13"13" 14"BA" 0"ECE, KACHI, KG, PAKI,PG, PREP" 100 "HIFZ"

        la val current_grade grade
		la val dropout_grade grade
		la val highest_grade grade
		
		gen child_school_type =1 if institutetype ==1
		replace child_school_type =2 if institutetype ==2
		replace child_school_type=3 if institutetype ==3
		replace child_school_type=5 if institutetype ==4
				
		la def schooltype 1 "Government School" 2 "Private" 3 "Madaras" 4 "NFE" 5 "Other"
		la val child_school_type schooltype
	
		drop private_a	
		
		gen private_share_a = 1 if child_school_type ==2
		replace private_share_a =0 if child_school_type !=2 & child_school_type !=.
		la var private_share_a "Private Share: 1 = Private , 0 = All Other"
		
	
		gen private_share = 1 if child_school_type ==2
		replace private_share =0 if child_school_type ==1
		la var private_share "Private Share: 1 = Private , 0 = Government"
		
		ren educationstatus es
		fre es
	
		gen education_status = 1 if es ==3
		replace education_status = 2 if es ==2
		replace education_status = 3 if es ==1 
		   
	    ren hhid hhcode
	    ren childid member_id
	   
	    ren prov province
	   
	    ren c011 languagetested
	    gen reading_language = languagetested
		
	    fre reading_language
	    recode reading_language (0=.)
		
	    keep hhcode member_id dist_nm2 dist_key year province age gender_male education_status ///
		child_school_type in_school in_school_ever hh_educ_level current_grade highest_grade ///
		reading math english Asset_Level asset_quintiles reading_language
	   
	   
	    tostring hhcode, replace
	   	   
	    tempfile 2018
	    save `2018', replace


	
********************************************************************************
	
	    use "$aser_clean/ASER_HH_2019.dta", clear

	    ren dist_nm dist_nm2
	    ren hhid hhcode
	    ren prov province
	    gen gender_male =0 
	    replace gender_male=1 if sex ==1
		
	    gen school_category_2019 = school_category
		
	    ren c011 reading_language
		  
	    keep hhcode member_id dist_nm2 dist_key year province age gender_male education_status ///
	    school_category_2019 in_school in_school_ever hh_educ_level current_grade highest_grade ///
	    reading math english Asset_Level asset_quintiles reading_language
	
	    ta school_category_2019

	    la drop _all
	   	   
	    tempfile 2019
	    save `2019', replace
		
		
    

********************************************************************************

  
		* Append datasets:
	  
		use `2018', clear

		append using `2016'
		append using `2015'
		append using `2014'
		append using `2013'
		append using `2012'
		append using `2019'
		
		recode math reading english (0=.)
		  
		la def math 1 "Beginner" 2 "Count 1-9" 3 "Count 1-99" 4 "Count 100-200" 5 "Subtraction" 6 "Division"
		la val math  math
		  
		la def reading 1 "Beginner" 2 "Read letters" 3 "Read words" 4 "Read sentence" 5 "Read story"
		la val reading reading
		  
		la def english 1 "Beginner" 2 "Read Capital letter" 3 "Read Small Letter" 4 "Read words" 5 "Read sentence"
		la val english english
		  
		  
		la var highest_grade "Highest Grade Completed"
		la var current_grade  "Current Grade"
		la var in_school "Currently in school"
		la var in_school_ever "Ever enrolled in school (including dropouts)"
		la var child_school_type "School Type"
		 
		la var year "Year"
			
			
	    * Province:
	  
	    la var province "Province"
	    recode province (.=0)

	   
	    * Learning Vars:
			  
	    ren reading reading_aser
	    ren math math_aser
	    ren english english_aser
		 
		
	    * Education Vars:

	    la def educ 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" ///
		5 "class 5" 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" ///
		11 "FA/FSc/Diplomas" 12 "Bachelors or Higher"

	    la def educ_aser 0 "ECE, KACHI,	KG,	PAKI,PG, PREP" 1 "1" 2 "2" 3 "3" 4 "4" ///
		5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" 11 "11" 12 "12" 13 "13" 14 "BA" 100 "HIFZ"
		
	    * Highest grade:  
			 
		gen hg = highest_grade if highest_grade <= 10 & highest_grade !=.
		replace hg = 11 if highest_grade == 11 | highest_grade == 12 
		replace hg = 12 if highest_grade ==14 | highest_grade ==13
		replace hg=. if highest_grade ==100
			
		ren highest_grade highest_grade_aser
			
		ren hg highest_grade
		
		la var highest_grade "Highest Grade - (0-10)"

		la val highest_grade educ
		la val highest_grade_aser educ_aser
		la var highest_grade_aser "ASER: highest grade"
		
		
		* Current grade:
		
		gen cg = current_grade if current_grade <= 10 & current_grade !=.
		replace cg = 11 if current_grade == 11 | current_grade == 12 
		replace cg = 12 if current_grade ==14 | current_grade ==13
		replace cg=. if current_grade ==100
		
		ren current_grade current_grade_aser
		
		ren cg current_grade
		la var current_grade "Current Grade - (0-10)"
		
		la val current_grade educ
		la val current_grade_aser educ_aser
		la var current_grade_aser "ASER: current grade"

	   
		* School Category:
		ren child_school_type st
		
		gen school_category = 2 if st == 1
		replace school_category = 1 if st == 2
		replace school_category = 9 if st == 3
		replace school_category = 8 if st == 5
		
	
	    la def sc 1 "Private" 2 "Public" 3 "Institutions:Army/Police/Navy/Wapda/Railways/LDA"  ///
		4 "Non-Profits" 5 "PEF" 6 "NFBE" 7 "Government Departments/Welfare Schools (both Public & Private)" ///
		8 "Other" 9 "Religious"
	    
		la val school_category sc
	
	    
		fre st
		fre school_category
		la var school_category "School Category"
	
	    * school category format fix for the year 2019
	
		replace school_category = school_category_2019 if year ==2019
		drop school_category_2019
	
		* Gender
		ren gender_male gend
		gen gender = 1 if gend == 0
		replace gender = 0 if gend == 1
		drop gend	
		la var gender "Gender"
		
	
		la var in_school "Currently enrolled in school"
		la var english_aser "ASER: learning outcome - English"
		la var math_aser "ASER: learning outcome - Math"
		la var reading_aser "ASER: learning outcome - Reading"
		
        la def educ_status 1 "Child in school" 2 "Child dropped out" 3 "Child never enrolled"
		la val education_status educ_status
		la var education_status "Education Status"
		
		
		gen sex = 1 if gender == 0
		replace sex = 2 if gender ==1
		la var sex "Sex"
		la def sex 1 "Male" 2 "Female"
		la val sex sex 
		
		
		ren gender female 
		la def female 1 "Female" 0 "Male"		
		la val female female 
		la var female "Female Dummy"

		
		la var member_id "Member ID (IDC)"
		la var hhcode "Household Code"
		la var age "Age"
		
		ren dist_nm2 dist_nm
	
	
	    keep hhcode member_id dist_nm dist_key year province age sex female school_category ///
		education_status in_school in_school_ever hh_educ_level  ///
		current_grade highest_grade current_grade_aser highest_grade_aser ///
		reading_aser math_aser english_aser Asset_Level asset_quintiles reading_language
		
        gen dataset = "ASER"
	    la var dataset "Dataset Name"
		
	    order hhcode member_id dist_nm dist_key year province age sex female school_category /// 
		education_status in_school in_school_ever hh_educ_level ///
		current_grade highest_grade current_grade_aser highest_grade_aser ///
		reading_language reading_aser math_aser english_aser Asset_Level asset_quintiles dataset

	 
	    drop dist_nm
	
		
		* BANNU
		replace dist_key = 38 if dist_key ==127
		replace province = 4 if dist_key ==38

		* DI KHAN 
		replace dist_key = 43 if dist_key ==128
		replace province = 4 if dist_key ==43

		
		
		* PEHSHAWAR
		replace dist_key = 55 if dist_key ==131
		replace province = 4 if dist_key ==55

		* KOHAT 
		replace dist_key = 47 if dist_key ==129
		replace province = 4 if dist_key ==47

		* TANK
		replace dist_key = 59 if dist_key ==132
		replace province = 4 if dist_key ==59
		
		* LAKI MARWAT
		
		replace dist_key = 49 if dist_key ==130
		replace province = 4 if dist_key ==49

	    /* 
		* ICT
		replace dist_key = 28 if dist_key ==139
		replace province = 1 if dist_key ==28
		*/
	
	 	* District Level Cleaning:
		
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
		 
		  
		 labmask dist_key, val(dist_nm)
		  
		
		 la def rlang 1 "URDU" 2 "SINDHI" 3 "PASHTO"
		 la val reading_language rlang
		 
		 la var reading_language "ASER: Reading Test Language"
		 
		 ren reading_language test_language
		  
		 compress
		 
		
		 gen dist_tag =1 if province ==0
		 la var dist_tag "Inconsistent districts in ASER" 
		 
		 
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
		
		 * ren asset_quintiles wealth_quintiles
 
         la var asset_quintiles "ASER: Asset Quintiles"

		 ren *, lower
		 compress
		 
		
		* Fix province var
		
		la drop prov
		la def prov 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP" 5 "OTHER AREAS"
		replace province = 5 if province ==0
		la val province prov
		fre province
		
						
		* Share of children enrolled in private schools
		
		gen private_school = 1 if school_category == 1 | school_category ==9 | school_category ==6 // including NFBE & Religious
		
		replace private_school = 0 if school_category == 2 | school_category ==4 | school_category ==8
		
		la var private_school "Private School Dummy: No. of children enrolled in private schools"
		
		ren private_school ps
		
		
		* Change name of the asset quintiles to suit program

		ren asset_quintiles aq 
		la var aq "Asset Quintiles"
				
		ta school_category in_school
	
		gen country = 1
	    lab def country 1 "Pakistan"
		cap lab val country country
		
********************************************************************************	
		
		gen reading = 1 if reading_aser == 5
		replace reading = 0 if reading_aser < 5
	   
		gen division = 1 if math_aser == 6
		replace division = 0 if math_aser < 6
	   
		gen weight_aser = 1 
		la var weight_aser "Weight: Aser"
		
		gen region =.
		la var region "Region"
		
		
		gen relation = . 
		la var relation "relation to Head"
		
		la var country "Country"
		
		la var reading "Reading Paragraph - Dummy"
		la var division "2 digit Division - Dummy"
		
		la var ps "Private School Dummy"
		
		
	    * Unique identifier test 
		
		* 1,533/290,309 observations in year 2019 have missing member_ids which are not dropped from the aser panel

		note: 1,533/290,309 observations in year 2019 have missing member_ids which are not dropped from the aser panel
		
		* note: "dist_tag" variable is created to tag the districts which are inconsistent in ASER

		
		* drop if member_id ==. 
		
		* isid hhcode member_id year
		
	  
		* Save the panel:
		save "$panel/aser_panel.dta", replace