cap program drop dd_indicator

program define dd_indicator
	version 16
	syntax varlist(min=1), agegroup(numlist integer min=2 max=2) disaggregation(string) ds(string) 
	
	local filestub = subinstr("`varlist'"," ","_",.)
	
	// Evaluating the length of the arguments
	local varsize  : list sizeof varlist
	local ds_size  : list sizeof ds
	
	// Set a minimum and maximum age
	gettoken minage agegroup : agegroup
	gettoken maxage : agegroup 
	
	// Check that dataset is specified
	if ("`ds'" == "") {
			di "{red:Error: No dataset specified.}"
			exit
		}

	forvalues i = 1(1)`ds_size' {
		tokenize `ds'
		local dataset ``i''
		
		use "$panel/`dataset'_panel.dta", clear
				
		// Generate a country variable if not specified
		cap gen country = 1
		cap lab def country 1 "Pakistan"
		cap lab val country country
			
		capture confirm variable dist_key
	
		if _rc == 0 {
			local levels "country province dist_key"
		}
			
		else {
			capture confirm variable province
				
				if _rc == 0 {
					local levels "country province"
				}
				
				else {
					local levels "country"
				}
		}
		
		// Check that a weight is specified, if not specify it now
		capture confirm variable weight_`dataset'
		if _rc != 0 {
			cap gen weight_`dataset' = 1
		}
		
		quietly: local levelsize : list sizeof levels

		// Loop over levels (district, province, country)
		forvalues j = 1(1)`levelsize' {
			tokenize `levels'
			local level ``j''
			
			forvalues k = 1(1)`varsize' {
			    // Loop over every value of varlist and indicators
				tokenize `varlist'
				local var ``k''
				di "Estimating results for variable `var' at `level' for age `minage' to `maxage' in `dataset'"
				// Estimate the population means
				preserve
					quietly: keep if age >= `minage' & age <= `maxage'
					quietly: collapse (mean) `var'_`minage'_`maxage'=`var' (semean) `var'_`minage'_`maxage'_se = `var' (count) `var'_`minage'_`maxage'_N = `var' [aw=weight_`dataset'], by(`level' year)
					
					// Create a matrix with the results, include year and level key
					tempname results
					mkmat _all, matrix(`results')
				restore
				
				// The very first time this is done, create a tempfile and save the data there
				if `k' == 1 {
					// Save the matrix as a dataset that can be merged with future datasets
					preserve
						drop _all
						quietly: svmat `results', names(col)

						// Save the temporary dataset
						tempfile level_`j'
						quietly: save "`level_`j''", replace
					restore
				}	
				
				// The next times, just merge in the data with the original data
				else {
					preserve
						// Generate a dataset from the matrix
						drop _all
						quietly: svmat `results', names(col)
												
						// Save the temporary dataset
						quietly: merge 1:1 `level' year using "`level_`j''", nogenerate
						quietly: save "`level_`j''", replace
					restore
				}
				
				// Do the same estimation if there are further disaggregations required
				local dis_size  : list sizeof disaggregation

				if "`disaggregation'" != "" {
					forvalues l = 1(1)`dis_size' {
					tokenize `disaggregation'
					local disag ``l''
					
					di "Disaggregating `disag'"

					quietly: levelsof `disag', local(disag_levs)
						foreach lev of local disag_levs {
							
							// Estimate the population means
							preserve
								quietly: keep if age >= `minage' & age <= `maxage' & `disag' == `lev' 
								quietly: collapse (mean) `var'_`minage'_`maxage'_`disag'_`lev' =`var' (semean) `var'_`minage'_`maxage'_`disag'_`lev'_se = `var' (count) `var'_`minage'_`maxage'_`disag'_`lev'_N = `var' [aw=weight_`dataset'], by(`level' year)
								
								tempname results_disag
								mkmat _all, matrix(`results_disag')
							restore
							
	
						preserve
							drop _all
							quietly: svmat `results_disag', names(col)

							// Save the temporary dataset
							quietly: merge 1:1 `level' year using "`level_`j''", nogenerate
							quietly: save "`level_`j''", replace
						restore	
 						}
					
					// Close disaggregation loop (l)
					//di "Closing disaggregation loop (i = `i', j = `j', k = `k', l = `l')"
					}
				}
			
			// Close indicator loop (k)
			//di "Closing indicator loop (i = `i', j = `j', k = `k')"
			}
			
			// Save the results from each level in a temporary dataset, appending for each new level
			if `j' == 1 {
				preserve 
					use "`level_`j''", clear
					gen dataset="`dataset'"
					
					tempfile dataset_`i' 
					quietly: save "`dataset_`i''", replace
				restore
				}	
				
			else {

				preserve
					use "`level_`j''", clear
					gen dataset="`dataset'"

					quietly: append using "`dataset_`i''"
					quietly: save "`dataset_`i''", replace
				restore
				}				
				

			// Close level loop (j)
			//di "Closing level loop (i = `i', j = `j')"
			}
			    
		if `i' == 1 {
			
			// Save the results from each dataset in a final temporary dataset, appending for each new dataset
			preserve 
				quietly: use `dataset_`i'', clear
				
				tempfile final_results
				quietly: save "`final_results'", replace
			restore
		}	
			
		else {
			
			preserve 
				quietly: use "`final_results'", clear
				quietly: append using "`dataset_`i''"
				quietly: save "`final_results'", replace
			restore
		}			
				
	// Close dataset loop (i)
	//di "Closing dataset loop (i = `i')"
	}
	//di "going to final results saving"
	preserve 
	
	use "`final_results'", clear
		
		
	*******************************************	
	*AR: Unique Identifier
	
	* order `filestub'
		
	gen district = dist_key
	replace district = 0 if district ==. 
	replace country = 0 if country ==.	
	replace province = 0 if province ==.
	
	gen identifier = district
	replace identifier = 1000 * province if province != 0
	replace identifier = 10000 * country if country != 0

	isid country province district year dataset
		
	**********************************************	
		
		save "$pe/point_estimates2/results_`minage'_`maxage'.dta", replace
	restore
end
	