* ============================================================================
* Date: 21/08/2018
* Project: Leibniz PhD Network Survey 
*
* This program is intended to transform the raw data into a working sample
* 
* database used:	- results-survey-2018-02-05.dta
* 
* output:			- final_data.dta - final_data.csv
*
* ============================================================================


clear all	
clear matrix
set more off
capture log close
/*
global input "H:\leibnizSurvey\input\"			// macro for data input
global output "H:\leibnizSurvey\output\"			// macro for data output
global temp "H:\leibnizSurvey\temp\"			// macro for temp data
*/

global input 	"INSERT PATH\Data\input"			// macro for data input
global output 	"INSERT PATH\Data\output"		// macro for data output
global temp 	"INSERT PATH\Data\temp"			// macro for temp data
global dofiles 	"INSERT PATH\Data\do-files"			// macro for temp data

* ============================================================================

/*
cd ${input}
unicode analyze "results-survey-2018-02-05.dta", redo
unicode encoding set ISO-8859-1
unicode translate "results-survey-2018-02-05.dta", transutf8																// tranlasting uncode strings (so we can see "ös and ßs")
*/



* ============================================================================

* ============================================================================
* First data editing
* ============================================================================


use "${input}/results-survey-2018-02-05.dta", clear

drop url 
drop if id == 33 // Drop one observation as it was a pretest interview

* ============================================================================
* Section A
* ============================================================================

* start of PhD thesis 

tab a_1 

* generation of start and date of phd as date variables
gen startphd_1 = substr(a_1,1,4)
destring startphd_1, gen(a_1_year)
drop startphd_1
gen startphd_1 = substr(a_1,9,2)
destring startphd_1, gen(a_1_day)
drop startphd_1
gen startphd_2 = substr(a_1,6,2)
destring startphd_2, gen(a_1_month)
drop startphd_2

cap drop a_1_n 
gen a_1_n = mdy(a_1_month, a_1_day, a_1_year)
format a_1_n %d 
*drop a_1_year
drop a_1_day
*drop a_1_month
 
gen date_sub_month = substr(date_sub,6,2) // interview submitted in which month?

/* Correcting for the month the response has been submitted */
gen add_month = .
replace add_month = -1 if date_sub_month=="11"
replace add_month = 0 if date_sub_month=="12"
replace add_month = 1 if date_sub_month=="01"
replace add_month = 2 if date_sub_month=="02"

gen a_1_duration = ((a_1_year-2018)*-1)*12
replace a_1_duration = a_1_duration-a_1_month
replace a_1_duration = a_1_duration+add_month

recode a_1_duration (0/12 = 1) (13/24=2) (25/36=3) (37/48=4) (49/170=5), gen(a_1_duration_g)
label define labduration 1 "First year" 2 "Second year" 3 "Third year" 4 "Fourth year" 5 "Fifth or more years"
label value a_1_duration_g labduration

lab var a_1_duration_g "Duration of PhD until survey interview"

/* percentiles - Eine andere potentielle Lösung zur Gruppierung der Dauer des PhDs
pctile  p10_dur = a_1_duration, nq(10)

     gen     a_1_duration_pct=. 
     replace a_1_duration_pct=1 if a_1_duration<=r(r1) 
     replace a_1_duration_pct=2 if a_1_duration<=r(r2) & a_1_duration>r(r1) 
     replace a_1_duration_pct=3 if a_1_duration<=r(r3) & a_1_duration>r(r2) 
     replace a_1_duration_pct=4 if a_1_duration<=r(r4) & a_1_duration>r(r3) 
     replace a_1_duration_pct=5 if a_1_duration<=r(r5) & a_1_duration>r(r4) 
     replace a_1_duration_pct=6 if a_1_duration<=r(r6) & a_1_duration>r(r5)  
     replace a_1_duration_pct=7 if a_1_duration<=r(r7) & a_1_duration>r(r6)  
     replace a_1_duration_pct=8 if a_1_duration<=r(r8) & a_1_duration>r(r7) 
     replace a_1_duration_pct=9 if a_1_duration<=r(r9) & a_1_duration>r(r8)  
     replace a_1_duration_pct=10 if a_1_duration>r(r9) & a_1_duration<.      
*/

*Expect. End of PhD Thesis

tab a_2
gen endphd_1 = substr(a_2,1,4)
destring endphd_1, gen(a_2_year)
drop endphd_1
gen endphd_1 = substr(a_2,9,2)
destring endphd_1, gen(a_2_day)
drop endphd_1
gen endphd_2 = substr(a_2,6,2)
destring endphd_2, gen(a_2_month)
drop endphd_2

cap drop a_2_n 
gen a_2_n = mdy(a_2_month, a_2_day, a_2_year)
format a_2_n %d 
*drop a_2_year
drop a_2_day
*drop a_2_month

/* Total duration of PhD in months */
gen a_2_duration =(a_2_year-a_1_year)*12 + a_2_month - a_1_month

/* Please note: Only 13 people in the sample with a PhD duration of less than 2 years */
recode a_2_duration (0/36=1) (37/48=2) (49/60=3) (60/170=4), gen(a_2_duration_g)
label define labduration2 1 "Less than 3 years" 2 "3 to 4 years" 3 "4 to 5 years" 4 "More than 5 years"
label value a_2_duration_g labduration2

lab var a_2_duration "Total duration of PhD in months"
lab var a_2_duration_g "Total duration of PhD in years (grouped)"

