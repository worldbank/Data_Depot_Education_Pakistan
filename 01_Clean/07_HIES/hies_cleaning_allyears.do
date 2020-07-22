* DATASET: PSLM
* Author: Ahmed Raza
* Date: 3rd June, 2019 
* Purpose: Cleaning HIES data : Strategy: Combine HH data with Education data on unique identifiers "hhcode" and "idc" and merge with other files using "hhcode".



	* Dropbox Globals		
	include init.do
		
		


********************************************************************************
	* 2015 -16
********************************************************************************	

	* Roster & Education:

	use "$hies_raw/2015/roster.dta", clear

	merge 1:1 hhcode idc using "$hies_raw/2015/sec_2a.dta" 
	ren _merge _merge1
	
	tempfile roster_2015
	save `roster_2015', replace
	
	
    * Expenditure & Income 

	use "$hies_raw/2015/sec_9c.dta", clear	
	
	/*
	ren bs3c01 tot_income1
	ren bs3c02 tot_exp1
	ren bs3c03 ratio1
	ren bs3c04 ratio1_check
	
	
	ren bs5ec01 tot_income2
	ren bs5ec02 tot_exp2
	ren bs5ec03 ratio2
	ren bs5ec04 ratio2_check
	*/
	
	keep hhcode idc province region psu  tot_income* tot_exp* ratio*
	
	
	merge 1:1 hhcode idc using `roster_2015'
	ren _merge _merge2
		
		
	tempfile full_2015
	save `full_2015', replace	
	 
	

	* Weights:
	
	use "$hies_raw/2015/weight.dta", clear
	merge 1:m psu using `full_2015'
	drop _merge 
	
	
********************************************************************************
	
	gen year = 2015
	
	
	* generate string province
	
	decode province, gen (prov)
	
	ren region region_old
	gen region = 1 if region_old ==2
	replace region = 2 if region_old ==1
	
	fre region
	fre region_old
	
	* saving the dataset:
	save "$hies_clean/HIES_clean_2015.dta", replace 
	
	

	
	
********************************************************************************
	* 2013 -14
********************************************************************************	

	* Roster & Education:
    
	use "$hies_raw/2013/roster.dta", clear
	

	merge 1:1 hhcode idc using "$hies_raw/2013/sec_2ab.dta"
	ren _merge _merge1
	
	tempfile roster_2013
	save `roster_2013', replace
	
	
	
    * Expenditure & Income 
	
	use "$hies_raw/2013/sec_12c.dta"
	tostring hhcode, replace

	
	ren t_income tot_income1
	ren t_exp tot_exp1
	ren ratio ratio1
	ren ratio_lrg ratio1_check

	merge 1:1 hhcode using "$hies_raw/2013/sec_12e.dta"
	
	
	ren t_income tot_income2
	ren t_exp tot_exp2
	ren ratio ratio2
	ren ratio_lrg1 ratio2_check

	
	keep hhcode  province region   tot_income* tot_exp* ratio*
	
		
	destring hhcode, replace	
		
	merge 1:m hhcode  using `roster_2013'
	ren _merge _merge2
		
		
	tempfile full_2013
	save `full_2013', replace	


	* Weights:
	
	use "$hies_raw/2013/weight_file.dta", clear
	merge 1:m psu using `full_2013'
	drop _merge 
	
	gen year = 2013
	
	
	* generate string province
	
	decode province, gen (prov)
	
	fre province
	
	drop if hhcode ==.
	drop if idc ==.
	
	isid hhcode idc

	* region
	
	fre region
	
	
************************************************************************
	
	* saving the dataset:
	save "$hies_clean/HIES_clean_2013.dta", replace 
	
	
	
	
********************************************************************************
	* 2011 -12
