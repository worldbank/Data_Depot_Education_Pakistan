
* ASAER DATA CLEANING : 
* Author: Ahmed Raza
* Date: 20th May 2019
* Purpose: Cleaning ASER data:  HH data - 2016


		* Init for Globals

	    include init.do	
	
	

********************************************************************************	
	    * YEAR: 2016
********************************************************************************	
		
		
		* HH Child:
		
		import delimited "$aser_raw/2016/ITAASER2016Child.csv", encoding(ISO-8859-1)clear
		
		
		
		tempfile child_1
		save `child_1', replace

		import delimited "$aser_raw/2016/ITAASER2016HealthFunctioning.csv", encoding(ISO-8859-1)clear

		merge 1:1 cid using `child_1' 
		drop _merge 
		
		ren cid childid
		isid childid	
		
			
		tempfile child_2016
		save `child_2016', replace

		
		
		* Household:
		import delimited "$aser_raw/2016/ITAASER2016HouseholdIndicators.csv", encoding(ISO-8859-1)clear

		isid hhid

		tempfile household_2016
		save `household_2016', replace

	 
		
		* Village map survey:
		import delimited "$aser_raw/2016/ITAASER2016VMSurvey.csv", encoding(ISO-8859-1)clear	
			
		tempfile villagemap_2016
		save `villagemap_2016', replace

		
		* District:
		
		import delimited "$aser_raw/2016/ITAASER2016ProvDist.csv", encoding(ISO-8859-1)clear
			
		ren *, lower 
		ren dname dist_nm
		sort rid dist_nm
		
		replace dist_nm = trim(dist_nm)
		ta dist_nm
		clean_lname dist_nm
		ta dist_nm
		
		/*
		* keeping the districts in Punjab:
		keep if rid ==2
		*/
	
	
	    ren rid pcode
		gen prov = 1 if pcode == 2 
		replace prov = 2 if pcode == 3
		replace prov = 3 if pcode == 4
		replace prov = 4 if pcode == 5
		replace prov = 0 if pcode ==6 | pcode ==7 | pcode ==8 | pcode ==9
		
		la def prov 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP" 0 "OTHER AREAS"			
		la val prov prov	
     	
	 	ta dist_nm if prov ==1
		
		
		gen dist_nm2 = dist_nm if prov==1

	
	    * District Level Cleaning:
	
        gen dist_key = 1	if prov ==1		 
		replace dist_key = 1 if dist_nm == "ATTOCK"	 & prov ==1 
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER" & prov ==1 
		replace dist_key = 3 if dist_nm == "BAHAWALPUR" & prov ==1
		replace dist_key = 4 if dist_nm == "BHAKKAR" & prov ==1
		replace dist_key = 5 if dist_nm == "CHAKWAL" & prov ==1
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN" & prov ==1
		replace dist_key = 7 if dist_nm == "FAISALABAD" & prov ==1
		replace dist_key = 8 if dist_nm == "GUJRANWALA" & prov ==1
		replace dist_key = 9 if dist_nm == "GUJRAT" & prov ==1
		replace dist_key = 10 if dist_nm == "HAFIZABAD" & prov ==1
		replace dist_key = 11 if dist_nm == "JEHLUM" & prov ==1
		replace dist_key = 12 if dist_nm == "JHANG" & prov ==1
		replace dist_key = 13 if dist_nm == "KASUR" & prov ==1
		replace dist_key = 14 if dist_nm == "KHANEWAL" & prov ==1
		replace dist_key = 15 if dist_nm == "KHUSHAB" & prov ==1
			 
		replace dist_key = 16 if dist_nm == "LAHORE" & prov ==1
		replace dist_key = 17 if dist_nm == "LAYYAH" & prov ==1
		replace dist_key = 18 if dist_nm == "LODHRAN" & prov ==1
		replace dist_key = 19 if dist_nm == "MANDI BAHUDDIN" & prov ==1
		replace dist_key = 20 if dist_nm == "MIANWALI" & prov ==1
		replace dist_key = 21 if dist_nm == "MULTAN" & prov ==1 
		replace dist_key = 22 if dist_nm == "MUZAFFAR GARH" & prov ==1
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
		replace dist_key = 33 if dist_nm == "T.T.SINGH" & prov ==1 
		replace dist_key = 34 if dist_nm == "VEHARI" & prov ==1
		replace dist_key = 35 if dist_nm == "NANKANA SAHIB" & prov ==1
        replace dist_key = 36 if dist_nm == "CHINIOT" & prov ==1
				
		
		la var dist_key "District-ID :Key"
		la var dist_nm2 "Clean: District Name"
		
					
		
			
	     ta dist_nm if dist_key ==. & prov==1


		 * KP:
		
		replace dist_nm = "PESHAWAR" if dist_nm == "PESHAWAR URBAN" & prov ==4 
		replace dist_nm = "MARDAN" if dist_nm == "MARDAN URBAN" & prov ==4 
		replace dist_nm = "SWAT" if dist_nm == "SWAT URBAN" & prov ==4 
  
		replace dist_key = 37 if dist_nm == "ABBOTTABAD" & prov ==4 
 		replace dist_key = 38 if dist_nm == "BANNU" & prov ==4
	    replace dist_key = 39 if dist_nm == "BATTAGRAM" & prov ==4
		replace dist_key = 40 if dist_nm == "BUNER" & prov ==4
		replace dist_key = 41 if dist_nm == "CHARSADDA" & prov ==4
		replace dist_key = 42 if dist_nm == "CHITRAL" & prov ==4
		replace dist_key = 43 if dist_nm == "DERA ISMAIL KHAN" & prov ==4
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
		replace dist_key = 64 if dist_nm == "GOTKI" & prov ==2
		replace dist_key = 65 if dist_nm == "HYDERABAD" & prov ==2
		replace dist_key = 66 if dist_nm == "JACOBABAD" & prov ==2
		replace dist_key = 67 if dist_nm == "JAMSHORO" & prov ==2
		 
		replace dist_key = 68 if dist_nm == "KARACHI" & prov ==2
		replace dist_key = 69 if dist_nm == "KASHMORE" & prov ==2
		replace dist_key = 70 if dist_nm == "KHAIRPUR" & prov ==2
		replace dist_key = 71 if dist_nm == "LARKANA" & prov ==2
		replace dist_key = 72  if dist_nm == "MATIARI" & prov ==2
		 
		 
		replace dist_key = 73 if dist_nm == "MIRPURKHAS" & prov ==2
		replace dist_key = 74 if dist_nm == "NOWSHERO FEROZE" & prov ==2
		replace dist_key = 75 if dist_nm == "SANGHAR" & prov ==2
		replace dist_key = 76 if dist_nm == "QAMBAR SHAHDADKOT" & prov ==2
		replace dist_key = 77 if dist_nm == "SHAHEED BENAZIRABAD" & prov ==2
		replace dist_key = 78 if dist_nm == "SHIKARPUR" & prov ==2
		 
		replace dist_key = 79 if dist_nm == "SAJAWAL" & prov ==2
		replace dist_key = 80 if dist_nm == "SUKKUR" & prov ==2 
		replace dist_key = 81 if dist_nm == "TANDO ALLAH YAR" & prov ==2
		replace dist_key = 82 if dist_nm == "TANDO MUHAMMAD KHAN" & prov ==2
		* replace dist_key = 83 if dist_nm == "THARPARKAR" & prov ==2
		replace dist_key = 84 if dist_nm == "TANK" & prov ==2
		replace dist_key = 85 if dist_nm == "THATTA" & prov ==2
		replace dist_key = 86 if dist_nm == "UMER KOT" & prov ==2
		 
		replace dist_key = 87 if dist_nm == "MITHI" & prov ==2

		ta dist_key if prov ==2
	    ta dist_nm if prov ==2
		ta dist_nm if dist_key ==. & prov==2

		 * BALOCHISTAN:
			 	   
		replace dist_nm = "MARDAN" if dist_nm == "MARDAN URBAN"
		replace dist_nm = "PESHAWAR" if dist_nm == "PESHAWAR URBAN"
		replace dist_nm = "SWAT" if dist_nm == "SWAT URBAN"

		replace dist_nm = "KHUZDAR" if dist_nm == "KHUZDAR URBAN"
		replace dist_nm = "QUETTA" if dist_nm == "QUETTA URBAN"

	  
		replace dist_key = 88 if dist_nm == "AWARAN" & prov ==3
 		replace dist_key = 89 if dist_nm == "BARKHAN" & prov ==3
		replace dist_key = 90 if dist_nm == "BOLAN" & prov ==3
		replace dist_key = 91 if dist_nm == "CHAGHI" & prov ==3
		replace dist_key = 92 if dist_nm == "DERA BUGTI" & prov ==3
	    replace dist_key = 93 if dist_nm == "GWADAR" & prov ==3
		 
		replace dist_key = 94 if dist_nm == "HARNAI" & prov ==3
		replace dist_key = 95 if dist_nm == "JAFARABAD" & prov ==3
		replace dist_key = 96 if dist_nm == "JHAL MAGSI" & prov ==3
		replace dist_key = 97 if dist_nm == "KALLAT" & prov ==3
		replace dist_key = 98 if dist_nm == "KHARAN" & prov ==3
		replace dist_key = 99  if dist_nm == "KHUZDAR" & prov ==3
		 
		 
		replace dist_key = 100 if dist_nm == "QILLA ABDULLAH" & prov ==3
		replace dist_key = 101 if dist_nm == "QILLA SAIFULLAH" & prov ==3
		replace dist_key = 102 if dist_nm == "KOHLU" & prov ==3
		replace dist_key = 103 if dist_nm == "LASBELA" & prov ==3
		replace dist_key = 104 if dist_nm == "LORALAI" & prov ==3
		replace dist_key = 105 if dist_nm == "MASTUNG" & prov ==3
		 
		replace dist_key = 106 if dist_nm == "MUSAKHEL" & prov ==3
		replace dist_key = 107 if dist_nm == "NASIRABAD" & prov ==3
		replace dist_key = 108 if dist_nm == "NUSHKI" & prov ==3
		replace dist_key = 109 if dist_nm == "PISHIN" & prov ==3
		replace dist_key = 110 if dist_nm == "QUETTA" & prov ==3
		replace dist_key = 111 if dist_nm == "SHERANI" & prov ==3
		replace dist_key = 112 if dist_nm == "SIBI" & prov ==3
		 
		replace dist_key = 113 if dist_nm == "WASHUK" & prov ==3 
		replace dist_key = 114 if dist_nm == "ZHOB" & prov ==3
		replace dist_key = 115 if dist_nm == "ZIARAT" & prov ==3
		 
		* replace dist_key = 116 if dist_nm == "DUKI" & prov ==3
		replace dist_key = 117 if dist_nm == "LEHRI" & prov ==3	 
		replace dist_key = 118 if dist_nm == "KECH (TURBAT)" & prov ==3
		replace dist_key = 119 if dist_nm == "PANJGUR" & prov ==3	 
		
		replace dist_key = 120 if dist_nm == "SOHBATPUR" & prov ==3
		* replace dist_key = 121 if dist_nm == "SURAB" & prov ==3
		 	
		ta dist_key if prov ==3
		ta dist_nm if prov ==3
		ta dist_nm if dist_key ==. & prov==3
		 

		* OTHER AREAS
		  
		replace dist_nm = "ISLAMABAD" if dist_nm == "ISLAMABAD URBAN"
				 
			 
		replace dist_key = 122 if dist_nm == "ASTORE" & prov ==0
		
		replace dist_key = 123 if dist_nm == "BAGH" & prov ==0
		replace dist_key = 124 if dist_nm == "BAJAUR AGENCY" & prov ==0
		replace dist_key = 125 if dist_nm == "BHIMBER" & prov ==0
		replace dist_key = 126 if dist_nm == "DIAMER" & prov ==0

		replace dist_key = 127 if dist_nm == "F.R. BANNU" & prov ==0
		replace dist_key = 128 if dist_nm == "F.R. D.I. KHAN" & prov ==0
		replace dist_key = 129 if dist_nm == "F.R. KOHAT" & prov ==0
		replace dist_key = 130 if dist_nm == "F.R. LAKKI MARWAT" & prov ==0
		replace dist_key = 131 if dist_nm == "F.R. PESHAWAR" & prov ==0
		replace dist_key = 132 if dist_nm == "F.R. TANK" & prov ==0
		replace dist_key = 133 if dist_nm == "GHANCHE" & prov ==0
		replace dist_key = 134 if dist_nm == "GHIZER" & prov ==0
		replace dist_key = 135 if dist_nm == "GILGIT" & prov ==0
		replace dist_key = 136 if dist_nm == "HATTIAN" & prov ==0
		replace dist_key = 137 if dist_nm == "HAVELI" & prov ==0
		replace dist_key = 138 if dist_nm == "HUNZA NAGAR" & prov ==0
		replace dist_key = 139 if dist_nm == "ISLAMABAD" & prov ==0
		*  replace dist_key = 140 if dist_nm == "KHARMANG" & prov ==0
		replace dist_key = 141 if dist_nm == "KHYBER AGENCY" & prov ==0
		replace dist_key = 142 if dist_nm == "KOTLI" & prov ==0
		replace dist_key = 143 if dist_nm == "KURRAM AGENCY" & prov ==0
		replace dist_key = 144 if dist_nm == "MOHMAND AGENCY" & prov ==0
		replace dist_key = 145 if dist_nm == "MIRPUR" & prov ==0

		replace dist_key = 146 if dist_nm == "MUZAFFARABAD" & prov ==0
		replace dist_key = 147 if dist_nm == "NAGAR" & prov ==0
		replace dist_key = 148 if dist_nm == "NEELUM" & prov ==0
		
		replace dist_key = 149 if dist_nm == "NORTH WAZIRISTAN" & prov ==0
		replace dist_key = 150 if dist_nm == "ORAKZAI AGENCY" & prov ==0
		replace dist_key = 151 if dist_nm == "POONCH" & prov ==0
		replace dist_key = 152 if dist_nm == "SKARDU" & prov ==0
		replace dist_key = 153 if dist_nm == "SOUTH WAZIRISTAN" & prov ==0
		replace dist_key = 154 if dist_nm == "SUDHNATI" & prov ==0
		  
	
	
	    ta dist_nm if dist_key ==. & prov==0
		ta dist_nm if dist_key ==. & prov==1
	    ta dist_nm if dist_key ==. & prov==2
	    ta dist_nm if dist_key ==. & prov==3
        ta dist_nm if dist_key ==. & prov==4
		
********************************************************************************	

		tempfile dist_2016
		save `dist_2016', replace