/* percentiles - Eine andere potentielle Lösung zur Gruppierung der Dauer des PhDs
pctile  p10_dur = a_2_duration, nq(10)

     gen     a_2_duration_pct=. 
     replace a_2_duration_pct=1 if a_2_duration<=r(r1) 
     replace a_2_duration_pct=2 if a_2_duration<=r(r2) & a_2_duration>r(r1) 
     replace a_2_duration_pct=3 if a_2_duration<=r(r3) & a_2_duration>r(r2) 
     replace a_2_duration_pct=4 if a_2_duration<=r(r4) & a_2_duration>r(r3) 
     replace a_2_duration_pct=5 if a_2_duration<=r(r5) & a_2_duration>r(r4) 
     replace a_2_duration_pct=6 if a_2_duration<=r(r6) & a_2_duration>r(r5)  
     replace a_2_duration_pct=7 if a_2_duration<=r(r7) & a_2_duration>r(r6)  
     replace a_2_duration_pct=8 if a_2_duration<=r(r8) & a_2_duration>r(r7) 
     replace a_2_duration_pct=9 if a_2_duration<=r(r9) & a_2_duration>r(r8)  
     replace a_2_duration_pct=10 if a_2_duration>r(r9) & a_2_duration<.      
*/


* Section of the Leibniz Association

tab a_3
rename a_3 a_3_temp
label define a_3 ///
1 "Section A: Humanities and Educational Research" ///
2 "Section B: Economics, Social Sciences, Spatial Research" ///
3 "Section C: Life Sciences" ///
4 "Section D: Mathematics, Natural Sciences, Engineering" ///
5 "Section E: Environmental Research" ///
98 "I prefer not answer", replace
encode a_3_temp, gen(a_3)
drop a_3_temp  

lab def a_3short ///
1 "Section A" ///
2 "Section B" ///
3 "Section C" ///
4 "Section D" ///
5 "Section E" ///
98 "I prefer not answer", replace
lab val a_3 a_3short
numlabel a_3short, add
codebook a_3

* Citizenship

tab a_4
rename a_4 a_4_temp
label define a_4 ///
1 "German and others" ///
2 "only German" ///
3 "other citizenship of an EU-member country" ///
4 "other citizenship outside the EU", replace
encode a_4_temp, gen(a_4)
lab val a_4 a_4
drop a_4_temp  
codebook a_4             


* Gender
tab a_5
rename a_5 a_5_temp
label define a_5 ///
1 "Female" ///
2 "Male" ///
3 "Neither / Other" ///
98 "I prefer not to answer", replace
encode a_5_temp, gen(a_5)
lab val a_5 a_5
drop a_5_temp  
codebook a_5

* Second version of Gender
gen a_5rec = (a_5-2)*-1
replace a_5rec =. if a_5>=3
lab def lab_a_5rec 1 "Female" 0 "Male" 
lab val a_5rec lab_a_5rec

* Age
rename a_6 a_6_n

recode a_6_n (20/25 = 1) (26/30 = 2) (31/35 = 3) (36/50 = 4), gen(a_6_g)

label define age_groupsl 1 "Younger than 25" 2 "26 to 30" 3 "31 to 35" 4 "Older than 35"
label value a_6_g age_groupsl
label var a_6_g "Age in groups"

order a_1 a_1_n a_1_duration_g a_2 a_2_n a_2_duration a_2_duration_g a_3 a_4 a_5 a_6_n a_6_g, a(date_lastaction)
drop a_1 a_1_year a_1_month date_sub_month add_month a_1_duration a_2 a_2_year a_2_month 


* ============================================================================
* Section B
* ============================================================================

* Satisfaction (QB.1)
codebook b_1 // 0 missing

rename b_1 b_1_str
label define b_1 1 "Very dissatisfied" 2 "Dissatisfied" 3 "Rather dissatisfied" 4 "Rather satisfied" 5 "Satisfied" 6 "Very satisfied"
encode b_1_str, gen(b_1)
codebook b_1
drop b_1_str

* Contract type (QB.2)
codebook b_2

rename b_2 b_2_str
label define b_2 99 "I don't know" 97 "Other" ///
5 "Working contract" ///
4 "Both, stipend and contract" ///
3 "Stipend (by your institute)" ///
2 "Stipend (other)" ///
1 "I have no funding/payment", replace
encode b_2_str, gen(b_2)
codebook b_2
drop b_2_str

* Contract type Other (QB.2 fill in)--> leave for team "Freifelder")

/* Main concept of comparing working contract to stipend holders */
gen contract = .
replace contract = 1 if b_2 == 5
replace contract = 0 if b_2 <=4
replace contract = . if b_2 == 1 // I don't have a contract == missing value

lab var contract "Resp. with working contract (1) or stipends (0)"

lab def labcontract 0 "Stipends or stipend + contract" 1 "Working contract"
lab val contract labcontract
numlabel labcontract, add

order b_1 b_2, before(b_2a)
order contract, a(b_2a)

* Payment (QB.2.a) (problem of special characters)
codebook b_2_1 //202 missing
rename b_2_1 b_2_1_str
encode b_2_1_str, gen(b_2_1)
label list b_2_1
recode b_2_1 (10=97) (8=98) (7=99) (9=1) (1=7)
label define b_2_1 99 "I don't know" 98 "I prefer not to answer" 97 "Other" ///
7 "100%" 6 "76 - 99%" 5 "66 - 75%" ///
4 "51 - 65%" 3 "50%" 2 "25 - 49%" 1 "< 25%", replace 
label val b_2_1 b_2_1
tab b_2_1
drop b_2_1_str
* Payment Other (QB.2.1 fill in)--> leave for team "Freifelder")

