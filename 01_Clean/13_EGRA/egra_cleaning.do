* ASAER DATA CLEANING : 
* Author: Ahmed Raza
* Date: 18th Nov 2019
* Purpose: To create the panel of EGRA datasets:

		* Dropbox Globals
		
        include init.do
		

	    /*	
	
********************************************************************************		
		* 1st Folder: Pakistan EGRA 2013-2017 datasets and codebook_081718
********************************************************************************

		* AZAD AND JAMMU KASHMIR 

		* 2013
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2013_2017_base_mid_ajk_student_PUF_w_share.dta", clear

		* 2017
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2017_base_ajk_student_PUF_w_share.dta", clear


********************************************************************************


		* BALOCHISTAN

		* 2013
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2013_2017_base_mid_balochistan_student_PUF_w_share.dta", clear
		* 2017
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2017_base_balochistan_student_PUF_w_share.dta", clear


********************************************************************************

		* Gilgit

		* 2013
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2013_2017_base_mid_gb_student_PUF_w_share.dta", clear

		* 2017
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2017_base_gb_student_PUF_w_share.dta", clear

********************************************************************************

		*KP

		* 2013
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2013_2017_base_mid_kp_student_PUF_w_share.dta", clear

		* 2017
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2017_base_kp_student_PUF_w_share.dta", clear

********************************************************************************
		* FATA:
		use "$rawdata\Pakistan EGRA 2013-2017 datasets and codebook_081718\pak_midline_2017_base_fata_student_PUF_w_share.dta", clear

********************************************************************************
*/


			
********************************************************************************
		* 2nd Folder: Pakistan EGRA 2013-2017 datasets and codebook_081718
********************************************************************************


		* AZAD AND JAMMU KASHMIR 

		* 2013
		use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_ajk_student_PUF_w_share.dta", clear
		destring school_code_m, replace
		isid school_code_m grade id year
		gen province = "ajk"


		tempfile ajk
		save `ajk', replace


********************************************************************************


		* BALOCHISTAN

		use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_balochistan_student_PUF_w_share.dta", clear

		destring school_code_m, replace

		gen province = "balochistan"
		duplicates tag school_code_m grade id year , gen (x)
		ta x
		duplicates drop school_code_m grade id year , force
		drop x

		isid school_code_m grade id year

		tempfile balochistan
		save `balochistan', replace



********************************************************************************

		* Gilgit

		use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_gb_student_PUF_w_share.dta", clear


		destring school_code_m, replace
		isid school_code_m grade id year

		gen province = "gb"


		isid school_code_m grade id year

		tempfile gb
		save `gb', replace



********************************************************************************

		*KP

		use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_kp_student_PUF_w_share.dta", clear


		destring school_code_m, replace

		isid school_code_m grade id year
		gen province = "kp"

		isid school_code_m grade id year


		tempfile kp
		save `kp', replace


********************************************************************************
		*ICT

		use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_ict_student_PUF_w_share.dta", clear


		destring school_code_m, replace

		tostring language, replace
		drop language
		gen lanuage = "Urdu"


		isid school_code_m grade id year

		gen province = "ict"
		tempfile ict
		save `ict', replace

********************************************************************************

		* SINDH

		use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_sindh_SND_student_PUF_w_share.dta", clear
		
		* Note: This file has a lot of ids missing 

		drop if id ==.

		duplicates tag school_code_m grade id year , gen (x)
		ta x
		duplicates drop school_code_m grade id year , force
		drop x

		isid school_code_m grade id year


		gen province = "sindh"



		destring school_code_m, replace
		codebook school_code_m grade id year, compact


		tempfile sindh1
		save `sindh1', replace

		
        use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_sindh_URD_student_PUF_w_share.dta", clear

		drop if id ==.

		duplicates tag school_code_m grade id year , gen (x)
		ta x
		duplicates drop school_code_m grade id year , force
		drop x

		isid school_code_m grade id year


		gen province = "sindh"


		destring school_code_m, replace
		codebook school_code_m grade id year, compact

		tempfile sindh2
		save `sindh2', replace


		merge 1:1 school_code_m grade id year  using `sindh1'


		tostring language, replace

		* ren _merge sindh_chk


		tempfile sindh
		save `sindh', replace



		********************************************************************************

		* Punjab

		use "$egra_raw\2013\pak_baseline_2013_base_punjab_student_PUF_share.dta", clear


		
		destring school_code_m, replace
		destring id_str, gen(id)

		isid school_code_m grade id year


		drop province
		gen province = "punjab"

		* language
		tostring language, replace
		ren language lang

		gen language = "Urdu" if lang ==2 
		drop lang 


		* treat_phase

		drop treat_phase
		gen treat_phase =1




		destring school_code_m, replace

		tempfile punjab
		save `punjab', replace


		********************************************************************************

		* Append the data:

		append using `sindh'
		append using `ict'
		append using `kp'
		append using `gb'
		append using `balochistan'
		append using `ajk'


		drop _merge 
		isid school_code_m grade id year province
		egen panelid = group(province school_code_m grade id)


		* clean province var
			
		ren province prov
			
			
		fre prov

		gen province = 1  if prov == "punjab"
		replace province = 2  if prov == "sindh"
		replace province = 3  if prov == "balochistan"
		replace province = 4  if prov == "kp"
		replace province = 5 if prov == "ajk" | prov == "gb" | prov == "ict"				
							
							
							
	    la def prov 1 "Punjab" 2 "Sindh" 3 "Balochistan" 4 "KP" 5 "OTHER AREAS"				
	    la val province prov 


		fre province 
		fre prov
	    drop prov
		   
		drop country
	    gen country =1 
	    la def country 1 "Pakistan"
        la var country country
		   
   	    ren wt_final weight_egra
		   
		sum weight_egra
		   
		replace weight_egra = 1 if province ==1
		   
		ta year
		   
		* region
		
		ren region prov
		
        gen region = 1 if urban ==1
		replace region = 2 if urban == 0
		la drop region
		la def region 1 "urban" 2 "rural"
		la val region region
		
		fre region
		fre urban
	    
		
		save "$egra_clean/EGRA_clean_2013-2017.dta", replace




		*******************************************************************************

		* Check how many observations in baseline match with endline:

		/*
		preserve

		keep if year ==2013
		tempfile year1
		save `year1', replace

		restore


		preserve

		keep if year ==2017

		merge 1:1 panelid using `year1'

		restore



		* matched : 9259
		*/




