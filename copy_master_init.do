clear all 
set more off

	
********************************************************************************	
	* Dropbox Globals to create User Path-ways:
	
	    * Ahmed Raza
		else if c(username) == "WB549384" { 
		global folder = "C:\Users\WB549384.WB\WBG\Ayesha Tahir - Data Depot_Education_Pakistan"
		  }
		  
		  
		else if c(username) == "wb549384" { 
		global folder = "C:\Users\wb549384\WBG\Ayesha Tahir - Data Depot_Education_Pakistan"
		  }
		  
		  
		  * Koen Geven 
		 else if c(username) == "wb495813" { 
		global folder = "C:\Users\wb495813\WBG\Ayesha Tahir - Data Depot_Education_Pakistan"
		  }
		  

********************************************************************************
        * Globals to the Data Depot Folder:
     
	 
	    gl raw "$folder\01_Raw"
		gl code "$folder\02_Code\public"
		gl output "$folder\03_Processed_Data\public"
********************************************************************************

* Copy master init file to create relevant init files in each folder of cleaning & aggregation:

********************************************************************************

		* Copy init file in the do folder of the cleaning code
		
		copy "master_init.do" "$code\01_Clean\05_PSLM\init.do", replace
		copy "master_init.do" "$code\01_Clean\07_HIES\init.do", replace
		copy "master_init.do" "$code\01_Clean\12_ASER\init.do", replace
		copy "master_init.do" "$code\01_Clean\15_DHS\init.do", replace
		copy "master_init.do" "$code\01_Clean\13_EGRA\init.do", replace
		copy "master_init.do" "$code\01_Clean\06_MICS\init.do", replace

		******************************************************
		* Copy init file in the panel folder of the cleaning code
		copy "master_init.do" "$code\02_Panels\init.do", replace
		 
		******************************************************
		* Copy init file in the Indicators folder of the cleaning code		
		* Version 1
		copy "master_init.do" "$code\04_Indicators\version1\init.do", replace
		
		* Version 2
		copy "master_init.do" "$code\04_Indicators\version2\init.do", replace
	
	
	
	
	
********************************************************************************		
/*
Note: The copy portion of this master_init will have to be commented out in each innit file. 
Everytime the master init file is updated.
*/
********************************************************************************		

