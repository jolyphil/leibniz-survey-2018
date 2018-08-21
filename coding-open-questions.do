*** Do-file to insert coding of open questions ***

** Define important label
lab def labdummy 0 "No" 1 "Yes"

/* Replacing existing variables for some cases */

*** Type of contract
replace b_2 = 5	if id == 556 & b_2 == 97
replace b_2 = 5	if id == 82	& b_2 == 97
replace b_2 = 5	if id == 1359 & b_2 == 97
replace b_2 = 5	if id == 248 & b_2 == 97
replace b_2 = 5	if id == 637 & b_2 == 97
replace b_2 = 3	if id == 736 & b_2 == 97
replace b_2 = 2	if id == 1255 & b_2 == 97
replace b_2 = 5	if id == 403 & b_2 == 97
replace b_2 = 2	if id == 799 & b_2 == 97
replace b_2 = 2	if id == 1554 & b_2 == 97
replace b_2 = 5	if id == 1325 & b_2 == 97
replace b_2 = 5	if id == 1559 & b_2 == 97
replace b_2 = 1	if id == 495 & b_2 == 97
replace b_2 = 5	if id == 1264 & b_2 == 97
replace b_2 = 5	if id == 1012 & b_2 == 97
replace b_2 = 5	if id == 580 & b_2 == 97
replace b_2 = 5	if id == 923 & b_2 == 97
replace b_2 = 5	if id == 795 & b_2 == 97
replace b_2 = 2	if id == 1150 & b_2 == 97
replace b_2 = 5	if id == 608 & b_2 == 97
replace b_2 = 5	if id == 797 & b_2 == 97

*** Level of payment
replace b_2_1 = 99	if id == 1076 & b_2_1 == 97 // marked as mv as person said WHK contract earning more than 2000 EUR per month
replace b_2_1 = 4 if id == 374 & b_2_1 == 97
replace b_2_1 = 1 if id == 649 & b_2_1 == 97
replace b_2_1 = 1 if id == 801 & b_2_1 == 97
replace b_2_1 = 4 if id == 546 & b_2_1 == 97
replace b_2_1 = 4 if id == 333 & b_2_1 == 97
replace b_2_1 = 7 if id == 122 & b_2_1 == 97


*** Distribution of working time on specific tasks 

/* 1st: Replacing given variiables with the amount of time given in "Other tasks" */

replace b_4b = b_4b + b_4n if id == 236 | id == 207 // Research projects (not your PhD project)
replace b_4n = 0 if id == 236 | id == 207 // set Other tasks to for these cases 0 

replace b_4c = b_4c + b_4n if id == 976	// Teaching
replace b_4n = 0 if id == 976 // set Other tasks to for these cases 0

replace b_4d = b_4d + b_4n if id == 959 // Own education
replace b_4n = 0 if id == 959 // set Other tasks to for these cases 0

replace b_4g = b_4g + b_4n if id == 448 | id == 84 | id == 1011 | id == 244 // Public relation, communication with society
replace b_4n = 0 if id == 448 | id == 84 | id == 1011 | id == 244 // set Other tasks to for these cases 0

replace b_4j = b_4j + b_4n if id == 1333 |	id == 136 | id == 689 // Organisation of scientific meetings/conferences
replace b_4n = 0 if id == 1333 |	id == 136 | id == 689 // set Other tasks to for these cases 0

replace b_4k = b_4k + b_4n if id == 908 | id == 1110  // Reviewing articles for scientific journals
replace b_4n = 0 if id == 908 | id == 1110 // set Other tasks for these cases 0

replace b_4m = b_4m + b_4n if id == 887 | id == 281 | id == 1326 | id == 165 | id == 682 | id == 906 | id == 821 | id == 1563 | id == 1670 // 13	Administrative tasks within the Leibniz Institute
replace b_4n = 0 if id == 887 | id == 281 | id == 1326 | id == 165 | id == 682 | id == 906 | id == 821 | id == 1563 | id == 1670 

/* To-Do: 2nd Coding of additional taks within working time (new categories) */

*** Suggestions for improvements of financial situation
gen b_7h = 0 
replace b_7h = 1 if id == 374 | id == 64 | id == 56 | id == 596 | id == 450 | id == 1077 | id == 1279 | id == 335 | id == 489 | id == 1584 | id == 1702 | id == 518 | id == 364 | id == 1536 | id == 538 | id == 703 | id == 349
lab var b_7h "suggested improvements [At least 65% positions]"

gen b_7j = 0
replace b_7j = 1 if id == 672 | id == 247 | id == 361 | id == 801 | id == 654 | id == 448 | id == 1040 | id == 379 | id == 154 | id == 229 | id == 911 | id == 975 | id == 797 | id == 1540 | id == 816 | id == 658 | id == 878 | id == 776
lab var b_7j "suggested improvements [Longer contracts]"

lab val b_7h b_7j labdummy
numlabel labdummy, add

order b_7h b_7j, a(b_7g)

*** Where is supervisor employed? 
replace b_9a = 1 if id == 657 // at your Leibniz Institute 
replace b_9b = 1 if id == 963 | id == 404 // at another Leibniz Institute 
replace b_9c = 1 if id == 580 | id == 772 // university
replace b_9d = 1 if id == 413 // emeritus

