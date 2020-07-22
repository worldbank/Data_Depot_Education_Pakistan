* MICS DATA CLEANING : 
* Author: Ahmed Raza
* Date: 30th September 2019
* Purpose: Create a panel of MICS data


clear all
set more off

		* Dropbox Globals
		
        include init.do
	  

********************************************************************************
		use "$mics_clean\MICS_HH_clean_2017.dta", clear 
********************************************************************************	


        gen relation_hh_head = hl3 
		
		clonevar relation = hl3
		
		order psu year	hh_cluster hh_number line_number dist_key dist_nm age gender in_school_ever in_school current_grade in_school_2016 current_grade_2016 school_type highest_grade wscore Asset_Level hh_educ_level  windex5 asset_quintiles region relation
		
	    keep psu year dist_key dist_nm hh_cluster hh_number line_number dist_key dist_nm age gender in_school_ever in_school current_grade  school_type highest_grade hhweight wscore Asset_Level hh_educ_level  windex5 asset_quintiles in_school_2016 current_grade_2016 region relation
		
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
	    gen en = 1 if in_school ==1
	    gen ne = 1 if in_school_ever ==0
			
		
	ren in_school_2016  in_school_ly
	ren current_grade_2016 current_grade_ly
	
    isid hh_cluster hh_number line_number	
	
		tempfile 2017
		save `2017', replace

	
		
		

********************************************************************************
		use "$mics_clean\MICS_HH_clean_2014.dta", clear 

********************************************************************************	
	
	
	
		clonevar relation = hl3
	
	    keep psu year dist_key dist_nm hh_cluster hh_number line_number dist_key dist_nm age gender in_school_ever in_school current_grade  school_type highest_grade hhweight wscore Asset_Level hh_educ_level  windex5 asset_quintiles in_school_2013 current_grade_2013 region relation
	
	ren in_school_2013  in_school_ly
	ren current_grade_2013 current_grade_ly
	
        gen dp = 1 if in_school_ever ==1 & in_school ==0
	    gen en = 1 if in_school ==1
	    gen ne = 1 if in_school_ever ==0
			
		isid hh_cluster hh_number line_number	

		tempfile 2014
		save `2014', replace
		



	
********************************************************************************		
		use "$mics_clean\MICS_HH_clean_2011.dta", clear 
