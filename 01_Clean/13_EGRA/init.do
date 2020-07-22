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
		
		
		* Raw Data Folder Globals
		  
        gl gsc_raw "$raw\01_GSC"	  
        gl pslm_raw "$raw\05_PSLM"		  
        gl mics_raw "$raw\06_MICS"
		gl hies_raw "$raw\07_HIES"
		gl aser_raw "$raw\12_ASER"	
	    gl egra_raw "$raw\13_EGRA"	 
	    gl dhs_raw "$raw\15_DHS"
		
	
		
		* Clean Data Folder Globals 
		
		gl pslm_clean "$output\Clean\05_PSLM"
		gl mics_clean "$output\Clean\06_MICS"
		gl hies_clean "$output\Clean\07_HIES"
		gl aser_clean "$output\Clean\12_ASER"
		gl egra_clean "$output\Clean\13_EGRA"
		gl dhs_clean  "$output\Clean\15_DHS"


		* Panel Globals:
				
		gl panel "$output\Panel"
		
		* Indicators Output:		
		gl pe "$output\Indicators" 

********************************************************************************

/*
* Cleaning Programs to be added:

- unique - ssc install unique
- clean_lname -
- clean_fname -

*/