** Other 
replace b_9g = 1 if id == 937 | id == 797 | id == 162  | id == 216 | id == 74 | id == 102 // other
replace b_9g = 0 if b_9g > 1 // all other cases == 0 

* New variable for "No supervisor"
gen  b_9h = 0

replace b_9h = 1 if id == 569 | id == 1031 | id == 644 | id == 475 | id == 1077 | id == 68 | id == 609

lab val b_9h b_9g labdummy 
numlabel labdummy, add

lab var b_9h "Employment first supervisor [Don't have a supervisor]"
order b_9h, a(b_9g)

/* Creating new variables with addditional information (e.g. from follow-up questions) */

*** Other reasons for thinking about quitting doctorate

* 1. recoding existing categories
replace b_15_1a = 1 if id == 600 | id == 801 | id == 832 | id == 1578 // I do not like scientific work anymore
replace b_15_1b = 1 if id == 1157 | id == 1739	// I do not like my topic anymore
replace b_15_1c = 1 if id == 201  // Financial insecurity
replace b_15_1d = 1 if id == 474 | id == 475 | id == 795 // Unclear career path
replace b_15_1e = 1 if id == 112 | id == 558 | id == 608 | id == 644 | id == 701 | id == 888 // Work-related difficulties with supervisor
replace b_15_1f = 1 if id == 533 | id == 1471 	// Personal difficulties with supervisor
replace b_15_1g = 1 if id == 1392 	// Poor results
replace b_15_1i = 1 if id == 422 | id == 1740	// Family responsibilities
replace b_15_1j = 1 if id == 241 | id == 1116 // Feeling not qualified

* 2. New categories

gen b_15_1add = .

replace b_15_1add =	12 if id == 382
replace b_15_1add =	12 if id == 433
replace b_15_1add =	12 if id == 528
replace b_15_1add =	12 if id == 626
replace b_15_1add =	12 if id == 723
replace b_15_1add =	12 if id == 753
replace b_15_1add =	12 if id == 814
replace b_15_1add =	12 if id == 1084
replace b_15_1add =	13 if id == 136
replace b_15_1add =	13 if id == 142
replace b_15_1add =	13 if id == 147
replace b_15_1add =	13 if id == 380
replace b_15_1add =	13 if id == 479
replace b_15_1add =	13 if id == 538
replace b_15_1add =	13 if id == 554
replace b_15_1add =	13 if id == 562
replace b_15_1add =	13 if id == 692
replace b_15_1add =	13 if id == 709
replace b_15_1add =	13 if id == 1034
replace b_15_1add =	13 if id == 1188
replace b_15_1add =	13 if id == 1638
replace b_15_1add =	14 if id == 389
replace b_15_1add =	14 if id == 543
replace b_15_1add =	14 if id == 797
replace b_15_1add =	14 if id == 1035
replace b_15_1add =	14 if id == 1669
replace b_15_1add =	15 if id == 104
replace b_15_1add =	15 if id == 442
replace b_15_1add =	15 if id == 1619
replace b_15_1add =	16 if id == 115
replace b_15_1add =	16 if id == 285
replace b_15_1add =	16 if id == 360
replace b_15_1add =	16 if id == 488
replace b_15_1add =	16 if id == 856
replace b_15_1add =	16 if id == 871
replace b_15_1add =	16 if id == 880
replace b_15_1add =	16 if id == 894
replace b_15_1add =	16 if id == 908
replace b_15_1add =	16 if id == 990
replace b_15_1add =	16 if id == 993
replace b_15_1add =	16 if id == 1738
replace b_15_1add =	17 if id == 707
replace b_15_1add =	17 if id == 967
replace b_15_1add =	18 if id == 209
replace b_15_1add =	18 if id == 305
replace b_15_1add =	18 if id == 323
replace b_15_1add =	18 if id == 344
replace b_15_1add =	18 if id == 471
replace b_15_1add =	18 if id == 756
replace b_15_1add =	18 if id == 845
replace b_15_1add =	18 if id == 929
replace b_15_1add =	18 if id == 1054
replace b_15_1add =	18 if id == 1258
replace b_15_1add =	18 if id == 1366
replace b_15_1add =	18 if id == 1459
replace b_15_1add =	18 if id == 1513
replace b_15_1add =	18 if id == 1707

* Labeling 
lab var b_15_1add "Other reasons leading to thoughts about quitting PhD"

lab def labquitreasons ///
12 "Time pressure" ///
13 "Pressure due to workload and expectations" ///
14 "Bad atmosphere at workplace" ///
15 "Unclear project definition" ///
16 "Probblems with institutions/project partners etc." ///
17 "Institute's bureaucracy" ///
18 "Personal reasons" 

lab val b_15_1add labquitreasons
numlabel labquitreasons, add

order b_15_1add, a(b_15_1j)

*** Quitting doctorate: Concrete familiy responsibilities 
gen b_15_1i_add = .