********************************************************************************	
		
	    * Merging:
	
		use `villagemap_2016', clear
		
		
		merge 1:m vid using `household_2016'
		 
		keep if _merge ==3
		drop _merge
********************************************************************************	

		preserve
		
		use `child_2016', clear
		merge m:1 did using `dist_2016'
		keep if _merge ==3
		drop _merge
		 
		tempfile child
		save `child', replace
		
		restore 
		 
********************************************************************************	
		 
		merge 1:m hhid using `child'
		keep if _merge ==3
		drop _merge 
	   
 
		ren c003 educationstatus
		
		la def educ_status 1 "Never Enrolled" 2 "Drop-out" 3 "Enrolled"
		la val educationstatus educ_status 
		
		gen in_school = 1 if educationstatus !=. 
		replace in_school = 0 if educationstatus == 1
		replace in_school = 0 if educationstatus == 2
	
	
	   
		gen in_school_ever = 1 if educationstatus !=. 
		replace in_school_ever = 0 if educationstatus == 1
		

		la var in_school "No. of children in school (Age: 3-16 years)"

		
********************************************************************************	
		
		* Variable Harmonization:
	 
	    *1). Grade Variable (currentclassgrade):

	 	ren c005 cg

		replace cg = trim(cg)
		clean_lname cg
		ta cg
		
		
		gen current_grade = 1 if cg == "1"
		* replace grade = 0 if in_school ==0
		
		replace current_grade = 2 if cg == "2"
		replace current_grade = 3 if cg == "3"
		replace current_grade = 4 if cg == "4"
		replace current_grade = 5 if cg == "5"
		replace current_grade = 6 if cg == "6"
		replace current_grade = 7 if cg == "7"
		replace current_grade = 8 if cg == "8"
		replace current_grade = 9 if cg == "9"
		replace current_grade = 10 if cg == "10"
		replace current_grade = 11 if cg == "11"
		replace current_grade = 12 if cg == "12"
		* replace grade = 13 if cg == "13"
		* replace grade = 14 if cg == "BA"
		
		replace current_grade = 0 if cg == "ECE"
		replace current_grade = 0 if cg == "KACHI"
		replace current_grade = 0 if cg == "KG"
		replace current_grade = 0 if cg == "NURSERY"

		replace current_grade = 0 if cg == "PAKKI"
		replace current_grade = 0 if cg == "PG"
		replace current_grade = 0 if cg == "PREP"
		
		replace current_grade = 100 if cg == "HAFIZ"

		
		ta cg, m
		ta current_grade, m

		
		
		ren c004 dg
		replace dg = trim(dg)
		clean_lname dg

		
		gen dropout_grade = 1 if dg == "1"
		replace dropout_grade = 2 if dg == "2"
		replace dropout_grade = 3 if dg == "3"
		replace dropout_grade = 4 if dg == "4"
		replace dropout_grade = 5 if dg == "5"
		replace dropout_grade = 6 if dg == "6"
		replace dropout_grade = 7 if dg == "7"
		replace dropout_grade = 8 if dg == "8"
		replace dropout_grade = 9 if dg == "9"
		replace dropout_grade = 10 if dg == "10"
		replace dropout_grade = 11 if dg == "11"
		replace dropout_grade = 12 if dg == "12"
		* replace grade = 13 if currentclassgrade == "13"
		* replace grade = 14 if currentclassgrade == "BA"
		
		replace dropout_grade = 0 if dg == "ECE"
		replace dropout_grade = 0 if dg == "KACHI"
		replace dropout_grade = 0 if dg == "KG"
		replace dropout_grade = 0 if dg == "NURSERY"

		replace dropout_grade = 0 if dg == "PAKKI"
		replace dropout_grade = 0 if dg == "PG"
		replace dropout_grade = 0 if dg == "PREP"
		
		replace dropout_grade = 100 if dg == "HAFIZ"
		
   
