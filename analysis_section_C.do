********************************************************************************
* Project:	Leibniz PhD Network Survey 2018
* Task:		Generate bar graphs for questions with multiple answers
* Authors:	Survey Working Group
********************************************************************************

* ______________________________________________________________________________
* Load data

set scheme minimal // I use my own scheme, but you can use any you like.

// Define your own data folder in a global macro if needed.
use "${data}final_data_weights.dta", clear

* ______________________________________________________________________________
* Recode explanatory variables

/*
List of explanatory variables, in order:
	1. Section
	2. Gender
	3. Year of PhD/duration
	4. Internationals
	5. Parents
	6. Contract situation/Stipends
*/

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Section

recode a_3 (98=.), gen(section)
_crcslbl section a_3

label define sectionlb			///
	1 "A"			///
	2 "B"			///
	3 "C"			///
	4 "D"			///
	5 "E", modify
label values section sectionlb

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Female

recode a_5 (1=1)(2=0)(else=.), gen(female)
_crcslbl female a_5

label define femalelb	///
	0 "Male"			///
	1 "Female", modify
label values female femalelb

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Year of PhD

gen yearphd = a_1_duration_g
_crcslbl yearphd a_1_duration_g

label define yearphdlb		///
	1 "1st year"			///
	2 "2nd year"			///
	3 "3rd year"			///
	4 "4th year"			///
	5 "5th year or more", modify
label values yearphd yearphdlb

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Internationals

recode d_1_n (0=1) (1=0), gen(inter)
replace inter = 0 if a_4 == 1 | a_4 == 2
label variable inter "International students"

label define interlb	///
	0 "Other"			///
	1 "International", modify
label values inter interlb

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Parents

recode e_2 (98=.), gen(parent)
label variable parent "Parents"

label define interlb	///
	0 "Not parent"			///
	1 "Parent", modify
label values parent parentlb

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Conctractual situation

recode b_2 (2/4=0) (5=1) (97=0) (else=.), gen(contract)
label variable contract "Working contract / Stipend"

label define contractlb	///
	0 "Stipend or other"			///
	1 "Working contract", modify
label values contract contractlb

* ______________________________________________________________________________
* C1: Support with...

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print frequency tables with weights

foreach var of varlist c_1a_n-c_1d_n {
	tab `var' [aw=weight]
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print cross-tables

local iv "section female yearphd inter parent contract"

foreach indvar of varlist `iv' {
	foreach depvar of varlist c_1a_n-c_1d_n {
	tab `indvar' `depvar' [aw=weight], nofreq co
	}
}
* ______________________________________________________________________________
* C2: Personal mentor

* Recode don't know to missing
recode c_2_n (99 = .), gen(mentor)
_crcslbl mentor c_2_n

label define mentorlb	///
	0 "Mentor"			///
	1 "No mentor", modify
label values mentor mentorlb

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* ANOVA: Test relationships with explanatory variables

local iv "section female yearphd inter parent contract"

foreach var of varlist `iv' {
	local label : variable label `var'
	disp "`label' --------"
	anova mentor `var' [aw=weight]
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print cross-tables

* Note: Only significant factor is year of PhD
tab yearphd mentor [aw=weight], nofreq co

* ______________________________________________________________________________
* C3: Actions taken to prepare future career

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* ANOVA: Test relationships with explanatory variables

local iv "section female yearphd inter parent contract"

foreach action of varlist c_3a_n-c_3f_n {
	local label : variable label `action'
	disp "============================================================="
	disp "`label'"
	
	foreach var of varlist `iv' {
		local label : variable label `var'
		disp "Explanatory variable: `label' --------"
		anova `action' `var' [aw=weight]
	}
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print cross-tables

* Relevant factors: year of PhD and parental status
foreach var of varlist c_3a_n-c_3f_n {
	tab yearphd `var' [aw=weight], nofreq co
	tab parent `var' [aw=weight], nofreq co
}

* ______________________________________________________________________________
* C4: Preferred area after the PhD

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* ANOVA: Test relationships with explanatory variables

local iv "section female yearphd inter parent contract"

foreach action of varlist c_4a_n-c_4f_n {
	local label : variable label `action'
	disp "============================================================="
	disp "`label'"
	
	foreach var of varlist `iv' {
		local label : variable label `var'
		disp "Explanatory variable: `label' --------"
		anova `action' `var' [aw=weight]
	}
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print cross-tables

* Relevant factors: section and gender
foreach var of varlist c_3a_n-c_3f_n {
	tab section `var' [aw=weight], nofreq co
	tab female `var' [aw=weight], nofreq co
}

* ______________________________________________________________________________
* C4.1: Reasons for not pursuing a career in academia

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* ANOVA: Test relationships with explanatory variables

* Five main factors
local factors "c_4_1e_n c_4_1j_n c_4_1i_n c_4_1b_n c_4_1k_n"
local iv "section female yearphd inter parent contract"

foreach factor of varlist `factors' {
	local label : variable label `factor'
	disp "============================================================="
	disp "`label'"
	
	foreach var of varlist `iv' {
		local label : variable label `var'
		disp "Explanatory variable: `label' --------"
		anova `factor' `var' [aw=weight]
	}
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print cross-tables

* Relevant factors: section, year of PhD and internationals
foreach var of varlist c_4_1e_n c_4_1j_n c_4_1i_n c_4_1b_n c_4_1k_n {
	tab section `var' [aw=weight], nofreq co
	tab yearphd `var' [aw=weight], nofreq co
	tab inter `var' [aw=weight], nofreq co
}

* ______________________________________________________________________________
* C5.2: Professional training needed

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* ANOVA: Test relationships with explanatory variables

local iv "section female yearphd inter parent contract"

foreach training of varlist c_5_2a_n-c_5_2h_n {
	local label : variable label `training'
	disp "============================================================="
	disp "`label'"
	
	foreach var of varlist `iv' {
		local label : variable label `var'
		disp "Explanatory variable: `label' --------"
		anova `training' `var' [aw=weight]
	}
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print cross-tables

* Relevant factor: section, year of PhD
foreach var of varlist c_5_2a_n-c_5_2h_n {
	tab section `var' [aw=weight], nofreq co
	tab yearphd `var' [aw=weight], nofreq co
}

* ______________________________________________________________________________
* C6: Information about career options


recode c_6_n (99=.), gen(infocareer)
_crcslbl infocareer c_6_n

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* ANOVA: Test relationships with explanatory variables

local iv "section female yearphd inter parent contract"

foreach var of varlist `iv' {
	local label : variable label `var'
	disp "`label' --------"
	anova infocareer `var' [aw=weight]
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Print cross-tables

* Relevant factor: section
tab section infocareer [aw=weight], nofreq co