replace b_15_1i_add = 12 if id == 1075 & b_15_1i == 1
replace b_15_1i_add = 12 if id == 891 & b_15_1i == 1
replace b_15_1i_add = 12 if id == 986 & b_15_1i == 1
replace b_15_1i_add = 12 if id == 338 & b_15_1i == 1
replace b_15_1i_add = 12 if id == 1015 & b_15_1i == 1
replace b_15_1i_add = 12 if id == 344 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 156 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 1286 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 230 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 989 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 1076 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 752 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 1519 & b_15_1i == 1
replace b_15_1i_add = 13 if id == 556 & b_15_1i == 1
replace b_15_1i_add = 14 if id == 754 & b_15_1i == 1
replace b_15_1i_add = 14 if id == 1104 & b_15_1i == 1
replace b_15_1i_add = 14 if id == 1573 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 1317 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 1119 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 1514 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 1040 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 1556 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 509 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 458 & b_15_1i == 1
replace b_15_1i_add = 15 if id == 1268 & b_15_1i == 1
replace b_15_1i_add = 16 if id == 493 & b_15_1i == 1
replace b_15_1i_add = 16 if id == 587 & b_15_1i == 1
replace b_15_1i_add = 16 if id == 553 & b_15_1i == 1
replace b_15_1i_add = 16 if id == 854 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 374 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 321 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 958 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 210 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 488 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 1493 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 1110 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 1262 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 85	& b_15_1i == 1
replace b_15_1i_add = 17 if id == 209 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 477 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 185 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 591 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 1551 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 938 & b_15_1i == 1
replace b_15_1i_add = 17 if id == 844 & b_15_1i == 1
replace b_15_1i_add = 18 if id == 1539 & b_15_1i == 1
replace b_15_1i_add = 18 if id == 349 & b_15_1i == 1
replace b_15_1i_add = 18 if id == 1444 & b_15_1i == 1

* Labeling 
lab var b_15_1i_add "Reasons in familiy leading to thoughts not continuing PhD"

lab def labquitfam ///
12 "(International) Mobility" ///
13 "Uncertainty of job situation" ///
14 "Pregnancy as a breaking point" ///
15 "Requirements above the 9 to 5 job" ///
16 "Not enough quality time with family" ///
17 "Care work (children and other family members" /// 
18 "Other"

lab val b_15_1i_add labquitfam
numlabel labquitfam, add

order b_15_1i_add, a(b_15_1i)

*** Actions to prepare for professional future
/* 1st. Coding those cases that belong to already existing categories */
replace c_3d_n = 1 if id == 142 | id == 544 | id == 706 | id == 1416 | id == 321 | id == 822 // constant job search

/* 2nd. Coding of further actions not used as there are no further relevant categories */


*** Preferred area after finishing PhD

** Coding new categories with more than 10 open answers 
gen c_4h_n = 0 
replace c_4h_n = 1 if id == 1181 | id == 1704 | id == 1262 | id == 1738 | id == 505 | id == 305 | id == 706 | id == 1632 | id == 413 | id == 856 | id == 535 | id == 989 | id == 611 | id == 1023 | id == 82 | id == 511 | id == 1307 | id == 1228 | id == 1353 | id == 1132

lab var c_4h_n "Preferred are: Teaching"
lab val c_4h_n labdummy

order c_4h_n, a(c_4f_n)

/* Reasons for not considering a career in academia */
replace c_4_1b_n = 1 if id == 888 | id == 1084 | id == 1635 | id == 135 | id == 983 | id == 728 // Job market too competitive

* Further categories received a very low number of respondents!

*** Other professional trainings

replace c_5_1a_n = c_5_1_n