********************************************************************************	
        * Highest Grade:
	   
	    gen highest_grade = current_grade
	    replace highest_grade = dropout_grade if current_grade==. 
	    * replace highest_grade = 0 if in_school_ever ==0

	    gen childschoolprivate =1 if c006 ==2
        gen childschoolgov =1 if c006 ==1
		
	    ren c002 gender
	    ren c001 childage
	    ren c006 institutetype
		
	    gen gender_male =1 if gender == 0
	    replace gender_male =0 if gender == -1
				
		* Private:
		
	    gen private_a =1 if institutetype ==2 | institutetype ==3
	    replace private_a = 0 if institutetype ==1 | institutetype ==4

	    la var private_a "Private Share (all)"

********************************************************************************	

		* Addtional Cleaning
		
	    preserve
		
		* Parent
		import delimited "$aser_raw\2016\ITAASER2016Parent.csv", clear
		ren *, lower
		

		* MOTHER EDUC
		clean_lname pr005
		
		gen hg_mother = 0 if pr005 == "0" | pr005 =="NURSERY" | pr005 == "PG" | pr005 == "PREP" | pr005 == "KG" | pr005 == "KACHI" 
		replace hg_mother = 0 if pr004 == 0
		replace hg_mother = 1 if pr005 == "1" | pr005 == "PRIMARY" | pr005 == "PAKI"
		replace hg_mother = 2 if pr005 == "2"
		replace hg_mother = 3 if pr005 == "3"
		replace hg_mother = 4 if pr005 == "4"
		replace hg_mother = 5 if pr005 == "5" | pr005 == "MIDDLE"
		replace hg_mother = 6 if pr005 == "6"
		replace hg_mother = 7 if pr005 == "7"
		replace hg_mother = 8 if pr005 == "8"
		replace hg_mother = 9 if pr005 == "9"
		replace hg_mother = 10 if pr005 == "10" | pr005== "O LEVEL" | pr005 =="MATRIC"
		replace hg_mother = 11 if pr005 == "11" | pr005 == "INTER"
		replace hg_mother = 12 if pr005 == "12" | pr005 == "PTC" | pr005 == "SSC" | pr005 == "I.COM" | pr005 == "ICS" | pr005 == "CT" | pr005 == "D.COM" | pr005 == "FA" | pr005 == "FSC" | pr005 == "HSSC"
		replace hg_mother = 13 if pr005 == "13"
		replace hg_mother = 14 if pr005 == "14"
		replace hg_mother = 15 if pr005 ==  "15"
		replace hg_mother = 16 if pr005 == "16"
		replace hg_mother = 17 if pr005 == "BA" | pr005 == "BSC" | pr005 == "B.COM" | pr005 == "B.ED" | pr005 == "BACHELOR" | pr005 == "BBS" | pr005 == "BCS" | pr005 == "BS" | pr005 == "BS.ED"  | pr005 == "B.TECH" | pr005 == "GRADUATE" | pr005 == "LLB" | pr005 == "ECE" | pr005 == "CT" //Bachelors 
		replace hg_mother = 18 if pr005 == "MA" | pr005 == "M PHIL" | pr005 == "MS" | pr005 == "MSC" | pr005 == "M.COM" | pr005 == "M.ED"| pr005 == "MASTER"| pr005 == "MBA"| pr005 == "MBBS" | pr005 == "MBS"| pr005 == "MCS" // MASTERS
		replace hg_mother = 19 if pr005 == "PHD"  // PHD
		replace hg_mother = 20 if pr005 == "QURAN" | pr005 == "HAFIZA" | pr005 == "MADRASAH/NFE ISLAMIC EDUCATION" | pr005 == "ALIMA" // Quran


		fre hg_mother
		fre pr005
        
	
		* FATHER EDUC

		clean_lname pr010


		gen hg_father = 0 if pr010 == "0" | pr010 =="NURSERY" | pr010 == "PG" | pr010 == "PREP" | pr010 == "KG" | pr010 == "KACHI" 
		replace hg_father = 0 if pr009 == 0
		replace hg_father = 1 if pr010 == "1" | pr010 == "PRIMARY" | pr010 == "PAKI"
		replace hg_father = 2 if pr010 == "2"
		replace hg_father = 3 if pr010 == "3"
		replace hg_father = 4 if pr010 == "4"
		replace hg_father = 5 if pr010 == "5" | pr010 == "MIDDLE"
		replace hg_father = 6 if pr010 == "6"
		replace hg_father = 7 if pr010 == "7"
		replace hg_father = 8 if pr010 == "8"
		replace hg_father = 9 if pr010 == "9"
		replace hg_father = 10 if pr010 == "10" | pr010== "O LEVEL" | pr010 =="MATRIC"
		replace hg_father = 11 if pr010 == "11" | pr010 == "INTER"
		replace hg_father = 12 if pr010 == "12" | pr010 == "PTC" | pr010 == "SSC" | pr010 == "I.COM" | pr010 == "ICS" | pr010 == "CT" | pr010 == "D.COM" | pr010 == "FA" | pr010 == "FSC" | pr010 == "HSSC" | pr010 == "DIPLOMA" | pr010 == "DAE"
		replace hg_father = 13 if pr010 == "13"
		replace hg_father = 14 if pr010 == "14"
		replace hg_father = 15 if pr010 ==  "15"
		replace hg_father = 16 if pr010 == "16"
		replace hg_father = 17 if pr010 == "BA" | pr010 == "BSC" | pr010 == "B.COM" | pr010 == "B.ED" | pr010 == "BACHELOR" | pr010 == "BBS" | pr010 == "BCS" | pr010 == "BS" | pr010 == "BS.ED"  | pr010 == "B.TECH" | pr010 == "GRADUATE" | pr010 == "LLB" | pr010 == "ECE" | pr010 == "CT" | pr010 == "BA B.ED"| pr010 == "BBA"| pr010 == "BE"| pr010 == "DENTAL" | pr010 == "DOCTOR" | pr010 == "ENGINEER" | pr010 == "DPA" | pr010 == "DVM" | pr010 == "DHMS" | pr010 ==  "DHE" | pr010 == "DENTAL" | pr010 == "CA" | pr010 == "CSS"  | pr010 == "PST" //Bachelors 
		replace hg_father = 18 if pr010 == "MA" | pr010 == "M PHIL" | pr010 == "MS" | pr010 == "MSC" | pr010 == "M.COM" | pr010 == "M.ED"| pr010 == "MASTER"| pr010 == "MBA"| pr010 == "MBBS" | pr010 == "MBS"| pr010 == "MCS" | pr010 == "M ED"  | pr010 == "M PHILL"| pr010 == "MA B.ED"| pr010 == "MA CT" // MASTERS
		replace hg_father = 19 if pr010 == "PHD"  // PHD
		replace hg_father = 20 if pr010 == "QURAN" | pr010 == "HAFIZA" | pr010 == "MADRASAH/NFE ISLAMIC EDUCATION" | pr010 == "ALIM" | pr010 == "MAULVI" | pr010 == "MOLANA"| pr010 == "MOLVI"| pr010 == "MUFTI" | pr010 == "HAFIZ" // Quran

		
		fre hg_father
		fre pr010
		
	
		bysort hhid: gen x =_n

		keep hhid hg_* x
		reshape wide hg_father hg_mother, i(hhid) j(x) 


		egen hg_mom = rowmax (hg_mother1 hg_mother2 hg_mother3 hg_mother4 hg_mother5)
		br hg_mother1 hg_mother2 hg_mother3 hg_mother4 hg_mother5 if hg_mom ==20


		egen hg_dad = rowmax (hg_father1 hg_father2 hg_father3 hg_father4 hg_father5)
		br hg_father1 hg_father2 hg_father3 hg_father4 hg_father5 if hg_dad ==20


		keep hhid hg_dad hg_mom


		gen x =1 if hg_dad > hg_mom & hg_dad !=.
		gen y =1 if hg_mom > hg_dad & hg_mom !=.


		ta x y

		gen hh_es = hg_mom
		replace hh_es = hg_dad if x ==1 & hg_dad !=20


		gen hh_educ_status = 1 if hh_es ==0
		replace hh_educ_status = 2 if hh_es >=1 & hh_es <=5  // primary
		replace hh_educ_status = 3 if hh_es >=6 & hh_es <=8  // secondary
		replace hh_educ_status = 4 if hh_es >=9 & hh_es <=10 // higher secondary
		replace hh_educ_status = 5 if hh_es >=11 & hh_es <=12 // Fsc Fa
		replace hh_educ_status = 6 if hh_es >=13 & hh_es <=14 | hh_es == 17 // bachelors
		replace hh_educ_status = 6 if hh_es >=15 & hh_es <=16 | hh_es == 18 // masters
		replace hh_educ_status = 6 if hh_es ==19 // Phd
		replace hh_educ_status = . if hh_es ==20 // Other


		la def hh_educ_status 1 "Less than grade 1" 2 "Primary(1-5)" 3 "Secondary(6-8)" 4 "Higher Secondary (9-10)" 5 "Fa/Fsc/Diplomas" 6 "Bachelors or higher"		
		la val hh_educ_status hh_educ_status
		la var hh_educ_status "HH's Education Level"


		
		keep hhid hh_educ_status

	
		tempfile parent_2016
		save `parent_2016', replace
		
		restore

		
	    merge m:1 hhid using `parent_2016', nogen
	
