
* Purpose: 'pe' program to calculate point estimates (means and standard errors) for the pakistan education portal datasets (MICS, ASER, PSLM)
* Author: Koen Geven & Ahmed Raza
* Date: 12th November, 2019 


cap program drop pe
program define pe
	syntax varlist [if], tv(string) ds(string) restrict(string) level(string)
   
   *tv - name of the "target variable" to store calculated point estimates.
   *restrict - restriction must be specified 
   *ds - dataset name
   *level - level at which point estimates should be calculated i.e. district, province & country
   
   
	foreach var in `varlist' {
		
		
		// Make matsize large enough so it can include all the data
       set matsize 5000
	   
		
		if "`level'" == "district" {
				
		// Estimate the population means
		preserve
			keep if `restrict'
			
			collapse (mean) `var' [aw=weight_`ds'], by(dist_key year)
				
				rename `var' `tv'
				mkmat year dist_key `tv', matrix(results_pe)
		
		restore
	
	   // Estimate the SE
		
		preserve
			keep if `restrict'
			collapse (semean) `var' [aw=weight_`ds'], by(dist_key year)
				rename `var' `tv'_se
				mkmat `tv'_se, matrix(results_se)

		restore
		

		preserve
		
		mat `ds' = results_pe , results_se
		mat drop results_pe results_se
		
	   // Create the final matrix
		local matrix "`ds'"

		mat `tv' = `matrix'
	
		// Export the matrix to a dataset and save that dataset for later merging
		drop _all
		
		svmat `tv', names(col)

		gen dataset = "`ds'"
		
		
	
		
		save "$pe/point_estimates/district/`ds'/`tv'.dta", replace
		restore
	
		}
		
        ********************************************************************* 
		
		
		if "`level'" == "province" {
		
		// Estimate the population means
		preserve
			keep if `restrict'
			
			collapse (mean) `var' [aw=weight_`ds'], by(province year)
				
				rename `var' `tv'
				mkmat year province `tv', matrix(results_pe)
		
		restore
	
	   // Estimate the SE
		
		preserve
			keep if `restrict'
			collapse (semean) `var' [aw=weight_`ds'], by(province year)
				rename `var' `tv'_se
				mkmat `tv'_se, matrix(results_se)

		restore
		

		preserve
		
		mat `ds' = results_pe , results_se
		mat drop results_pe results_se
		
	    // Create the final matrix
		local matrix "`ds'"

		mat `tv' = `matrix'
	
		// Export the matrix to a dataset and save that dataset for later merging
		drop _all
		
		svmat `tv', names(col)

		gen dataset = "`ds'"
		
		
	
		
		save "$pe/point_estimates/province/`ds'/`tv'.dta", replace
		restore
	
		}
				
        ********************************************************************* 
		
		
		if "`level'" == "country" {
		
		// Estimate the population means
		preserve
			keep if `restrict'
			
			collapse (mean) `var' [aw=weight_`ds'], by(country year)
				
				rename `var' `tv'
				mkmat year country `tv', matrix(results_pe)
		
		restore
	
	   // Estimate the SE
		
		preserve
			keep if `restrict'
			collapse (semean) `var' [aw=weight_`ds'], by(country year)
				rename `var' `tv'_se
				mkmat `tv'_se, matrix(results_se)

		restore
		

		preserve
		
		mat `ds' = results_pe , results_se
		mat drop results_pe results_se
		
	    // Create the final matrix
		local matrix "`ds'"

		mat `tv' = `matrix'
	
		// Export the matrix to a dataset and save that dataset for later merging
		drop _all
		
		svmat `tv', names(col)

		gen dataset = "`ds'"
		
		
	
		
		save "$pe/point_estimates/country/`ds'/`tv'.dta", replace
		restore
	
		}
		
		
	}
		
		
end 
		


	   