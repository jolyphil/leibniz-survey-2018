********************************************************************************
* Project:	Leibniz PhD Network Survey 2018
* Task:		Generate bar graphs for questions with multiple answers
* Authors:	Survey Working Group
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

* Female ------------------------------------------------------------

recode a_5 (1=1)(2=0)(else=.), gen(female)
_crcslbl female a_5

label define femalelb	///
	0 "Male"			///
	1 "Female", modify
label values female femalelb

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
* C1: Support for activities related to career development
* ==============================================================================
* _______________________________________________________________________
* Graphs: C.1.A. Support for conferences with participation

* Recode and reorder labels -----------------------------------------
recode c_1a_n (0=4) (1=1) (2=3) (3=2), gen(c_1a_rec)
_crcslbl c_1a_rec c_1a_n

label define c1lb	///
	1 "Yes and all expenses covered" ///
	2 "Yes and expenses partly covered" ///
	3 "Yes but non-monetary support" ///
	4 "No" ///
	98 "Prefer not to answer" ///
	99 "Don't know", modify
label values c_1a_rec c1lb

* Overall results  --------------------------------------------------

* Export graph
graph pie [aw=weight], over(c_1a_rec) ///
	pie(5, color(gs12)) ///
	pie(6, color(gs10))
graph export "${figures_pdf}c_1a_n_pie.pdf", replace