********************************************************************************	
		
		* Cleaning HH assets:
		/*
		 
		Household Type, Ownership of household, Electricity, Television, Mobile Phones, Computer and Motor Vehicle. 
		 
		*/
			
			
	    * Type of HH:		
		
		
		* Var cleaning 
		recode h003 h004 h005 h006   h011 h010 (-1 =1)

		   
		* Type of HH:
		   
	    gen WI_housetype = h002
		  
		la def ht 1 "Katcha" 2 "Semi Pacca" 3 "Pacca"
	    la val WI_housetype ht
		  
		  
		  
		* Ownership of HH
			   
		 gen WI_houseownership = h003
			   
			   
	    * electricity:
			
		 gen WI_electricity = h004
			
		 * Television 
					
		 gen WI_tv = h005
			
			
		 * Mobile phones
			
		 gen WI_mobile = h006
			
		
		 * cars:
			
		 *  gen WI_motorcycles = h008
			
		 * motorcycle 
			
		 *  gen WI_cars = h009
			
			
		 gen WI_vechile = 0 if h008 !=.| h009 !=.
		 replace WI_vechile =1 if h008 ==1 | h009 ==1
		 replace WI_vechile =2 if h008 ==2 | h009 ==2
		 replace WI_vechile =3 if h008 ==3 | h009 ==3
		 replace WI_vechile =4 if h008 ==4 | h009 ==4
			
		 replace WI_vechile =5 if h008 ==5 | h009 ==5
		 replace WI_vechile =6 if h008 ==6 | h009 ==6
		 replace WI_vechile =7 if h008 ==7 | h009 ==7
		 replace WI_vechile =8 if h008 ==8 | h009 ==8
		 replace WI_vechile =9 if h008 ==9 | h009 ==9
		 replace WI_vechile =10 if h008 ==10 | h009 ==10
		 replace WI_vechile =11 if h008 ==11 | h009 ==11

			
		 * Computer
			
		 gen WI_computer = h010
			
		 * Solar panels 
		
		 * gen WI_solarpanel = h012

