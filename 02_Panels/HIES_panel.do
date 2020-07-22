* DATA CLEANING : HIES
* Author: Ahmed Raza
* Date: 18th June 2019
* Purpose: To create the panel of HIES data


		* Dropbox Globals
	
	    include init.do

		
		* 2015
********************************************************************************
		
		use "$hies_clean/HIES_clean_2015.dta", clear

		clonevar relation = s1aq02
		
		ren s1aq02 relation_hh_head
		ren s1aq04 gender
		
		ren s2ac01 read
		ren s2ac02 write
		ren s2ac03 math
		
		gen in_school_ever = 1 if s2ac04 ==1
		replace in_school_ever = 0 if s2ac04 ==2
	
		
		gen in_school = 1 if s2ac06 ==1
		replace in_school=0 if s2ac06 ==2
		
		ren s2ac05 highest_grade
		ren s2ac07 current_grade
		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		ren weights weight
		ren s2ac08 school_type
		
		keep psu hhcode idc province read write math highest_grade current_grade in_school school_type in_school_ever ///
		relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 tot_exp2 ratio2 ///
		ratio2_check weight year prov region relation
		
		order psu hhcode idc year province read write math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 ///
		tot_exp2 ratio2 ratio2_check weight prov region relation

		decode school_type, gen (st)
		
		
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		
		
		tempfile hies_2015
		save `hies_2015', replace
		
		
		
		
		* 2013
********************************************************************************
	
	
	    use "$hies_clean/HIES_clean_2013.dta", clear
		
		
		clonevar relation = s1aq02
	
		ren s1aq02 relation_hh_head
		ren s1aq04 gender
		
		ren s2aq01 read
		ren s2aq02 write
		ren s2aq03 math
		
		gen in_school_ever = 1 if s2bq01 ==2 | s2bq01 ==3
		replace in_school_ever = 0 if s2bq01 ==1

		
		gen in_school = 1 if s2bq01 ==3
		replace in_school = 0 if s2bq01 ==1 | s2bq01 ==2

		
		ren s2bq05 highest_grade
		ren s2bq14 current_grade
		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		ren weights weight
		ren s2bq11 school_type
	
		fre school_type
	
		
		keep  psu hhcode idc province read write math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 ///
		tot_exp2 ratio2 ratio2_check weight year prov region relation
		
		order psu hhcode idc year province read write math highest_grade current_grade in_school school_type /// 
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 /// 
		tot_exp2 ratio2 ratio2_check weight prov region relation

		decode school_type, gen (st)

		ren ratio2_check r2c
		gen ratio2_check = 1 if r2c == "1"
		replace ratio2_check = 2 if r2c == "2"
		
		fre ratio2_check
		
		drop r2c
	

	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		
		decode highest_grade, gen (hg)
		decode current_grade, gen (cg)
			
			
		
	
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
		
			
		tempfile hies_2013
		save `hies_2013', replace
		
		
       * 2011