********************************************************************************

	* Roster & Education:
    use "$hies_raw/2011/roster.dta", clear
	

	merge 1:1 hhcode idc using "$hies_raw/2011/sec_2a.dta"	
	ren _merge _merge1
	
	tempfile roster_2011
	save `roster_2011', replace
	
	
	
    * Expenditure & Income 
	
	use "$hies_raw/2011/sec_12c.dta", clear
	
	* tostring hhcode, replace

	ren t_icom tot_income1
	ren t_exp tot_exp1
	ren ratio ratio1
	ren ratio_1rg ratio1_check

	merge 1:1 hhcode using "$hies_raw/2011/sec_12e.dta"
	
	ren t_income tot_income2
	ren t_exp tot_exp2
	ren ratio ratio2
	ren ratio_1rg ratio2_check

	
	keep hhcode  province region tot_income* tot_exp* ratio*
	
	

				
	merge 1:m hhcode  using `roster_2011'
	ren _merge _merge2
		
		
	tempfile full_2011
	save `full_2011', replace	
	 
	


	* Weights:
	
	use "$hies_raw/2011/hh_weight.dta", clear
	
	merge 1:m hhcode using `full_2011'
	drop _merge 
	
	
	gen year =2011
	

	* generate string province
	
	fre province

	
	gen prov = "punjab" if province ==1
	replace prov = "sindh" if province ==2
	replace prov = "kpk" if province ==3
	replace prov = "balochistan" if province ==4
	
	
	drop if hhcode ==.
	drop if idc ==.
	
	isid hhcode idc
	
	
	* region:
	
	fre region
	
	
********************************************************************************
	* saving the dataset:
	save "$hies_clean/HIES_clean_2011.dta", replace 
		
		
	
********************************************************************************
	* 2010 -11
********************************************************************************



	* Roster & Education:
	
	use "$hies_raw/2010/sec_b.dta", clear

	merge 1:1 hhcode idc using "$hies_raw/2010/sec c.dta"
	
	ren _merge _merge1
	
	tempfile roster_2010
	save `roster_2010', replace

	
	
    * Expenditure & Income 
	
	use "$hies_raw/2010/sec 12c.dta", clear
	
	* tostring hhcode, replace
	ren s12cq01 tot_income1
	ren s12cq02 tot_exp1
	ren s12cq03 ratio1
	ren S12CQ04 ratio1_check

	merge 1:1 hhcode using "$hies_raw/2010/sec 12e.dta"
	
	ren s12eq01 tot_income2
	ren s12eq02 tot_exp2
	ren s12eq03 ratio2
	ren S12EQ04 ratio2_check

	
	keep hhcode tot_income* tot_exp* ratio*
	
	

				
	merge 1:m hhcode  using `roster_2010'
	ren _merge _merge2
		
		
	tempfile full_2010
	save `full_2010', replace	
	 

	* Weights:
	
	use "$hies_raw/2010/plist.dta", clear
	
	merge 1:1 hhcode idc using `full_2010'
	drop _merge 
	
		gen year =2010

		
	* generate string province
	
	decode province, gen (prov)

	drop if hhcode ==.
	drop if idc ==.
	
	isid hhcode idc
	
	* region
	
	fre region
	
	
	
************************************************************************
	* saving the dataset:
	save "$hies_clean/HIES_clean_2010.dta", replace 
	
	
************************************************************************	
		* 2007 -08