********************************************************************************	
		 
		 
	     // Final Income Variable for PCA analysis to create a Wealth Index
		
		 quiet: estpost sum WI_*	
		 esttab, cell("mean(label(Mean)fmt(%9.3f)) sd(label(S.D)) min(label(Min)fmt(%9.0f)) max(label(Max)fmt(%9.0f)) count(label(Obs.)fmt(%9.0f))") label nonumber noobs 


			
		// Principal Component Analysis

		* SES 1: taking Yearly total income variable
		
		pca WI_*
		predict Asset_Level

		alpha WI_*

		cap drop asset_quintiles
		xtile asset_quintiles = Asset_Level , n(5)
		
		la var asset_quintiles "Asset Quintiles from Wealth Index"

		
        la def quintiles 1 "Bottom 20" 2 "20-40" 3 "40-60" 4 "60-80" 5 "Upper 20", modify
	    la val asset_quintiles quintiles
	
	    ren hh_educ_status hh_educ_level
	
	    ren childage age

	    fre asset_quintiles
	    fre hh_educ_level
	
		* Corr
		
		corr hh_educ_level asset_quintiles

		
		table asset_quintiles , c(mean in_school)
		table asset_quintiles if age>=6 & age<=10 , c(mean in_school)
				
		table hh_educ_level , c(mean in_school)		
		table hh_educ_level if age>=6 & age<=10 , c(mean in_school)
		
		gen year = 2016
		 
		

