* ASAER DATA CLEANING : 
* Author: Ahmed Raza
* Date: 20th May 2019
* Purpose: Cleaning ASER data: 1. Private School Data , 2. Government School Data, 3. HH data.

** NOTE: HH data not cleaned yet. 


clear all
set more off

		* Dropbox Globals
		
		
		include init.do

	
********************************************************************************	
	* YEAR: 2012
********************************************************************************	
	

	* Province:
	import excel "$aser_raw/2012/0tblProvince.xlsx", sheet("_0tblProvince") firstrow clear
	
	
	* District:
	import excel "$aser_raw/2012/1tblDistricts.xlsx", sheet("_1tblDistricts") firstrow clear

	ren *, lower 
	ren districts dist_nm
	sort provinceid dist_nm
	
	replace dist_nm = trim(dist_nm)
	ta dist_nm
	clean_lname dist_nm
	ta dist_nm
	
	* keeping the districts in Punjab:
	keep if provinceid ==2
	
	* District Level Cleaning:
	
        gen dist_key = 1			 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER"
		replace dist_key = 3 if dist_nm == "BAHAWALPUR"
		replace dist_key = 4 if dist_nm == "BHAKKAR"
		replace dist_key = 5 if dist_nm == "CHAKWAL"
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"
		replace dist_key = 7 if dist_nm == "FAISALABAD"
		replace dist_key = 8 if dist_nm == "GUJRANWALA"
		replace dist_key = 9 if dist_nm == "GUJRAT"
		replace dist_key = 10 if dist_nm == "HAFIZABAD"
		replace dist_key = 11 if dist_nm == "JEHLUM"
		replace dist_key = 12 if dist_nm == "JHANG"
		replace dist_key = 13 if dist_nm == "KASUR"
		replace dist_key = 14 if dist_nm == "KHANEWAL"
		replace dist_key = 15 if dist_nm == "KHUSHAB"
			 
		replace dist_key = 17 if dist_nm == "LAHORE"
		replace dist_key = 18 if dist_nm == "LAYYAH"
		replace dist_key = 19 if dist_nm == "LODHRAN"
		replace dist_key = 20 if dist_nm == "MANDI BAHUDDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "MUZAFFAR GARH"
		replace dist_key = 24 if dist_nm == "NAROWAL"
		replace dist_key = 25 if dist_nm == "OKARA"
		replace dist_key = 26 if dist_nm == "PAKPATTAN"
		replace dist_key = 27 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key = 28 if dist_nm == "RAJANPUR"
		replace dist_key = 29 if dist_nm == "RAWALPINDI"
		replace dist_key = 30 if dist_nm == "SAHIWAL"
		replace dist_key = 31 if dist_nm == "SARGODHA"
		replace dist_key = 32 if dist_nm == "SHEIKHUPURA"
		replace dist_key = 33 if dist_nm == "SIALKOT"
		replace dist_key = 34 if dist_nm == "T.T.SINGH"
		replace dist_key = 35 if dist_nm == "VEHARI"
		replace dist_key = 36 if dist_nm == "NANKANA SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 
				
		gen year = 2012
		
		la var dist_key "District-ID :Key"
		la var dist_nm "Clean: District Name"
		
		tempfile dist_2012
		save `dist_2012', replace

 
	
	* Villages:
	import excel "$aser_raw/2012/2tblVillages.xlsx", sheet("_3tblVillages") firstrow clear

	ren *, lower
	
	tempfile villages_2012
    save `villages_2012', replace
 
 
	
	* Village map survey:
	import excel "$aser_raw/2012/3VillageMapSurvey.xlsx", sheet("_4VillageMapSurvey") firstrow clear
	
	ren *, lower
	
	tempfile villagemap_2012
    save `villagemap_2012', replace
 
	
    /*
	** HH LEVEL DATASET:
	
	* Household:
	import excel "$rawdata/2012/4Household.xlsx", sheet("_4HouseholdSurvey_ALL__136_6_") firstrow clear
	
	* HH Child:
	import excel "$rawdata/2012/5tlbHHChild.xlsx", sheet("_5tlbHHChild") firstrow clear
	
	* Mother :
	import excel "$rawdata/2012/6Mother Data.xlsx", sheet("_6Mother_Data") firstrow clear
	
    */
	
	* Private schools data:
	
	import excel "$aser_raw/2012/7Pvt School.xlsx", sheet("DB") firstrow clear
	
	isid VillageMapSurveyId 
	ren VillageMapSurveyId villagemap_id
	count
	
	ren *, lower

	ren id school_id 
	
	
	****************************************************************************
	merge 1:1  villagemap_id using `villagemap_2012'
	keep if _merge ==3
	drop _merge 
	
	
	count 
	****************************************************************************
	merge 1:1 villageid using `villages_2012'

	keep if _merge ==3
	drop _merge 
	ren districtid districtsid
	
	
	merge m:m districtsid using `dist_2012'
	
	count
	keep if _merge ==3 
	
	
	* Saving the private School data:
	
	save "$aser_clean/ASER_PS_2012.dta", replace
	
	****************************************************************************
	
	* Government schools data:
	import excel "$aser_raw/2012/8Gov School.xlsx", sheet("DB") firstrow clear
	
	
	isid _VillageMapSurveyId 
	ren _VillageMapSurveyId villagemap_id
	count
	
	ren _*, lower
	ren _* *
	
	
	****************************************************************************
	merge 1:1  villagemap_id using `villagemap_2012'
	keep if _merge ==3
	drop _merge 
	
	
	count 
	

	****************************************************************************
	merge 1:1 villageid using `villages_2012'

	keep if _merge ==3
	drop _merge 
	ren districtid districtsid
	
	
	merge m:m districtsid using `dist_2012'
	count
	keep if _merge ==3 

	ren governmentschoolsurveyid gs_id
	* Saving the government School data:
	
	save "$aser_clean/ASER_GS_2012.dta", replace

	
	
********************************************************************************	
	* YEAR: 2013
********************************************************************************	
	

	
	* Province:
	import excel "$aser_raw/2013/0Province.xlsx", sheet("Province") firstrow clear
	
	
	
	* District:
	import excel "$aser_raw/2013/2District.xlsx", sheet("District") firstrow clear
	
	ren *, lower 
	ren name dist_nm
	sort provinceid dist_nm
	
	replace dist_nm = trim(dist_nm)
	ta dist_nm
	clean_lname dist_nm
	ta dist_nm

	ren id districtsid
	
	* keeping the districts in Punjab:
	keep if provinceid ==2

	
	* District Level Cleaning:
	
        gen dist_key = 1			 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER"
		replace dist_key = 3 if dist_nm == "BAHAWALPUR"
		replace dist_key = 4 if dist_nm == "BHAKKAR"
		replace dist_key = 5 if dist_nm == "CHAKWAL"
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"
		replace dist_key = 7 if dist_nm == "FAISALABAD"
		replace dist_key = 8 if dist_nm == "GUJRANWALA"
		replace dist_key = 9 if dist_nm == "GUJRAT"
		replace dist_key = 10 if dist_nm == "HAFIZABAD"
		replace dist_key = 11 if dist_nm == "JEHLUM"
		replace dist_key = 12 if dist_nm == "JHANG"
		replace dist_key = 13 if dist_nm == "KASUR"
		replace dist_key = 14 if dist_nm == "KHANEWAL"
		replace dist_key = 15 if dist_nm == "KHUSHAB"
			 
		replace dist_key = 17 if dist_nm == "LAHORE"
		replace dist_key = 18 if dist_nm == "LAYYAH"
		replace dist_key = 19 if dist_nm == "LODHRAN"
		replace dist_key = 20 if dist_nm == "MANDI BAHUDDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "MUZAFFAR GARH"
		replace dist_key = 24 if dist_nm == "NAROWAL"
		replace dist_key = 25 if dist_nm == "OKARA"
		replace dist_key = 26 if dist_nm == "PAKPATTAN"
		replace dist_key = 27 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key = 28 if dist_nm == "RAJANPUR"
		replace dist_key = 29 if dist_nm == "RAWALPINDI"
		replace dist_key = 30 if dist_nm == "SAHIWAL"
		replace dist_key = 31 if dist_nm == "SARGODHA"
		replace dist_key = 32 if dist_nm == "SHEIKHUPURA"
		replace dist_key = 33 if dist_nm == "SIALKOT"
		replace dist_key = 34 if dist_nm == "T.T.SINGH"
		replace dist_key = 35 if dist_nm == "VEHARI"
		replace dist_key = 36 if dist_nm == "NANKANA SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 
				
		gen year = 2013
		
		la var dist_key "District-ID :Key"
		la var dist_nm "Clean: District Name"
		
		tempfile dist_2013
		save `dist_2013', replace

 
	* Villages:
	import excel "$aser_raw/2013/2Village.xlsx", sheet("Village") firstrow clear
	ren *, lower
	
	ren id villageid
	
	tempfile villages_2013
    save `villages_2013', replace
 
 
	
	* Village map survey:
	
	import excel "$aser_raw/2013/3VillageMapSurvey.xlsx", sheet("VillageMapSurvey") firstrow clear
	
	ren *, lower
	ren id villagemap_id

	
	tempfile villagemap_2013
    save `villagemap_2013', replace
 
 
	
    /*
	** HH LEVEL DATASET:
	
	* Household:
	import excel "$rawdata/raw/2013/4HouseholdSurvey.xlsx", sheet("~Household") firstrow clear
	
	* HH Child:
	import excel "$rawdata/2013/5HouseholdChildInformation.xlsx", sheet("~child") firstrow clear
	
	* Mother :	
	import excel "$rawdata/2013/6HouseholdParentEducationLevel.xlsx", sheet("mother") firstrow clear
    */
	

	
	
	
	* Private schools data:
	import excel "$aser_raw/2013/8PrivateSchool.xlsx", sheet("~Pvt_school") firstrow clear
	
	isid VillageMapSurveyId 
	ren VillageMapSurveyId villagemap_id
	count
	
	ren schoolId school_id
	
	ren *, lower
	
	
	
	
	****************************************************************************
	merge 1:1  villagemap_id using `villagemap_2013'
	keep if _merge ==3
	drop _merge 
	
	
	count 
	
	****************************************************************************
	merge 1:1 villageid using `villages_2013'

	keep if _merge ==3
	drop _merge 
	ren districtid districtsid
	
	merge m:m districtsid using `dist_2013'
	
	count
	keep if _merge ==3 
	
	* Saving the private School data:
	
	save "$aser_clean/ASER_PS_2013.dta", replace
	
	
	****************************************************************************
	
	* Government schools data:	
	import excel "$aser_raw/2013/7Govt School.xlsx", sheet("Govt_school") firstrow clear
	
	
	isid VillageMapSurveyId 
	ren VillageMapSurveyId villagemap_id
	count
	
	ren *, lower
	
	
	
	****************************************************************************
	merge 1:1  villagemap_id using `villagemap_2013'
	keep if _merge ==3
	drop _merge 
	
	
	count 
	

	****************************************************************************
	merge 1:1 villageid using `villages_2013'

	keep if _merge ==3
	drop _merge 
	ren districtid districtsid
	
	
	merge m:m districtsid using `dist_2013'
	count
	keep if _merge ==3 

	ren govtid gs_id 
	
	* Saving the government School data:
	
	save "$aser_clean/ASER_GS_2013.dta", replace

	
	