**************************************************************************


	use "$hies_raw/2007\pslm_02a.dta", clear

	isid hhcode serialno
	ren serialno idc
	
	ren a0201 s2aq01 
	ren a0202 s2aq02 
	ren a0203 s2aq03 
	
	
	
	ren b0201  s2bq01
	ren b0202  s2bq02
	ren b0203  s2bq03
	ren b0204  s2bq04
	ren b0205  s2bq05
	ren b0206  s2bq06
	ren b0207  s2bq07
	ren b0208  s2bq08
	ren b0209  s2bq09
	ren b0210  s2bq10
	
	ren b0211 s2bq11
	ren b0212 s2bq12
	ren b0213 s2bq13
	ren b0214 s2bq14
	ren b0215 s2bq15
	ren b0216 s2bq16
	ren b0217 s2bq17
	ren b0218 s2bq18
	ren b02191 s2bq19a
	ren b02192 s2bq19b
	ren b02193 s2bq19c
	
	tempfile educ_2007
	save `educ_2007', replace
	
	
	use "$hies_raw/2007\pslm_01a.dta", clear
     
	
	ren serialno idc
	isid hhcode idc
	
	ren a0102 sbq02
	ren a0103 sbq03
	ren a0104 sbq04
	ren a0105 age 
	ren a0151 sbq51
	ren a0152 sbq52
	ren a0153 sbq53 
	ren a0106 sbq06
	ren a0107 sbq07
	ren a0108 sbq08
	ren a0109 sbq09
	ren a0110 sbq10


	tempfile roster
	save `roster', replace
	

	
	merge 1:1 hhcode idc using `educ_2007'
	
	gen year =2007	
	drop _merge 
   
 
	merge m:1 psucode using "$hies_raw/2007\pslm_wgt.dta"

	* generate string province
	
	decode province, gen (prov)
	
	* region:
	
	clonevar region = urbrural
	
************************************************************************
	* saving the dataset:
	save "$hies_clean/HIES_clean_2007.dta", replace 
	
************************************************************************	
		* 2005 -06
**************************************************************************


	* Roster & Education:
	
	* education
	use "$hies_raw/2005/sec 2a.dta", clear
	
	duplicates tag hhcode idc, gen (x)
	drop if x==1 
		
	* Note_2005: There is a cleaning error where there are 16 obsverations for which hhcode and idc is not unique.
		
	
	tempfile educ_2005
	save `educ_2005', replace
	
	
	
	use "$hies_raw/2005/1a_roster.dta", clear
	isid hhcode idc
	
	
	merge 1:1 hhcode idc using `educ_2005'
	ren _merge _merge1
	
	tempfile roster_2005
	save `roster_2005', replace

	
    * Expenditure & Income 
	
	use "$hies_raw/2005/sec 12c.dta"
	
	* tostring hhcode, replace
	ren s12cq01 tot_income1
	ren s12cq02 tot_exp1
	ren s12cq03 ratio1
	ren s12cq04 ratio1_check

	merge 1:1 hhcode using "$hies_raw/2005/sec 12e.dta"

	ren s12eq01 tot_income2
	ren s12eq02 tot_exp2
	ren s12eq03 ratio2
	ren s12eq04 ratio2_check
	
	keep hhcode tot_income* tot_exp* ratio*
	
	
	merge 1:m hhcode  using `roster_2005'
	ren _merge _merge2
		
	
		
	tempfile full_2005
	save `full_2005', replace	
	 
	 
	* Weights:
	use "$hies_raw/2005/p list.dta", clear	
	merge 1:1 hhcode idc using `full_2005'
	drop _merge 
	
	gen year =2005
	
	
	* generate string province
	
	decode province, gen (prov)
	
	* region
	
	fre region

	
********************************************************************************

	* saving the dataset:
	save "$hies_clean/HIES_clean_2005.dta", replace 
	
	
	
********************************************************************************
		* 2004 -05
********************************************************************************


	* Roster & Education:

	use "$hies_raw/2004/sec b0.dta"
	
	merge 1:1 hhcode msno using "$hies_raw/2004/sec c0.dta"
	ren _merge _merge1
	
	

		
	tempfile roster_2004
	save `roster_2004', replace

	
    * Expenditure & Income (Not available)
	

	use "$hies_raw/2004/pslmN.dta", clear

	ren tinc tot_income1
	ren texp tot_exp1
	gen ratio = tot_income1/tot_exp1
	gen ratio1_check = 1 if ratio > 0.85 & ratio !=.
	replace ratio1_check = 0 if ratio <= 0.85 & ratio !=.
	
	
	merge 1:m hhcode using `roster_2004'
	
	ren _merge _merge2
	
	
	tempfile full_2004
	save `full_2004', replace	
	 
	* Weights:
	
	merge m:1 hhcode using 	"$hies_raw/2004/pslmA.dta"
	
	drop _merge 
	
		
	ren msno idc
	
	gen year =2004
	

	
	* generate string province
	
	
	gen prov = "punjab" if province ==1
	replace prov = "sindh" if province ==2
	replace prov = "kpk" if province ==3
	replace prov = "balochistan" if province ==4
	
	drop if hhcode ==.
	drop if idc==.
	
	isid hhcode idc
	
	* drop if province ==.
	
	drop if province ==.
	
	* region
	clonevar region = urbrural
	