********************************************************************************
			
		
		use "$hies_clean/HIES_clean_2011.dta", clear
		
		
		
		clonevar relation = s1aq02

		ren s1aq02 relation_hh_head
		ren s1aq03 gender
		
		ren s2aq01 read
		ren s2aq02 write
		ren s2aq03 math
		
		gen in_school_ever = 1 if s2bq01 ==2 | s2bq01 ==3
		replace in_school_ever = 0 if s2bq01 ==1

	
		gen in_school = 1 if s2bq01 ==3
		replace in_school = 0 if s2bq01 ==1 | s2bq01 ==2

		
		ren s2bq05 highest_grade
		ren s2bq14 current_grade
		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		ren s2bq11 school_type
		
		fre school_type
	
	
		keep  psu hhcode idc province read write math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 /// 
		tot_exp2 ratio2 ratio2_check weight year prov region relation
		
		order psu hhcode idc year province read write math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 ///
		tot_exp2 ratio2 ratio2_check weight prov region relation

		
		decode school_type, gen (st)
		
		decode highest_grade, gen (hg)
		decode current_grade, gen (cg)
			
		
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
			
			
		
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
		
			
		tempfile hies_2011
		save `hies_2011', replace

		
		
       * 2010
********************************************************************************
		use "$hies_clean/HIES_clean_2010.dta", clear
		
		
		
		clonevar relation = sbq02
		
		ren sbq02 relation_hh_head
		ren sbq03 gender
		
		
		
	   ren scq01 read 
	   ren scq02 math  

		gen in_school_ever = 1 if scq03 ==1
		replace in_school_ever = 0 if scq03 ==2
		
		
		gen in_school = 1 if scq05 ==1
		replace in_school=0 if scq05 ==2
		
		ren scq04 highest_grade
		ren scq06 current_grade
		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		ren scq07 school_type 
		
		keep  psu hhcode idc province read  math highest_grade current_grade in_school school_type /// 
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 /// 
		tot_exp2 ratio2 ratio2_check weight year prov region relation
		
		order psu hhcode idc year province read  math highest_grade current_grade in_school school_type /// 
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 ///
		tot_exp2 ratio2 ratio2_check weight prov region relation

		
		decode school_type, gen (st)

			
		* Note_2010: read var is read and write here.
	
	

	
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		decode highest_grade, gen (hg)
		decode current_grade, gen (cg)
		
		
		* highest eduction
		
			
		replace highest_grade = 11  if  highest_grade  ==17
		replace highest_grade = 13  if  highest_grade  ==14
		replace highest_grade = 14  if  highest_grade  ==15
		replace highest_grade = 15  if  highest_grade  ==18
		replace highest_grade = 16  if  highest_grade  ==19
		replace highest_grade = 17  if  highest_grade  ==20
		replace highest_grade = 18  if  highest_grade  ==21
		replace highest_grade = 19  if  highest_grade  ==22
		replace highest_grade = 20  if  highest_grade  ==23

			* current grade
					
		replace current_grade = 11  if  current_grade  ==17
		replace current_grade = 13  if  current_grade  ==14
		replace current_grade = 14  if  current_grade  ==15
		replace current_grade = 15  if  current_grade  ==18
		replace current_grade = 16  if  current_grade  ==19
		replace current_grade = 17  if  current_grade  ==20
		replace current_grade = 18  if  current_grade  ==21
		replace current_grade = 19  if  current_grade  ==22
		replace current_grade = 20  if  current_grade  ==23
		
		
	
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
	

	    tempfile hies_2010
		save `hies_2010', replace
		
		
		
       * 2007