********************************************************************************	
	* YEAR: 2014
********************************************************************************	


	
	* Province:	
	import delimited "$aser_raw/2014/0Province.csv", encoding(ISO-8859-1)clear
	
	* District:
	import delimited "$aser_raw/2014/1District.csv", encoding(ISO-8859-1) clear
	
	ren *, lower 
	ren name dist_nm
	sort provinceid dist_nm
	
	replace dist_nm = trim(dist_nm)
	ta dist_nm
	clean_lname dist_nm
	ta dist_nm

	ren id districtsid
	
	* keeping the districts in Punjab:
	keep if provinceid ==2

	
	* District Level Cleaning:
	
        gen dist_key = 1			 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER"
		replace dist_key = 3 if dist_nm == "BAHAWALPUR"
		replace dist_key = 4 if dist_nm == "BHAKKAR"
		replace dist_key = 5 if dist_nm == "CHAKWAL"
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"
		replace dist_key = 7 if dist_nm == "FAISALABAD"
		replace dist_key = 8 if dist_nm == "GUJRANWALA"
		replace dist_key = 9 if dist_nm == "GUJRAT"
		replace dist_key = 10 if dist_nm == "HAFIZABAD"
		replace dist_key = 11 if dist_nm == "JEHLUM"
		replace dist_key = 12 if dist_nm == "JHANG"
		replace dist_key = 13 if dist_nm == "KASUR"
		replace dist_key = 14 if dist_nm == "KHANEWAL"
		replace dist_key = 15 if dist_nm == "KHUSHAB"
			 
		replace dist_key = 17 if dist_nm == "LAHORE"
		replace dist_key = 18 if dist_nm == "LAYYAH"
		replace dist_key = 19 if dist_nm == "LODHRAN"
		replace dist_key = 20 if dist_nm == "MANDI BAHUDDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "MUZAFFAR GARH"
		replace dist_key = 24 if dist_nm == "NAROWAL"
		replace dist_key = 25 if dist_nm == "OKARA"
		replace dist_key = 26 if dist_nm == "PAKPATTAN"
		replace dist_key = 27 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key = 28 if dist_nm == "RAJANPUR"
		replace dist_key = 29 if dist_nm == "RAWALPINDI"
		replace dist_key = 30 if dist_nm == "SAHIWAL"
		replace dist_key = 31 if dist_nm == "SARGODHA"
		replace dist_key = 32 if dist_nm == "SHEIKHUPURA"
		replace dist_key = 33 if dist_nm == "SIALKOT"
		replace dist_key = 34 if dist_nm == "T.T.SINGH"
		replace dist_key = 35 if dist_nm == "VEHARI"
		replace dist_key = 36 if dist_nm == "NANKANA SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 
				
		gen year = 2014
		
		la var dist_key "District-ID :Key"
		la var dist_nm "Clean: District Name"
		
		tempfile dist_2014
		save `dist_2014', replace


   	* Villages:

	import delimited "$aser_raw/2014/2Village.csv", encoding(ISO-8859-1)clear
	ren *, lower
	ren id villageid
	
	tempfile villages_2014
    save `villages_2014', replace
 
 
	
	* Village map survey:
	
	import delimited "$aser_raw/2014/3VillageMapSurvey.csv", encoding(ISO-8859-1)clear
		
	ren *, lower
	ren id villagemap_id

	
	tempfile villagemap_2014
    save `villagemap_2014', replace
 	
    /*
	** HH LEVEL DATASET:
	
	* Household:
	import delimited "$rawdata/2014/4HouseholdSurvey.csv", encoding(ISO-8859-1)clear
	
	* HH Child:
	import delimited "$rawdata/2014/5HouseholdChildInformation.csv", encoding(ISO-8859-1)clear
	
	* Mother :	
	import delimited "$rawdata/2014/6HouseholdParentEducationLevel.csv", encoding(ISO-8859-1)clear
	
	
    */
		
	* Private schools data:
	
	import delimited "$aser_raw/2014/8PrivateSchool.csv", encoding(ISO-8859-1)clear
	isid villagemapsurveyid
	
	ren villagemapsurveyid villagemap_id
	count

	ren schoolid school_id
	ren *, lower
	
	
	****************************************************************************
	merge 1:1  villagemap_id using `villagemap_2014'
	keep if _merge ==3
	drop _merge 
	
	
	count 
	
	****************************************************************************
	merge 1:1 villageid using `villages_2014'

	keep if _merge ==3
	drop _merge 
	ren districtid districtsid
	
	merge m:m districtsid using `dist_2014'
	
	count
	keep if _merge ==3 
	
	* Saving the private School data:
	
	save "$aser_clean/ASER_PS_2014.dta", replace
	

	****************************************************************************
	
	* Government schools data:
	
	import delimited "$aser_raw/2014/7GovtSchool.csv", encoding(ISO-8859-1)clear
	
	isid villagemapsurveyid 
	ren villagemapsurveyid villagemap_id
	count
	
	ren *, lower
	
	
	****************************************************************************
	merge 1:1  villagemap_id using `villagemap_2014'
	keep if _merge ==3
	drop _merge 
	
	
	count 
	

	****************************************************************************
	merge 1:1 villageid using `villages_2014'

	keep if _merge ==3
	drop _merge 
	ren districtid districtsid
	
	
	merge m:m districtsid using `dist_2014'
	count
	keep if _merge ==3 

	ren govtid gs_id
	
	* Saving the government School data:
	save "$aser_clean/ASER_GS_2014.dta", replace

  
 	
********************************************************************************	
	* YEAR: 2015
********************************************************************************	

	
     * Village Map Survey:
	 	
	import delimited "$aser_raw/2015/1VillageMapSurvey.csv", encoding(ISO-8859-1)clear
	
	ren *, lower 
	ren districtname dist_nm
	sort provincecode dist_nm
	
	replace dist_nm = trim(dist_nm)
	ta dist_nm
	clean_lname dist_nm
	ta dist_nm

		
	* keeping the districts in Punjab:
	keep if provincecode ==1

	
	* District Level Cleaning:
	
        gen dist_key = 1			 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER"
		replace dist_key = 3 if dist_nm == "BAHAWALPUR"
		replace dist_key = 4 if dist_nm == "BHAKKAR"
		replace dist_key = 5 if dist_nm == "CHAKWAL"
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"
		replace dist_key = 7 if dist_nm == "FAISALABAD"
		replace dist_key = 8 if dist_nm == "GUJRANWALA"
		replace dist_key = 9 if dist_nm == "GUJRAT"
		replace dist_key = 10 if dist_nm == "HAFIZABAD"
		replace dist_key = 11 if dist_nm == "JEHLUM"
		replace dist_key = 12 if dist_nm == "JHANG"
		replace dist_key = 13 if dist_nm == "KASUR"
		replace dist_key = 14 if dist_nm == "KHANEWAL"
		replace dist_key = 15 if dist_nm == "KHUSHAB"
			 
		replace dist_key = 17 if dist_nm == "LAHORE"
		replace dist_key = 18 if dist_nm == "LAYYAH"
		replace dist_key = 19 if dist_nm == "LODHRAN"
		replace dist_key = 20 if dist_nm == "MANDI BAHUDDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "MUZAFFAR GARH"
		replace dist_key = 24 if dist_nm == "NAROWAL"
		replace dist_key = 25 if dist_nm == "OKARA"
		replace dist_key = 26 if dist_nm == "PAKPATTAN"
		replace dist_key = 27 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key = 28 if dist_nm == "RAJANPUR"
		replace dist_key = 29 if dist_nm == "RAWALPINDI"
		replace dist_key = 30 if dist_nm == "SAHIWAL"
		replace dist_key = 31 if dist_nm == "SARGODHA"
		replace dist_key = 32 if dist_nm == "SHEIKHUPURA"
		replace dist_key = 33 if dist_nm == "SIALKOT"
		replace dist_key = 34 if dist_nm == "T.T.SINGH"
		replace dist_key = 35 if dist_nm == "VEHARI"
		replace dist_key = 36 if dist_nm == "NANKANA SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 
				
		gen year = 2015
		
		la var dist_key "District-ID :Key"
		la var dist_nm "Clean: District Name"
		
		tempfile dist_2015
		save `dist_2015', replace


		/*
		** HH data:
		
		* HH Survey:
		import delimited "$rawdata/2015/2HouseholdSurvey.csv", encoding(ISO-8859-1)clear
		
		* Child:
		import delimited "$rawdata/2015/5ChildDisabilityData.csv", encoding(ISO-8859-1)clear
		*/
		
		* Private School: 
		import delimited "$aser_raw/2015/4PrivateSchool.csv", encoding(ISO-8859-1)clear

		ren schoolid school_id 
		
 		merge 1:1 villagemapsurveyid using `dist_2015'
		keep if _merge ==3
		drop _merge
		

	    * Saving the private School data:
	    save "$aser_clean/ASER_PS_2015.dta", replace
		
********************************************************************************
		
		* Government School:
		import delimited "$aser_raw/2015/3GovtSchool.csv", encoding(ISO-8859-1)clear
		
				
 		merge 1:1 villagemapsurveyid using `dist_2015'
		keep if _merge ==3
		drop _merge

		ren govtid gs_id
		
	    * Saving the government School data:
	    save "$aser_clean/ASER_GS_2015.dta", replace

		
