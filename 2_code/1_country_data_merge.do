// Author: Bryan Phillips
// Purpose: Clean and merge country datasets to one final dataset

// Pull in raw country dataset

	use	"${codedir}1_data/countries.dta", clear

// ///////////////////////	
// Specific Country fixes
// ///////////////////////

// Bangladesh
	//Code
	replace startyear=1971 if abb=="BNG"

//Germany
	// Name
	replace country="Germany" if country=="German Democratic Republic" | country=="German Federal Republic"
	// Code
	replace abb="GMY" if abb=="GDR" | abb=="GFR"
	// Year
	replace startyear=1816 if abb=="GMY"
	
// Vietnam
	// Name
	replace country="Vietnam" if country=="Republic of Vietnam"
	// Code
	replace abb="DRV" if abb=="RVN"
	// Year
	replace startyear=1954 if country=="Vietnam"

	
// Yemen
	// Name
	replace country="Yemen" if country=="Yemen Arab Republic" | country=="Yemen People's Republic"
	// Code
	replace abb="YEM" if abb=="YAR" | abb=="YPR"
	// Year
	replace startyear=1926 if abb=="YEM"
	
// Keeping one observation of each country and dropping if before 1945
gsort country -endyear
bys country : keep if _n==1
drop if endyear<1945

// Saving cleaned Countries dataset
	tempfile countries_clean
	save `countries_clean', replace
	
	
// ///////////////////////	
// Merge Region dataset
// ///////////////////////

// Pull in regions dataset
	use	"${codedir}1_data/region.dta", clear
	
// Merge on Linking Country Name and Code Dataset
	mmerge country using "${codedir}1_data/link1.dta", umatch(country)
	
// Drop merge variable	
drop _merge
// Fix Missing Taiwan
replace country="Taiwan" if country2=="Taiwan"
replace cc=999 if country=="Taiwan"

// ///////////////////////	
// Merge Clean Country dataset
// ///////////////////////
	
mmerge country2 using `countries_clean', umatch(country)
drop if _merge==2 | _merge ==-1

replace country2=country if country2==""


// ///////////////////////	
// Merge Concordance dataset ????????
// ///////////////////////
	

	mmerge cc using "${codedir}1_data/concordance_all.dta", umatch(unpopcodes) uname(ifs_)
	
	keep if _merge==3

	
// ///////////////////////	
// Merge Link datasets ????????
// ///////////////////////
	
// Merging Link datasets 2,3,4

	mmerge cc using "${codedir}1_data/link2.dta" 
	drop if _merge==2

	mmerge cc using "${codedir}1_data/link3.dta"
	drop if _merge==2

	mmerge country using "${codedir}1_data/link4.dta"
	list country if _merge==1

	drop if _merge==2
	
	
	
	
	
	
	
	