********************************************************************************
		
	    use "$hies_clean/HIES_clean_2007.dta", clear
	
	    clonevar relation = sbq02
		
		ren sbq02 relation_hh_head
		ren sbq03 gender
		

	    ren s2aq01 read
	    ren s2aq02 write
	    ren s2aq03 math  
		
        recode s2bq01 (5 =.)
		
		gen in_school_ever  = 0 if s2bq01 ==1 
		replace in_school_ever = 1 if s2bq01 ==2 |s2bq01  ==3
		
		
		gen in_school = 1 if s2bq01 == 3
		replace in_school =0 if s2bq01 != 3 & s2bq01!=.
		
		
		/*
		
		gen in_school_ever = 1 if scq03 ==1
		replace in_school_ever = 0 if scq03 ==2
		
		
		gen in_school = 1 if scq05 ==1
		replace in_school=0 if scq05 ==2
		
		*/
		
		
		ren s2bq11 school_type
		
		la def st 1 "Government" 2 "Private" 3 "Deeni Madrissa" 4 "NGO/Trust" 5 "NFBE" 6 "Other" 7 "Privately"
		la val school_type st
		decode school_type, gen (st)

	
		
		ren s2bq05 highest_grade
		ren s2bq14 current_grade
		
		fre highest_grade
		fre current_grade
		
		la def educ 0 "Less than 1" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" ///
		11 "11" 12 "12" 13 "13" 14 "Bachelors" 15 "15" 16 "Masters" 17 "Diploma" 18 "Degree Engineering" ///
		19 "Degree Medicine" 20 "Degree Agriculture" 21 "Degree Law" 22 "Mphil/Phd" 23 "Other"
		
		
		la val current_grade highest_grade educ
		
	
	
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		decode highest_grade, gen (hg)
		decode current_grade, gen (cg)

		* highest eduction	
	    recode highest_grade (11=12)(13=12) (17=11) (14=13) (15=13) (16=14) (18=15) (19=16) (20=17) (21 =18) (22=19) (23=20)
	 
		* current grade
	    recode current_grade (11=12)(13=12) (17=11) (14=13) (15=13) (16=14) (18=15) (19=16) (20=17) (21 =18) (22=19) (23=20)
	
	    ren psucode psu

	    * ren urbrural region
	
		
		keep  psu hhcode idc province read  math highest_grade current_grade in_school school_type in_school_ever ///
		relation_hh_head gender age  year weight prov region relation
		
		order psu hhcode idc year province read  math highest_grade current_grade in_school school_type in_school_ever ///
		relation_hh_head gender age  weight prov region relation

		decode school_type, gen (st)

	
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
		
		tempfile hies_2007
		save `hies_2007', replace
	
	
	
	
       * 2005
********************************************************************************
		
	   use "$hies_clean/HIES_clean_2005.dta", clear

	   clonevar relation = s1aq02

	   
		ren s1aq02 relation_hh_head
		ren s1aq03 gender
		
		ren s2aq01 read
		ren s2aq02 write
		ren s2aq03 math
		
		gen in_school_ever = 1 if s2bq01 ==2 | s2bq01 ==3
		replace in_school_ever = 0 if s2bq01 ==1

		
		gen in_school = 1 if s2bq01 ==3
		replace in_school = 0 if s2bq01 ==1 | s2bq01 ==2

		
		ren s2bq05 highest_grade
		ren s2bq14 current_grade
		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		* ren weights weight
		ren s2bq11 school_type
	
		fre school_type
	
	
		keep  psu hhcode idc province read  math highest_grade current_grade in_school school_type in_school_ever ///
		relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 ///
		tot_exp2 ratio2 ratio2_check weight year prov region relation
		
		order psu hhcode idc year province read  math highest_grade current_grade in_school school_type in_school_ever ///
		relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check tot_income2 ///
		tot_exp2 ratio2 ratio2_check weight prov region relation

		
		decode school_type, gen (st)
		
	    la def grade 0 "less than class 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7 "class 7" ///
	    8 "class 8" 9 "class 9" 10 "class 10" 11 "class 11" 12 "class 12" 13 "class 13" 14 "b.a/b.sc." 15 "class 15" ///
	    16 "post graduate (m.a/m.sc.)" 17 "diploma" 18 "degree in engineering" 19 "degree in medicine" 20 "degree in agriculture" ///
	    21 "degree in law" 22 "m. phil, ph.d" 23 "other"
	
	    la val highest_grade grade		  
	    la val current_grade grade		  
	 
	    decode highest_grade, gen (hg)
	    decode current_grade, gen (cg)
	
	
		* highest eduction		
				
		replace highest_grade = 11  if  highest_grade  ==17
		replace highest_grade = 13  if  highest_grade  ==14
		replace highest_grade = 14  if  highest_grade  ==15
		replace highest_grade = 15  if  highest_grade  ==18
		replace highest_grade = 16  if  highest_grade  ==19
		replace highest_grade = 17  if  highest_grade  ==20
		replace highest_grade = 18  if  highest_grade  ==21
		replace highest_grade = 19  if  highest_grade  ==22
		replace highest_grade = 20  if  highest_grade  ==23

		* current grade
					
		replace current_grade = 11  if  current_grade  ==17
		replace current_grade = 13  if  current_grade  ==14
		replace current_grade = 14  if  current_grade  ==15
		replace current_grade = 15  if  current_grade  ==18
		replace current_grade = 16  if  current_grade  ==19
		replace current_grade = 17  if  current_grade  ==20
		replace current_grade = 18  if  current_grade  ==21
		replace current_grade = 19  if  current_grade  ==22
		replace current_grade = 20  if  current_grade  ==23
	
	
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		
		
	
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
	
	    
		fre relation
		
	
	
		tempfile hies_2005
		save `hies_2005', replace
		
	
	    *2004