order b_2_1, before(b_2_1a)

* monthly net income (QB2.2) (problem of special characters)
codebook b_2_2
rename b_2_2 b_2_2_str
encode b_2_2_str, gen(b_2_2)
label list b_2_2
recode b_2_2 (13=98) (11=1) (7=2) (8=3) (9=4) (10=5) (1=6) (2=7) (3=8) (4=9) (5=10) (6=11) 
label define b_2_2 ///
1 "<= 500 EURO" /// 
2 "501 - 650 EURO" /// 
3 "651 - 800 EURO" /// 
4 "801 - 950 EURO" /// 
5 "951 - 1100 EURO" /// 
6 "1101 - 1250 EURO" ///
7 "1251 - 1400 EURO" /// 
8 "1401 - 1550 EURO" /// 
9 "1551 - 1700 EURO" /// 
10 "1701 - 1850 EURO" ///
11 "1851 - 2000 EURO" /// 
12 ">= 2001 EURO" ///
98 "I prefer not to answer" , replace
label values b_2_2 b_2_2
tab b_2_2, m
drop b_2_2_str

* hours worked per week (QB.3)
codebook b_3
rename b_3 b_3_str
label define b_3 99 "I don't know" 98 "I prefer not to answer" 97 "Other"
encode b_3_str, gen(b_3)
codebook b_3
drop b_3_str

* hours worked per week --> positive answer (QB.3)
tab b_3a
replace b_3a="32.5" if b_3a=="30-35" 
replace b_3a="40" if b_3a=="30-50 (exluding fieldwork)" 
replace b_3a="37.5" if b_3a=="35-40" 
replace b_3a="40" if b_3a=="35-45" 
replace b_3a="39.2" if b_3a=="39,2"
replace b_3a="39.5" if b_3a=="39,5"
replace b_3a="40" if b_3a=="40 +/- 5"
replace b_3a="40" if b_3a=="40 approx."
replace b_3a="40" if b_3a=="40 or more"
replace b_3a="42.5" if b_3a=="40-45" 
replace b_3a="45" if b_3a=="40-50" 
replace b_3a="47.5" if b_3a=="40-55" 
replace b_3a="50" if b_3a=="40-60" 
replace b_3a="42" if b_3a=="42+" 
replace b_3a="47.5" if b_3a=="45-50" 
replace b_3a="50" if b_3a=="45-55" 
replace b_3a="47.5" if b_3a=="45/50" 
replace b_3a="45" if b_3a=="45h"
replace b_3a="55" if b_3a=="50-60"  
replace b_3a="57.5" if b_3a=="55-60" 
replace b_3a="65" if b_3a=="60-70"
replace b_3a="65" if b_3a=="60 -70hours" 
replace b_3a="7.5" if b_3a=="7,5"
replace b_3a="8" if b_3a=="8 or more"
replace b_3a="9" if b_3a=="8-10"
replace b_3a="8.5" if b_3a=="8-9"
replace b_3a="9.5" if b_3a=="9-10"
replace b_3a="50" if b_3a==">50"
replace b_3a="40" if b_3a=="around 40"
replace b_3a="40" if b_3a=="more than 40"
replace b_3a="30.5" if b_3a=="305"

destring b_3a, replace
sum b_3a

order b_2_2 b_3, before(b_3a)

* distribution of working time (QB.4)
*--> !!! I renamed the variables as it's not logical from my point of view
rename b_4m b_4l
rename b_4n b_4m
rename b_4p b_4n
rename b_4q b_4o

foreach z in a b c d e f g h i j k l m n o {
codebook b_4`z'
}

* Distrib. of working time other (QB.4 fill in)--> leave for team "Freifelder")

* duration of current contract/stipend (QB.5)
codebook b_5

rename b_5 b_5_str
label define b_5 ///
1 "Up to 6 months" ///
2 "Up to 12 months" ///
3 "Up to 18 months" /// 
4 "Up to 24 months" /// 
5 "Up to 36 months" ///
6 "More than 36 months" ///
99 "I don't know.", replace
encode b_5_str, gen(b_5)
codebook b_5
drop b_5_str

* Number of contracts and stipends (QB.6)
codebook b_6
order b_5, before(b_6)


* improvement of financial situation (QB.7)
foreach z in a b c d e f g h{
tab b_7`z'
}

rename b_7h b_7_1 // such as the other "other-variables"

foreach z in a b c d e f g {
rename b_7`z' b_7`z'_str
label define b_7`z' 0 "No" 1 "Yes", replace 
encode b_7`z'_str, gen(b_7`z')
drop b_7`z'_str
}

* improvements (QB.7 fill in)--> leave for team "Freifelder")

order b_7a - b_7g, before(b_7_1)

* satisfaction with supervision (QB.8)
codebook b_8 // 0 missing
rename b_8 b_8_str
label define b_8 1 "Very dissatisfied" 2 "Dissatisfied" 3 "Rather dissatisfied" 4 "Rather satisfied" 5 "Satisfied" 6 "Very satisfied"
encode b_8_str, gen(b_8)
codebook b_8
drop b_8_str


* emlpoyment of supervisor (QB.9)
foreach z in a b c d e f g{
tab b_9`z', m
}

