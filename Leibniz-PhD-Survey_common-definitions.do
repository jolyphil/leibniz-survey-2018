** Common definitions in Leibniz PhD Survey Data!

/* CITIZENSHIP */

/* The following definition of citizenship will be applied throughout the report */
* Second version of citizenship without double citizenships
recode a_4 (1/2 = 1) (3 = 2) (4 = 3), gen(a_4rec)
lab def lab_a_4rec 1 "German (and others)" 2 "Other, EU-member" 3 "Other, Non-EU"
lab val a_4rec lab_a_4rec
numlabel lab_a_4rec, add    

gen internationals = 0 
replace internationals = 1 if a_4rec!=1 & d_1!=1
lab def labint 0 "Germans OR growing up in GER" 1 "Internationals" 
lab val internationals labint 
numlabel labint, add

lab var internationals "True internationals (Main variable for report)"
order a_4rec internationals, a(a_4)


/* Main concept of comparing WORKING CONTRACTS to STIPEND HOLDERS */
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