********************************************************************************	
		save "$aser_clean/ASER_HH_2016.dta", replace
********************************************************************************	
		
		keep if prov ==1
	    labmask dist_key, val(dist_nm2)

********************************************************************************	
		save "$aser_clean/ASER_HH_clean_2016_punjab.dta", replace
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
				
	    ren hhid hhcode
	    ren childid member_id
	    ren prov province
	 
	    recode math reading english (0=.)
	  
		la def math 1 "Beginner" 2 "Count 1-9" 3 "Count 1-99" 4 "Count 100-200" 5 "Subtraction" 6 "Division"
		la val math  math
		  
	    la def reading 1 "Beginner" 2 "Read letters" 3 "Read words" 4 "Read sentence" 5 "Read story"
	    la val reading reading
	  
	    la def english 1 "Beginner" 2 "Read Capital letter" 3 "Read Small Letter" 4 "Read words" 5 "Read sentence"
	    la val english english
	  
	 
********************************************************************************	
	   
		* Define Labels:
		
		la def yn 1 "Yes" 0 "No"
		* la def ht 1 "Kaccha" 2 "Semi-Paca" 3 "Pacca"
		la def gender 1 "Female" 0  "Male"
		
		la def difficult 1 "No difficulty" 2 "Yes some difficulty" 3 "Yes a lot of difficulty" 4 "Cannot see at all" 
		la def rlang 1 "Urdu" 2 "Sindhi" 3 "Pashto"
		la def it 1 "Government" 2 "Private" 3 "Madrassa" 4 "Other (NFBE)"
		la def dropreason 1 "Law and order" 2 "Poverty" 3 "Flood" 4 "School building shifted by govt" 5 "other" 6 "Migration" 7 "Illness" 8 "Misc Reasons with frequency less than 5 case"
	