********************************************************************************
	
		use "$hies_clean/HIES_clean_2004.dta", clear
		
		
		clonevar relation = b3
		
		fre relation
		
		
		
		
		ren b3 relation_hh_head
		ren b1 gender
		ren b4 age
		
		
	    ren scq01 read 
	    ren scq02 math  
		
		
		gen in_school_ever = 1 if scq03 ==1
		replace in_school_ever = 0 if scq03 ==2
		
		
		gen in_school = 1 if scq05 ==1
		replace in_school=0 if scq05 ==2
		
		ren scqo4 highest_grade
		ren scq06 current_grade
		
		fre in_school
		fre in_school_ever
		
		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		ren scq07 school_type 
		
		
		keep  psu hhcode idc province read  math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check ///
		weight year prov region relation
		
		
		order psu hhcode idc year province read  math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age tot_income1 tot_exp1 ratio1 ratio1_check ///
		weight prov region relation

		
		decode school_type, gen (st)

	    decode highest_grade, gen (hg)
	    decode current_grade, gen (cg)
		
		
		* highest grade
		
		replace highest_grade = 12  if  highest_grade  ==11
		replace highest_grade = 13  if  highest_grade  ==12
		replace highest_grade = 15  if  highest_grade  ==13
		replace highest_grade = 16  if  highest_grade  ==14
		replace highest_grade = 21  if  highest_grade  ==15
		replace highest_grade = 17  if  highest_grade  ==16
		replace highest_grade = 14  if  highest_grade  ==17
		replace highest_grade = 19  if  highest_grade  ==18
		replace highest_grade = 20  if  highest_grade  ==19

		
		*curent grade 
		
		replace highest_grade = 12  if  highest_grade  ==11
		replace highest_grade = 13  if  highest_grade  ==12
		replace highest_grade = 15  if  highest_grade  ==13
		replace highest_grade = 16  if  highest_grade  ==14
		replace highest_grade = 21  if  highest_grade  ==15
		replace highest_grade = 17  if  highest_grade  ==16
		replace highest_grade = 14  if  highest_grade  ==17
		replace highest_grade = 19  if  highest_grade  ==18
		replace highest_grade = 20  if  highest_grade  ==19

	
	
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
	
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
	
		
		tempfile hies_2004
		save `hies_2004', replace
	

	    * 2001
		
********************************************************************************
	
	    use "$hies_clean/HIES_clean_2001.dta", clear

			
		clonevar relation = s1aq02
		
		ren s1aq02 relation_hh_head
		ren sex gender
		
	    ren s2aq21 read 
	    ren s2aq22 write
	    ren s2aq23 math  
		
		
		gen in_school_ever = 1 if s2bq01 == 3 | s2bq01 ==2
		replace in_school_ever = 0 if s2bq01 ==1
		
		
		gen in_school = 1 if s2bq01 ==3
		replace in_school=0 if s2bq01 ==2 | s2bq01 ==1
		
		ren s2bq06 highest_grade
		ren s2bq16 current_grade
		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		ren s2bq13 school_type 
		
		
		
		
		keep psu hhcode idc province read  math highest_grade current_grade in_school school_type in_school_ever /// 
		relation_hh_head gender age weight year prov region relation
		
		
		order psu hhcode idc year province read  math highest_grade current_grade in_school school_type in_school_ever ///
		relation_hh_head gender age weight prov region relation

		
		decode school_type, gen (st)

		decode highest_grade, gen (hg)
		decode current_grade, gen (cg)
		
		* highest education
		
				
		replace highest_grade = 11  if  highest_grade  ==17
		replace highest_grade = 13  if  highest_grade  ==14
		replace highest_grade = 14  if  highest_grade  ==15
		replace highest_grade = 15  if  highest_grade  ==18
		replace highest_grade = 16  if  highest_grade  ==19
		replace highest_grade = 17  if  highest_grade  ==20
		replace highest_grade = 18  if  highest_grade  ==21
		replace highest_grade = 19  if  highest_grade  ==22
		replace highest_grade = 20  if  highest_grade  ==23

		* current grade
				
		replace current_grade = 11  if  current_grade  ==17
		replace current_grade = 13  if  current_grade  ==14
		replace current_grade = 14  if  current_grade  ==15
		replace current_grade = 15  if  current_grade  ==18
		replace current_grade = 16  if  current_grade  ==19
		replace current_grade = 17  if  current_grade  ==20
		replace current_grade = 18  if  current_grade  ==21
		replace current_grade = 19  if  current_grade  ==22
		replace current_grade = 20  if  current_grade  ==23
		
	
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
	
	    ta highest_grade
	
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
	
		
		tempfile hies_2001
		save `hies_2001', replace
	
		
		
	    * 1998