********************************************************************************
	* saving the dataset:
	save "$hies_clean/HIES_clean_2004.dta", replace 
		
		
				
********************************************************************************
		* 2001 -02
********************************************************************************

	* Roster & Education:
		
	use "$hies_raw/2001/educat1.dta", clear
	merge 1:1 hhcode idc using "$hies_raw/2001/educat2.dta"
	drop _merge
	merge 1:1 hhcode idc using "$hies_raw/2001/educat3.dta"
	drop _merge 
	
	tempfile educ_2001
	save `educ_2001', replace
	
	
	* Weight & HH data
	
	use "$hies_raw/2001/plist.dta", clear
	
	merge 1:1 hhcode idc using `educ_2001'
	
	gen year =2001
	
	
	* Note_2001: Expenditure and Income data not included yet

	
	gen prov = "punjab" if province ==1
	replace prov = "sindh" if province ==2
	replace prov = "nwfp" if province ==3
	replace prov = "balochistan" if province ==4
	replace prov = "ajk" if province ==5
	replace prov = "northern area" if province ==6
	replace prov = "fata" if province ==7
	
	
	fre prov
	
	* region
	fre region
	
	
************************************************************************
	
	* saving the dataset:
	save "$hies_clean/HIES_clean_2001.dta", replace 
	

************************************************************************	
		* 1998 -99 : Issues with the data
**************************************************************************


	* Roster & Education:

	use "$hies_raw/1998/educatn1.dta"
	duplicates tag hhcode idc, gen (x)
	ta x
	drop if x ==1
	drop x

	merge 1:1 hhcode idc using "$hies_raw/1998/educatn2.dta"
    drop _merge
	
	merge 1:1 hhcode idc using "$hies_raw/1998/educatn3.dta"
    drop _merge
	
	merge 1:1 hhcode idc using "$hies_raw/1998/roster.dta"
	isid hhcode idc
	ren _merge _merge1 
	
	tempfile educ_98
	save `educ_98', replace
	
	
	
	* expenditure 
	
	use "$hies_raw/1998/sect12b.dta"
	
	duplicates tag hhcode, gen(x)
	drop if x ==1
	
	isid hhcode 
	
	* Note_1998: hhcode should be unique and it's not for 6 obs.
		
	* tostring hhcode, replace
	ren sbiq01 tot_income1
	ren sbiq02 tot_exp1
	ren sbiq03 ratio1
	ren sbiq04 ratio1_check

	
	ren sbiiq01 tot_income2
	ren sbiiq02 tot_exp2
	ren sbiiq03 ratio2
	ren sbiiq04 ratio2_check
	
	keep hhcode tot_income* tot_exp* ratio*
		
	merge 1:m hhcode using `educ_98'
	ren _merge _merge2
	
	
	gen prov = "punjab" if province ==1
	replace prov = "sindh" if province ==2
	replace prov = "nwfp" if province ==3
	replace prov = "balochistan" if province ==4
	replace prov = "ajk" if province ==5
	replace prov = "northern area" if province ==6
	replace prov = "fata" if province ==7
	
	drop if idc ==.
	drop if hhcode ==.
	 
	 isid hhcode idc
	 
	 * region	 
	 fre region
	 
	 
************************************************************************
	
	* saving the dataset:
	
	save "$hies_clean/HIES_clean_1998.dta", replace 
		



		
		
		
		
