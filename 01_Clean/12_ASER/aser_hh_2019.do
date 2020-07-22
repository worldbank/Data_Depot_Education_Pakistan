
* ASER DATA CLEANING : 
* Author: Ahmed Raza
* Date: 20th April 2020
* Purpose: Cleaning ASER data:  HH data - 2019

	
		* Init for Globals

		include init.do
		

********************************************************************************	
	   * YEAR: 2019
********************************************************************************	

		import delimited "$aser_raw\2019\ITAASER2019CHILD.CSV", encoding(ISO-8859-9) clear

		ren cid member_id

		la var syear  "Year"
		ren syear year

		la def area 1 "Urban" 2 "Rural"
		la val area area
		la var area "Rural or Urban"

		clean_lname rname
		la def prov 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP" 0 "OTHER AREAS"			

		gen prov = 1 if rname == "PUNJAB"
		replace prov = 2 if rname == "SINDH"
		replace prov = 3 if rname == "BALOCHISTAN"
		replace prov = 4 if rname == "KHYBER PAKHTUNKHWA"
		replace prov = 0 if rname == "ISLAMABAD ICT" | rname == "AZAD JAMMU AND KASHMIR" | rname == "GILGIT BALTISTAN" |  rname == "FEDERALLY ADMINISTRATED TRIBAL AREAS"


		fre rname 
		fre prov


		* District Cleaning :

		clean_lname dname
		gen dist_nm = dname


		fre dist_nm


		* District Level Cleaning:
		
	    * Punjab
	
        gen dist_key = 1	if prov ==1	 
		replace dist_key = 1 if dist_nm == "ATTOCK"	 & prov ==1
		replace dist_key = 2 if dist_nm == "BAHAWALNAGER" & prov ==1
		replace dist_key = 3 if dist_nm == "BAHAWALPUR" & prov ==1
		replace dist_key = 4 if dist_nm == "BHAKKAR"  & prov ==1
		replace dist_key = 5 if dist_nm == "CHAKWAL"  & prov ==1
		replace dist_key = 6 if dist_nm == "DERA GHAZI KHAN"  & prov ==1
		replace dist_key = 7 if dist_nm == "FAISALABAD"  & prov ==1
		replace dist_key = 8 if dist_nm == "GUJRANWALA"  & prov ==1
		replace dist_key = 9 if dist_nm == "GUJRAT"  & prov ==1
		replace dist_key = 10 if dist_nm == "HAFIZABAD"  & prov ==1
		replace dist_key = 11 if dist_nm == "JEHLUM"  & prov ==1
		replace dist_key = 12 if dist_nm == "JHANG"  & prov ==1
		replace dist_key = 13 if dist_nm == "KASUR"  & prov ==1
		replace dist_key = 14 if dist_nm == "KHANEWAL"  & prov ==1
		replace dist_key = 15 if dist_nm == "KHUSHAB"  & prov ==1
			 
		replace dist_key = 16 if dist_nm == "LAHORE"  & prov ==1
		replace dist_key = 17 if dist_nm == "LAYYAH"  & prov ==1
		replace dist_key = 18 if dist_nm == "LODHRAN"  & prov ==1
		replace dist_key = 19 if dist_nm == "MANDI BAHUDDIN"  & prov ==1
		replace dist_key = 20 if dist_nm == "MIANWALI"  & prov ==1
		replace dist_key = 21 if dist_nm == "MULTAN"  & prov ==1
		replace dist_key = 22 if dist_nm == "MUZAFFAR GARH"  & prov ==1
		replace dist_key = 23 if dist_nm == "NAROWAL"  & prov ==1
		replace dist_key = 24 if dist_nm == "OKARA"  & prov ==1
		replace dist_key = 25 if dist_nm == "PAKPATTAN"  & prov ==1
		replace dist_key = 26 if dist_nm == "RAHIM YAR KHAN"  & prov ==1
		replace dist_key = 27 if dist_nm == "RAJANPUR"  & prov ==1
		replace dist_key = 28 if dist_nm == "RAWALPINDI"  & prov ==1
		replace dist_key = 29 if dist_nm == "SAHIWAL"  & prov ==1
		replace dist_key = 30 if dist_nm == "SARGODHA"  & prov ==1
		replace dist_key = 31 if dist_nm == "SHEIKHUPURA"  & prov ==1
		replace dist_key = 32 if dist_nm == "SIALKOT"  & prov ==1
		replace dist_key = 33 if dist_nm == "T.T.SINGH"  & prov ==1
		replace dist_key = 34 if dist_nm == "VEHARI"  & prov ==1
		replace dist_key = 35 if dist_nm == "NANKANA SAHIB"  & prov ==1
        replace dist_key = 36 if dist_nm == "CHINIOT"  & prov ==1				
		
		la var dist_key "District-ID :Key"
		la var dist_nm "Clean: District Name"
		
		ta dist_nm if dist_key ==. & prov==1

		*KP:
		
		replace dist_nm = "PESHAWAR" if dist_nm == "PESHAWAR URBAN" & prov ==4 
  
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
		  
		replace dist_nm = "KARACHI" if dist_nm == "KARACHI SOUTH" | dist_nm =="KORANGI" 
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
		 
		replace dist_key = 116 if dist_nm == "DUKKI" & prov ==3
		replace dist_key = 117 if dist_nm == "LEHRI" & prov ==3	 
		replace dist_key = 118 if dist_nm == "KECH (TURBAT)" & prov ==3
		replace dist_key = 119 if dist_nm == "PANJGUR" & prov ==3	 
		
	    replace dist_key = 120 if dist_nm == "SOHBATPUR" & prov ==3
		replace dist_key = 121 if dist_nm == "SURAB" & prov ==3
		 
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
		replace dist_key = 131 if dist_nm ==  "F.R. PESHAWAR" & prov ==0
		replace dist_key = 132 if dist_nm == "F.R. TANK" & prov ==0
		replace dist_key = 133 if dist_nm == "GHANCHE" & prov ==0
		replace dist_key = 134 if dist_nm == "GHIZER" & prov ==0
		replace dist_key = 135 if dist_nm == "GILGIT" & prov ==0
		replace dist_key = 136 if dist_nm == "HATTIAN" & prov ==0
		replace dist_key = 137 if dist_nm == "HAVELI" & prov ==0
		replace dist_key = 138 if dist_nm == "HUNZA" & prov ==0
		replace dist_key = 139 if dist_nm == "ISLAMABAD" & prov ==0
		replace dist_key = 140 if dist_nm == "KHARMANG" & prov ==0
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
		replace dist_key = 155 if dist_nm == "SHIGAR" & prov ==0

		replace dist_key = 156 if dist_nm == "DARIAL"
	    replace dist_key = 157 if dist_nm == "GUPIS YASIN"
		replace dist_key = 158 if dist_nm == "RONDU"
		replace dist_key = 159 if dist_nm == "TANGIR"
		  
	    ta dist_key if prov ==0
		ta dist_nm if prov ==0
		ta dist_nm if dist_key ==. & prov==0
 
		 
		 
		 
        * In School		 
		 		
		ren c003 educationstatus
		
		la def educ_status 1 "Never Enrolled" 2 "Drop-out" 3 "Enrolled"
		la val educationstatus educ_status 
		
		gen in_school = 1 if educationstatus !=. 
		replace in_school = 0 if educationstatus == 1
		replace in_school = 0 if educationstatus == 2

		gen in_school_ever = 1 if educationstatus !=. 
		replace in_school_ever = 0 if educationstatus == 1

	    * 1). Grade Variable (currentclassgrade):

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
		
		replace current_grade = 100 if cg == "HAFIZ/ALIM/RELIGIOUS"

		
		ta cg, m
		ta current_grade, m

		
		
		ren c004 dg
		replace dg = trim(dg)
		clean_lname dg
		
		* data entry mistake ? Check with ASER 1 obs value code 16 which is not according to the codebook
		
		replace dg = "1" if dg == "16"

		
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
		
	   
	    ta dg
	    ta dropout_grade
	   
 ********************************************************************************
		* Highest Grade:
	   
	    gen highest_grade = current_grade
	    replace highest_grade = dropout_grade if current_grade==. 
	    
		* replace highest_grade = 0 if in_school_ever ==0
