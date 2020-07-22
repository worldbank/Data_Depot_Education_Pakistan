* Author: Ahmed Raza
* Date: 5th Feburary 2020
* Purpose: To clean DHS HH level data cleaning 


		* Dropbox Globals
		
        include init.do	

********************************************************************************
        * 2012 - HH-level Dataset:
********************************************************************************	

		* Get the district codes :


		use "$dhs_raw\2012\district_codes_2012.dta", clear
		ren*, lower

		duplicates drop shdist, force

		save "$dhs_raw\2012\dc_clean.dta", replace


********************************************************************************	

		use "$dhs_raw\2012\PKPR61FL.DTA", clear


		isid hv001 hv002 hvidx

		* Education Vars:

		* in school ever:
		clonevar hg = hv108
		recode hg (98=.)(99=.)
		fre hg


		gen in_school_ever = 0 if hg ==0
		replace in_school_ever =1 if hg != 0 & hg !=.

		ta hg in_school_ever 
		replace hg = . if in_school_ever ==0
		ta  hg in_school_ever
				

				
				

		* hv121

		clonevar cg = hv124
		recode cg (98=.) (99=.)

		* gen in_school = 0 if cg ==0
		* replace in_school = 1 if cg != 0 & cg !=.

		gen in_school = 1 if hv121 ==2
		replace in_school = 0 if hv121 ==0

		ta cg in_school 
		replace cg = . if in_school ==0
		ta cg in_school 