********************************************************************************	
	
		
		recode v001 v002 v003 v004 v005 v006 (-1=1)
		la val v001 v002 v003 v004 v005 v006 yn

		la var v001 "Village: Post office available"
		
		la var v002 "Village: Bank"
		
		la var v003 "Village: Public call office"
		
		la var v004 "Village: Computer Center"
		
		la var v005 "Village: Hospital/Health Unit"
		
		la var v006 "Village: Carpeted Roads"
		
		la var v007 "Village: Total number of Government Schools"
		
		la var v008 "Village: Total number of Private Schools"
	   
********************************************************************************	
	  	
	
		la var hcounter "Sampled household in village"
		la var rid "Region Identification Code"
		
		ren hhcode hhid
		la var hhid "Household ID"

		
		la var h001m "Male members of the HH"
		la var h001f "Female members of the HH"
		
		la var h002  "HH Type"
		la val h002 ht
		fre h002
	

	
********************************************************************************	

	    codebook h003 h004 h005 h006 h008 h009 h010 h011 hbisp hpspa hakhu, comp
		
		recode hbisp hpspa hakhu h100 h101(-1=1)
		
		
		la var h003  "Ownership of HH"
		la var h004 "hh asset: Electricity"
		la var h005 "hh asset: Tv"
		la var h006 "hh asset: Mobile"
		la var h008 "hh asset: No. of Cars"
		la var h009 "hh asset: No. of Motorcycles" 
		la var h010  "hh asset: Computer"
		la var h011  "hh asset: Solar Panel"
		
		la var hbisp "Social Safety Net - BISP"
		la var hpspa "Social Safety Net - PSPA"
		la var hakhu  "Social Safety Net - Akhuwat"
	
		la var h100 "hh asset: SMS"
		la var h101 "hh asset: Whatsapp"
		
		
		la val h003 h004 h005 h006 h008 h009 h010 h011 hbisp hpspa hakhu h100 h101 yn

		
		drop v24 v25 v26 v27 v28 v29 v30 v31
		
		la var member_id "Member ID"
		la var hhid "Household ID"
		