* Export graph data
estpost tabulate c_1a_rec [aw=weight], nototal
esttab using "${figures_data}c_1a_n_pie.csv", ///
	cells("pct(fmt(2))") csv noobs plain collabels(none) ///
	varlabels(`e(labels)') unstack nomtitles ///
	replace

* By section, year of PhD, internationals, contract  ----------------
	
foreach var of varlist section yearphd inter contract {
	* Export graph
	graph hbar (count) [aw=weight], ///
		over(c_1a_rec) over(`var') ///
		asyvars percentages ytitle("Percentage of doctoral candidates") ///
		bar(5, color(gs12)) ///
		bar(6, color(gs10)) ///
		stack ///
		xsize(8)
	graph export "${figures_pdf}c_1a_n_`var'_bar.pdf", replace

	* Export graph data
	estpost tabulate c_1a_rec `var' [aw=weight], nototal
	esttab using "${figures_data}c_1a_n_`var'_bar.csv", ///
		cell(colpct(fmt(2))) unstack noobs  varlabels(`e(labels)') ///
		collabels(none) nomtitles plain ///
	replace 
}
*	

* _______________________________________________________________________
* Graphs: C.1.B. Support for conferences without participation

* Recode and reorder labels -----------------------------------------
recode c_1b_n (0=4) (1=1) (2=3) (3=2), gen(c_1b_rec)
_crcslbl c_1b_rec c_1b_n
label values c_1b_rec c1lb

* Overall results  --------------------------------------------------

* Export graph
graph pie [aw=weight], over(c_1b_rec) ///
	pie(5, color(gs12)) ///
	pie(6, color(gs10))
graph export "${figures_pdf}c_1b_n_pie.pdf", replace

* Export graph data
estpost tabulate c_1b_rec [aw=weight], nototal
esttab using "${figures_data}c_1b_n_pie.csv", ///
	cells("pct(fmt(2))") csv noobs plain collabels(none) ///
	varlabels(`e(labels)') unstack nomtitles ///
	replace

* By section, contract  ---------------------------------------------
	
foreach var of varlist section contract {
	* Export graph
	graph hbar (count) [aw=weight], ///
		over(c_1b_rec) over(`var') ///
		asyvars percentages ytitle("Percentage of doctoral candidates") ///
		bar(5, color(gs12)) ///
		bar(6, color(gs10)) ///
		stack ///
		xsize(8)
	graph export "${figures_pdf}c_1b_n_`var'_bar.pdf", replace

	* Export graph data
	estpost tabulate c_1b_rec `var' [aw=weight], nototal
	esttab using "${figures_data}c_1b_n_`var'_bar.csv", ///
		cell(colpct(fmt(2))) unstack noobs  varlabels(`e(labels)') ///
		collabels(none) nomtitles plain ///
	replace 
}
*	
* _______________________________________________________________________
* Graphs: C.1.C. Support for job fairs

* Recode and reorder labels -----------------------------------------
recode c_1c_n (0=4) (1=1) (2=3) (3=2), gen(c_1c_rec)
_crcslbl c_1c_rec c_1c_n
label values c_1c_rec c1lb

* Overall results  --------------------------------------------------

* Export graph
graph pie [aw=weight], over(c_1c_rec) ///
	pie(5, color(gs12)) ///
	pie(6, color(gs10))
graph export "${figures_pdf}c_1c_n_pie.pdf", replace

* Export graph data
estpost tabulate c_1c_rec [aw=weight], nototal
esttab using "${figures_data}c_1c_n_pie.csv", ///
	cells("pct(fmt(2))") csv noobs plain collabels(none) ///
	varlabels(`e(labels)') unstack nomtitles ///
	replace

* By section, contract  ---------------------------------------------
	
foreach var of varlist section contract {
	* Export graph
	graph hbar (count) [aw=weight], ///
		over(c_1c_rec) over(`var') ///
		asyvars percentages ytitle("Percentage of doctoral candidates") ///
		bar(5, color(gs12)) ///
		bar(6, color(gs10)) ///
		stack ///
		xsize(8)
	graph export "${figures_pdf}c_1c_n_`var'_bar.pdf", replace

	* Export graph data
	estpost tabulate c_1c_rec `var' [aw=weight], nototal
	esttab using "${figures_data}c_1c_n_`var'_bar.csv", ///
		cell(colpct(fmt(2))) unstack noobs  varlabels(`e(labels)') ///
		collabels(none) nomtitles plain ///
	replace 
}
* _______________________________________________________________________
* Graphs: C.1.D. Support for specific training

* Recode and reorder labels -----------------------------------------
recode c_1d_n (0=4) (1=1) (2=3) (3=2), gen(c_1d_rec)
_crcslbl c_1d_rec c_1d_n
label values c_1d_rec c1lb

* Overall results  --------------------------------------------------

* Export graph
graph pie [aw=weight], over(c_1d_rec) ///
	pie(5, color(gs12)) ///
	pie(6, color(gs10))
graph export "${figures_pdf}c_1d_n_pie.pdf", replace

* Export graph data
estpost tabulate c_1d_rec [aw=weight], nototal
esttab using "${figures_data}c_1d_n_pie.csv", ///
	cells("pct(fmt(2))") csv noobs plain collabels(none) ///
	varlabels(`e(labels)') unstack nomtitles ///
	replace

* By section, contract  ---------------------------------------------
	
foreach var of varlist section contract {
	* Export graph
	graph hbar (count) [aw=weight], ///
		over(c_1d_rec) over(`var') ///
		asyvars percentages ytitle("Percentage of doctoral candidates") ///
		bar(5, color(gs12)) ///
		bar(6, color(gs10)) ///
		stack ///
		xsize(8)
	graph export "${figures_pdf}c_1d_n_`var'_bar.pdf", replace

	* Export graph data
	estpost tabulate c_1d_rec `var' [aw=weight], nototal
	esttab using "${figures_data}c_1d_n_`var'_bar.csv", ///
		cell(colpct(fmt(2))) unstack noobs  varlabels(`e(labels)') ///
		collabels(none) nomtitles plain ///
	replace 
}

* ==============================================================================
* C2: Personal mentor
* ==============================================================================
* _______________________________________________________________________
* ANOVA

* Test intergroup differences ---------------------------------------

local iv "section female yearphd inter parent contract"

foreach var of varlist `iv' {
	local label : variable label `var'
	disp "`label' --------"
	anova c_2_n `var' [aw=weight] if c_2_n <= 1 // ignore don't knows
}
* Conclusions -------------------------------------------------------

* Only year of PhD is significant.


* _______________________________________________________________________
* Graphs

* Recode ------------------------------------------------------------
recode c_2_n (0 = 2), gen(c_2_rec)
_crcslbl c_2_rec c_2_n

label define c_2_reclb ///
	1 "Yes" ///
	2 "No" ///
	99 "Don’t know", modify
label values c_2_rec c_2_reclb

* Overall results  --------------------------------------------------

* Export graph
graph pie [aw=weight], over(c_2_rec) ///
	pie(2, color("43 140 190")) ///
	pie(3, color(gs12))
graph export "${figures_pdf}c_2_pie.pdf", replace

* Export graph data
estpost tabulate c_2_rec [aw=weight], nototal
esttab using "${figures_data}c_2_pie.csv", ///
	cells("pct(fmt(2))") csv noobs plain collabels(none) ///
	unstack nomtitles ///
	replace

* By year of PhD  ---------------------------------------------------

* Export graph
graph hbar (count) [aw=weight], ///
	over(c_2_rec) over(yearphd) ///
	asyvars percentages ytitle("Percentage of doctoral candidates") ///
	bar(2, color("43 140 190")) ///
	bar(3, color(gs12)) ///
	stack ///
	xsize(8)
graph export "${figures_pdf}c_2_yearphd_bar.pdf", replace

* Export graph data
estpost tabulate c_2_rec yearphd [aw=weight], nototal
esttab using "${figures_data}c_2_yearphd_bar.csv", ///
	cell(colpct(fmt(2))) unstack noobs  varlabels(`e(labels)') ///
	collabels(none) nomtitles plain ///
replace 


* ==============================================================================
* C3: Actions taken to prepare future career
* ==============================================================================

* _______________________________________________________________________
* ANOVA
* Test intergroup differences ---------------------------------------

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

* Conclusions -------------------------------------------------------

/*
Significant factors according to ANOVA: ***

1. Build a network
	- (Nothing significant)
    
2. Specific training
	- Year of PhD

3. Seek advice
	- Year of PhD
	- Parents
    
4. Constant job search
	- Year of PhD
    
5. Apply for jobs already
	- Year of PhD
	- Parents

6. None
	- (Nothing significant)
*/

* _______________________________________________________________________
* Graphs

* Overall results  --------------------------------------------------

* Order variables from most to least frequent

local ordered_var "c_3a_n c_3c_n c_3b_n c_3d_n c_3e_n c_3f_n"
summ `ordered_var' [aw=weight]

tabstat `ordered_var'

capture drop c_3a_n_rec c_3c_n_rec c_3b_n_rec c_3d_n_rec c_3e_n_rec c_3f_n_rec
foreach var of varlist `ordered_var' {
	* little trick to get percentages and not proportions
	recode `var'(1=100), gen(`var'_rec)
	_crcslbl `var'_rec `var'
	local ordered_var_pct "`ordered_var_pct' `var'_rec"
}
disp "`ordered_var_pct'"

* Display labels in order

foreach var of varlist `ordered_var' {
	local label : variable label `var'
	disp "`label'"
}
* Output:
/*
career: Bulid a network
career: seek advice
career: specific training
career: constant job search
career: apply to job already
career: none
*/

* Generate and export the graph
graph hbar (mean) `ordered_var_pct' [aw=weight], ///
	showyvars  /// 
	yvaroptions(relabel( ///
		1 "Bulid a network" ///
		2 "Seek advice" ///
		3 "Specific training" ///
		4 "Constant job search" ///
		5 "Apply to job already" ///
		6 "None" /// 
		)) ///
	bargap(10) ///
	yscale(noline) ///
	ytitle("Percentage of doctoral candidates") ///
	legend(off)
graph export "${figures_pdf}c_3_bar.pdf", replace

* Export graph data
estpost tabstat `ordered_var_pct', statistics(mean) columns(statistics)
esttab using "${figures_data}c_3_bar.csv", ///
	cells("mean(fmt(2))") ///
	coeflabel( ///
		c_3a_n_rec "Bulid a network" ///
		c_3c_n_rec "Seek advice" ///
		c_3b_n_rec "Specific training" ///
		c_3d_n_rec "Constant job search" ///
		c_3e_n_rec "Apply to job already" ///
		c_3f_n_rec "None" ///
		) ///
	csv noobs plain collabels(none) unstack nomtitles ///
	replace

* ==============================================================================
* C4: Preferred area after the PhD
* ==============================================================================

* _______________________________________________________________________
* ANOVA

* Test intergroup differences ---------------------------------------

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
* _______________________________________________________________________
* Graphs

*...

* ==============================================================================
* C4.1: Reasons for not pursuing a career in academia
* ==============================================================================

* _______________________________________________________________________
* ANOVA

* Test intergroup differences ---------------------------------------

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
* Conclusions -------------------------------------------------------
/*
Significant factors according to ANOVA: ***

1. Academic
	- Section 
	- Gender
	- Year of PhD
	- Internationals
	- Contract

2. Scientific, public
	- Section 
	- Gender

3. Non-scientific, public
	- Section 
	- Year of PhD
	- Internationals
	- Contract

4. Non-scientific, private
	- Section 
	- Gender
	- Year of PhD
	- Internationals
	- Contract

5. Scientific, private
	- Section 
	- Gender
	- Parents
	- Contract

5. Don't know 
	- Gender
*/

* _______________________________________________________________________
* Graphs

*...

* ==============================================================================
* C5.2: Professional training needed
* ==============================================================================

* _______________________________________________________________________
* ANOVA

* Test intergroup differences ---------------------------------------

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

* Conclusions -------------------------------------------------------
/*
Significant factors according to ANOVA: ***

1. Scientific writing
	- Section
	- Gender
	- Year
	- Internationals
	- Parents
    
2. English
	- Section
	- Gender

3. German
	- Section
	- Year of PhD
	- Internationals
	- Contract
    
4. Other language
	- Year of PhD
	- Parents
    
5. Scientific methods
	- Section
	- Gender
	- Year of PhD
	- Internationals

6. Graduate schools
	- Section

7. Grant application
	- Section
	- Gender
	- Internationals

8. Other soft skills
	- Year
	- Internationals
*/

* _______________________________________________________________________
* Graphs

*...

* ==============================================================================
* C6: Information about career options
* ==============================================================================

recode c_6_n (99=.), gen(infocareer)
_crcslbl infocareer c_6_n

* _______________________________________________________________________
* ANOVA
* Test intergroup differences ---------------------------------------

local iv "section female yearphd inter parent contract"

foreach var of varlist `iv' {
	local label : variable label `var'
	disp "`label' --------"
	anova infocareer `var' [aw=weight]
}

* Conclusions -------------------------------------------------------
/*
Significant factors according to ANOVA (five most important factors): ***
	- Section
*/

* _______________________________________________________________________
* Graphs

*...
