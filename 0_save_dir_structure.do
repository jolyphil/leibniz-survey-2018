********************************************************************************
* Project:	Leibniz PhD Network Survey 2018
* Task:		Save structure of working directory
* Author:	Philippe Joly, Humboldt-Universität zu Berlin & WZB
********************************************************************************

* ______________________________________________________________________________
* Folders

global data "${path}data/"
global figures "${path}figures/"
	global figures_pdf "${figures}pdf/"
	global figures_png "${figures}png/"
global scheme "${path}scheme/"

* ______________________________________________________________________________
* Plot schemes: 

* 	Adds a scheme directory to the beginning of the search path stored in the 
* 	global macro S_ADO.

adopath ++ "${scheme}"
