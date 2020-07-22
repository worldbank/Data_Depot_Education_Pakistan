* Author: Ahmed Raza
* Date: 24th June 2020
* Purpose to create published version of the HH-level panels.


		* Init for Globals
		
        include init.do

		
*******************************************************
* PSLM
*******************************************************

use "$panel/pslm_panel.dta", clear
order hhcode member_id psu year country province dist_key dist_nm


ren ps private_school_dummy 
ren aq asset_quintiles
la var asset_quintiles "Asset/Wealth Quintiles"

drop asset_level tot_income

save "$panel/published/pslm_panel.dta", replace





*******************************************************
* HIES
*******************************************************

use "$panel/hies_panel.dta", clear
order hhcode member_id psu year country province 

ren ps private_school_dummy

*Check with Koen:
drop aq _merge

* nomexpend psupind eqadultM hhsizeM texpend peaexpM popwt pline npline poor_2001 poor_2014


ren *, lower
save "$panel/published/hies_panel.dta", replace


*******************************************************
* ASER 
*******************************************************

use "$panel/aser_panel.dta", clear

order hhcode member_id year country province dist_key dist_nm
drop reading division dist_tag asset_level
ren aq asset_quintiles
ren ps private_school_dummy

la var relation "Relationship to Household Head"
la var weight_aser "Sampling Weight: ASER"

save "$panel/published/aser_panel.dta", replace



*******************************************************
* MICS
*******************************************************

use "$panel/mics_panel.dta", clear

order hh_cluster hhcode member_id psu year country province dist_key dist_nm

ren aq wealth_quintiles
la var wealth_quintiles "Asset/Wealth Quintiles"
la var region "Region"
ren ps private_school_dummy

drop wscore Asset_Level
la var relation "Relationship to Household Head"
la var wealth_quintiles "MICS: Wealth Quintiles"
la var weight_mics "Sampling Weight: MICS"

save "$panel/published/mics_panel.dta", replace


*******************************************************
* DHS
*******************************************************

use "$panel/dhs_panel.dta", clear

order hh_cluster hhcode member_id psu year country province dist_key dist_nm

drop ps

ren aq asset_quintiles
la var relation "Relationship to Household Head"
la var weight_dhs "Sampling Weight: DHS"

save "$panel/published/dhs_panel.dta", replace



*******************************************************
* EGRA
*******************************************************

use "$panel/egra_panel_baseline.dta", clear

order panelid year country province 
drop dist_key aq age
la var female "Female Dummy"
la var grade "Student's Grade level"
la var weight_egra "Sampling Weight: EGRA"

save "$panel/published/egra_panel.dta", replace