foreach z in a b c d e f g {
replace b_9`z'="" if b_9`z'=="N/A"
rename b_9`z' b_9`z'_str
label define b_9`z' 0 "No" 1 "Yes", replace 
encode b_9`z'_str, gen(b_9`z')
drop b_9`z'_str
}

* Frequency of communication with supervisor (QB.10)
codebook b_10
rename b_10 b_10_str
label define b_10 1 "Never" 2"Less than once a year" ///
3 "Yearly" 4 "Six-monthly" 5 "Quarterly" 6 "Monthly" ///
7 "Weekly" 8 "Almost daily", replace
encode b_10_str, gen(b_10)
codebook b_10
drop b_10_str

* Supervision agreement (QB.11)
codebook b_11
rename b_11 b_11_str
label define b_11 1 "Yes" 0 "No" 99 "I don't know.", replace
encode b_11_str, gen(b_11)
codebook b_11
drop b_11_str

* Rating of supervision (QB.12)
foreach z in a b c d e f g h i{
tab b_12`z', m
}

foreach z in a b c d e f g h i{
rename b_12`z' b_12`z'_str
label define b_12`z' 98 "I prefer not to answer" 1 "Fully disagree" 2 "Partially disagree" 3 "Neither agree nor disagree" 4 "Partially agree" 5 "Fully agree", replace
encode b_12`z'_str, gen(b_12`z')
drop b_12`z'_str
}

* feeling integrated (QB.13)
codebook b_13
rename b_13 b_13_str
label define b_13 99 "I do not know" 98 "I prefer not to answer" ///
1 "Not integrated at all" 2 "Rather not integrated" ///
3 "Integrated" 4 "Very integrated", replace
encode b_13_str, gen(b_13)
codebook b_13
drop b_13_str

* reasons for feeling not integrated (QB13.1)--> leave for team "Freifelder"

order b_8 - b_13, before (b_13_1)

* PhD council/representatives (QB.14)
codebook b_14
rename b_14 b_14_str
label define b_14 99 "I don't know." 0 "No" 1 "Yes", replace
encode b_14_str, gen(b_14)
codebook b_14
drop b_14_str

* Not continuing doctorate QB.15

codebook b_15
replace b_15="" if b_15=="N/A"
rename b_15 b_15_str
label define b_15 0 "No" 1 "Yes", replace
encode b_15_str, gen(b_15)
codebook b_15
drop b_15_str

* reasons for not continuing doctorate (QB15.1)

foreach z in a b c d e f g h i j k {
tab b_15_1`z', m
}

foreach z in a b c d e f g h i j k {
replace b_15_1`z'="" if b_15_1`z'=="N/A"
rename b_15_1`z' b_15_1`z'_str
label define b_15_1`z' 0 "No" 1 "Yes", replace 
encode b_15_1`z'_str, gen(b_15_1`z')
drop b_15_1`z'_str
}

* reasons for not continuing doctorate (QB15.1) --> Leave for group Freitextfelder

rename b_15_1m b_15_1_1
rename b_15_1_1_ b_15_1_2

order b_14 - b_15_1k, before (b_15_1_1) 

* Support at the institute (QB.16)
codebook b_16
rename b_16 b_16_str
label define b_16 1 "No" 2 "No, but my colleagues help me." 3 "Yes", replace
encode b_16_str, gen(b_16)
codebook b_16
drop b_16_str

order b_16, before(c_1a)

* ============================================================================
* Section C
* ============================================================================

desc c_*

rename (c5_1 c5_1a) (c_5_1 c_5_1a)

foreach v of var c_* {
        	encode `v', gen(`v'_n) 
			}