replace c_5_1a_n = 	1	if id ==	743
replace c_5_1a_n = 	1	if id ==	1570
replace c_5_1a_n = 	1	if id ==	112
replace c_5_1a_n = 	1	if id ==	879
replace c_5_1a_n = 	1	if id ==	1009
replace c_5_1a_n = 	1	if id ==	554
replace c_5_1a_n = 	1	if id ==	818
replace c_5_1a_n = 	1	if id ==	1358
replace c_5_1a_n = 	1	if id ==	1262
replace c_5_1a_n = 	1	if id ==	1190
replace c_5_1a_n = 	1	if id ==	420
replace c_5_1a_n = 	1	if id ==	398
replace c_5_1a_n = 	1	if id ==	223
replace c_5_1a_n = 	1	if id ==	1551
replace c_5_1a_n = 	1	if id ==	317
replace c_5_1a_n = 	1	if id ==	706
replace c_5_1a_n = 	1	if id ==	1489
replace c_5_1a_n = 	1	if id ==	114
replace c_5_1a_n = 	1	if id ==	580
replace c_5_1a_n = 	1	if id ==	1365
replace c_5_1a_n = 	2	if id ==	748
replace c_5_1a_n = 	2	if id ==	1133
replace c_5_1a_n = 	2	if id ==	600
replace c_5_1a_n = 	2	if id ==	595
replace c_5_1a_n = 	2	if id ==	488
replace c_5_1a_n = 	2	if id ==	1034
replace c_5_1a_n = 	2	if id ==	1028
replace c_5_1a_n = 	2	if id ==	45
replace c_5_1a_n = 	2	if id ==	478
replace c_5_1a_n = 	3	if id ==	1741
replace c_5_1a_n = 	3	if id ==	308
replace c_5_1a_n = 	3	if id ==	958
replace c_5_1a_n = 	3	if id ==	832
replace c_5_1a_n = 	3	if id ==	49
replace c_5_1a_n = 	4	if id ==	477
replace c_5_1a_n = 	4	if id ==	365
replace c_5_1a_n = 	4	if id ==	462
replace c_5_1a_n = 	4	if id ==	1105
replace c_5_1a_n = 	5	if id ==	1188
replace c_5_1a_n = 	5	if id ==	1075
replace c_5_1a_n = 	5	if id ==	89
replace c_5_1a_n = 	5	if id ==	940
replace c_5_1a_n = 	5	if id ==	891
replace c_5_1a_n = 	5	if id ==	87
replace c_5_1a_n = 	5	if id ==	216
replace c_5_1a_n = 	5	if id ==	850
replace c_5_1a_n = 	5	if id ==	1617
replace c_5_1a_n = 	5	if id ==	1003
replace c_5_1a_n = 	5	if id ==	481
replace c_5_1a_n = 	5	if id ==	771
replace c_5_1a_n = 	5	if id ==	906
replace c_5_1a_n = 	5	if id ==	1286
replace c_5_1a_n = 	5	if id ==	591
replace c_5_1a_n = 	5	if id ==	568
replace c_5_1a_n = 	5	if id ==	1531
replace c_5_1a_n = 	5	if id ==	228
replace c_5_1a_n = 	5	if id ==	1025
replace c_5_1a_n = 	6	if id ==	165
replace c_5_1a_n = 	6	if id ==	1467
replace c_5_1a_n = 	6	if id ==	305
replace c_5_1a_n = 	6	if id ==	565
replace c_5_1a_n = 	6	if id ==	385
replace c_5_1a_n = 	6	if id ==	1193
replace c_5_1a_n = 	7	if id ==	619
replace c_5_1a_n = 	7	if id ==	1418
replace c_5_1a_n = 	7	if id ==	1702
replace c_5_1a_n = 	7	if id ==	888
replace c_5_1a_n = 	8	if id ==	770
replace c_5_1a_n = 	8	if id ==	1117
replace c_5_1a_n = 	8	if id ==	210
replace c_5_1a_n = 	9	if id ==	727
replace c_5_1a_n = 	9	if id ==	725
replace c_5_1a_n = 	9	if id ==	558
replace c_5_1a_n = 	9	if id ==	152
replace c_5_1a_n = 	10	if id ==	79
replace c_5_1a_n = 	10	if id ==	1405
replace c_5_1a_n = 	10	if id ==	1412
replace c_5_1a_n = 	10	if id ==	333
replace c_5_1a_n = 	10	if id ==	422
replace c_5_1a_n = 	10	if id ==	641
replace c_5_1a_n = 	10	if id ==	382
replace c_5_1a_n = 	10	if id ==	1568
replace c_5_1a_n = 	10	if id ==	733
replace c_5_1a_n = 	11	if id ==	456
replace c_5_1a_n = 	11	if id ==	657
replace c_5_1a_n = 	11	if id ==	1548
replace c_5_1a_n = 	11	if id ==	658
replace c_5_1a_n = 	11	if id ==	578
replace c_5_1a_n = 	11	if id ==	871
replace c_5_1a_n = 	11	if id ==	447
replace c_5_1a_n = 	11	if id ==	1012
replace c_5_1a_n = 	11	if id ==	1022
replace c_5_1a_n = 	11	if id ==	723
replace c_5_1a_n = 	11	if id ==	1738
replace c_5_1a_n = 	11	if id ==	44
replace c_5_1a_n = 	11	if id ==	896
replace c_5_1a_n = 	11	if id ==	1291
replace c_5_1a_n = 	11	if id ==	272
replace c_5_1a_n = 	11	if id ==	712
replace c_5_1a_n = 	11	if id ==	1659
replace c_5_1a_n = 	11	if id ==	1670
replace c_5_1a_n = 	11	if id ==	1062
replace c_5_1a_n = 	11	if id ==	448
replace c_5_1a_n = 	11	if id ==	988
replace c_5_1a_n = 	11	if id ==	1353
replace c_5_1a_n = 	11	if id ==	637
replace c_5_1a_n = 	11	if id ==	1268
replace c_5_1a_n = 	11	if id ==	1406

lab def labtraining ///
0	"No" ///
1	"Programming/Software" ///
2	"Writing (Publishing/Grant writing)" ///
3	"Statistics" ///
4	"Time and self management" ///
5	"Rhetoric and presentation" ///
6	"PhD colloquium" ///
7	"Good scientific practice" ///
8	"Job Interview Training" ///
9	"Gender issues" ///
10	"Coaching and Management" ///
11	"General doctoral training (no details specified and mostly external)" ///
99	"Don't know"

lab val c_5_1a_n labtraining
numlabel labtraining, add


*** Professional training: More support 

** Replacing existing categories
replace c_5_2e_n = 1 if id == 384 | id == 794 | id == 1583 | id == 1769

/* New categories with more than 10 respondents */

** Career development
gen c_5_2j_n = 0 
replace c_5_2j_n = 1 if id == 427 | id == 889 | id == 201 | id == 40 | id == 1075 | id == 1539 | id == 338 | id == 519 | id == 845 | id == 888 | id == 1340 | id == 1392 | id == 142 | id == 398 | id == 1028 | id == 372 | id == 767 | id == 727 | id == 1522 | id == 1011 | id == 1100 | id == 1584

