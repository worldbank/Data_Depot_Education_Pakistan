* ASAER DATA CLEANING : 
* Author: Ahmed Raza
* Date: 18th Nov 2019
* Purpose: To create the panel of EGRA datasets:
	


clear all
set more off

		* Dropbox Globals
		
        include init.do
		
		
********************************************************************************		
* 1st Folder: Pakistan EGRA 2013-2017 datasets and codebook_081718
********************************************************************************


* AZAD AND JAMMU KASHMIR 

* 2013
use "$egra_raw\2013-2017_081718\pak_midline_2013_2017_base_mid_ajk_student_PUF_w_share.dta", clear

count
fre form
ta year

isid school_code_m grade id treat_phase 



* 2017
use "$egra_raw\2013-2017_081718\pak_midline_2017_base_ajk_student_PUF_w_share.dta", clear

count
fre form
ta year


isid school_code_m grade id treat_phase 


	
********************************************************************************		
* 2nd Folder: Pakistan EGRA 2013-2017 datasets and codebook_081718
********************************************************************************


* AZAD AND JAMMU KASHMIR 

* 2013
use "$egra_raw\2013-2017_082218\pak_midline_2013_2017_base_mid_ajk_student_PUF_w_share.dta", clear

count
fre form
ta year

isid school_code_m grade id treat_phase 


* 2017

use "$egra_raw\2013-2017_082218\pak_midline_2017_base_ajk_student_PUF_w_share.dta", clear 
count
fre form
ta year


****************************************************************************************************************************

* BASELINE:

use "$egra_raw\2013-2017_082218\pak_midline_2017_base_ajk_student_PUF_w_share.dta", clear 
merge 1:1 school_code_m grade id treat_phase using "$egra_raw\2013-2017_081718\pak_midline_2017_base_ajk_student_PUF_w_share.dta"


* Endline:

use "$egra_raw\2013-2017_081718\pak_midline_2013_2017_base_mid_ajk_student_PUF_w_share.dta", clear
merge 1:1 school_code_m grade id treat_phase using "$egra_raw\2013-2017_082218\pak_midline_2017_base_ajk_student_PUF_w_share.dta"



ex