*
label variable 	c_1a_n	"Support with: conferences with active particip."
label variable 	c_1b_n	"Support with: conferences without active particip."
label variable 	c_1c_n	"Support with: job fairs"
label variable 	c_1d_n	"Support with: specific trainings"
label variable 	c_1e_n	"Support with: other"
label variable 	c_1_1_n	"Support from your institute "
label variable 	c_2_n	"personal mentor for career"
label variable 	c_3a_n	"career: Bulid a network"
label variable 	c_3b_n	"career: specific training"
label variable 	c_3c_n	"career: seek advice"
label variable 	c_3d_n	"career: constant job search"
label variable 	c_3e_n	"career: apply to job already"
label variable 	c_3f_n	"career: none"
label variable 	c_3g_n	"career: other"
label variable 	c_4a_n	"Preferred area: Academia, scientific"
label variable 	c_4b_n	"Preferred area: Science-related public work "
label variable 	c_4c_n	"Preferred area: Publically-funded non-scientific job "
label variable 	c_4d_n	"Preferred area: Private non-scientific job "
label variable 	c_4e_n	"Preferred area: Private scientific jobs in industry "
label variable 	c_4f_n	"Preferred area: Don't know"
label variable 	c_4g_n	"Preferred area: Other"
label variable 	c_4_1a_n	"Reasons against academia: Interest"
label variable 	c_4_1b_n	"Reasons against academia: competetive"
label variable 	c_4_1c_n	"Reasons against academia: organize work"
label variable 	c_4_1d_n	"Reasons against academia: low chance to get post doc position"
label variable 	c_4_1e_n	"Reasons against academia: unlimited working contract"
label variable 	c_4_1f_n	"Reasons against academia: supervisor"
label variable 	c_4_1g_n	"Reasons against academia: grades"
label variable 	c_4_1h_n	"Reasons against academia: new challenge "
label variable 	c_4_1i_n	"Reasons against academia: payment"
label variable 	c_4_1j_n	"Reasons against academia: resident changes"
label variable 	c_4_1k_n	"Reasons against academia: familiy responsibilities"
label variable 	c_4_1m_n	"Reasons against academia: qualification"
label variable 	c_4_1n_n	"Reasons against academia: other"
label variable 	c_5a_n	"Professional trainings: Scientific writing"
label variable 	c_5b_n	"Professional trainings:  English"
label variable 	c_5c_n	"Professional trainings: German"
label variable 	c_5d_n	"Professional trainings: Other language"
label variable 	c_5e_n	"Professional trainings: career development"
label variable 	c_5f_n	"Professional trainings: scientific methods"
label variable 	c_5g_n	"Professional trainings: graduate school"
label variable 	c_5h_n	"Professional trainings: grant application"
label variable 	c_5i_n	"Professional trainings: other soft skills"
label variable 	c_5_1_n	"Are there other sorts of professional trainings"
label variable 	c_5_1a_n	"Professional trainings: other"
label variable 	c_5_2a_n	"Need training: scientific writing"
label variable 	c_5_2b_n	"Need training: English"
label variable 	c_5_2c_n	"Need training: German"
label variable 	c_5_2d_n	"Need training: other language"
label variable 	c_5_2e_n	"Need training: scientific methods"
label variable 	c_5_2f_n	"Need training: graduate school"
label variable 	c_5_2g_n	"Need training: grant application"
label variable 	c_5_2h_n	"Need training: other soft skills"
label variable 	c_5_2i_n	"Need training: other "
label variable 	c_6_n	"Sufficiently informed about carrer options"
label variable 	c_6_1_n	"Information about which career-related topics"

drop c_1a c_1b c_1c c_1d c_1e c_1_1 c_2 c_3a c_3b c_3c c_3d c_3e c_3f c_3g c_4a ///
	c_4b c_4c c_4d c_4e c_4f c_4g c_4_1a c_4_1b c_4_1c c_4_1d c_4_1e c_4_1f c_4_1g ///
	c_4_1h c_4_1i c_4_1j c_4_1k c_4_1m c_5a c_5b c_5c c_5d c_5e c_5f c_5g c_5h c_5i ///
	c_5_1 c_5_1 c_5_1a c_5_2a c_5_2b c_5_2c c_5_2d c_5_2e c_5_2f c_5_2g c_5_2h c_5_2i c_6 c_6_1


foreach v of var c_1* c_2* c_3* c_4* c_5* c_6*{
        	tab `v' //, nolabel
			}
*			

// // // recode c1 variables // // //

global c_1_global c_1a_n c_1b_n c_1c_n c_1d_n c_1e_n 

recode $c_1_global (1= 99) (2 = 98) (3 = 0) (4=1) (5=2) (6=3) 

label define c_1_label 1 "Yes, and all expenses are covered" ///
				2 "Yes, but expenses are not covered" ///
				3 "Yes, but expenses are only partly cover" ///
				0 "No" 99 "Don't know"  98 "Prefer not to answer"  97 "Other" 
				
label values c_1a_n c_1b_n c_1c_n c_1d_n c_1e_n  c_1_label 

foreach v of var $c_1_global {
        	tab `v' , nolabel
			}

// // // recode c2 variables // // //

codebook c_2_n

recode c_2_n (1 = 99) (2=0) (3=1)

label define c_2_label 1 "Yes" 0 "No" 99 "Don't know" 

label values c_2_n c_2_label

// // // recode c3 variables // // //

global c_3_global c_3a_n c_3b_n c_3c_n c_3d_n c_3e_n 

recode $c_3_global (1= .) (2 = 0) (3 = 1) // 99-dont know  98-prefer not to answer 97-other

label define c_3_label 1 "Yes" 0 "No" 
				
label values $c_3_global c_3_label 

recode c_3f_n (1=0) (2=1) 
label val c_3f_n c_3_label 

// // // recode c4 variables // // //

codebook c_* 

global c_4_global c_4a_n c_4b_n c_4c_n c_4d_n c_4e_n  ///
				c_4_1a_n c_4_1b_n c_4_1c_n c_4_1d_n c_4_1e_n c_4_1f_n c_4_1g_n ///
				c_4_1h_n c_4_1i_n c_4_1j_n c_4_1k_n c_4_1m_n

recode $c_4_global (1= .) (2 = 0) (3 = 1) // 99-dont know  98-prefer not to answer 97-other 

label define c_4_label 1 "Yes" 0 "No"  
				
label values $c_4_global c_4_label 

recode c_4f_n (1=0) (2=1)
label val c_4f_n c_4_label 



// // // recode c5 variables // // //

global c_5_global c_5a_n c_5b_n c_5c_n c_5d_n c_5e_n c_5f_n c_5g_n c_5h_n c_5i_n 

recode $c_5_global (1= 99) (2 = 0) (3 = 1) 

label define c_5_label 1 "Is offered at my institute to doctoral researchers" ///
						0 "Is not offered at my institute to doctoral researchers" /// 
						99 "I do not know if it is offered at my institute to doctoral researchers" 