lab var c_5_2j_n "Need training: Career development" 
lab val c_5_2j_n labdummy
order c_5_2j_n, a(c_5_2i_n)

** Programming / Software
gen c_5_2k_n = 0 
replace c_5_2k_n = 1 if id == 1632 | id == 1012 | id == 81 | id == 1642 | id == 741 | id == 449 | id == 226 | id == 493 | id == 464 | id == 209 | id == 1559 | id == 127 | id == 249 | id == 112 | id == 951

lab var c_5_2k_n "Need training: Programming / Software" 
lab val c_5_2k_n labdummy
order c_5_2k_n, a(c_5_2j_n)

*** On which career-releated topcis would you like to have more information?

replace c_6_1_n = .

replace c_6_1_n = 	1	if id ==	832
replace c_6_1_n = 	1	if id ==	1414
replace c_6_1_n = 	1	if id ==	44
replace c_6_1_n = 	1	if id ==	1389
replace c_6_1_n = 	1	if id ==	1649
replace c_6_1_n = 	1	if id ==	807
replace c_6_1_n = 	1	if id ==	1770
replace c_6_1_n = 	1	if id ==	1493
replace c_6_1_n = 	1	if id ==	762
replace c_6_1_n = 	1	if id ==	896
replace c_6_1_n = 	1	if id ==	991
replace c_6_1_n = 	1	if id ==	1471
replace c_6_1_n = 	1	if id ==	670
replace c_6_1_n = 	1	if id ==	652
replace c_6_1_n = 	1	if id ==	1786
replace c_6_1_n = 	1	if id ==	207
replace c_6_1_n = 	1	if id ==	399
replace c_6_1_n = 	1	if id ==	737
replace c_6_1_n = 	1	if id ==	1678
replace c_6_1_n = 	1	if id ==	481
replace c_6_1_n = 	1	if id ==	90
replace c_6_1_n = 	1	if id ==	838
replace c_6_1_n = 	1	if id ==	535
replace c_6_1_n = 	1	if id ==	1610
replace c_6_1_n = 	1	if id ==	458
replace c_6_1_n = 	1	if id ==	416
replace c_6_1_n = 	1	if id ==	736
replace c_6_1_n = 	1	if id ==	1132
replace c_6_1_n = 	1	if id ==	471
replace c_6_1_n = 	1	if id ==	244
replace c_6_1_n = 	1	if id ==	1445
replace c_6_1_n = 	1	if id ==	543
replace c_6_1_n = 	1	if id ==	1299
replace c_6_1_n = 	1	if id ==	1491
replace c_6_1_n = 	1	if id ==	351
replace c_6_1_n = 	1	if id ==	1207
replace c_6_1_n = 	1	if id ==	288
replace c_6_1_n = 	1	if id ==	564
replace c_6_1_n = 	1	if id ==	84
replace c_6_1_n = 	1	if id ==	887
replace c_6_1_n = 	1	if id ==	1133
replace c_6_1_n = 	1	if id ==	1082
replace c_6_1_n = 	2	if id ==	247
replace c_6_1_n = 	2	if id ==	835
replace c_6_1_n = 	2	if id ==	1788
replace c_6_1_n = 	2	if id ==	610
replace c_6_1_n = 	2	if id ==	1764
replace c_6_1_n = 	2	if id ==	63
replace c_6_1_n = 	2	if id ==	890
replace c_6_1_n = 	2	if id ==	726
replace c_6_1_n = 	2	if id ==	1578
replace c_6_1_n = 	2	if id ==	1554
replace c_6_1_n = 	2	if id ==	1737
replace c_6_1_n = 	3	if id ==	1793
replace c_6_1_n = 	3	if id ==	633
replace c_6_1_n = 	3	if id ==	321
replace c_6_1_n = 	3	if id ==	127
replace c_6_1_n = 	3	if id ==	40
replace c_6_1_n = 	3	if id ==	1501
replace c_6_1_n = 	3	if id ==	1018
replace c_6_1_n = 	3	if id ==	1624
replace c_6_1_n = 	3	if id ==	82
replace c_6_1_n = 	3	if id ==	668
replace c_6_1_n = 	3	if id ==	844
replace c_6_1_n = 	3	if id ==	781
replace c_6_1_n = 	3	if id ==	68
replace c_6_1_n = 	3	if id ==	477
replace c_6_1_n = 	3	if id ==	1622
replace c_6_1_n = 	3	if id ==	241
replace c_6_1_n = 	3	if id ==	703
replace c_6_1_n = 	3	if id ==	1062
replace c_6_1_n = 	3	if id ==	911
replace c_6_1_n = 	3	if id ==	1658
replace c_6_1_n = 	3	if id ==	979
replace c_6_1_n = 	3	if id ==	1756
replace c_6_1_n = 	3	if id ==	1419
replace c_6_1_n = 	3	if id ==	712
replace c_6_1_n = 	3	if id ==	591
replace c_6_1_n = 	3	if id ==	1033
replace c_6_1_n = 	3	if id ==	142
replace c_6_1_n = 	3	if id ==	533
replace c_6_1_n = 	3	if id ==	531
replace c_6_1_n = 	3	if id ==	1659
replace c_6_1_n = 	3	if id ==	349
replace c_6_1_n = 	3	if id ==	514
replace c_6_1_n = 	3	if id ==	1019
replace c_6_1_n = 	3	if id ==	1150
replace c_6_1_n = 	3	if id ==	398
replace c_6_1_n = 	3	if id ==	1008
replace c_6_1_n = 	3	if id ==	875
replace c_6_1_n = 	3	if id ==	115
replace c_6_1_n = 	3	if id ==	149
replace c_6_1_n = 	3	if id ==	1536
replace c_6_1_n = 	3	if id ==	1324
replace c_6_1_n = 	3	if id ==	598
replace c_6_1_n = 	3	if id ==	1543
replace c_6_1_n = 	3	if id ==	1276
replace c_6_1_n = 	3	if id ==	375
replace c_6_1_n = 	3	if id ==	519
replace c_6_1_n = 	3	if id ==	1412
replace c_6_1_n = 	3	if id ==	364
replace c_6_1_n = 	3	if id ==	801
replace c_6_1_n = 	3	if id ==	1705
replace c_6_1_n = 	3	if id ==	651
replace c_6_1_n = 	3	if id ==	1476
replace c_6_1_n = 	3	if id ==	106
replace c_6_1_n = 	3	if id ==	767
replace c_6_1_n = 	3	if id ==	341
replace c_6_1_n = 	3	if id ==	1188
replace c_6_1_n = 	3	if id ==	538
replace c_6_1_n = 	3	if id ==	1704
replace c_6_1_n = 	3	if id ==	128
replace c_6_1_n = 	3	if id ==	466
replace c_6_1_n = 	3	if id ==	866
replace c_6_1_n = 	3	if id ==	1069
replace c_6_1_n = 	3	if id ==	1714
replace c_6_1_n = 	3	if id ==	776
replace c_6_1_n = 	3	if id ==	511
replace c_6_1_n = 	3	if id ==	1105
replace c_6_1_n = 	3	if id ==	816
replace c_6_1_n = 	3	if id ==	176
replace c_6_1_n = 	3	if id ==	753
replace c_6_1_n = 	3	if id ==	425
replace c_6_1_n = 	3	if id ==	230
replace c_6_1_n = 	3	if id ==	792
replace c_6_1_n = 	3	if id ==	640
replace c_6_1_n = 	3	if id ==	1777
replace c_6_1_n = 	3	if id ==	182
replace c_6_1_n = 	3	if id ==	1307
replace c_6_1_n = 	4	if id ==	817
replace c_6_1_n = 	4	if id ==	615
replace c_6_1_n = 	4	if id ==	427
replace c_6_1_n = 	4	if id ==	308
replace c_6_1_n = 	4	if id ==	595
replace c_6_1_n = 	4	if id ==	1627
replace c_6_1_n = 	4	if id ==	249
replace c_6_1_n = 	4	if id ==	338
replace c_6_1_n = 	4	if id ==	478
replace c_6_1_n = 	4	if id ==	878
replace c_6_1_n = 	4	if id ==	1569
replace c_6_1_n = 	4	if id ==	505
replace c_6_1_n = 	4	if id ==	1531
replace c_6_1_n = 	4	if id ==	1054
replace c_6_1_n = 	4	if id ==	559
replace c_6_1_n = 	4	if id ==	1152
replace c_6_1_n = 	4	if id ==	467
replace c_6_1_n = 	4	if id ==	470
replace c_6_1_n = 	4	if id ==	1470
replace c_6_1_n = 	4	if id ==	822
replace c_6_1_n = 	4	if id ==	109
replace c_6_1_n = 	4	if id ==	1403
replace c_6_1_n = 	4	if id ==	1648
replace c_6_1_n = 	4	if id ==	140
replace c_6_1_n = 	4	if id ==	1670
replace c_6_1_n = 	4	if id ==	797
replace c_6_1_n = 	4	if id ==	116
replace c_6_1_n = 	4	if id ==	845
replace c_6_1_n = 	4	if id ==	1383
replace c_6_1_n = 	4	if id ==	339
replace c_6_1_n = 	5	if id ==	853
replace c_6_1_n = 	5	if id ==	48
replace c_6_1_n = 	5	if id ==	175
replace c_6_1_n = 	5	if id ==	492
replace c_6_1_n = 	5	if id ==	429
replace c_6_1_n = 	5	if id ==	295
replace c_6_1_n = 	5	if id ==	780
replace c_6_1_n = 	5	if id ==	958
replace c_6_1_n = 	5	if id ==	1349
replace c_6_1_n = 	5	if id ==	818
replace c_6_1_n = 	5	if id ==	1688
replace c_6_1_n = 	5	if id ==	880
replace c_6_1_n = 	5	if id ==	556
replace c_6_1_n = 	5	if id ==	689
replace c_6_1_n = 	5	if id ==	1559
replace c_6_1_n = 	5	if id ==	518
replace c_6_1_n = 	5	if id ==	1769
replace c_6_1_n = 	5	if id ==	1229
replace c_6_1_n = 	5	if id ==	464
replace c_6_1_n = 	5	if id ==	1283
replace c_6_1_n = 	5	if id ==	1323
replace c_6_1_n = 	5	if id ==	1444
replace c_6_1_n = 	5	if id ==	1482
replace c_6_1_n = 	5	if id ==	70
replace c_6_1_n = 	5	if id ==	664
replace c_6_1_n = 	5	if id ==	1227
replace c_6_1_n = 	5	if id ==	1101
replace c_6_1_n = 	5	if id ==	628
replace c_6_1_n = 	5	if id ==	1522
replace c_6_1_n = 	5	if id ==	496
replace c_6_1_n = 	5	if id ==	594
replace c_6_1_n = 	5	if id ==	646
replace c_6_1_n = 	6	if id ==	944
replace c_6_1_n = 	6	if id ==	118
replace c_6_1_n = 	6	if id ==	1707
replace c_6_1_n = 	6	if id ==	693
replace c_6_1_n = 	6	if id ==	275
replace c_6_1_n = 	6	if id ==	1566
replace c_6_1_n = 	6	if id ==	1635
replace c_6_1_n = 	6	if id ==	1608
replace c_6_1_n = 	7	if id ==	637
replace c_6_1_n = 	7	if id ==	1584
replace c_6_1_n = 	7	if id ==	568
replace c_6_1_n = 	7	if id ==	305
replace c_6_1_n = 	7	if id ==	420
replace c_6_1_n = 	7	if id ==	715
replace c_6_1_n = 	7	if id ==	1752
replace c_6_1_n = 	7	if id ==	360
replace c_6_1_n = 	7	if id ==	335
replace c_6_1_n = 	7	if id ==	384
replace c_6_1_n = 	7	if id ==	372
replace c_6_1_n = 	7	if id ==	316
replace c_6_1_n = 	7	if id ==	694
replace c_6_1_n = 	7	if id ==	1039
replace c_6_1_n = 	7	if id ==	795
replace c_6_1_n = 	7	if id ==	1020
replace c_6_1_n = 	7	if id ==	840
replace c_6_1_n = 	7	if id ==	1479
replace c_6_1_n = 	7	if id ==	41
replace c_6_1_n = 	7	if id ==	281
replace c_6_1_n = 	7	if id ==	469
replace c_6_1_n = 	7	if id ==	1514
replace c_6_1_n = 	7	if id ==	545
replace c_6_1_n = 	7	if id ==	608
replace c_6_1_n = 	7	if id ==	1198
replace c_6_1_n = 	7	if id ==	1392

