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
* Question C3 ("Which of the following actions are you undertaking in order to 
* prepare your professional future career")

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Examine variables and labels

* After inspection variables are ordered from the highest to the lowest mean.
* Means correspond to the percentage of respondents answering "yes"
local ordered_var "c_3a_n c_3c_n c_3b_n c_3d_n c_3e_n c_3f_n"
summ `ordered_var'

* Run the loop to display the variable labels in the right order
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

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Generate and export the graph

graph hbar (mean) `ordered_var', ///
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
	bar(1, color(ebblue)) /// Need to change settings to get same color for all
	bar(2, color(ebblue)) /// ... the bars.
	bar(3, color(ebblue)) ///
	bar(4, color(ebblue)) ///
	bar(5, color(ebblue)) ///
	bar(6, color(ebblue)) ///
	legend(off)

// Define your own figures folder in a global macro if needed.
graph export "${figures_pdf}fig_c3.pdf", replace
graph export "${figures_png}fig_c3.png", replace ///
	width(2750) height(2000)

* ______________________________________________________________________________
* Question C4 ("Which of the following work areas would you prefer after your 
* PhD?")

* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Examine variables and labels

local ordered_var "c_4a_n c_4e_n c_4b_n c_4c_n c_4d_n c_4f_n"
summ `ordered_var' 

foreach var of varlist `ordered_var' {
	local label : variable label `var'
	disp "`label'"
}
* Output:
/*
Preferred area: Academia, scientific
Preferred area: Private scientific jobs in industry 
Preferred area: Science-related public work 
Preferred area: Publically-funded non-scientific job 
Preferred area: Private non-scientific job 
Preferred area: Don't know
*/
* _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
* Generate and export the graph

graph hbar (mean) `ordered_var', ///
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
	bar(1, color(ebblue)) /// 
	bar(2, color(ebblue)) /// 
	bar(3, color(ebblue)) ///
	bar(4, color(ebblue)) ///
	bar(5, color(ebblue)) ///
	bar(6, color(ebblue)) ///
	legend(off)

graph export "${figures_pdf}fig_c4.pdf", replace
graph export "${figures_png}fig_c4.png", replace ///
	width(2750) height(2000)
* ______________________________________________________________________________
* Question C4.1 ("What are the reasons for not considering a future career in
* academia?")

local ordered_var "c_4_1e_n  c_4_1j_n c_4_1i_n c_4_1b_n c_4_1k_n c_4_1d_n c_4_1h_n c_4_1m_n c_4_1a_n c_4_1c_n c_4_1g_n c_4_1f_n"
summ `ordered_var' 

foreach var of varlist `ordered_var' {
	local label : variable label `var'
	disp "`label'"
}
* Output:
/*
Reasons against academia: unlimited working contract
Reasons against academia: resident changes
Reasons against academia: payment
Reasons against academia: competetive
Reasons against academia: familiy responsibilities
Reasons against academia: low chance to get post doc position
Reasons against academia: new challenge 
Reasons against academia: qualification
Reasons against academia: Interest
Reasons against academia: organize work
Reasons against academia: grades
Reasons against academia: supervisor
*/

graph hbar (mean) `ordered_var', ///
	showyvars  /// 
	yvaroptions(relabel( ///
		1 "Limited working contracts" ///
		2 "Changes of residence" ///
		3 "Other sectors paid better" ///
		4 "Too competitive" ///
		5 "Familiy responsibilities" ///
		6 "Low chance to get post doc position" /// 
		7 "Looking for a new challenge" /// 
		8 "Do not feel qualified enough" /// 
		9 "No interest" /// 
		10 "Hard to organize my own work" /// 
		11 "Don't have the required grades" /// 
		12 "Supervisor advised to leave academia" /// 
		)) ///
	bargap(10) ///
	yscale(noline) ///
	bar(1, color(ebblue)) /// 
	bar(2, color(ebblue)) /// 
	bar(3, color(ebblue)) ///
	bar(4, color(ebblue)) ///
	bar(5, color(ebblue)) ///
	bar(6, color(ebblue)) ///
	bar(7, color(ebblue)) ///
	bar(8, color(ebblue)) ///
	bar(9, color(ebblue)) ///
	bar(10, color(ebblue)) ///
	bar(11, color(ebblue)) ///
	bar(12, color(ebblue)) ///
	legend(off)
graph export "${figures_pdf}fig_c4_1.pdf", replace
graph export "${figures_png}fig_c4_1.png", replace ///
	width(2750) height(2000)
* ______________________________________________________________________________
* Question C5.2 ("In which of the following areas of professional training do 
* you see need for more support with regard to career development?")
	
local ordered_var "c_5_2e_n c_5_2g_n c_5_2a_n c_5_2h_n c_5_2b_n c_5_2c_n c_5_2f_n c_5_2d_n"
summ `ordered_var' 

foreach var of varlist `ordered_var' {
	local label : variable label `var'
	disp "`label'"
}
* Output:
/*
Need training: scientific methods
Need training: grant application
Need training: scientific writing
Need training: other soft skills
Need training: English
Need training: German
Need training: graduate school
Need training: other language
*/

graph hbar (mean) `ordered_var', ///
	showyvars  /// 
	yvaroptions(relabel( ///
		1 "Scientific methods" ///
		2 "Grant application" ///
		3 "Scientific writing" ///
		4 "Other soft skills" ///
		5 "English" ///
		6 "German" /// 
		7 "Graduate school" /// 
		8 "Other language" /// 
		)) ///
	bargap(10) ///
	yscale(noline) ///
	bar(1, color(ebblue)) ///
	bar(2, color(ebblue)) ///
	bar(3, color(ebblue)) ///
	bar(4, color(ebblue)) ///
	bar(5, color(ebblue)) ///
	bar(6, color(ebblue)) ///
	bar(7, color(ebblue)) ///
	bar(8, color(ebblue)) ///
	legend(off)
graph export "${figures_pdf}fig_c5_2.pdf", replace
graph export "${figures_png}fig_c5_2.png", replace ///
	width(2750) height(2000)