label values $c_5_global c_5_label 

recode c_5_1_n (1=99)(2=0)(3=1) 
label define c_5_1_n 1 "Yes" 0 "No" 99 "Don't know", replace 
label values c_5_1_n c_5_1_n 


codebook c_5_2a_n c_5_2b_n c_5_2c_n c_5_2d_n c_5_2e_n c_5_2f_n c_5_2g_n c_5_2h_n c_5_2i_n

global c_5_2_global c_5_2a_n c_5_2b_n c_5_2c_n c_5_2d_n c_5_2e_n c_5_2f_n c_5_2g_n c_5_2h_n

recode $c_5_2_global (1=0) (2=1) 

label define c_5_2_label 1 "Yes" 0 "No" 
				
label values $c_5_2_global c_5_2_label 


recode c_6_n (1=99)(2=0)(3=1)
label define c_6_n 1 "Yes" 0 "No" 99 "Don't know", replace 
label values c_6_n c_6_n 


* ============================================================================
* Section D
* ============================================================================
desc d_*

foreach v of var d_* {
        	encode `v', gen(`v'_n) 
			}
*

label variable 	d_1_n	"Did you grow up in Germany?"
label variable 	d_2_n	"Is there a contact person for people from abroad at your institute?"
label variable 	d_3a_n	"Going to the registration office"
label variable 	d_3b_n	"Opening a bank account"
label variable 	d_3c_n	"Clarification of residence permit"
label variable 	d_3d_n	"Health insurance"
label variable 	d_3e_n	"Finding a flat"
label variable 	d_3f_n	"Finding a childcare place"
label variable 	d_3g_n	"Finding a medical doctor who speaks a language you understand"
label variable 	d_3h_n	"General information about living and bureaucracy in Germany"
label variable 	d_3i_n	"Translation of documents"
label variable 	d_3j_n	"Accompanying persons for dealing with bureaucratic issues (maybe also for translation)"
label variable 	d_4_n	"Do you desire more support or would you have desired more support in the past?"
label variable 	d_4a_n	"Do you desire more support or would you have desired more support in the past? Other"
label variable 	d_5a_n	"work language(s) at your institute? English"
label variable 	d_5b_n	"work language(s) at your institute? German"
label variable 	d_5c_n	"work language(s) at your institute? Other"
label variable 	d_6_n	"Do you have language barriers in the work language at your institute?"
label variable 	d_7a_n	"My institute offers language classes."
label variable 	d_7b_n	"My institute offers funding for external language classes."
label variable 	d_7c_n	"My institute permits the attendance of language classes during working hours."
label variable 	d_7d_n	"My colleagues help me to learn German."
label variable 	d_7e_n	"I do not need support for learning German (e.g. because I speak German)"
label variable 	d_7f_n	"More support for learning German would be desirable."
label variable 	d_7_1_n	"Please specify, how this support would ideally look like:"
label variable 	d_8_n	"Do you have additional comments regarding the support of foreign/international doctoral researchers at your institute or research museum?"

drop d_1 d_2 d_3a d_3b d_3c d_3d d_3e d_3f d_3g d_3h d_3i d_3j d_4 d_4a ///
		d_5a d_5b d_5c d_6 d_7a d_7b d_7c d_7d d_7e d_7f d_7_1 d_8 

// // // recode d_ variables // // //

codebook d_1_n d_2_n

recode d_1_n d_2_n (1=.)(2=0)(3=1)

label define d_label 1 "Yes" 0 "No" 99 "Don't know", replace
label values d_1_n d_2_n d_label 

// // // recode d_3 variables // // //

codebook d_3a_n d_3b_n d_3c_n d_3d_n d_3e_n d_3f_n d_3g_n d_3h_n d_3i_n d_3j_n

global d_3_global d_3a_n d_3b_n d_3c_n d_3d_n d_3e_n d_3f_n d_3g_n d_3h_n d_3i_n d_3j_n

recode $d_3_global (1=99)(4=1)(2=0)(3=2)

label define d_3_label 0 "No, does not exist"  1 "Yes, exists" ///
		2 " does not exist, but colleagues help informally" ///
		99 "Don't know", replace
		
label values $d_3_global d_3_label

codebook $d_3_global 

// // // recode d_4 variables // // //

recode d_4_n (1=0)(2=97)

label define d_4_n 0 "No" 97 "Other", replace
		
label values d_4_n d_4_n

codebook d_4_n

// // // recode d_5 variables // // //

codebook d_5a_n d_5b_n d_5c_n

recode d_5a_n d_5b_n (1=.)(2=0)(3=1)

label values d_5a_n d_5b_n d_label 

codebook d_5a_n d_5b_n d_5c_n


// // // recode d_6 variables // // //

codebook d_6_n

recode d_6_n (1=.)(2=0)(3=1) 

label values d_6_n d_label 

codebook d_6_n

// // // recode d_7 variables // // //

codebook d_7a_n d_7b_n d_7c_n d_7d_n d_7e_n d_7f_n d_7_1_n

global d_7_global d_7a_n d_7b_n d_7c_n d_7d_n d_7e_n d_7f_n

recode $d_7_global (1=99)(2=0)(3=1) 

label values $d_7_global d_label 

codebook $d_7_global


* ============================================================================
* Section E
* ============================================================================

* Parents

mvdecode e_2, mv(98 = .)