********************************************************************************	

		ta in_school_ever 
		ta in_school
		ta in_school_ever in_school

		ta cg if in_school_ever ==0 & in_school ==1
		ta hg if in_school_ever ==0 & in_school ==1
			
			
		/*

		- DATA ERRORS:

			 
		ta cg if in_school_ever ==0 & in_school ==1

		Education in |
		single years |
		   - current |
		 school year |      Freq.     Percent        Cum.
		-------------+-----------------------------------
				   0 |      1,847       37.58       37.58
				   1 |      3,056       62.18       99.76
				   2 |          9        0.18       99.94
				   5 |          1        0.02       99.96
				   6 |          1        0.02       99.98
				  10 |          1        0.02      100.00
		-------------+-----------------------------------
			   Total |      4,915      100.00

		. ta hg if in_school_ever ==0 & in_school ==1

		*/
				
			

		* generate tag to flag and fix the error:
		gen x = 1 if in_school_ever ==0 & in_school ==1



		replace in_school_ever = 1 if x ==1
		replace hg = cg if x==1

		ta in_school_ever in_school


		gen education_status =1 if in_school ==1
		replace education_status =2 if in_school ==0 & in_school_ever ==1
		replace education_status =3 if in_school_ever == 0 


		la def es 1 "Child in school" 2 "Child dropped out" 3 "Child never enrolled"
		la val education_status es
		fre education_status


		* highest_grade:

		fre hg

		clonevar highest_grade = hg

		replace highest_grade = 11 if hg ==12
		replace highest_grade = 12 if hg >12 & hg !=.

		la def educ 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "FA/FSc/Diplomas" 12 "Bachelors or Higher"
		la val highest_grade educ

		fre highest_grade
		ren hg highest_grade_dhs


		* current_grade:

		clonevar current_grade = cg

		replace current_grade = 11 if cg ==12
		replace current_grade = 12 if cg >12 & cg !=.

		la val current_grade educ
		fre current_grade

		ren cg current_grade_dhs

		* Sex

		clonevar sex = hv104

		gen female = 1 if sex ==2
		replace female =0 if sex ==1
		la var female "Female Dummy"


		* Age

		clonevar age = hv105
		recode age (98 =.) (99=.)


		* HH Education level:

		* HH-Head:

		preserve

		* keep only HH head:

		keep if hv101 ==1

		fre highest_grade
		fre highest_grade_dhs

		gen es_head = 1 if highest_grade>= 0 & highest_grade <=5
		replace es_head =2 if highest_grade>=6 & highest_grade<=8
		replace es_head =3 if highest_grade>=9 & highest_grade<=10
		replace es_head =4 if highest_grade ==11
		replace es_head =5  if highest_grade >=12 & highest_grade !=.


		la def hh_educ_status 1 "Primary (1-5)" 2 "Secondary (6-8)"	3 "Higher Secondary (9-10)" 4 "FA/FSc/Diploma" 5 "Bachelors or Higher Education"	
		la val es_head hh_educ_status


		isid hv001 hv002 hvidx

		keep hv001 hv002 hvidx es_head

		tempfile hh_head
		save `hh_head', replace

		restore


		* Mothers educ:

		  fre hv101


		* Keep Mothers Only:

		preserve

		keep if hv101 ==6 | hv101 ==7
		keep if sex ==2

		fre sex

		fre highest_grade
		fre highest_grade_dhs

		gen es_mother = 1 if highest_grade>= 0 & highest_grade <=5
		replace es_mother =2 if highest_grade>=6 & highest_grade<=8
		replace es_mother =3 if highest_grade>=9 & highest_grade<=10
		replace es_mother =4 if highest_grade ==11
		replace es_mother =5  if highest_grade >=12 & highest_grade !=.


		la def hh_educ_status 1 "Primary (1-5)" 2 "Secondary (6-8)"	3 "Higher Secondary (9-10)" 4 "FA/FSc/Diploma" 5 "Bachelors or Higher Education"	
		la val es_mother hh_educ_status

		duplicates drop hv001 hv002, force

		isid hv001 hv002 
		keep hv001 hv002 hvidx es_mother

		tempfile hh_mother
		save `hh_mother', replace

		restore 


		* Keep Fathers Only:

		 preserve

		keep if hv101 ==6 | hv101 ==7
		keep if sex ==1

		fre sex

		fre highest_grade
		fre highest_grade_dhs

		gen es_father = 1 if highest_grade>= 0 & highest_grade <=5
		replace es_father =2 if highest_grade>=6 & highest_grade<=8
		replace es_father =3 if highest_grade>=9 & highest_grade<=10
		replace es_father =4 if highest_grade ==11
		replace es_father =5  if highest_grade >=12 & highest_grade !=.


		la def hh_educ_status 1 "Primary (1-5)" 2 "Secondary (6-8)"	3 "Higher Secondary (9-10)" 4 "FA/FSc/Diploma" 5 "Bachelors or Higher Education"	
		la val es_father hh_educ_status

		duplicates drop hv001 hv002, force
		isid hv001 hv002 


		keep hv001 hv002 hvidx es_father

		tempfile hh_father
		save `hh_father', replace


		restore 


		********************************************************************************
		* Create one indicator for HH-Education level

		preserve

		use `hh_head', clear
		merge 1:1 hv001 hv002 using `hh_father', nogen
		merge 1:1 hv001 hv002 using `hh_mother', nogen 


		egen hh_es = rowmax (es_head es_mother es_father)


		la val hh_es hh_educ_status

		ren hh_es hh_educ_level

		isid hv001 hv002

		keep hv001 hv002 hvidx hh_educ_level

		fre hh_educ_level

		tempfile hh_es
		save `hh_es', replace

		restore


		********************************************************************************
		count
		merge m:1 hv001 hv002 using `hh_es', nogen

		********************************************************************************

		* Year
					
		gen year = 2012
				


		* district
				
		merge m:1 shdist using "$dhs_raw\2012\dc_clean.dta", nogen
		ren district dist_nm 
		clean_lname dist_nm


        * Punjab
	
        gen dist_key = .
		la var dist_nm "Clean: District Name"
		
		replace dist_key =1 if dist_nm == "ATTOCK"  
		replace dist_key =2 if dist_nm == "BAHAWAL NAGAR" 	
		replace dist_key =3 if dist_nm == "BAHAWAL PUR"  
		replace dist_key =4 if dist_nm == "BHAKKAR" 
		replace dist_key =5 if dist_nm == "CHAKWAL"  
		replace dist_key =6 if dist_nm == "DERA GHAZI KHAN"  
		replace dist_key =7 if dist_nm == "FAISALABAD" 
		replace dist_key =8 if dist_nm == "GUJRANWALA" 
		replace dist_key =9 if dist_nm == "GUJRAT" 
		replace dist_key =10 if dist_nm == "HAFIZABAD" 
		replace dist_key =11 if dist_nm == "JHELUM"  
		replace dist_key =12 if dist_nm == "JHANG" 
		replace dist_key =13 if dist_nm == "KASUR" 
		replace dist_key =14 if dist_nm == "KHANEWAL"  
		replace dist_key =15 if dist_nm == "KHUSHAB" 
			 
		replace dist_key =16 if dist_nm == "LAHORE" 
		replace dist_key =17 if dist_nm == "LAYYAH" 
		replace dist_key =18 if dist_nm == "LODHRAN" 
		replace dist_key =19 if dist_nm == "MANDI BAHAUDDIN" 
		replace dist_key =20 if dist_nm == "MIANWALI" 
		replace dist_key =21 if dist_nm == "MULTAN" 
		replace dist_key =22 if dist_nm == "MUZAFFAR GARH" 
		replace dist_key =23 if dist_nm == "NAROWAL" 
		replace dist_key =24 if dist_nm == "OKARA" 
		replace dist_key =25 if dist_nm == "PAKPATTAN" 
		replace dist_key =26 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key =27 if dist_nm == "RAJANPUR" 
		replace dist_key =28 if dist_nm == "RAWALPINDI" 
		replace dist_key =29 if dist_nm == "SAHIWAL" 
		replace dist_key =30 if dist_nm == "SARGODHA" 
		replace dist_key =31 if dist_nm == "SHEIKHUPURA" 
		replace dist_key =32 if dist_nm == "SIALKOT" 
		replace dist_key =33 if dist_nm == "TOBA TEK SINGH" 
		replace dist_key =34 if dist_nm == "VEHARI" 
		replace dist_key =35 if dist_nm == "NANKANA SAHIB" 
        replace dist_key =36 if dist_nm == "CHINIOT" 
				
	
				
		* 2 3 22


		*KP: 37-61 
	
		 replace dist_key =37 if dist_nm == "ABBOTTABAD" 
 		 replace dist_key =38 if dist_nm == "BANNU" | dist_nm == "FR BANNU"
		 replace dist_key =39 if dist_nm == "BATAGRAM"
		 replace dist_key =40 if dist_nm == "BUNER" 
		 replace dist_key =41 if dist_nm == "CHARSADDA"
		 replace dist_key =42 if dist_nm == "CHITRAL" 
		 replace dist_key =43 if dist_nm == "D.I.KHAN"
		 replace dist_key =44 if dist_nm == "HANGU" 
		 replace dist_key =45 if dist_nm == "HARIPUR" 
		 replace dist_key =46 if dist_nm == "KARAK"
		 replace dist_key =47 if dist_nm == "KOHAT"
		 replace dist_key =48 if dist_nm == "KOHISTAN"  // missing
		 replace dist_key =49 if dist_nm == "LAKKI MARWAT" 
		 replace dist_key =50 if dist_nm == "LOWER DIR"
		 replace dist_key =51 if dist_nm == "MALAKAND PROTECTED AREA"
		 replace dist_key =52 if dist_nm == "MANSEHRA"
		 replace dist_key =53 if dist_nm == "MARDAN" 
		 replace dist_key =54 if dist_nm == "NOWSHERA"
		 
		 replace dist_key =55 if dist_nm == "PESHAWAR" 
		 replace dist_key =56 if  dist_nm == "SHANGLA"
		 replace dist_key =57 if dist_nm == "SWABI" 
		 replace dist_key =58 if dist_nm == "SWAT"
		 replace dist_key =59 if dist_nm == "TANK" 
		 replace dist_key =60 if dist_nm == "TOR GHAR"
		 replace dist_key =61 if dist_nm == "UPPER DIR"
		 
		 
		 ta dist_key if dist_key >36
		
		* 43 48
		

		 * Sindh:62-87
		 
		 
		 replace dist_nm = "KARACHI" if dist_nm == "KARACHI CENTRAL" | dist_nm == "KARACHI EAST" | dist_nm == "KARACHI MALIR" | dist_nm == "KARACHI SOUTH" | dist_nm == "KARACHI WEST" | dist_nm == "KORANGI"
		 
		 
		 replace dist_key = 62 if dist_nm == "BADIN" 
 		 replace dist_key = 63 if dist_nm == "DADU"
		 replace dist_key = 64 if  dist_nm == "GHOTKI" 
		 replace dist_key = 65 if  dist_nm == "HYDERABAD" 
		 replace dist_key = 66 if  dist_nm == "JACOBABAD"
		 replace dist_key = 67 if  dist_nm == "JAMSHORO" 
		 
		 replace dist_key = 68 if  dist_nm == "KARACHI" 
		 replace dist_key = 69 if  dist_nm == "KASHMORE" 
		 replace dist_key = 70 if  dist_nm == "KHAIRPUR" 
		 replace dist_key = 71 if  dist_nm == "LARKANA" 
		 replace dist_key = 72 if  dist_nm == "MATIARI" 
		 
		 
		 replace dist_key = 73 if  dist_nm == "MIRPUR KHAS" 
		 replace dist_key = 74 if  dist_nm == "N.FEROZE" 
		 replace dist_key = 75 if  dist_nm == "SANGHAR" 
		 replace dist_key = 76 if  dist_nm == "KAMBAR SHAHDADKOT" | dist_nm == "SHAHDAD KOT"
		 replace dist_key = 77 if  dist_nm == "SHAHEED BENAZIRABAD" 
		 replace dist_key = 78 if  dist_nm == "SHIKAR PUR"
		 
		 replace dist_key = 79 if  dist_nm == "SUJAWAL" 
		 replace dist_key = 80 if  dist_nm == "SUKKUR" 
		 replace dist_key = 81 if  dist_nm == "TANDO ALLA YAR" 
		 replace dist_key = 82 if  dist_nm == "TANDO MUHAMMAD KHAN" 
		 replace dist_key = 83 if  dist_nm == "THARPARKAR" 
		 * replace dist_key = 84 if  dist_nm == "TANK" 
		 replace dist_key = 85 if  dist_nm == "THATTA" 
		 replace dist_key = 86 if  dist_nm == "UMER KOT" 
		 
		 replace dist_key = 87 if  dist_nm == "MITHI" 

        ta dist_key if dist_key >= 62
	
	   ta dist_nm if dist_key ==.
	
     	* 73 74 76 77 78 
	

		 * BALOCHISTAN: 88-121
		 
	  
		 replace dist_key =88 if dist_nm == "AWARAN" // missing
 		 replace dist_key =89 if dist_nm == "BARKHAN"   // missing
		 replace dist_key =90 if dist_nm == "BOLAN" | dist_nm == "BOLAN/KACHHI" 
		 replace dist_key =91 if dist_nm == "CHAGAI"  
		 replace dist_key =92 if dist_nm == "DERA BUGTI" // missing
	     replace dist_key =93 if dist_nm == "GAWADAR"  
		 
		 replace dist_key =94 if dist_nm == "HARNAI" // missing
		 replace dist_key =95 if dist_nm == "JAFFARABAD"  
		 replace dist_key =96 if dist_nm == "JHAL MAGSI" 
		 replace dist_key =97 if dist_nm == "KALAT" 
		 replace dist_key =98 if dist_nm == "KHARAN" 
		 replace dist_key =99 if dist_nm == "KHUZDAR" 
		 
		 
		 replace dist_key =100 if dist_nm == "KILLA ABDULLAH"
		 replace dist_key =101 if dist_nm == "KILLA SAIFULLAH" 
		 replace dist_key =102 if dist_nm == "KOHLU" 
		 replace dist_key =103 if dist_nm == "LASBELA"
		 replace dist_key =104 if dist_nm == "LORALAI" 
		 replace dist_key =105 if dist_nm == "MASTUNG" 
		 
		 replace dist_key =106 if dist_nm == "MUSAKHEL" // missing
		 replace dist_key =107 if dist_nm == "NASIRABAD/TAMBOO" 
		 replace dist_key =108 if dist_nm == "NUSHKI"  // missing
		 replace dist_key =109 if dist_nm == "PISHIN"  
		 replace dist_key =110 if dist_nm == "QUETTA"  
		 replace dist_key =111 if dist_nm == "SHERANI"  
		 replace dist_key =112 if dist_nm == "SIBI" 
		 
		 replace dist_key =113 if dist_nm == "WASHUK" 

		 
		 replace dist_key =114 if dist_nm == "ZHOB" 
		 replace dist_key =115 if dist_nm == "ZIARAT" // missing
		 
		 *
		 	 
		 replace dist_key =116 if dist_nm == "DUKI" 
		 replace dist_key =117	if dist_nm == "LEHRI"   
		 replace dist_key =118 if dist_nm == "KETCH" | dist_nm == "KECH/TURBAT"
		 replace dist_key =119 if dist_nm == "PANJGUR"  // missing
		
		 replace dist_key =120 if dist_nm == "SOHBATPUR" 
		 replace dist_key =121 if dist_nm == "SURAB"  // missing 
		 
		 
		 
         ta dist_key if dist_key >= 88
	
	
	     ta dist_nm if dist_key ==.
	
     	* 88 90 91 92 93 95 106 107 113
	

		  * OTHER AREAS 122 - 201
		
				 
		  replace dist_key =122 if dist_nm == "ASTORE" 
		
		  replace dist_key =123 if dist_nm == "BAGH" 
		  replace dist_key =124 if dist_nm == "BAJAUR AGENCY" 
		  replace dist_key =125 if dist_nm == "BHIMBER" 
		  replace dist_key =126 if dist_nm == "DIAMIR" 

		  replace dist_key =127 if dist_nm == "FATA BANNU" 
		  replace dist_key =128 if dist_nm == "TRIBAL AREA ADJ D.I.KHAN" 
		  replace dist_key =129 if dist_nm == "FATA KOHAT" 
		  replace dist_key =130 if dist_nm == "FATA LAKKI MARWAT"
		  replace dist_key =131 if dist_nm == "FATA PESHAWAR"
		  replace dist_key =132 if dist_nm == "FATA TANK" 
		  replace dist_key =133 if dist_nm == "GHANCHE" 
		  replace dist_key =134 if dist_nm == "GHIZER" 
		  replace dist_key =135 if dist_nm == "GILGIT" | dist_nm== "BALTISTAN"
		  replace dist_key =136 if dist_nm == "HATTIAN" | dist_nm == "HATTIAN BALA"
		  replace dist_key =137 if dist_nm == "HAVELI" 
		  replace dist_key =138 if dist_nm == "HUNZA NAGAR" | dist_nm == "HUNZA"
		  replace dist_key =139 if dist_nm == "ICT" | dist_nm == "ISLAMABAD" 
		  replace dist_key =140 if dist_nm == "KHARMANG" 
		  replace dist_key =141 if dist_nm == "KHYBER AGENCY" 
		  replace dist_key =142 if dist_nm == "KOTLI"  
		  replace dist_key =143 if dist_nm == "KURRAM AGENCY"  
		  replace dist_key =144 if dist_nm == "MOHMAND AGENCY"  
		  replace dist_key =145 if dist_nm == "MIRPUR"  

		  replace dist_key =146 if dist_nm == "MUZAFFARABAD" 
		  replace dist_key =147 if dist_nm == "NAGAR"  
		  replace dist_key =148 if dist_nm == "NEELUM"  
		

		  replace dist_key =149 if dist_nm == "NORTH WAZIRISTAN AGENCY" 
		  replace dist_key =150 if dist_nm == "ORAKZAI" | dist_nm == "ORAKZAI AGENCY"
		  replace dist_key =151 if dist_nm == "POONCH" 
		  replace dist_key =152 if dist_nm == "SKARDU"  
		  replace dist_key =153 if dist_nm == "SOUTH WAZIRISTAN AGENCY"  
		  replace dist_key =154 if dist_nm == "SUDHONTI"  
		  replace dist_key =155 if dist_nm == "SHIGAR"  

		
		  replace dist_key = 200 if dist_nm == "NAWAB SHAH" 

		  ta dist_nm if dist_key ==.
		  
	
		  
		  * Province
		  
		  
		  gen province = 1 if dist_key >= 0 & dist_key <= 36
		  replace province = 2 if dist_key >= 62 & dist_key <=87
		  replace province = 3 if dist_key >= 88 & dist_key <= 121
		  replace province = 4 if dist_key >= 37 & dist_key <= 61
		  replace province = 5 if dist_key >= 122 & dist_key <= 201
		  
		  
		  * fix province for tank
		  
		  fre province 
		  
		  la def prov 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP" 5 "OTHER AREAS"
		  la val province prov
		  
		  * Weight 
		// Note: national level stats were created by excluding GB and AJK
		// These regions are identified as 5 and 7 in v024

		// Weight variable
		gen weight_dhs = hv005
				  
		* Quintiles 
		  
		clonevar wealth_quintiles = hv270
		la var wealth_quintiles "Wealth Quintiles: DHS"
		
		* region

		gen region = hv025
		la def region 1 "Urban" 2 "Rural"
		la val region region
		
		
		save "$dhs_clean/DHS_HH_clean_2012.dta", replace
		