********************************************************************************	

	clonevar relation = hl3
	

    keep psu year dist_key dist_nm hh_cluster hh_number line_number dist_key dist_nm age gender in_school_ever in_school current_grade  school_type highest_grade hhweight in_school_2010 current_grade_2010 wscore Asset_Level hh_educ_level  windex5 asset_quintiles  region relation
	
	ren in_school_2010  in_school_ly
	ren current_grade_2010 current_grade_ly
	
        gen dp = 1 if in_school_ever ==1 & in_school ==0
	    gen en = 1 if in_school ==1
	    gen ne = 1 if in_school_ever ==0
			

		tempfile 2011
		save `2011', replace


********************************************************************************


    use `2017' , clear 

	append using  `2014'
	append using  `2011'
	

   
  * Panel Consistency - Cleaning 

	ren gender gen2
	gen gender = 1 	if gen2 ==2 
	replace gender = 0 if gen2 ==1
	

	drop gen2
	
			
	    gen sex = 1 if gender == 0
		replace sex = 2 if gender ==1
	    la var sex "Sex"
	    la def sex 1 "Male" 2 "Female"
		la val sex sex 
		
	   
		ren gender female
		la def female 1 "Female" 0 "Male"	
		la val female female
		la var female "Female Dummy"
		
		
	
		
	    
		gen education_status = 1 if en ==1 
		replace education_status = 2 if dp ==1
		replace education_status = 3 if ne ==1 
		
		
        la def educ_status 1 "Child in school" 2 "Child dropped out" 3 "Child never enrolled"
		la val education_status educ_status
		la var education_status "Education Status"
		
		
		drop  dp en ne 
		
		gen school_category =1 if school_type ==3
		replace school_category = 9 if school_type ==2
		replace school_category = 2 if school_type ==1
		replace school_category = 8 if school_type ==4
		replace school_category = 6 if school_type ==5

	
		
		la def  sc 1 "Private" 2 "Public" 3 "Institutions:Army/Police/Navy/Wapda/Railways/LDA" 4 "Non-Profits" 5 "PEF" 6 "NFBE" 7 "Government Departments/Welfare Schools (both Public & Private)" 8 "Other" 9 "Religious"
		
		la val school_category sc
		
		drop school_type
		
		la var dist_nm "District Name"
		la var dist_key "District Key"
		la var age "Age"
		la var current_grade "Highest Grade"
		la var school_category "School Category"
		
		
		la var in_school_ly    "Previous Year: In school (current)"
		la var current_grade_ly "Previous Year: Grade (current)"
		
		
		* Education Vars:

		 
		 
		* la def educ_pslm 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "polytechnic diploma/other diplomas" 12 "fa/fsc/i-com" 13 "ba/bsc/bed/bcs" 14 "ma/msc/med/mcs" 15 "degree in engineering" 16 "degree in medicine" 17 "degree in agriculture" 18 "degree in law" 19 "mphil/phd" 20 "others" 21 "Computer Science"
			
		la def educ 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "FA/FSc/Diplomas" 12 "Bachelors or Higher"


		 * Highest grade:  
		 
		 gen hg = highest_grade if highest_grade <= 10 & highest_grade !=.
		 replace hg = 11  if highest_grade ==11
		 replace hg = 12 if highest_grade >= 12 & highest_grade !=.
		 
		
		ren highest_grade highest_grade_mics
		
		ren hg highest_grade
	    la var highest_grade "Highest Grade"
		la val highest_grade educ
		la var highest_grade_mics "MICS: Highest Grade"
		

		* Current grade:
		
		gen cg = current_grade if current_grade <= 10 & current_grade !=.
		 replace cg = 11  if current_grade ==11
		 replace cg = 12 if current_grade >= 12 & current_grade !=.
		
		
		ren current_grade current_grade_mics
		
		ren cg current_grade
		la var current_grade "Current Grade"
		la val current_grade educ
			la var current_grade_mics "MICS: Current Grade"
			
			
					
		drop if line_number ==.
		isid hh_cluster hh_number line_number year 
		

		ren hhweight weight_mics 
		
		gen province = 1
		 
		la def prov 0 "OTHER AREAS" 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP"        
		la val province province
		la var province "Province"
		
		la var year "Year"
		
		
		la var in_school_ever "Ever enrolled in school"
		la var in_school  "Currently enrolled in school"
			 
		
		la def yes 1"Yes" 0 "No"
		la val in_school yes
		la val in_school_ever yes
		
		
		la drop HL4 st  
		
	
	    * District Key
		
		
		* district
			
		ren dist_key dist_key2
		  
		gen dist_key =1 if dist_key2 ==1
		replace dist_key =2 if dist_key2 ==2
	    replace dist_key =3 if dist_key2 ==3
	    replace dist_key =4 if dist_key2 ==4
	    replace dist_key =5 if dist_key2 ==5
	    replace dist_key =6 if dist_key2 ==6
	    replace dist_key =7 if dist_key2 ==7
	    replace dist_key =8 if dist_key2 ==8
	    replace dist_key =9 if dist_key2 ==9
	    replace dist_key =10 if dist_key2 ==10
	    replace dist_key =11 if dist_key2 ==11
	    replace dist_key =12 if dist_key2 ==12
	    replace dist_key =13 if dist_key2 ==13
	    replace dist_key =14 if dist_key2 ==14
	    replace dist_key =15 if dist_key2 ==15
		  
		replace dist_key =16 if dist_key2 ==17
		replace dist_key =17 if dist_key2 == 18
		replace dist_key =18 if dist_key2 == 19
		replace dist_key =19 if dist_key2 == 20
		replace dist_key =20 if dist_key2 == 21


		replace dist_key =21 if dist_key2 == 22
		replace dist_key =22 if dist_key2 == 23
		replace dist_key =23 if dist_key2 == 24
		replace dist_key =24 if dist_key2 == 25
		replace dist_key =25 if dist_key2 == 26
		replace dist_key =26 if dist_key2 == 27
		replace dist_key =27 if dist_key2 == 28
		replace dist_key =28 if dist_key2 == 29
		replace dist_key =29 if dist_key2 == 30
		replace dist_key =30 if dist_key2 == 31
		replace dist_key =31 if dist_key2 == 32
		replace dist_key =32 if dist_key2 == 33
		replace dist_key =33 if dist_key2 == 34
		replace dist_key =34 if dist_key2 == 35
		replace dist_key =35 if dist_key2 == 36
		replace dist_key =36 if dist_key2 == 37
		 
		drop dist_nm dist_key2
		  
		* District Level Cleaning:
		
		gen dist_nm = "ATTOCK"	if dist_key == 1  
		replace dist_nm = "BAHAWALNAGER" if dist_key == 2  
		replace dist_nm = "BAHAWALPUR" if dist_key == 3
		replace dist_nm = "BHAKKAR" if dist_key == 4 
		replace dist_nm = "CHAKWAL" if dist_key == 5
		replace dist_nm = "DERA GHAZI KHAN" if dist_key == 6 
		replace dist_nm = "FAISALABAD" if dist_key == 7 
		replace dist_nm = "GUJRANWALA" if dist_key == 8 
		replace dist_nm = "GUJRAT" if dist_key == 9 
		replace dist_nm = "HAFIZABAD" if dist_key == 10
		replace dist_nm = "JEHLUM" if dist_key == 11
		replace dist_nm = "JHANG" if dist_key == 12 
		replace dist_nm = "KASUR" if dist_key == 13
		replace dist_nm = "KHANEWAL" if dist_key == 14 
		replace dist_nm = "KHUSHAB" if dist_key == 15 
			 
		replace dist_nm = "LAHORE" if dist_key == 16
		replace dist_nm = "LAYYAH" if dist_key == 17
		replace dist_nm = "LODHRAN" if dist_key == 18 
		replace dist_nm = "MANDI BAHUDDIN" if dist_key == 19 
		replace dist_nm = "MIANWALI" if dist_key == 20
		replace dist_nm = "MULTAN" if dist_key == 21
		replace dist_nm = "MUZAFFAR GARH" if dist_key == 22 
		replace dist_nm = "NAROWAL" if dist_key == 23
		replace dist_nm = "OKARA" if dist_key == 24
		replace dist_nm = "PAKPATTAN" if dist_key == 25 
		replace dist_nm = "RAHIM YAR KHAN" if dist_key == 26 
		replace dist_nm = "RAJANPUR" if dist_key == 27
		replace dist_nm = "RAWALPINDI" if dist_key == 28 
		replace dist_nm = "SAHIWAL" if dist_key == 29
		replace dist_nm = "SARGODHA" if dist_key == 30 
		replace dist_nm = "SHEIKHUPURA" if dist_key == 31
		replace dist_nm = "SIALKOT" if dist_key == 32
		replace dist_nm = "T.T.SINGH"  if dist_key == 33
		replace dist_nm = "VEHARI" if dist_key == 34 
		replace dist_nm = "NANKANA SAHIB" if dist_key == 35 
        replace dist_nm = "CHINIOT" if dist_key == 36
		
		replace dist_nm = "" if dist_key==100

	
	    labmask dist_key, values(dist_nm)
	   
	
	    * District key edit : for provinces other than punjab
		replace dist_key =. if dist_key ==100
	
		
		la var dist_key "District Key"
		la var dist_nm "District Name" 
		la var psu "Primary Sampling Unit"
				
		la var hh_educ_level "HH Education Level"
		

	
		order psu province dist_key dist_nm hh_cluster hh_number line_number year age sex female in_school_ever in_school school_category highest_grade current_grade  highest_grade_mics current_grade_mics weight_mics
		
		ren hh_number hhcode
	    ren line_number  member_id
		
		la var hhcode "HH Code"
		la var member_id "Member ID"
		
		gen dataset = "MICS"
		la var dataset "Dataset"
	
		compress
	
	
		/*
		Due to the instrument design (see questionnaires) we have to recode the in_school variable (to 0) in the dataset so that individuals that are coded 
		to be (in_school_ever ==0) never gone to school are missing in the in_school (currently in school) variable.
		*/
	
	
		replace in_school = 0 if in_school_ever ==0
	
	    ta in_school if in_school_ever ==0
	
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
		
	
		la val province prov
		
		ren windex5 wealth_quintiles
		la var wealth_quintiles "Wealth Quintiles from Wealth Index"
		la val wealth_quintiles quintiles
		
	

		la var asset_quintiles "MICS: Asset Quintiles"
		la var wealth_quintiles "MICS: Wealth Quintiles"

		
			
		* Share of children enrolled in private schools
		
		gen private_school = 1 if school_category == 1 | school_category ==9 | school_category ==6 // including NFBE & Religious
		
		replace private_school = 0 if school_category == 2 | school_category ==4 | school_category ==8
		
		la var private_school "Private School Dummy: No. of children enrolled in private schools"
		
		ta school_category in_school
		ta private_school in_school
		
		ren private_school ps
		
		gen country = 1
		lab def country 1 "Pakistan"
		lab val country country
		
		
		
		* check unique identifiers 
		
	    isid hhcode hh_cluster member_id year
				
				
		* Change name of the asset quintiles to suit program
		
		ren wealth_quintiles aq 
		la var aq "Wealth Quintiles"
		
		la var current_grade "Current Grade (0-10)"
		la var highest_grade "Highest Grade (0-10)"
		
		
		fre relation 
		la var relation "relation to Head"
		la var country "Country"

		

      * Unique Identifier Test: 
	
	  isid hh_cluster hhcode member_id year
	  
	  
	  order hh_cluster hhcode member_id year psu province dist_key dist_nm age sex female in_school_ever in_school school_category highest_grade current_grade highest_grade_mics current_grade_mics weight_mics in_school_ly current_grade_ly wscore Asset_Level hh_educ_level aq asset_quintiles region relation dataset education_status ps country
		
		

		* Save the panel:
	    save "$panel\mics_panel.dta", replace 
	