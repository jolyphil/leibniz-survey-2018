********************************************************************************
* Project:	Recode ESS data to produce Oesch's class schema
* Task:		Set up working directory
* Author:	Philippe Joly, Humboldt-Universität zu Berlin
********************************************************************************

* Important:
	* Run this do-file before running any other do-file in the repository.
	* This file loads paths to the folders of the repository in global macros.

* ______________________________________________________________________________
* Main path

global path "M:/user/joly/Analyses/leibniz-survey-2018/" // **Put your own path here**

* ______________________________________________________________________________
* Folders

global data "${path}data/"
global figures "${path}figures/"
	global figures_pdf "${figures}pdf/"
global scheme "${path}scheme/"

* ______________________________________________________________________________
* Plot schemes: 

* 	Adds a scheme directory to the beginning of the search path stored in the 
* 	global macro S_ADO.

adopath ++ "${scheme}"
