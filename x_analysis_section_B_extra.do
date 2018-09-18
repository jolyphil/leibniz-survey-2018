********************************************************************************
* Project:  Leibniz PhD Network Survey 2018
* Task:     Export results (figures and tables) for section B
* Authors:  Survey Working Group
********************************************************************************

* ==============================================================================
* Preparation
* ==============================================================================

* Configuration -----------------------------------------------------

version 14
set more off

* Load scheme -------------------------------------------------------

set scheme minimal // I use my own scheme, but you can use any you like.

* Load packages -----------------------------------------------------

ssc install estout

* Load data ---------------------------------------------------------

use "${data}final_data.dta", clear

* _______________________________________________________________________
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

* Section -----------------------------------------------------------

recode a_3 (98=.), gen(section)
_crcslbl section a_3

label define sectionlb			///
	1 "A"			///
	2 "B"			///
	3 "C"			///
	4 "D"			///
	5 "E", modify
label values section sectionlb

* gender ------------------------------------------------------------

recode a_5 (1=1)(2=0)(else=.), gen(gender)
_crcslbl gender a_5

label define genderlb	///
	0 "Male"			///
	1 "Female", modify
label values gender genderlb

* Year of PhD -------------------------------------------------------

gen yearphd = a_1_duration_g
_crcslbl yearphd a_1_duration_g

label define yearphdlb		///
	1 "1st year"			///
	2 "2nd year"			///
	3 "3rd year"			///
	4 "4th year"			///
	5 "5th year or more", modify
label values yearphd yearphdlb

* Internationals ----------------------------------------------------

recode d_1_n (0=1) (1=0), gen(inter)
replace inter = 0 if a_4 == 1 | a_4 == 2
label variable inter "International students"

label define interlb ///
	0 "German or grew up in Germany" ///
	1 "International", modify
label values inter interlb

* Parents -----------------------------------------------------------

recode e_2 (98=.), gen(parent)
label variable parent "Parents"

label define parentlb	///
	0 "Not parent"			///
	1 "Parent", modify
label values parent parentlb

* Conctractual situation --------------------------------------------

capture drop contract
recode b_2 (2/4=0) (5=1) (97=0) (else=.), gen(contract)
label variable contract "Working contract / Stipend"

label define contractlb	///
	0 "Stipend or other"			///
	1 "Working contract", modify
label values contract contractlb

* ==============================================================================
* E2: Children in Household (Parenthood)
* ==============================================================================

* _______________________________________________________________________
* Logistic regression

logit e_2 i.section a_6_n gender i.yearphd inter contract [pw=weight]
est store M1

local vspacing "\hspace{0.4cm}"

#delimit ;
esttab M1 using "${tables_tex}e_2_logit.tex", replace 
	b(2) se(2) noomit nobase wide booktabs fragment nonum
	alignment(S S) compress
	nomtitles 
	collabels("\multicolumn{1}{c}{Coef.}" "\multicolumn{1}{c}{SE}")
	eqlabels(none)
	refcat( 
		2.section "Section, A (ref.)" 
		2.yearphd "Year of PhD, 1st year (ref.)" 
		, nolabel 
	) 
	coeflabel( 
		2.section "`vspacing'B"
		3.section "`vspacing'C"
		4.section "`vspacing'D"
		5.section "`vspacing'E"
		gender "Woman"
		a_6_n "Age"
		2.yearphd "`vspacing'2nd year"
		3.yearphd "`vspacing'3rd year"
		4.yearphd "`vspacing'4th year"
		5.yearphd "`vspacing'5th year or more"
		inter "International student"
		contract "Working contract"
		_cons "Intercept"
	)
;
