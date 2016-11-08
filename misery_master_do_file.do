// Author: Bryan Phillips
// Date: November 2016
// Description: Master do file to prep and analyze misery data

// ////////////////////
// SET UP MACROS //////
// ////////////////////


// Today's date

	global date				= string(date("`c(current_date)'", "DMY"), "%tdYYNNDD")
	global date				= lower(subinstr("`c(current_date)'"," ","",.))
	
// Directory Information
	// global user rkuhn 	// Username for Randall Kuhn

	global user phillb3 // Username for Bryan Phillips
	
	global git NEW_MISERY
	
// Establish Directory

	global codedir	 "C:/Users/${user}/Documents/${git}/"
	
// ///////////////////////////////////
// 1. CLEAN AND MERGE
// /////////////////////////////////////

// 1a. Create final merged country dataset

	do				"${codedir}/2_code/1_country_data_merge.do"