lab def labknow ///
1	"From Postdoc to Professorship" ///
2	"Jobs outside Academia (but still using science)" ///
3	"Career outside of Academia (General)" ///
4	"Industry" ///
5	"What jobs are there?" ///
6	"Job applications, interviews, …" ///
7	"Other Softskills (Academia)"

lab val c_6_1_n labknow
numlabel labknow, add

/* Wishing more support for foreigners! */

** new labels
lab var d_3a_n	"Formal support [Going to the registration office]"
lab var d_3b_n	"Formal support [Opening a bank account]"
lab var d_3c_n	"Formal support [Clarification of residence permit]"
lab var d_3d_n 	"Formal support [Health insurance]"
lab var d_3e_n	"Formal support [Finding a flat]"
lab var d_3f_n	"Formal support [Finding a childcare place]"
lab var d_3g_n	"Formal support [Finding a medical doctor who speaks a language you understand]"
lab var d_3h_n	"Formal support [General information about living and bureaucracy in Germany]"
lab var d_3i_n	"Formal support [Translation of documents]"
lab var d_3j_n	"Formal support [Accompanying persons for dealing with bureaucratic issues (maybe also for translation)]"

** 1st: Replacing existing categories

replace d_4a_n = d_4_n

replace d_4a_n =	1	if id ==	1009
replace d_4a_n =	3	if id ==	1764
replace d_4a_n =	4	if id ==	818
replace d_4a_n =	4	if id ==	1324
replace d_4a_n =	5	if id ==	573
replace d_4a_n =	5	if id ==	1258
replace d_4a_n =	5	if id ==	825
replace d_4a_n =	5	if id ==	92
replace d_4a_n =	5	if id ==	1471
replace d_4a_n =	5	if id ==	1466
replace d_4a_n =	5	if id ==	878
replace d_4a_n =	5	if id ==	397
replace d_4a_n =	5	if id ==	1101
replace d_4a_n =	5	if id ==	332
replace d_4a_n =	5	if id ==	598
replace d_4a_n =	5	if id ==	1153
replace d_4a_n =	6	if id ==	207
replace d_4a_n =	7	if id ==	523
replace d_4a_n =	8	if id ==	1094
replace d_4a_n =	8	if id ==	1680
replace d_4a_n =	8	if id ==	479
replace d_4a_n =	8	if id ==	1637
replace d_4a_n =	8	if id ==	1140
replace d_4a_n =	8	if id ==	1418
replace d_4a_n =	8	if id ==	383
replace d_4a_n =	8	if id ==	441
replace d_4a_n =	8	if id ==	359
replace d_4a_n =	8	if id ==	762
replace d_4a_n =	8	if id ==	1274
replace d_4a_n =	8	if id ==	1544
replace d_4a_n =	8	if id ==	1738
replace d_4a_n =	8	if id ==	1578
replace d_4a_n =	8	if id ==	1744
replace d_4a_n =	8	if id ==	964
replace d_4a_n =	8	if id ==	1632
replace d_4a_n =	8	if id ==	141
replace d_4a_n =	9	if id ==	1145
replace d_4a_n =	9	if id ==	715
replace d_4a_n =	9	if id ==	1719
replace d_4a_n =	10	if id ==	1152
replace d_4a_n =	10	if id ==	325
replace d_4a_n =	11	if id ==	693
replace d_4a_n =	11	if id ==	1737
replace d_4a_n =	11	if id ==	572
replace d_4a_n =	12	if id ==	670
replace d_4a_n =	12	if id ==	381
replace d_4a_n =	12	if id ==	570
replace d_4a_n =	12	if id ==	299
replace d_4a_n =	12	if id ==	998
replace d_4a_n =	12	if id ==	109
replace d_4a_n =	13	if id ==	1228
replace d_4a_n =	13	if id ==	317
replace d_4a_n =	13	if id ==	344
replace d_4a_n =	14	if id ==	1498
replace d_4a_n =	14	if id ==	776
replace d_4a_n =	14	if id ==	512
replace d_4a_n =	14	if id ==	75
replace d_4a_n =	14	if id ==	249
replace d_4a_n =	15	if id ==	1192
replace d_4a_n =	15	if id ==	1323
replace d_4a_n =	15	if id ==	1649
replace d_4a_n =	15	if id ==	384
replace d_4a_n =	15	if id ==	1125
replace d_4a_n =	16	if id ==	302
replace d_4a_n =	16	if id ==	352
replace d_4a_n =	16	if id ==	1676
replace d_4a_n =	16	if id ==	413
replace d_4a_n =	16	if id ==	1410
replace d_4a_n =	16	if id ==	1412
replace d_4a_n =	16	if id ==	706
replace d_4a_n =	16	if id ==	1707
replace d_4a_n =	16	if id ==	281
replace d_4a_n =	16	if id ==	405
replace d_4a_n =	16	if id ==	97
replace d_4a_n =	16	if id ==	1310
replace d_4a_n =	16	if id ==	1020
replace d_4a_n =	16	if id ==	941
replace d_4a_n =	16	if id ==	1360
replace d_4a_n =	16	if id ==	1416
replace d_4a_n =	16	if id ==	748
replace d_4a_n =	16	if id ==	1491
replace d_4a_n =	16	if id ==	951
replace d_4a_n =	16	if id ==	696
replace d_4a_n =	16	if id ==	1064
replace d_4a_n =	16	if id ==	142
replace d_4a_n =	16	if id ==	449
replace d_4a_n =	16	if id ==	338
replace d_4a_n =	16	if id ==	1229
replace d_4a_n =	16	if id ==	896
replace d_4a_n =	16	if id ==	692
replace d_4a_n =	16	if id ==	597
replace d_4a_n =	16	if id ==	1062
replace d_4a_n =	16	if id ==	153
replace d_4a_n =	16	if id ==	646
replace d_4a_n =	16	if id ==	564
replace d_4a_n =	16	if id ==	1788
replace d_4a_n =	16	if id ==	1786
replace d_4a_n =	16	if id ==	1114
replace d_4a_n =	16	if id ==	1103
replace d_4a_n =	16	if id ==	880
replace d_4a_n =	16	if id ==	1385
replace d_4a_n =	16	if id ==	934
replace d_4a_n =	16	if id ==	201
replace d_4a_n =	16	if id ==	1365
replace d_4a_n =	16	if id ==	288
replace d_4a_n =	16	if id ==	285
replace d_4a_n =	16	if id ==	244
replace d_4a_n =	16	if id ==	898
replace d_4a_n =	16	if id ==	906
replace d_4a_n =	16	if id ==	1304
replace d_4a_n =	16	if id ==	1622
replace d_4a_n =	16	if id ==	123
replace d_4a_n =	16	if id ==	1669
replace d_4a_n =	16	if id ==	1479
replace d_4a_n =	16	if id ==	106
mvdecode d_4a_n, mv(97=.)

lab def labsupport ///
0   "No" ///
1	"Going to the registration office" ///
2	"Opening a bank account" ///
3	"Clarification of residence permit" ///
4	"Health insurance" ///
5	"Finding a flat" ///
6	"Finding a childcare place" ///
7	"Finding a medical doctor who speaks a language you understand" ///
8	"General information about living and bureaucracy in Germany" ///
9	"Translation of documents" ///
10	"Accompanying persons for dealing with bureaucratic issues" ///
11	"VISA issues" ///
12	"more English spreaking staff (e.g. in administration, tech staff)" /// 
13	"tax issues" ///
14	"a designated contact person at the institute" ///
15	"academic mentoring" ///
16  "Other or more of the above"

lab val d_4a_n labsupport
numlabel labsupport, add


*** Dropping original open questions - also for the purpose of data protection!
drop b_2a
drop b_2_1a
drop b_4_1
drop b_7_1
drop b_15_1_1
drop b_15_1_2
drop c_3g_n
drop c_4g_n

