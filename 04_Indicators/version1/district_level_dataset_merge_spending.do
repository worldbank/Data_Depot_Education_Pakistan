
* DATASETS: ASER, MICS, PSLM 
* Author: Koen Geven & Ahmed Raza
* Date: 3rd December, 2019 
* Purpose: To merge district-level dataset with the spending data.
* Version: 1



clear all
set more off

		* Dropbox Globals
		
	    include init.do
	 
		gl panel "$output\Panel"
		gl pe "$output\Point_Estimates" 
	
        * include programs do file for Point Estimates
	    include pe_program.do
		
********************************************************************************		

	use "$pe\spendingdata\final_students_spendingdb.dta", clear

     
	* province:
	
	ren province prov
	
	fre prov
	
	gen province = 1 if prov ==4
	replace province =2 if prov ==5
	replace province =3 if prov ==1
	replace province =4 if prov ==3
	replace province =0 if prov ==2
	
	la def prov 0 "OTHER AREAS" 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP"   
	la val province prov
	la var province "Province"
	fre province
	

	* district:
	
    clean_lname district
   
    ren district dist_nm
	
	
   * District Level Cleaning: Setting up dist_key in spending data. 
	
	* Punjab

        gen dist_key = .	
		replace dist_key = 1 if dist_nm == "ATTOCK"	 & province ==1
		replace dist_key = 2 if dist_nm == "BAHAWALNAGAR" & province ==1
		replace dist_key = 3 if dist_nm == "BAHAWALPUR" & province ==1
		replace dist_key = 4 if dist_nm == "BHAKKAR"  & province ==1
		replace dist_key = 5 if dist_nm == "CHAKWAL"  & province ==1
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"  & province ==1
		replace dist_key = 7 if dist_nm == "FAISALABAD"  & province ==1
		replace dist_key = 8 if dist_nm == "GUJRANWALA"  & province ==1
		replace dist_key = 9 if dist_nm == "GUJRAT"  & province ==1
		replace dist_key = 10 if dist_nm == "HAFIZABAD"  & province ==1
		replace dist_key = 11 if dist_nm == "JHELUM"  & province ==1
		replace dist_key = 12 if dist_nm == "JHANG"  & province ==1
		replace dist_key = 13 if dist_nm == "KASUR"  & province ==1
		replace dist_key = 14 if dist_nm == "KHANEWAL"  & province ==1
		replace dist_key = 15 if dist_nm == "KHUSHAB"  & province ==1
			 
		replace dist_key = 16 if dist_nm == "LAHORE"  & province ==1
		replace dist_key = 17 if dist_nm == "LAYYAH"  & province ==1
		replace dist_key = 18 if dist_nm == "LODHRAN"  & province ==1
		replace dist_key = 19 if dist_nm == "MANDI BAHAUDDIN"  & province ==1
		replace dist_key = 20 if dist_nm == "MIANWALI"  & province ==1
		replace dist_key = 21 if dist_nm == "MULTAN"  & province ==1
		replace dist_key = 22 if dist_nm == "MUZAFFARGARH"  & province ==1
		replace dist_key = 23 if dist_nm == "NAROWAL"  & province ==1
		replace dist_key = 24 if dist_nm == "OKARA"  & province ==1
		replace dist_key = 25 if dist_nm == "PAKPATTAN"  & province ==1
		replace dist_key = 26 if dist_nm == "RAHIM YAR KHAN"  & province ==1
		replace dist_key = 27 if dist_nm == "RAJANPUR"  & province ==1
		replace dist_key = 28 if dist_nm == "RAWALPINDI"  & province ==1
		replace dist_key = 29 if dist_nm == "SAHIWAL"  & province ==1
		replace dist_key = 30 if dist_nm == "SARGODHA"  & province ==1
		replace dist_key = 31 if dist_nm == "SHEIKHUPURA"  & province ==1
		replace dist_key = 32 if dist_nm == "SIALKOT"  & province ==1
		replace dist_key = 33 if dist_nm == "TOBA TEK SINGH"  & province ==1
		replace dist_key = 34 if dist_nm == "VEHARI"  & province ==1
		replace dist_key = 35 if dist_nm == "NANKANA SAHIB"  & province ==1
        replace dist_key = 36 if dist_nm == "CHINIOT"  & province ==1
			
			

				
		ta dist_nm if dist_key ==. & province==1
	    ta dist_key if province ==1

		
		
		***********************************************************************
		
		
		*KP:
		
        ta dist_nm if province ==4
		
  
		 replace dist_key = 37 if dist_nm == "ABBOTTABAD" & province ==4 
 		 replace dist_key = 38 if dist_nm == "BANNU" & province ==4
		 replace dist_key = 39 if dist_nm == "BATAGRAM" & province ==4
		 replace dist_key = 40 if dist_nm == "BUNER" & province ==4
		 replace dist_key = 41 if dist_nm == "CHARSADDA" & province ==4
		 replace dist_key = 42 if dist_nm == "CHITRAL" & province ==4
		 replace dist_key = 43 if dist_nm == "DERA ISMAIL KHAN" & province ==4
		 replace dist_key = 44 if dist_nm == "HANGU" & province ==4
		 replace dist_key = 45 if dist_nm == "HARIPUR" & province ==4
		 replace dist_key = 46 if dist_nm == "KARAK" & province ==4
		 replace dist_key = 47 if dist_nm == "KOHAT" & province ==4
		 replace dist_key = 48 if dist_nm == "KOHISTAN" & province ==4
		 replace dist_key = 49 if dist_nm == "LAKKI MARWAT" & province ==4
		 replace dist_key = 50 if dist_nm == "LOWER DIR" & province ==4
		 replace dist_key = 51 if dist_nm == "MALAKAND" & province ==4
		 replace dist_key = 52 if dist_nm == "MANSEHRA" & province ==4
		 replace dist_key = 53 if dist_nm == "MARDAN" & province ==4
		 replace dist_key = 54 if dist_nm == "NOWSHERA" & province ==4
		 
		 replace dist_key = 55 if dist_nm == "PESHAWAR" & province ==4
		 replace dist_key = 56 if dist_nm == "SHANGLA" & province ==4
		 replace dist_key = 57 if dist_nm == "SWABI" & province ==4
		 replace dist_key = 58 if dist_nm == "SWAT" & province ==4
		 replace dist_key = 59 if dist_nm == "TANK" & province ==4
		 replace dist_key = 60 if dist_nm == "TOR GHAR" & province ==4
		 replace dist_key = 61 if dist_nm == "UPPER DIR" & province ==4
	
		 ta dist_nm if dist_key ==. & province==4
		 ta dist_key if province ==4

		 
		 ***********************************************************************

		 		 
		 * Sindh:
		 
		 
		 ta dist_nm if province ==2
	 
	  
		 replace dist_key = 62 if dist_nm == "BADIN" & province ==2 
 		 replace dist_key = 63 if dist_nm == "DADU" & province ==2
		 replace dist_key = 64 if dist_nm == "GHOTKI" & province ==2
		 replace dist_key = 65 if dist_nm == "HYDERABAD" & province ==2
		 replace dist_key = 66 if dist_nm == "JACOBABAD" & province ==2
		 replace dist_key = 67 if dist_nm == "JAMSHORO" & province ==2
		 
		 replace dist_key = 68 if dist_nm == "KARACHI CITY" & province ==2
		 replace dist_key = 69 if dist_nm == "KASHMORE" & province ==2
		 replace dist_key = 70 if dist_nm == "KHAIRPUR" & province ==2
		 replace dist_key = 71 if dist_nm == "LARKANA" & province ==2
		 replace dist_key = 72  if dist_nm == "MATIARI" & province ==2
		 
		 
		 replace dist_key = 73 if dist_nm == "MIRPUR KHAS" & province ==2
		 replace dist_key = 74 if dist_nm == "NAUSHAHRO FEROZE" & province ==2
		 replace dist_key = 75 if dist_nm == "SANGHAR" & province ==2
		 replace dist_key = 76 if dist_nm == "QAMBAR SHAHDADKOT" & province ==2
		 replace dist_key = 77 if dist_nm == "SHAHEED BENAZIRABAD" & province ==2
		 replace dist_key = 78 if dist_nm == "SHIKARPUR" & province ==2
		 
		 replace dist_key = 79 if dist_nm == "SAJAWAL" & province ==2
		 replace dist_key = 80 if dist_nm == "SUKKUR" & province ==2 
		 replace dist_key = 81 if dist_nm == "TANDO ALLAH YAR" & province ==2
		 replace dist_key = 82 if dist_nm == "TANDO MUHAMMAD KHAN" & province ==2
		 replace dist_key = 83 if dist_nm == "THARPARKAR" & province ==2
		 replace dist_key = 84 if dist_nm == "TANK" & province ==2
		 replace dist_key = 85 if dist_nm == "THATTA" & province ==2
		 replace dist_key = 86 if dist_nm == "UMERKOT" & province ==2
		 
		 replace dist_key = 87 if dist_nm == "MITHI" & province ==2

		 ta dist_nm if dist_key ==. & province==2

		 
		 ta dist_key if province ==2
		
		
		
	 **************************************************************************

		 * BALOCHISTAN:
		 
	    ta dist_nm if province ==3
		
		
		replace dist_key = 88 if dist_nm == "AWARAN" & province ==3
 		replace dist_key = 89 if dist_nm == "BARKHAN" & province ==3
		replace dist_key = 90 if dist_nm == "BOLAN" & province ==3
		replace dist_key = 91 if dist_nm == "CHAGAI" & province ==3
		replace dist_key = 92 if dist_nm == "DERA BUGTI" & province ==3
	    replace dist_key = 93 if dist_nm == "GWADAR" & province ==3
		 
		replace dist_key = 94 if dist_nm == "HARNAI" & province ==3
		replace dist_key = 95 if dist_nm == "JAFFARABAD" & province ==3
		replace dist_key = 96 if dist_nm == "JHAL MAGSI" & province ==3
		replace dist_key = 97 if dist_nm == "KALAT" & province ==3
		replace dist_key = 98 if dist_nm == "KHARAN" & province ==3
		replace dist_key = 99  if dist_nm == "KHUZDAR" & province ==3
		 
		 
		replace dist_key = 100 if dist_nm == "KILLA ABDULLAH" & province ==3
		replace dist_key = 101 if dist_nm == "KILLA SAIFULLAH" & province ==3
		replace dist_key = 102 if dist_nm == "KOHLU" & province ==3
		replace dist_key = 103 if dist_nm == "LAS BELA" & province ==3
		replace dist_key = 104 if dist_nm == "LORALAI" & province ==3
		replace dist_key = 105 if dist_nm == "MASTUNG" & province ==3
		 
		replace dist_key = 106 if dist_nm == "MUSAKHEL" & province ==3
		replace dist_key = 107 if dist_nm == "NASIRABAD" & province ==3
		replace dist_key = 108 if dist_nm == "NUSHKI" & province ==3
		replace dist_key = 109 if dist_nm == "PISHIN" & province ==3
		replace dist_key = 110 if dist_nm == "QUETTA" & province ==3
		replace dist_key = 111 if dist_nm == "SHEERANI" & province ==3
		replace dist_key = 112 if dist_nm == "SIBI" & province ==3
		 
		replace dist_key = 113 if dist_nm == "WASHUK" & province ==3

		 
		replace dist_key = 114 if dist_nm == "ZHOB" & province ==3
		replace dist_key = 115 if dist_nm == "ZIARAT" & province ==3
		 
		 
		 	 
		replace dist_key = 116 if dist_nm == "DUKI" & province ==3
		replace dist_key = 117 if dist_nm == "LEHRI" & prov ==3	 
		replace dist_key = 118 if dist_nm == "KECH" & province ==3
		replace dist_key = 119 if dist_nm == "PANJGUR" & province ==3	 
		
	    replace dist_key = 120 if dist_nm == "SOHBATPUR" & province ==3
		replace dist_key = 121 if dist_nm == "SURAB" & province ==3
		 
		 
		 
		ta dist_nm if dist_key ==. & province==3
		ta dist_key if province ==3

	    ta dist_nm if province ==3

		 
		 
		 ***********************************************************************
		  
		  * OTHER AREAS
		  
		replace dist_key = 139 if dist_nm == "ISLAMABAD" & province ==0
		  
		 
		ta dist_nm if dist_key ==. & province==0
		ta dist_key if province ==0

	    ta dist_nm if province ==0


        ***********************************************************************
 				
		ta dist_key
		isid dist_key
	    
		
		drop prov
		
		tempfile spending
		save `spending', replace
		
		
	   * Merging with the district level dataset:

	   use "$pe\DD_Pak_pe_district_version1.1.dta", clear
	   
	   isid dist_key year dataset
	   
	 

	   
	   merge m:1 dist_key using `spending'
		
		
			
	   order province dist_key dist_nm year dataset 	
	   
	   la var _merge "Merge with Spending Data"
			
			
	   ************************************************************************
	   
	   	save "$pe\DD_Pak_pe_district_with_spending_indicators_version1.1.dta", replace


	   		
	   exit
	   
			