********************************************************************************	
	
		recode gender (-1=1)
		la var age "Age" 
		la var gender "Gender"
		la val gender gender
		
		destring c003a, replace
		la var c003a "Reason for Dropout"
		la val c003a dropreason
		
		
		recode institutetype (0=.)
		la var institutetype "Type of Institute"
		la val institutetype it
		
********************************************************************************	
		
		recode c007 c008a  c010a c010b c012a c012b c012c c013a c013b c014 c015 c016 c017 c018 c019 (-1=1)
		la val c007 c008a  c010a c010b c012a c012b c012c c013a c013b c014 c015 c016 c017 c018 c019 yn
		recode c011 (0=.)
				
		la var c007 "Currentlly enrolled: Does the child goes to surveys school?"
		la var c008a "Is the child currently taking any paid tuition? "
		la var c008b "What is fee for tuition"
			
		la var c010a "Is the bonus question 1, about reading, attempted by the child correctly? "
		la var c010b "Is the bonus question 2, about reading, attempted by the child correctly? "
		la var c012a "Is the bonus question 1, about math, attempted by the child correctly?"
		la var c012b "Is the bonus question 2, about math, attempted by the child correctly?" 
		la var c012c "Is the bonus question 3, about math, attempted by the child correctly?"
		la var c013a "Is the bonus question 1, about english, attempted by the child correctly?"
		la var c013b "Is the bonus question 2, about english, attempted by the child correctly?"
		la var c014  "English: knows word meaning"
		la var c015  "English: knows sentence meaning"
		la var c016  "General Knowledge: English Poem"
		la var c017 "General Knowledge: English Q2"
		la var c018  "General Knowledge: English - figure recognition"
		la var c019  "Child available at the time of interview"

		
		la var c011 "Language Tested in Reading"
		la val c011 rlang

********************************************************************************	
			
		 recode hf001 hf002 hf003 hf004 hf005 hf006 hf007  (0=.)
		 la val hf001 hf002 hf003 hf004 hf005 hf006 hf007 difficult

		 
		la var hf001 "Does your child has difficulty in seeing, even if wearing glasses"
		la var hf002 "Does your child has difficulty in hearing, even if wearing hearing aids? "
		la var hf003 "Does your child has difficulty in walking, compared with children of same age?"
		la var hf004 "Does your child has difficulty with self-care such as feeding or dressing him/herself, compared with children of same age"
		la var hf005  "Does your child has difficulty in being understood by others using customary/usual language, compared with children of same age?"
		la var hf006 "Does your child has difficulty in remembering things that he/she has learned, compared with children of same age?"
		la var hf007 "Does your child using any aids and appliances (tick as many as application)"
		la var educationstatus "Education Status"



********************************************************************************	
				
		la var prid "Identification of Parents"
	  
		ren dist_nm district_name
		la var district_name "Original: District Name"
		
		ren dist_nm2 dist_nm
		
		la var province "Province"

		la var in_school "Currently enrolled in school"
		la var in_school_ever "Ever enrolled in school"
		la var current_grade "Current Grade"
		la var dropout_grade  "Dropout Grade"
		la var highest_grade  "Highest Grade"
		la var childschoolprivate "Child enrolled in Private"
		la var childschoolgov "Child enrolled Government School"
		la var gender_male "Gemder - Male"
		
		
		la var hh_educ_level "HH Education Level"
		la var WI_housetype "Asset: House Type"
		la var WI_houseownership "Asset: House Ownership Dummy"
		la var WI_electricity "Asset: Electricity Dummy"
		la var WI_tv  "Asset: TV Dummy"
		la var WI_mobile  "Asset: Mobile Dummy"
		la var WI_vechile "Asset: Vechile"
		la var WI_computer "Asset: Computer Dummy"
		la var Asset_Level "Asset Score  - (PCA)"
		la var asset_quintiles  "Asset Quintiles -(PCA)"
		la var year "Year"

		la var member_id "Member ID" 
		la var gender_male "Male Dummy"


********************************************************************************	
	
	    drop if member_id ==.
	  
	    ren hhid hhcode
	    la var hhcode "Household Code"
	  
	    isid hhcode member_id
	  
	    drop private_share_a private_share syear ischildwasavailable out_of_school child_school_type rname pcode v6  dg cg pr001 pr002 pr003 pr004 pr005 pr006 pr007 pr008 pr009 pr010 pr011 pr012 pcode
		 
		* region - error in the area var
		 
		fre area

 
********************************************************************************	
		save "$aser_clean/ASER_HH_clean_2016.dta", replace
********************************************************************************	
		
		
		
