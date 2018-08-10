********************************************************************************
* Project:	Leibniz PhD Network Survey 2018
* Task:		Generate bar graphs for questions with multiple answers
* Author:	Philippe Joly, Humboldt-Universität zu Berlin & WZB
********************************************************************************

* ______________________________________________________________________________
* Preparation

set scheme minimal // I use my own scheme, but you can use any you like.

// Define your own data folder in a global macro if needed.
use "${data}final_data_weights.dta"

* ______________________________________________________________________________
* Example 1: Question C4 ("Which of the following work areas would you prefer 
* after your PhD?")

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Examine variables and labels

* After inspection variables are ordered from the highest to the lowest mean.
* Means correspond to the percentage of respondents answering "yes"
local ordered_var "c_4a_n c_4e_n c_4b_n c_4d_n c_4c_n c_4f_n"
summ `ordered_var' [aweight = weight]

* Run the loop to display the variable labels in the right order
foreach var of varlist `ordered_var' {
	local label : variable label `var'
	disp "`label'"
}

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Generate and export the graph

* Output:
/*
Preferred area: Academia, scientific
Preferred area: Private scientific jobs in industry 
Preferred area: Science-related public work 
Preferred area: Publically-funded non-scientific job 
Preferred area: Private non-scientific job 
Preferred area: Don't know
*/

graph hbar (mean) `ordered_var' [aweight = weight], ///
	showyvars  /// 
	yvaroptions(relabel( ///
		1 "Academia, scientific" ///
		2 "Private scientific jobs" ///
		3 "Science-related public work" ///
		4 "Publically-funded non-scientific job" ///
		5 "Private non-scientific job" ///
		6 "Don't know" /// 
		)) ///
	bargap(10) ///
	yscale(noline) ///
	bar(1, color(ebblue)) /// Need to change settings to get same color for all
	bar(2, color(ebblue)) /// ... the bars.
	bar(3, color(ebblue)) ///
	bar(4, color(ebblue)) ///
	bar(5, color(ebblue)) ///
	bar(6, color(ebblue)) ///
	legend(off)

// Define your own figures folder in a global macro if needed.
graph export "${figures_pdf}fig_c4.pdf", replace
