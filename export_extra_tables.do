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

* _______________________________________________________________________
* Other variables

* Age groups --------------------------------------------

gen age_gr = a_6_g
_crcslbl age_gr a_6_g

label define age_grlb		///
	1 "25 or younger"			///
	2 "26 to 30"			///
	3 "31 to 35"			///
	4 "36 or older", modify
label values age_gr age_grlb


* ==============================================================================
* D4: Desire more support (internationals)
* ==============================================================================

* _______________________________________________________________________
* Logistic regressions

* Model 1 -----------------------------------------------------------
* logit d_4_n i.a_3 i.a_6_g i.a_1_duration_g contract parents [pw=weight]

recode d_4_n (97 = 1), gen(ask_support)

logit ask_support i.section i.age_gr i.yearphd contract parent [pw=weight]
est store M1


* Model 2 -----------------------------------------------------------
* logit d_4_n d_2_n i.a_3 i.a_6_g i.a_1_duration_g contract parents [pw=weight] 
* 	// including a regressor for having a contact person at the institute

logit ask_support d_2_n i.section i.age_gr i.yearphd contract parent [pw=weight]
est store M2

* _______________________________________________________________________
* Export table

local vspacing "\hspace{0.4cm}"

#delimit ;
esttab M1 M2 using "${tables_tex}d_4_logit.tex", replace 
	b(2) se(2) noomit nobase wide booktabs fragment
	alignment(S S)
	nomtitles 
	collabels("\multicolumn{1}{c}{Coef.}" "\multicolumn{1}{c}{SE}")
	eqlabels(none)
	refcat( 
		2.section "Section, A (ref.)" 
		2.age_gr "Age group, 25 or younger (ref.)"
		2.yearphd "Year of PhD, 1st year (ref.)" 
		, nolabel 
	) 
	coeflabel( 
		2.section "`vspacing'B"
		3.section "`vspacing'C"
		4.section "`vspacing'D"
		5.section "`vspacing'E"
		2.age_gr "`vspacing'26 to 30"
		3.age_gr "`vspacing'31 to 35"
		4.age_gr "`vspacing'36 or older"
		2.yearphd "`vspacing'2nd year"
		3.yearphd "`vspacing'3rd year"
		4.yearphd "`vspacing'4th year"
		5.yearphd "`vspacing'5th year or more"
		contract "Working contract only"
		parent "Parent"
		d_2_n "Contact person"
		_cons "Intercept"
	)
;
#delimit cr

estimates clear

* ==============================================================================
* D6: Language barriers at work (internationals)
* ==============================================================================

* _______________________________________________________________________
* Logistic regressions

* Model 1 -----------------------------------------------------------
* logit d_6_n i.a_3 i.a_6_g i.a_1_duration_g contract parents [pw=weight]

logit d_6_n i.section i.age_gr i.yearphd contract parent [pw=weight]
est store M1

* Model 2 -----------------------------------------------------------
* logit d_6_n d_2_n i.a_3 i.a_6_g i.a_1_duration_g contract parents [pw=weight]

logit d_6_n d_2_n i.section i.age_gr i.yearphd contract parent [pw=weight]
est store M2

* _______________________________________________________________________
* Export table

local vspacing "\hspace{0.4cm}"

#delimit ;
esttab M1 M2 using "${tables_tex}d_6_logit.tex", replace 
	b(2) se(2) noomit nobase wide booktabs fragment
	alignment(S S)
	nomtitles 
	collabels("\multicolumn{1}{c}{Coef.}" "\multicolumn{1}{c}{SE}")
	eqlabels(none)
	refcat( 
		2.section "Section, A (ref.)" 
		2.age_gr "Age group, 25 or younger (ref.)"
		2.yearphd "Year of PhD, 1st year (ref.)" 
		, nolabel 
	) 
	coeflabel( 
		2.section "`vspacing'B"
		3.section "`vspacing'C"
		4.section "`vspacing'D"
		5.section "`vspacing'E"
		2.age_gr "`vspacing'26 to 30"
		3.age_gr "`vspacing'31 to 35"
		4.age_gr "`vspacing'36 or older"
		2.yearphd "`vspacing'2nd year"
		3.yearphd "`vspacing'3rd year"
		4.yearphd "`vspacing'4th year"
		5.yearphd "`vspacing'5th year or more"
		contract "Working contract only"
		parent "Parent"
		d_2_n "Contact person"
		_cons "Intercept"
	)
;
#delimit cr

estimates clear

* ==============================================================================
* D7f: More support needed for learning German (internationals)
* ==============================================================================

gen language= d_7f_n
replace language=. if d_7f_n==99

* _______________________________________________________________________
* Logistic regressions

* Model 1 -----------------------------------------------------------
* logit language i.a_3 i.a_6_g i.a_1_duration_g contract parents [pw=weight]

logit language i.section i.age_gr i.yearphd contract parent [pw=weight]
est store M1

* Model 2 -----------------------------------------------------------
* logit language d_2_n i.a_3 i.a_6_g i.a_1_duration_g contract parents [pw=weight]

logit language d_2_n i.section i.age_gr i.yearphd contract parent [pw=weight]
est store M2

* _______________________________________________________________________
* Export table

local vspacing "\hspace{0.4cm}"

#delimit ;
esttab M1 M2 using "${tables_tex}d_7f_logit.tex", replace 
	b(2) se(2) noomit nobase wide booktabs fragment
	alignment(S S)
	nomtitles 
	collabels("\multicolumn{1}{c}{Coef.}" "\multicolumn{1}{c}{SE}")
	eqlabels(none)
	refcat( 
		2.section "Section, A (ref.)" 
		2.age_gr "Age group, 25 or younger (ref.)"
		2.yearphd "Year of PhD, 1st year (ref.)" 
		, nolabel 
	) 
	coeflabel( 
		2.section "`vspacing'B"
		3.section "`vspacing'C"
		4.section "`vspacing'D"
		5.section "`vspacing'E"
		2.age_gr "`vspacing'26 to 30"
		3.age_gr "`vspacing'31 to 35"
		4.age_gr "`vspacing'36 or older"
		2.yearphd "`vspacing'2nd year"
		3.yearphd "`vspacing'3rd year"
		4.yearphd "`vspacing'4th year"
		5.yearphd "`vspacing'5th year or more"
		contract "Working contract only"
		parent "Parent"
		d_2_n "Contact person"
		_cons "Intercept"
	)
;
#delimit cr

estimates clear

* ==============================================================================
* E2: Children in Household (Parenthood)
* ==============================================================================

* _______________________________________________________________________
* Logistic regression

* Model 1 -----------------------------------------------------------
logit e_2 i.section a_6_n gender i.yearphd inter contract [pw=weight]
est store M1

* _______________________________________________________________________
* Export table

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
		contract "Working contract only"
		_cons "Intercept"
	)
;
#delimit cr

estimates clear