* ============================================================================

* Note to the the lime Survey group: Is it possible to disinguish between children
* and adults in the hh?


* ============================================================================



* Marital status

codebook e_1
cap drop e_1_temp
gen e_1_temp = .
replace e_1_temp = 1 if e_1 == "I have a partner/wife/husband"
replace e_1_temp = 0 if e_1 == "Single"
replace e_1_temp = 98 if e_1 == "I prefer not to answer."
label define partner ///
0 "Single" ///
1 "I have a partner/wife/husband" ///
98 "I prefer not to answer.", replace

label val e_1_temp partner
drop e_1
rename e_1_temp e_1



foreach var in 2 4{
	
	codebook e_`var'
	rename e_`var' e_`var'_str
	label define e_`var' 0 "No" 1 "Yes" 98 "I prefer not to answer."
	encode e_`var'_str, gen(e_`var')
	drop e_`var'_str
	codebook e_`var'
	
}


codebook e_3_1
rename e_3_1 e_3_1_str
label define e_3_1 ///
1 "< 1 year" ///
2 "1 - 2 years" ///
3 "3 - 6 years" ///
4 "7 - 10 years" ///
5 "11 - 14 years" ///
98 "I prefer not to answer.", replace
encode e_3_1_str, gen(e_3_1)
drop e_3_1_str

rename e_3a e_3a_n
rename e_3b e_3b_n


* Compatibility

label define agree ///
1 "Strongly disagree" ///
2 "Disagree" ///
3 "Neither agree nor disagree" ///
4 "Agree" ///
5 "Strongly agree" ///
98 "I prefer not to answer", replace ///


foreach var in a b c d e f g h i{
	gen e_5`var'_temp = .
	replace e_5`var'_temp = 1 if e_5`var' == "5 (strongly disagree)"
	replace e_5`var'_temp = 2 if e_5`var' == "4 (disagree)"
	replace e_5`var'_temp = 3 if e_5`var' == "3 (neither agree nor disagree)"
	replace e_5`var'_temp = 4 if e_5`var' == "2 (agree)"
	replace e_5`var'_temp = 5 if e_5`var' == "1 (strongly agree)"
	replace e_5`var'_temp = 98 if e_5`var' == "I prefer not to answer."
	
	cap drop e_5`var'
	
	label val e_5`var'_temp agree
	rename e_5`var'_temp e_5`var'
}




* ============================================================================
* Section F
* ============================================================================