********************************************************************************
 		
		ren c002 gender
		ren c001 age
		clonevar institutetype = c006
		
		
		la def sc 1 "Private" 2 "Public" 3"Institutions:Army/Police/Navy/Wapda/Railways/LDA"4 "Non-Profits" 5 "PEF" 6 "NFBE" 7 "Government Departments/Welfare Schools (both Public & Private)" 8 "Other" 9 "Religious"

		fre institutetype

		gen school_category = 1 if institutetype ==2
		replace school_category =2 if institutetype ==1
		replace school_category =9 if institutetype ==3
		replace school_category =6 if institutetype ==4


		la val school_category sc

		fre school_category


		gen sex =1 if gender == 0
		replace sex = 2 if gender ==1
		replace sex = 0 if gender ==2

		la def sex 1 "Male" 2"Female" 0 "Transgender"
		la val sex sex
		fre sex


		 tostring hhid, replace

		* Parent's Education 

		preserve

		import delimited "$aser_raw\2019\ITAASER2019PARENT.CSV", encoding(ISO-8859-9) clear

		ren *, lower
			
		* MOTHER EDUC
		clean_lname pr005
		
		fre pr005
		
	    la def hh_educ_status 1 "Less than grade 1" 2 "Primary(1-5)" 3 "Secondary(6-8)" ///
		4 "Higher Secondary (9-10)" 5 "Fa/Fsc/Diplomas" 6 "Bachelors or higher"				
				
		cap drop hg_mother
		gen hg_mother = 1 if pr005 == "0"
		replace hg_mother = 1 if pr004 == 0
		replace hg_mother = 2 if pr005 == "1"
		replace hg_mother = 2 if pr005 == "2"
		replace hg_mother = 2 if pr005 == "3"
		replace hg_mother = 2 if pr005 == "4"
		replace hg_mother = 2 if pr005 == "5"
		replace hg_mother = 3 if pr005 == "6"
		replace hg_mother = 3 if pr005 == "7"
		replace hg_mother = 3 if pr005 == "8"
		replace hg_mother = 4 if pr005 == "9"
		replace hg_mother = 4 if pr005 == "10"
		replace hg_mother = 5 if pr005 == "INTERMEDIATE" | pr005 == "GRADUATE" | pr005 == "CT" | pr005 == "LLB" | pr005 == "ALIM/HAFIZ/MADRASSAH"
		replace hg_mother = 6 if pr005 == "MPHIL" | pr005 == "MASTERS" | pr005 == "MBBS" | pr005 == "PHD" | pr005 == "BACHELORS" | pr005 == "B.ED/M.ED" 
		
		
		fre pr005
		fre hg_mother

		la val hg_mother hh_educ_status
		fre hg_mother

		
		* FATHER EDUC

		clean_lname pr010
		
		fre pr009
		fre pr010
		
		gen hg_father = 1 if pr010 == "0"
		replace hg_father = 1 if pr009 == 0
		replace hg_father = 2 if pr010 == "1"
		replace hg_father = 2 if pr010 == "2"
		replace hg_father = 2 if pr010 == "3"
		replace hg_father = 2 if pr010 == "4"
		replace hg_father = 2 if pr010 == "5"
		replace hg_father = 3 if pr010 == "6"
		replace hg_father = 3 if pr010 == "7"
		replace hg_father = 3 if pr010 == "8"
		replace hg_father = 4 if pr010 == "9"
		replace hg_father = 4 if pr010 == "10"
		replace hg_father = 5 if pr010 == "CT" | pr010 == "INTERMEDIATE" | pr010 == "GRADUATE" | pr010 == "CT" | pr010 == "ALIM/HAFIZ/MADRASSAH" 
		
		replace hg_father = 6 if pr010 == "BACHELORS"| pr010 == "B.ED/M.ED"| pr010== "M PHIL" | pr010 == "MASTERS" | pr010 == "PHD" 
		
		la val hg_father hh_educ_status
		
		fre pr010
		fre hg_father


		isid hhid prid 

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
		replace hh_es = hg_dad if x ==1 

		ren hh_es hh_educ_status

		la val hh_educ_status hh_educ_status
		la var hh_educ_status "HH's Education Level"
		
		keep hhid hh_educ_status
		
		tempfile parent_2019
		save `parent_2019', replace
		
        restore
        
********************************************************************************		
	    merge m:1 hhid using `parent_2019', nogen        