********************************************************************************
       * 2017 - HH-level Dataset:
********************************************************************************	



		use "$dhs_raw\2017\PKPR71FL.DTA", clear

		isid hv001 hv002 hvidx

		* Education Vars:

		* in school ever:
		clonevar hg = hv108
		recode hg (98=.)
		fre hg


		gen in_school_ever = 0 if hg ==0
		replace in_school_ever =1 if hg != 0 & hg !=.

		ta hg in_school_ever 
		replace hg = . if in_school_ever ==0
		ta  hg in_school_ever


		* hv121

		clonevar cg = hv124
		recode cg (98=.)

		* gen in_school = 0 if cg ==0
		* replace in_school = 1 if cg != 0 & cg !=.

		gen in_school = 1 if hv121 ==2
		replace in_school = 0 if hv121 ==0

		ta cg in_school 
		replace cg = . if in_school ==0
		ta cg in_school 


		********************************************************************************

		ta in_school_ever 
		ta in_school
		ta in_school_ever in_school

		ta cg if in_school_ever ==0 & in_school ==1
		ta hg if in_school_ever ==0 & in_school ==1



		/*

		* Data Error: in_school_ever and in_school vars are not consistent. Some people are showing up as never went to school 
		but they are currently going to school. This maybe be due to how questions are phrased in DHS (Check).

		. ta cg if in_school_ever	==0	& in_school	==1

		education in 
		single years 
		current 
		school year       Freq.		Percent	Cum.
					
		0       3,104		51.35	51.35
		1       2,939		48.62	99.97
		6           1		0.02	99.98
		7           1		0.02	100.00
					
		Total       6,045		100.00


		*/


		* generate tag to flag and fix the error:
		gen x = 1 if in_school_ever ==0 & in_school ==1



		replace in_school_ever = 1 if x ==1
		replace hg = cg if x==1

		ta in_school_ever in_school


		gen education_status =1 if in_school ==1
		replace education_status =2 if in_school ==0 & in_school_ever ==1
		replace education_status =3 if in_school_ever == 0 


		la def es 1 "Child in school" 2 "Child dropped out" 3 "Child never enrolled"
		la val education_status es
		fre education_status


		* highest_grade:

		fre hg

		clonevar highest_grade = hg

		replace highest_grade = 11 if hg ==12
		replace highest_grade = 12 if hg >12 & hg !=.

		la def educ 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "FA/FSc/Diplomas" 12 "Bachelors or Higher"
		la val highest_grade educ

		fre highest_grade
		ren hg highest_grade_dhs


		* current_grade:

		clonevar current_grade = cg

		replace current_grade = 11 if cg ==12
		replace current_grade = 12 if cg >12 & cg !=.

		la val current_grade educ
		fre current_grade

		ren cg current_grade_dhs



		* Sex

		clonevar sex = hv104

		gen female = 1 if sex ==2
		replace female =0 if sex ==1
		la var female "Female Dummy"


		* Age

		clonevar age = hv105
		recode age (98 =.)


		* HH Education level:


		* HH-Head:

		preserve

		* keep only HH head:

		keep if hv101 ==1

		fre highest_grade
		fre highest_grade_dhs

		gen es_head = 1 if highest_grade>= 0 & highest_grade <=5
		replace es_head =2 if highest_grade>=6 & highest_grade<=8
		replace es_head =3 if highest_grade>=9 & highest_grade<=10
		replace es_head =4 if highest_grade ==11
		replace es_head =5  if highest_grade >=12 & highest_grade !=.


		la def hh_educ_status 1 "Primary (1-5)" 2 "Secondary (6-8)"	3 "Higher Secondary (9-10)" 4 "FA/FSc/Diploma" 5 "Bachelors or Higher Education"	
		la val es_head hh_educ_status


		isid hv001 hv002 hvidx

		keep hv001 hv002 hvidx es_head

		tempfile hh_head
		save `hh_head', replace

		restore


		* Mothers educ:

		* preserve

		  fre hv101


		* Keep Mothers Only:

		preserve

		keep if hv101 ==6 | hv101 ==7
		keep if sex ==2

		fre sex

		fre highest_grade
		fre highest_grade_dhs

		gen es_mother = 1 if highest_grade>= 0 & highest_grade <=5
		replace es_mother =2 if highest_grade>=6 & highest_grade<=8
		replace es_mother =3 if highest_grade>=9 & highest_grade<=10
		replace es_mother =4 if highest_grade ==11
		replace es_mother =5  if highest_grade >=12 & highest_grade !=.


		la def hh_educ_status 1 "Primary (1-5)" 2 "Secondary (6-8)"	3 "Higher Secondary (9-10)" 4 "FA/FSc/Diploma" 5 "Bachelors or Higher Education"	
		la val es_mother hh_educ_status

		duplicates drop hv001 hv002, force

		isid hv001 hv002 
		keep hv001 hv002 hvidx es_mother

		tempfile hh_mother
		save `hh_mother', replace

		restore 


		* Keep Fathers Only:

		 preserve

		keep if hv101 ==6 | hv101 ==7
		keep if sex ==1

		fre sex

		fre highest_grade
		fre highest_grade_dhs

		gen es_father = 1 if highest_grade>= 0 & highest_grade <=5
		replace es_father =2 if highest_grade>=6 & highest_grade<=8
		replace es_father =3 if highest_grade>=9 & highest_grade<=10
		replace es_father =4 if highest_grade ==11
		replace es_father =5  if highest_grade >=12 & highest_grade !=.


		la def hh_educ_status 1 "Primary (1-5)" 2 "Secondary (6-8)"	3 "Higher Secondary (9-10)" 4 "FA/FSc/Diploma" 5 "Bachelors or Higher Education"	
		la val es_father hh_educ_status

		duplicates drop hv001 hv002, force
		isid hv001 hv002 


		keep hv001 hv002 hvidx es_father

		tempfile hh_father
		save `hh_father', replace


		restore 


		********************************************************************************
		* Create one indicator for HH-Education level

		preserve

		use `hh_head', clear
		merge 1:1 hv001 hv002 using `hh_father', nogen
		merge 1:1 hv001 hv002 using `hh_mother', nogen 


		egen hh_es = rowmax (es_head es_mother es_father)
		egen mother_educ = rowmax (es_head es_mother)


		la val hh_es hh_educ_status

		ren hh_es hh_educ_level

		isid hv001 hv002

		keep hv001 hv002 hvidx hh_educ_level es_mother 

		fre hh_educ_level

		tempfile hh_es
		save `hh_es', replace

		restore


		********************************************************************************
		count
		merge m:1 hv001 hv002 using `hh_es', nogen

		********************************************************************************


		* Year

		gen year = 2017


		* district

		decode shdist, gen(dist_nm)
		clean_lname dist_nm




        * Punjab
	
        gen dist_key = .
		la var dist_nm "Clean: District Name"
		
		replace dist_key =1 if dist_nm == "ATTOCK"  
		replace dist_key =2 if dist_nm == "BAHAWALNAGAR" 	
		replace dist_key =3 if dist_nm == "BAHAWALPUR"  
		replace dist_key =4 if dist_nm == "BHAKKAR" 
		replace dist_key =5 if dist_nm == "CHAKWAL"  
		replace dist_key =6 if dist_nm == "DERA GHAZI KHAN"  
		replace dist_key =7 if dist_nm == "FAISALABAD" 
		replace dist_key =8 if dist_nm == "GUJRANWALA" 
		replace dist_key =9 if dist_nm == "GUJRAT" 
		replace dist_key =10 if dist_nm == "HAFIZABAD" 
		replace dist_key =11 if dist_nm == "JHELUM"  
		replace dist_key =12 if dist_nm == "JHANG" 
		replace dist_key =13 if dist_nm == "KASUR" 
		replace dist_key =14 if dist_nm == "KHANEWAL"  
		replace dist_key =15 if dist_nm == "KHUSHAB" 
			 
		replace dist_key =16 if dist_nm == "LAHORE" 
		replace dist_key =17 if dist_nm == "LAYYAH" 
		replace dist_key =18 if dist_nm == "LODHRAN" 
		replace dist_key =19 if dist_nm == "MANDI BAHAUDDIN" 
		replace dist_key =20 if dist_nm == "MIANWALI" 
		replace dist_key =21 if dist_nm == "MULTAN" 
		replace dist_key =22 if dist_nm == "MUZAFFARGARH" 
		replace dist_key =23 if dist_nm == "NAROWAL" 
		replace dist_key =24 if dist_nm == "OKARA" 
		replace dist_key =25 if dist_nm == "PAKPATTAN" 
		replace dist_key =26 if dist_nm == "RAHIM YAR KHAN"
		replace dist_key =27 if dist_nm == "RAJANPUR" 
		replace dist_key =28 if dist_nm == "RAWALPINDI" 
		replace dist_key =29 if dist_nm == "SAHIWAL" 
		replace dist_key =30 if dist_nm == "SARGODHA" 
		replace dist_key =31 if dist_nm == "SHEIKHUPURA" 
		replace dist_key =32 if dist_nm == "SIALKOT" 
		replace dist_key =33 if dist_nm == "TOBA TEK SINGH" 
		replace dist_key =34 if dist_nm == "VEHARI" 
		replace dist_key =35 if dist_nm == "NANKANA SAHIB" 
        replace dist_key =36 if dist_nm == "CHINIOT" 
				
		ta dist_key 
		ta dist_nm if dist_key ==.
				
		


		*KP: 37-61 
	
		 replace dist_key =37 if dist_nm == "ABBOTTABAD" 
 		 replace dist_key =38 if dist_nm == "BANNU" | dist_nm == "FR BANNU"
		 replace dist_key =39 if dist_nm == "BATAGRAM"
		 replace dist_key =40 if dist_nm == "BUNER" 
		 replace dist_key =41 if dist_nm == "CHARSADDA"
		 replace dist_key =42 if dist_nm == "CHITRAL" 
		 replace dist_key =43 if dist_nm == "D. I. KHAN"
		 replace dist_key =44 if dist_nm == "HANGU" 
		 replace dist_key =45 if dist_nm == "HARIPUR" 
		 replace dist_key =46 if dist_nm == "KARAK"
		 replace dist_key =47 if dist_nm == "KOHAT"
		 replace dist_key =48 if dist_nm == "KOHISTAN"  // missing
		 replace dist_key =49 if dist_nm == "LAKKI MARWAT" 
		 replace dist_key =50 if dist_nm == "LOWER DIR"
		 replace dist_key =51 if dist_nm == "MALAKAND PROTECTED AREA"
		 replace dist_key =52 if dist_nm == "MANSEHRA"
		 replace dist_key =53 if dist_nm == "MARDAN" 
		 replace dist_key =54 if dist_nm == "NOWSHERA"
		 
		 replace dist_key =55 if dist_nm == "PESHAWAR" 
		 replace dist_key =56 if  dist_nm == "SHANGLA"
		 replace dist_key =57 if dist_nm == "SWABI" 
		 replace dist_key =58 if dist_nm == "SWAT"
		 replace dist_key =59 if dist_nm == "TANK" 
		 replace dist_key =60 if dist_nm == "TOR GHAR"
		 replace dist_key =61 if dist_nm == "UPPER DIR"
		 
		 
		 ta dist_key if dist_key >36
		
		* 37, 41, 42, 43, 48, 51
		
	
		 * Sindh:62-87
		 
		 
		 replace dist_nm = "KARACHI" if dist_nm == "KARACHI CENTRAL" | dist_nm == "KARACHI EAST" | dist_nm == "KARACHI MALIR" | dist_nm == "KARACHI SOUTH" | dist_nm == "KARACHI WEST" | dist_nm == "KORANGI"
		 
		 
		 replace dist_key = 62 if dist_nm == "BADIN" 
 		 replace dist_key = 63 if dist_nm == "DADU"
		 replace dist_key = 64 if  dist_nm == "GHOTKI" 
		 replace dist_key = 65 if  dist_nm == "HYDERABAD" 
		 replace dist_key = 66 if  dist_nm == "JACOBABAD"
		 replace dist_key = 67 if  dist_nm == "JAMSHORO" 
		 
		 replace dist_key = 68 if  dist_nm == "KARACHI" 
		 replace dist_key = 69 if  dist_nm == "KASHMORE" 
		 replace dist_key = 70 if  dist_nm == "KHAIRPUR" 
		 replace dist_key = 71 if  dist_nm == "LARKANA" 
		 replace dist_key = 72 if  dist_nm == "MATIARI" 
		 
		 
		 replace dist_key = 73 if  dist_nm == "MIRPURKHAS" 
		 replace dist_key = 74 if  dist_nm == "NAUSHAHRO FIROZE" 
		 replace dist_key = 75 if  dist_nm == "SANGHAR" 
		 replace dist_key = 76 if  dist_nm == "KAMBAR SHAHDADKOT" 
		 replace dist_key = 77 if  dist_nm == "SHAHEED BENAZIRABAD" 
		 replace dist_key = 78 if  dist_nm == "SHIKARPUR"
		 
		 replace dist_key = 79 if  dist_nm == "SUJAWAL" 
		 replace dist_key = 80 if  dist_nm == "SUKKUR" 
		 replace dist_key = 81 if  dist_nm == "TANDO ALLAHYAR" 
		 replace dist_key = 82 if  dist_nm == "TANDO MUHAMMAD KHAN" 
		 replace dist_key = 83 if  dist_nm == "THARPARKAR" 
		 * replace dist_key = 84 if  dist_nm == "TANK" 
		 replace dist_key = 85 if  dist_nm == "THATTA" 
		 replace dist_key = 86 if  dist_nm == "UMERKOT" 
		 
		 replace dist_key = 87 if  dist_nm == "MITHI" 


	
	
		 * BALOCHISTAN: 88-121
		 
	  
		 replace dist_key =88 if dist_nm == "AWARAN" 
 		 replace dist_key =89 if dist_nm == "BARKHAN"   // missing
		 replace dist_key =90 if dist_nm == "BOLAN" | dist_nm == "KACHHI (BOLAN)" // missing
		 replace dist_key =91 if dist_nm == "CHAGHI"  // missing
		 replace dist_key =92 if dist_nm == "DERA BUGTI" 
	     replace dist_key =93 if dist_nm == "GWADAR"  
		 
		 replace dist_key =94 if dist_nm == "HARNAI" // missing
		 replace dist_key =95 if dist_nm == "JAFARABAD"  
		 replace dist_key =96 if dist_nm == "JHAL MAGSI" 
		 replace dist_key =97 if dist_nm == "KALAT" 
		 replace dist_key =98 if dist_nm == "KHARAN" 
		 replace dist_key =99 if dist_nm == "KHUZDAR" 
		 
		 
		 replace dist_key =100 if dist_nm == "KILLA ABDULLAH"
		 replace dist_key =101 if dist_nm == "KILLA SAIFULLAH" 
		 replace dist_key =102 if dist_nm == "KOHLU" 
		 replace dist_key =103 if dist_nm == "LASBELA"
		 replace dist_key =104 if dist_nm == "LORALAI" 
		 replace dist_key =105 if dist_nm == "MASTUNG" 
		 
		 replace dist_key =106 if dist_nm == "MUSA KHEL" // missing
		 replace dist_key =107 if dist_nm == "NASIRABAD" 
		 replace dist_key =108 if dist_nm == "NUSHKI"  // missing
		 replace dist_key =109 if dist_nm == "PISHIN"  
		 replace dist_key =110 if dist_nm == "QUETTA"  
		 replace dist_key =111 if dist_nm == "SHERANI"  
		 replace dist_key =112 if dist_nm == "SIBI" 
		 
		 replace dist_key =113 if dist_nm == "WASHUK" 

		 
		 replace dist_key =114 if dist_nm == "ZHOB" 
		 replace dist_key =115 if dist_nm == "ZIARAT" // missing
		 
		 
		 	 
		 replace dist_key =116 if dist_nm == "DUKI" 
		 replace dist_key =117	if dist_nm == "LEHRI"   
		 replace dist_key =118 if dist_nm == "KETCH" | dist_nm == "KECH (TURBAT)"
		 replace dist_key =119 if dist_nm == "PANJGUR"  // missing
		
		 replace dist_key =120 if dist_nm == "SOHBATPUR" 
		 replace dist_key =121 if dist_nm == "SURAB"  // missing 
		 
		 
	

		  * OTHER AREAS 122 - 201
		
				 
		  replace dist_key =122 if dist_nm == "ASTORE" 
		
		  replace dist_key =123 if dist_nm == "BAGH" 
		  replace dist_key =124 if dist_nm == "BAJAUR AGENCY" 
		  replace dist_key =125 if dist_nm == "BHIMBER" 
		  replace dist_key =126 if dist_nm == "DIAMER" 

		  replace dist_key =127 if dist_nm == "FATA BANNU" 
		  replace dist_key =128 if dist_nm == "TRIBAL AREA ADJ D.I.KHAN" 
		  replace dist_key =129 if dist_nm == "FATA KOHAT" 
		  replace dist_key =130 if dist_nm == "FATA LAKKI MARWAT"
		  replace dist_key =131 if dist_nm == "FATA PESHAWAR"
		  replace dist_key =132 if dist_nm == "FATA TANK" 
		  replace dist_key =133 if dist_nm == "GHANCHE" 
		  replace dist_key =134 if dist_nm == "GHIZER" 
		  replace dist_key =135 if dist_nm == "GILGIT" 
		  replace dist_key =136 if dist_nm == "HATTIAN" | dist_nm == "HATTIAN BALA"
		  replace dist_key =137 if dist_nm == "HAVELI" 
		  replace dist_key =138 if dist_nm == "HUNZA NAGAR" | dist_nm == "HUNZA"
		  replace dist_key =139 if dist_nm == "ICT" | dist_nm == "ISLAMABAD" 
		  replace dist_key =140 if dist_nm == "KHARMANG" 
		  replace dist_key =141 if dist_nm == "KHYBER AGENCY" 
		  replace dist_key =142 if dist_nm == "KOTLI"  
		  replace dist_key =143 if dist_nm == "KURRAM AGENCY"  
		  replace dist_key =144 if dist_nm == "MOHMAND AGENCY"  
		  replace dist_key =145 if dist_nm == "MIRPUR"  

		  replace dist_key =146 if dist_nm == "MUZAFFARABAD" 
		  replace dist_key =147 if dist_nm == "NAGAR"  
		  replace dist_key =148 if dist_nm == "NEELUM"  
		

		  replace dist_key =149 if dist_nm == "NORTH WAZIRISTAN AGENCY" 
		  replace dist_key =150 if dist_nm == "ORAKZAI" | dist_nm == "ORAKZAI AGENCY"
		  replace dist_key =151 if dist_nm == "POONCH" 
		  replace dist_key =152 if dist_nm == "SKARDU"  
		  replace dist_key =153 if dist_nm == "SOUTH WAZIRISTAN AGENCY"  
		  replace dist_key =154 if dist_nm == "SUDHONTI"  
		  replace dist_key =155 if dist_nm == "SHIGAR"  

		
		  replace dist_key = 200 if dist_nm == "NAWABSHA" 

		  ta dist_nm if dist_key ==.
		  
		  * Province
		  
		  
		  gen province = 1 if dist_key >= 0 & dist_key <= 36
		  replace province = 2 if dist_key >= 62 & dist_key <=87
		  replace province = 3 if dist_key >= 88 & dist_key <= 121
		  replace province = 4 if dist_key >= 37 & dist_key <= 61
		  replace province = 5 if dist_key >= 122 & dist_key <= 201
		  
		  
		  * fix province for tank
		  
		  
		  
		  fre province 
		  
		  la def prov 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP" 5 "OTHER AREAS"
		  la val province prov
		  
		  
		  * Weight 
		// Note: national level stats were created by excluding GB and AJK
		// These regions are identified as 5 and 7 in v024

		// Weight variable
		gen weight_dhs = hv005
		replace weight_dhs = shv005 if hv024 == 5 | hv024 == 7
				  
		  *Quintiles 
		
		
		clonevar wealth_quintiles = hv270
		la var wealth_quintiles "Wealth Quintiles: DHS"
		
				
		* region

		gen region = hv025
		la def region 1 "Urban" 2 "Rural"
		la val region region
		

		
		save "$dhs_clean/DHS_HH_clean_2017.dta", replace
		 
		  
		  
		  
		  