foreach var of var f_1 f_2a f_2b f_2c f_2d f_2e f_2f{
	tab `var'
	rename `var' `var'_temp
	label define `var' 0 "No" 1 "Yes" 96 "N/A"
	encode `var'_temp, gen(`var')
	drop `var'_temp
}






* ============================================================================
* Section G
* ============================================================================


label variable a_1_n "Start of PhD thesis"
label variable a_2_n "Exp. end of PhD thesis"
label variable a_3 "Section of the Leibniz Association"
label variable a_4 "Citizenship"
label variable a_5 "Gender"
label variable a_6_n "Age"
label 	var	b_1	"satisfaction with situation in general"
label 	var	b_2	"type of contract"
label 	var	b_2a	"type of contract [Other]"
label 	var	b_2_1	"level of payment according to contract"
label 	var	b_2_1a	"level of payment according to contract [Other]"
label 	var	b_2_2	"av. monthly net income"
label 	var	b_3	"av. hours worked per week [Reject/don't know]"
label 	var	b_3a	"av. hours worked per week "
label 	var	b_4a	"distribution of working time (%) [PhD thesis]"
label 	var	b_4b	"distribution of working time (%) [Research projects]"
label 	var	b_4c	"distribution of working time (%) [Teaching]"
label 	var	b_4d	"distribution of working time (%) [Own education]"
label 	var	b_4e	"distribution of working time (%) [Advisory for practioners]"
label 	var	b_4f	"distribution of working time (%) [Applications for funding]"
label 	var	b_4g	"distribution of working time (%) [PR, communication with society]"
label 	var	b_4h	"distribution of working time (%) [Scientific presentations]"
label 	var	b_4i	"distribution of working time (%) [Applications facility time]"
label 	var	b_4j	"distribution of working time (%) [Organisation of scientific events]"
label 	var	b_4k	"distribution of working time (%) [Reviewing journal articles]"
label 	var	b_4l	"distribution of working time (%) [Supervision of students/interns]"
label 	var	b_4m	"distribution of working time (%) [Administrative tasks]"
label 	var	b_4n	"distribution of working time (%) [Other tasks]"
label 	var	b_4o	"distribution of working time (%) [I don't know (100%)]"
label 	var	b_4_1	"list of other tasks"
label 	var	b_5	"total duration of current contract or stipend"
label 	var	b_6	"number of prior contracts or stipends in institute"
label 	var	b_7a	"suggested improvement [Higher payment]"
label 	var	b_7b	"suggested improvement [More positions]"
label 	var	b_7c	"suggested improvement [transparency about funding options]"
label 	var	b_7d	"suggested improvement [More completion grants]"
label 	var	b_7e	"suggested improvement [Follow-up grants]"
label 	var	b_7f	"suggested improvement [Better hardship grants]"
label 	var	b_7g	"suggested improvement [no need for improvements]"
label 	var	b_7_1	"suggested improvement [Other]"
label 	var	b_8	"satisfaction with PhD supervision in general"
label 	var	b_9a	"Employment first supervisor [At your Leibniz Institute]"
label 	var	b_9b	"Employment first supervisor [At another Leibniz Institute]"
label 	var	b_9c	"Employment first supervisor [At a university]"
label 	var	b_9d	"Employment first supervisor [Emeritus]"
label 	var	b_9e	"Employment first supervisor [I do not know]"
label 	var	b_9f	"Employment first supervisor [I prefer not to answer]"
label 	var	b_9g	"Employment first supervisor [Other]"
label 	var	b_10	"frequency of communication first supervisor"
label 	var	b_11	"supervision agreement"
label 	var	b_12a	"rating supervision [informed in research field]"
label 	var	b_12b	"rating supervision [available for advice]"
label 	var	b_12c	"rating supervision [constructive feedback]"
label 	var	b_12d	"rating supervision [respects own ideas]"
label 	var	b_12e	"rating supervision [advice on career development]"
label 	var	b_12f	"rating supervision [informed on state of work]"
label 	var	b_12g	"rating supervision [encouragement of independent work]"
label 	var	b_12h	"rating supervision [polite treatment]"
label 	var	b_12i	"rating supervision [reliable and consistent advice]"
label 	var	b_13	"feeling integrated into institute"
label 	var	b_13_1	"not feeling integrated into institute [reasons]"
label 	var	b_14	"PhD council / representatives at institute"
label 	var	b_15	"thoughts on not continuing doctorate"
label 	var	b_15_1a	"reason(s) for not continuing [dislike scientific work]"
label 	var	b_15_1b	"reason(s) for not continuing [dislike topic]"
label 	var	b_15_1c	"reason(s) for not continuing [Financial insecurities]"
label 	var	b_15_1d	"reason(s) for not continuing [Unclear career path]"
label 	var	b_15_1e	"reason(s) for not continuing [Work-related difficulties with supervisor]"
label 	var	b_15_1f	"reason(s) for not continuing [Personal difficulties with supervisor]"
label 	var	b_15_1g	"reason(s) for not continuing [No or poor results]"
label 	var	b_15_1h	"reason(s) for not continuing [Other jobs more interesting]"
label 	var	b_15_1i	"reason(s) for not continuing [not compatible family responsibilities]"
label 	var	b_15_1j	"reason(s) for not continuing [feeling not qualified]"
label 	var	b_15_1k	"reason(s) for not continuing [I prefer not to answer]"
label 	var	b_15_1_1 "reason(s) for not continuing [Other]"
label 	var	b_15_1_2	"reason(s) for not continuing [incompatible family responsibilities]"
label 	var	b_16	"important information at institute in understandable language"
label variable e_1 "Partner/wife/husband"
label variable e_2 "Children in HH"
label variable e_3a "Number of HH members of age 18 or older"
label variable e_3b "Number of HH members below age 18"
label variable e_3_1 "Age youngest child"
label variable e_4 "Care responsibilities"
label variable e_5a "Compatibility: care responsibilities children"
label variable e_5b "Compatibility: care responsibilities family"
label variable e_5c "Compatibility: romantic relationship"
label variable e_5d "Compatibility: children if family takes over care responsibility"
label variable e_5e "Compatibility with private life"
label variable e_5f "Compatibility: regional mobility"
label variable e_5g "Compatibility: financial uncertainty"
label variable e_5h "Compatibility: hobby"
label variable e_5i "Compatibility: social life"
label variable e_6 "Additional aspects in area of compatibility science and priv. life"
label variable f_1 "Knowledge about PhD network"
label variable f_2a "Get to know about Leibniz PhD Network via PhD representatives"
label variable f_2b "Get to know about Leibniz PhD Network via Leibniz Website"
label variable f_2c "Get to know about Leibniz PhD Network via newsletter of the Leibniz PhD Network"
label variable f_2d "Get to know about Leibniz PhD Network via Facebook page of the Leibniz PhD Network"
label variable f_2e "Get to know about Leibniz PhD Network via email from the Leibniz Association"
label variable f_2f "Get to know about Leibniz PhD Network via colleagues"
label variable f_2g "Get to know about Leibniz PhD Network via others"
label variable f_3 "Expectations towards work of the Leibniz PhD Network?"
label variable g_1 "General feedback/comments about the survey or the Leibniz PhD Network"


* ============================================================================

numlabel, add																											// add numbers to the variable labels


/* Common definitions for report */

/* The following definition of citizenship will be applied throughout the report */
* Second version of citizenship without double citizenships
recode a_4 (1/2 = 1) (3 = 2) (4 = 3), gen(a_4rec)
lab def lab_a_4rec 1 "German (and others)" 2 "Other, EU-member" 3 "Other, Non-EU"
lab val a_4rec lab_a_4rec
numlabel lab_a_4rec, add    

gen internationals=0 
replace internationals = 1 if a_4rec!=1 & d_1!=1
lab def labint 0 "Germans OR growing up in GER" 1 "Internationals" 
lab val internationals labint 
numlabel labint, add

lab var internationals "True internationals (Main variable for report)"
order a_4rec internationals, a(a_4)

** Coding open questions **
qui do "${dofiles}\coding-open-questions.do" // put the respective do-file into the folder first 

save "${output}/final_data.dta", replace

*** Add weights
qui do "${dofiles}/weighting_scheme_dg&jls_final.do"

save "${output}/final_data.dta", replace