********************************************************************************	
	* YEAR: 2016
********************************************************************************	
	
	* District:
	import delimited "$aser_raw/2016/ITAASER2016ProvDist.csv", encoding(ISO-8859-1)clear
		
	ren *, lower 
	ren dname dist_nm
	sort rid dist_nm
	
	replace dist_nm = trim(dist_nm)
	ta dist_nm
	clean_lname dist_nm
	ta dist_nm

		
	* keeping the districts in Punjab:
	keep if rid ==2

	
	* District Level Cleaning:
	
        gen dist_key = 1			 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER"
		replace dist_key = 3 if dist_nm == "BAHAWALPUR"
		replace dist_key = 4 if dist_nm == "BHAKKAR"
		replace dist_key = 5 if dist_nm == "CHAKWAL"
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"
		replace dist_key = 7 if dist_nm == "FAISALABAD"
		replace dist_key = 8 if dist_nm == "GUJRANWALA"
		replace dist_key = 9 if dist_nm == "GUJRAT"
		replace dist_key = 10 if dist_nm == "HAFIZABAD"
		replace dist_key = 11 if dist_nm == "JEHLUM"
		replace dist_key = 12 if dist_nm == "JHANG"
		replace dist_key = 13 if dist_nm == "KASUR"
		replace dist_key = 14 if dist_nm == "KHANEWAL"
		replace dist_key = 15 if dist_nm == "KHUSHAB"
			 
		replace dist_key = 17 if dist_nm == "LAHORE"
		replace dist_key = 18 if dist_nm == "LAYYAH"
		replace dist_key = 19 if dist_nm == "LODHRAN"
		replace dist_key = 20 if dist_nm == "MANDI BAHUDDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "MUZAFFAR GARH"
		replace dist_key = 24 if dist_nm == "NAROWAL"
		replace dist_key = 25 if dist_nm == "OKARA"
		replace dist_key = 26 if dist_nm == "PAKPATTAN"
		replace dist_key = 27 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key = 28 if dist_nm == "RAJANPUR"
		replace dist_key = 29 if dist_nm == "RAWALPINDI"
		replace dist_key = 30 if dist_nm == "SAHIWAL"
		replace dist_key = 31 if dist_nm == "SARGODHA"
		replace dist_key = 32 if dist_nm == "SHEIKHUPURA"
		replace dist_key = 33 if dist_nm == "SIALKOT"
		replace dist_key = 34 if dist_nm == "T.T.SINGH"
		replace dist_key = 35 if dist_nm == "VEHARI"
		replace dist_key = 36 if dist_nm == "NANKANA SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 
				
		gen year = 2016
		
		la var dist_key "District-ID :Key"
		la var dist_nm "Clean: District Name"
		
		tempfile dist_2016
		save `dist_2016', replace

		
			
		* Village Map Survey:
		
		import delimited "$aser_raw/2016/ITAASER2016VMSurvey.csv", encoding(ISO-8859-1)clear	
		ren *, lower
		ren vid villagemapsurveyid 
			
		
		tempfile vms_2016
		save `vms_2016', replace

		
		
		/*		
		** HH Data:
		
		* HH:
		import delimited "$rawdata/2016/ITAASER2016HouseholdIndicators.csv", encoding(ISO-8859-1)clear
		

		* Health:
		import delimited "$rawdata/2016/ITAASER2016HealthFunctioning.csv", encoding(ISO-8859-1)clear
		
		
		* Child:
		import delimited "$rawdata/2016/ITAASER2016Child.csv", encoding(ISO-8859-1)clear
		
		
		* Parent:
		import delimited "$rawdata/2016/ITAASER2016Parent.csv", encoding(ISO-8859-1)clear

		*/
		
	
		
		* Private School data:	
		import delimited "$aser_raw/2016/ITAASER2016PSchool.csv", encoding(ISO-8859-1)clear
		
		ren psid school_id
		ren vid villagemapsurveyid 

		gen total_enrollment = ps007e
		gen total_attendance = ps007p
		
		merge 1:1 villagemapsurveyid using `vms_2016'
		keep if _merge ==3 
		drop _merge
		
		merge m:m did using `dist_2016'
		
		keep if _merge ==3
		drop _merge
		
	    * Saving the private School data:
	    save "$aser_clean/ASER_PS_2016.dta", replace	
	