********************************************************************************
				
		use "$hies_clean/HIES_clean_1998.dta", clear
		
	    clonevar relation = s1aq02
		
		ren s2aq01 read
		ren s2aq02 write 
		ren s2aq03 math 
		
		
		ren s1aq02 relation_hh_head
		ren s1aq03 gender
		ren s1aq05d age

		gen in_school_ever = 1 if s2bq01 == 3 | s2bq01 ==2
		replace in_school_ever = 0 if s2bq01 ==1

		
		gen in_school = 1 if s2bq01 ==3
		replace in_school=0 if s2bq01 ==2 | s2bq01 ==1

		
		la var in_school "currently in school"
		la var in_school_ever "ever enrolled in school"

		
		ren s2bq06a highest_grade
		ren s2bq16 current_grade
		ren s2bq13 school_type
		
		gen year = 1998
		
		keep  psu hhcode idc province read  math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age   weight year prov region relation
		
		order psu hhcode idc year province read  math highest_grade current_grade in_school school_type ///
		in_school_ever relation_hh_head gender age weight prov region relation 

		
		decode school_type, gen (st)
	
		decode highest_grade, gen (hg)
		decode current_grade, gen (cg)
		
		
		* highest eduction
						
		replace highest_grade = 11  if  highest_grade  ==13
		replace highest_grade = 13  if  highest_grade  ==14
		replace highest_grade = 14  if  highest_grade  ==19
		replace highest_grade = 19  if  highest_grade  ==20
		replace highest_grade = 20  if  highest_grade  ==21
		
	
		* current grade

		replace current_grade = 11  if  current_grade  ==13
		replace current_grade = 13  if  current_grade  ==14
		replace current_grade = 14  if  current_grade  ==19
		replace current_grade = 19  if  current_grade  ==20
		replace current_grade = 20  if  current_grade  ==21
	
	
	    gen dp = 1 if in_school_ever ==1 & in_school ==0
		gen en = 1 if in_school ==1
		gen ne = 1 if in_school_ever ==0
		
		
	    ta highest_grade
	
		ta highest_grade in_school_ever
		ta highest_grade
		ta in_school_ever
	

	
		tempfile hies_1998
		save `hies_1998', replace

		
********************************************************************************

        * Appending the data:
	
	
		use `hies_2015', clear
		append using `hies_2013'
		append using `hies_2011'
		append using `hies_2010'
		append using `hies_2007'
		append using `hies_2005'
		append using `hies_2004'
		append using `hies_2001'
		append using `hies_1998'
		
	    clean_lname st
		
		encode st, gen(st1)
		fre st1
		
		
		drop school_type
		
		gen school_category = 1 if st1 ==1 |  st1 ==13 |  st1 ==14 // govt
		replace school_category = 2 if st1 ==3 |  st1 == 7 |  st1 == 28 | st1 ==29 | st1 ==30 | st1 ==31 | st1 ==32 | st1 ==33 // private
		replace school_category = 3 if st1 ==2 |  st1 == 4 |  st1 == 9 | st1 ==10 | st1 ==11 | st1 ==12 | st1 ==15 | st1 ==16 | st1 ==15 // Deeni
		replace school_category = 4 if st1 ==5 |  st1 == 18 |  st1 == 19 | st1 ==20 | st1 ==21 | st1 ==12 | st1 ==15 | st1 ==16 | st1 ==15 // NGO
		replace school_category = 5 if st1 ==6 |  st1 == 17 |  st1 == 22 | st1 ==23 | st1 ==24  // NFBE
		replace school_category = 6 if st1 ==8 |  st1 == 25 |  st1 == 26 | st1 ==27  // Others
		
		fre school_category	
		fre st1
		
		drop st st1
		
		la def sc 1 "Government Schools" 2 "Private" 3 "Religious Schools (Deeni Taleem/Madrassas)" 4 "NGO/Trust Schools" 5 "NFBE" 6 "Others"
		la val school_category sc
		

		la var hhcode "HH Code" 
		la var idc "Member Code"
		la var year "Year"
		la var province "Province"
		la var weight "HIES Sample Weight"
		
		
		drop hg cg
		
		
	    la def educ_orig 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" ///
	    7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "polytechnic diploma/other diplomas" 12 "fa/fsc/i-com" ///
	    13 "ba/bsc/bed/bcs" 14 "ma/msc/med/mcs" 15 "degree in engineering" 16 "degree in medicine" 17 "degree in agriculture" ///
	    18 "degree in law" 19 "mphil/phd" 20 "others" 21 "Computer Science"
		   
	   
	    la val highest_grade educ_orig
	    la val current_grade educ_orig

   		
		* fix data errors
		replace current_grade =. if in_school ==0
			
	   * Standardization of variables:

	   * hhcode
	   
	    la var hhcode "Household Code"

		* IDC
		
		la var idc "IDC"
		
		isid hhcode idc year
	   
	  	 * Year
		 
		la var year "Year"
		 
		 
	    * Province:
	   
	    ta prov
	    clean_lname prov
	   
	    drop province	
	    gen province = 1 if prov == "PUNJAB"
	    replace province = 2 if prov == "KP" | prov == "KPK" | prov == "NWFP"  | prov == "FATA" 
	    replace province = 3 if prov == "BALOCHISTAN"
	    replace province = 4 if prov == "SINDH"
	    replace province = 5 if prov == "AJK" | prov == "NORTHERN AREA" 
	   
	    la drop province
	 
	    la def province 1 "Punjab" 2 "KPK" 3 "Balochistan" 4 "Sindh" 5 "OTHER AREAS"
	    la val province province 
	    drop prov
	   
	  
	   
		* Learning Vars:
		 
		ren read read1
		ren math math1
		ren write write1
		 
		gen read = 1 if read1 == 1
		replace read = 0 if read1 == 2
		 
		gen math = 1 if math1 == 1
		replace math = 0 if math1 == 2
		  
		gen write = 1 if write1 == 1
		replace write = 0 if write1 == 2
		 
		drop math1 read1 write1
		 
		la var math "HIES: Solve simple arithmatic questions " 
		la var read "HIES: Read in any language with understanding"
		la var write "HIES: Write in any language with understanding"
		 
		la def yes 1 "Yes" 0 "No"
		 
		la val math yes
		la val read yes
		la val write yes
		
		ren math math_hies
		ren read read_hies
		ren write write_hies
		 
		 
	    
		 * Education Vars:

		la def educ_hies 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" ///
		7 "class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "polytechnic diploma/other diplomas" 12 "fa/fsc/i-com" ///
		13 "ba/bsc/bed/bcs" 14 "ma/msc/med/mcs" 15 "degree in engineering" 16 "degree in medicine" 17 "degree in agriculture" ///
		18 "degree in law" 19 "mphil/phd" 20 "others" 21 "Computer Science"
		
		
		la def educ1 0 "less than 1" 1 "class 1" 2 "class 2" 3 "class 3" 4 "class 4" 5 "class 5" 6 "class 6" 7  ///
		"class 7" 8 "class 8" 9 "class 9" 10 "class 10" 11 "FA/FSc/Diplomas" 12 "Bachelors or Higher"

		
		
		 * Highest grade:  
		 
		 gen hg = highest_grade if highest_grade <= 10 & highest_grade !=.
		 replace hg = 11 if highest_grade == 12 | highest_grade == 11 & highest_grade !=.
		 replace hg = 12 if highest_grade >=12 & highest_grade !=.
		 replace hg = . if highest_grade ==20  & highest_grade !=. // others codes as missings 
		
		
		 ren highest_grade highest_grade_hies
	 	
		 ren hg highest_grade
	     la var highest_grade "Highest Grade"

		 la val highest_grade educ1
		 la val highest_grade_hies educ_hies
		 la var highest_grade_hies "HIES: Current Grade"
		
		
		
		 * Current grade:
		
	     gen cg = current_grade if current_grade <= 10 & current_grade !=.
		
		 replace cg = 11 if current_grade == 12 | current_grade == 11 & current_grade !=.
		 replace cg = 12 if current_grade >=12 & current_grade !=.
		 replace cg = . if current_grade ==20  & current_grade !=. // others codes as missings 
		
		 ren current_grade current_grade_hies
		
		 ren cg current_grade
		 la var current_grade "Current Grade"
		
		 la val current_grade educ1
		 la val current_grade_hies educ_hies
		 la var current_grade_hies "HIES: Current Grade"
		
	   
		 * School Category:
		 ren school_category st
		
		 gen school_category = 2 if st == 1
		 replace school_category = 6 if st == 5
		 replace school_category = 4 if st == 4
		 replace school_category = 8 if st == 6
		 replace school_category = 1 if st == 2
		 replace school_category = 9 if st == 3	

         la drop sc	
	     la def sc 1 "Private" 2 "Public" 3 "Institutions:Army/Police/Navy/Wapda/Railways/LDA" 4 "Non-Profits" ///
		 5 "PEF" 6 "NFBE" 7 "Government Departments/Welfare Schools (both Public & Private)" 8 "Other" 9 "Religious" ///
		 
         la val school_category sc
	
		 fre st
		 fre school_category
		 la var school_category "School Category"
	

		 * Gender
		
		 ren gender gend
		 gen gender = 1 if gend == 2
		 replace gender = 0 if gend == 1
		
		 la val gender gender
		 la var gender "Gender"
		
		 la drop sex
		
	     gen sex = 1 if gender == 0
		 replace sex = 2 if gender ==1
	     la var sex "Sex"
	     la def sex 1 "Male" 2 "Female"
		 la val sex sex 
		
		 ren gender female
		 la def female 1 "Female" 0 "Male"	
		 la val female female
		 la var female "Female Dummy"
		 
		 * weights:
		
	     ren weight weight_hies
		
		 la var weight_hies "Sampling Weights - HIES"
	
		 la val in_school yes
		 la val in_school_ever yes
		
		
		 ren tot_income1 tot_income1_hies 
		 ren tot_exp1  tot_exp1_hies
		 ren ratio1  ratio1_hies
		 ren ratio1_check ratio1_check_hies 
		 ren tot_income2 tot_income2_hies
		 ren tot_exp2  tot_exp2_hies
		 ren ratio2 ratio2_hies
		 ren ratio2_check ratio2_check_hies
		
		 la var age "Age"
		 la var province "Province"
		
		 ren ratio2_check_hies r2
		 ren ratio1_check_hies r1
		
		 gen ratio1_check_hies = 1 if r1 == 1
		 replace ratio1_check_hies = 0 if r1 ==2
		
		 gen ratio2_check_hies = 1 if r2 == 1
		 replace ratio2_check_hies = 0 if r2 ==2
		
		 la var ratio2_check_hies "is the ratio larger than 0.85?"
		 la var ratio1_check_hies "is the ratio>than or equal to 0.85"
		
		 la val ratio1_check_hies yes
		 la val ratio2_check_hies yes
		
		
         la var psu "Primary Sampling Unit"
		
		
		 gen education_status = 1 if en ==1 
		 replace education_status = 2 if dp ==1
		 replace education_status = 3 if ne ==1 
			
         la def educ_status 1 "Child in school" 2 "Child dropped out" 3 "Child never enrolled"
		 la val education_status educ_status
		 la var education_status "Education Status"
		
		 drop r1 r2 dp en ne 
		
		
		 * Drop other vars
		 drop relation_hh_head st gend
		
		 order psu hhcode idc year province  age sex female education_status in_school_ever ///
		 in_school school_category highest_grade current_grade  highest_grade_hies current_grade_hies  ///
		 write_hies  math_hies read_hies tot_* ratio* weight_hies
		
		 gen dataset = "HIES"
		 la var dataset "Dataset Name"

	     compress

		
		
		 * Merge with PANEL shared by the pooverty team to get population estimates:
		
   	     merge m:1 hhcode year using  "$hies_raw\povertyteamfiles\2001-15 Consumption Aggregate & Pline.dta"
			

		 gen quintile=.
	     foreach x in 2001 2004 2005 2007 2010 2011 2013 2015 {
		 xtile quintile_`x'=peaexpM  if year==`x'  [aw=popw], nq(5)
		 replace quintile=quintile_`x' if year==`x'
		 drop quintile_`x'
			}
	
		 ren quintile  consumption_quintiles
		 la var consumption_quintiles "Consumption Quintiles"
			
		 la var _merge "Merge with Consumption Quintiles data"	
		
		drop  weight date intmonth intyear
		
		 *tot_income1_hies tot_exp1_hies tot_income2_hies tot_exp2_hies ///
		 * ratio1_hies ratio2_hies ratio1_check_hies ratio2_check_hies 
			
		 * adjustments
		 
		 replace in_school_ever =1 if highest_grade !=.
		 replace in_school =0 if in_school_ever ==0
		
		 replace school_category = . if in_school_ever ==0 & school_category !=.
		
		
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
		

		 * ren consumption_quintiles wealth_quintiles
			
		 la def quintiles 1 "Bottom 20" 2 "20-40" 3 "40-60" 4 "60-80" 5 "Upper 20" 
			
		 la val consumption_quintiles quintiles
			
		 la var consumption_quintiles "HIES: Consumption Quintiles"

		 ren idc member_id
		 la var member_id "Member-ID (IDC)"
			
		 la var region "Region (Rural/Urban)"
			
		 la drop region
			
		 la def region 1 "Urban" 2 "Rural"
		 la val region region
			
		 * drop 1 missing memberid from poverty team's file 
			
		 drop if member_id ==.
		 
		 
		 fre province
		 
		 
		 			
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
		la var country "Country"
		
		isid hhcode member_id year
		
		gen aq = .
		
		ren read_hies read
		ren write_hies write
		ren math_hies math
		
		
		

		
		***********************************************************************
		
       *  HH Head:  Highest Education:

	    preserve
	 
		keep  hhcode member_id relation highest_grade in_school_ever
		
		* hh head's education:
	    fre relation	
		
		keep if relation ==1
		
		keep hhcode relation highest_grade in_school_ever
		
		
	    ren highest_grade highest_grade_head_head

		duplicates drop hhcode, force
			
		tempfile save head_educ
		save `head_educ', replace

		restore 

		 
		* Parent's : Highest Education:
		
	    preserve

		keep  hhcode relation highest_grade in_school_ever
		
	   * parent's education:
	   
	  
	     fre relation
		
		keep if relation ==5
	
		keep hhcode relation highest_grade in_school_ever
		
		
		
		* recode others as missing 
		
		ren highest_grade hg_par
		
		
		* keeping the highest grade parents:
		
	    bysort hhcode: egen highest_grade_parent = max(hg_par)
		
		duplicates tag hhcode, gen (x)
		egen rank = rank( highest_grade_parent), by(hhcode)
		bysort hhcode: gen members=_n
	
        duplicates drop hhcode, force
        isid hhcode 
	    
		fre highest_grade_parent 
		* la val highest_grade_parent educ1
			
		drop hg_par members rank x
		
		tempfile save par_educ
		save `par_educ', replace
		
		
		
	    ***********************************************************************

		merge 1:1 hhcode using `head_educ'
		drop _merge
				
		
		egen hh_es = rowmax(highest_grade_head highest_grade_parent)
		
		* br highest_grade_head highest_grade_parent hh_es
		
		isid hhcode

		
	    tempfile save educ
		save `educ', replace
	
	    restore
		
	    ************************************************************************
		
		merge m:1 hhcode using `educ', nogen
		
		
		la val hh_es educ1
		
		
		gen hh_educ_status = 1 if hh_es ==0
		replace hh_educ_status = 2 if hh_es >=1 & hh_es<=5 // primary
		replace hh_educ_status = 3 if hh_es >=6 & hh_es<=8 // secondary
		replace hh_educ_status = 4 if hh_es >=9 & hh_es<=10 // higher secondary (matric)
		replace hh_educ_status = 5 if hh_es ==11 // diplomas
		replace hh_educ_status = 6 if hh_es ==12 // fa/fsc
		
		#delimit ;
		
		la def hh_educ_status 1 "Less than grade 1" 2 "Primary(1-5)"
		3 "Secondary(6-8)" 4 "Higher Secondary (9-10)" 5 "Fa/Fsc/Diploma"
		6 "Bachelors or Higher";
		
		#delimit cr
		
		la val hh_educ_status hh_educ_status
		la var hh_educ_status "HH's Education Level"
		
	    ren hh_educ_status hh_educ_level
		
		
		***********************************************************************
		
		* Unique identifer test:
		isid hhcode member_id year
		order hhcode member_id year
		
		
		* Save the panel:
		save "$panel/hies_panel.dta", replace
		
		 
		***********************************************************************
		
		* HIES PANEL CHECK:
		
		ren province province_AR
		 
		drop _merge
			
		local year "1998 2001 2004 2005 2007 2010 2011 2013 2015"
		
		preserve
			
			keep if year == 2015
			tempfile hies_2015
			save `hies_2015', replace
		
		restore
			
		************************************************************************
		
		preserve
		
		    keep if year == 2013
			tempfile hies_2013
			save `hies_2013', replace
		
		restore
		************************************************************************
		
		preserve
			
			keep if year == 2011
			tempfile hies_2011
			save `hies_2011', replace
		
		restore
		************************************************************************

		preserve
			
			keep if year == 2010
			tempfile hies_2010
			save `hies_2010', replace
			
		restore
		************************************************************************
		
		preserve
			
			keep if year == 2007
			tempfile hies_2007
			save `hies_2007', replace
		
		restore
			************************************************************************
			
		preserve
			
			keep if year == 2005
			tempfile hies_2005
			save `hies_2005', replace
		
		restore
				************************************************************************
					
		preserve
			
			keep if year == 2004
			tempfile hies_2004
			save `hies_2004', replace
		
		restore
		************************************************************************
			
		preserve
			
			keep if year == 2001
			tempfile hies_2001
			save `hies_2001', replace
			
		restore
		************************************************************************
			
		preserve
			
			keep if year == 1998
			tempfile hies_1998
			save `hies_1998', replace
			
		restore
		************************************************************************
			
		preserve
			
			use "$hies_raw\povertyteamfiles\2001-15 Consumption Aggregate & Pline.dta", clear
			
			ren province prov_AR
			
			tempfile pt_data
			save `pt_data', replace
			
		restore
			
			merge m:1 hhcode year using `pt_data'

			************************************************************************
	
	