********************************************************************************
		
        preserve


		import delimited "$aser_raw\2019\ITAASER2019HOUSEHOLD.CSV", encoding(ISO-8859-9) clear

		tostring hhid, replace


		tempfile hh_2019
		save `hh_2019', replace

		restore 
				 

********************************************************************************
		merge m:1 hhid using `hh_2019', nogen
********************************************************************************		

		 
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
		  
		* Smart Phones
			
		gen WI_smartphone = h007
			
			
	    * Cars 
			
		gen WI_cars = 0 if h008 ==0
	    replace WI_cars = 1 if h008 != 0 & h008 != . 
			
		* motorcycles:
			
		gen WI_motorcycle = 0 if h009 ==0
		replace WI_motorcycle = 1 if h009 != 0 & h009 != . 
						
	    * Computer:
	
		gen WI_computer = h010
			
		* Solar panels 
		
		gen WI_solarpanel = h011
			
	    * Internet
		
        gen WI_internet = h012 
		 
		 
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

		fre asset_quintiles
		fre hh_educ_level
		
		* Corr
		
		corr hh_educ_level asset_quintiles
		
		
		table asset_quintiles , c(mean in_school)
		table asset_quintiles if age>=6 & age<=10 , c(mean in_school)
		
		table hh_educ_level , c(mean in_school)
		table hh_educ_level if age>=6 & age<=10 , c(mean in_school)
		
	
	    labmask dist_key, val(dist_nm)

		* Error in institution type variable 0 = missing (check with ASER)
	
	    ren c010 readinghighestlevel
		ren c012 mathhighestlevel	
		ren c013 englishreading
	
		
	    * LEARNING OUTCOMES:
					 
		*  READING:
		ren readinghighestlevel reading
		
		*  MATH:
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


     	la def math 1 "Beginner" 2 "Count 1-9" 3 "Count 1-99" 4 "Count 100-200" 5 "Subtraction" 6 "Division"
	    la val math  math
	  
	  
	    la def reading 1 "Beginner" 2 "Read letters" 3 "Read words" 4 "Read sentence" 5 "Read story"
	    la val reading reading
	  
	  
	    la def english 1 "Beginner" 2 "Read Capital letter" 3 "Read Small Letter" 4 "Read words" 5 "Read sentence"
	    la val english english
	

		gen education_status = 1 if in_school ==1
		replace education_status = 2 if in_school_ever ==1 & in_school ==0
		replace education_status = 3 if in_school_ever ==0
		
		la var education_status "Education Status"
		la val education_status educ_status
		
		* region
		
		fre area
		

		drop year 
		gen year = 2019
		
		
		* 1,533/290,309 Some observations have missing member_ids which are not dropped from the aser 2019 data.

		* dropping not applicable id with missing
		drop if hhid == "#N/A"
		
		
		
		
		
		* Save datasets:
		
********************************************************************************		
		save "$aser_clean/ASER_HH_clean_2019.dta", replace
********************************************************************************


********************************************************************************			
		save "$aser_clean/ASER_HH_2019.dta", replace
********************************************************************************
	
	
********************************************************************************	
		keep if prov ==1

		save "$aser_clean/ASER_HH_clean_2019_punjab.dta", replace
********************************************************************************