********************************************************************************	
     
	 
	    * Government School data:
		
		import delimited "$aser_raw/2016/ITAASER2016GSchool.csv", encoding(ISO-8859-1)clear
		
		ren gsid gs_id 
		ren vid villagemapsurveyid 

	    gen total_enrollment = gs007e
		gen total_attendance = gs007p

		merge 1:1 villagemapsurveyid using `vms_2016'
		keep if _merge ==3 
		drop _merge
		
		merge m:m did using `dist_2016'
		
		keep if _merge ==3
		drop _merge
		
	    * Saving the govt School data:
	    save "$aser_clean/ASER_GS_2016.dta", replace	

	
*/


********************************************************************************	
	* YEAR: 2018
********************************************************************************	


	* VM:
	import excel "$aser_raw/2018/ITAASER2018VMSurvey.xlsx", sheet("Exported_Village_MAP") firstrow clear

	
	ren *, lower 
	ren dname dist_nm
	sort rid dist_nm
	
	replace dist_nm = trim(dist_nm)
	ta dist_nm
	clean_lname dist_nm
	ta dist_nm

		
	* keeping the districts in Punjab:
	keep if rid ==1

	ta dist_nm
	
	* District Level Cleaning:
	
        gen dist_key = 1			 
		replace dist_key = 1 if dist_nm == "ATTOCK"		 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER"
		replace dist_key = 3 if dist_nm == "BAHAWALPUR"
		replace dist_key = 4 if dist_nm == "BHAKKAR"
		replace dist_key = 5 if dist_nm == "CHAKWAL"
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"
		replace dist_key = 7 if dist_nm == "FAISALABAD"
		replace dist_key = 8 if dist_nm == "GUJRANWALA"
		replace dist_key = 9 if dist_nm == "GUJRAT"
		replace dist_key = 10 if dist_nm == "HAFIZABAD"
		replace dist_key = 11 if dist_nm == "JEHLUM"
		replace dist_key = 12 if dist_nm == "JHANG"
		replace dist_key = 13 if dist_nm == "KASUR"
		replace dist_key = 14 if dist_nm == "KHANEWAL"
		replace dist_key = 15 if dist_nm == "KHUSHAB"
			 
		replace dist_key = 17 if dist_nm == "LAHORE"
		replace dist_key = 18 if dist_nm == "LAYYAH"
		replace dist_key = 19 if dist_nm == "LODHRAN"
		replace dist_key = 20 if dist_nm == "MANDI BAHUDDIN"
		replace dist_key = 21 if dist_nm == "MIANWALI"
		replace dist_key = 22 if dist_nm == "MULTAN"
		replace dist_key = 23 if dist_nm == "MUZAFFAR GARH"
		replace dist_key = 24 if dist_nm == "NAROWAL"
		replace dist_key = 25 if dist_nm == "OKARA"
		replace dist_key = 26 if dist_nm == "PAKPATTAN"
		replace dist_key = 27 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key = 28 if dist_nm == "RAJANPUR"
		replace dist_key = 29 if dist_nm == "RAWALPINDI"
		replace dist_key = 30 if dist_nm == "SAHIWAL"
		replace dist_key = 31 if dist_nm == "SARGODHA"
		replace dist_key = 32 if dist_nm == "SHEIKHUPURA"
		replace dist_key = 33 if dist_nm == "SIALKOT"
		replace dist_key = 34 if dist_nm == "T.T.SINGH"
		replace dist_key = 35 if dist_nm == "VEHARI"
		replace dist_key = 36 if dist_nm == "NANKANA SAHIB"
        replace dist_key = 37 if dist_nm == "CHINIOT" 
				
		gen year = 2018
		
		la var dist_key "District-ID :Key"
		la var dist_nm "Clean: District Name"
		
		tempfile vms_2018
		save `vms_2018', replace

		
		/*		
		** HH Data:
				
		* Child:
		import excel "$rawdata/2018/ITAASER2018Child.xlsx", sheet("Ch_HH_VMAP") firstrow clear

		* Child Health:
		import excel "$rawdata/2018/ITAASER2018Health&Functioning.xlsx", sheet("Ch_HH_VMAP") firstrow clear

		* HH:
		import excel "$rawdata/2018/ITAASER2018HOUSEHOLD.xlsx", sheet("Household_VMAP") firstrow clear

		* Parent:
		import excel "$rawdata/2018/ITAASER2018PARENT.xlsx", sheet("Parent_HH_VMAP") firstrow clear


		*/
		
	
		
		* Private School data:	
        import excel "$aser_raw/2018/ITAASER2018PSchool.xlsx", sheet("Sheet1") firstrow clear		
		
		ren *, lower
		
		isid vid
		
		
		ren psid school_id
		
		gen total_enrollment = ps007e
		gen total_attendance = ps007p
		
		merge 1:1 vid using `vms_2018'	
		keep if _merge ==3 
		drop _merge
		
		
	    * Saving the private School data:
	    save "$aser_clean/ASER_PS_2018.dta", replace	
	
	
********************************************************************************	
     
	 
	    * Government School data:
		
        import excel "$aser_raw/2018/ITAASER2018GSchool.xlsx", sheet("GS_VMAP") firstrow clear
		
		ren *, lower
		
		ren gsid gs_id 
		 

	    gen total_enrollment = gs007e
		gen total_attendance = gs007p

		merge 1:1 vid using `vms_2018'
		keep if _merge ==3 
		drop _merge
		
		
		
	    * Saving the govt School data:
	    save "$aser_clean/ASER_GS_2018.dta", replace	



		
	
    	ex
	
	
	
