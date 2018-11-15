********************************************************************************
* Project:	Leibniz PhD Network Survey 2018
* Task:		Save structure of working directory
* Authors:	Survey working group
********************************************************************************

* ______________________________________________________________________________
* Declare your own working directory

* Before running this do-file...
* Store the path to your own working directory in a global macro ${path}.
* The path must end with a slash ("/").
* Ex: 
* global path "M:/user/joly/Analyses/leibniz-survey-2018/" // 

* OR, even better...
* Create a separate do-file to declare your own ${path}, save it in /dir and
* let it call the current do-file (0_save_dir_structure.do).
* See examples in /dir

* ______________________________________________________________________________
* Folders

global data "${path}data/"
global figures "${path}figures/"
	global figures_data "${figures}data/"
	global figures_pdf "${figures}pdf/"
	global figures_png "${figures}png/"
global scheme "${path}scheme/"
global tables "${path}tables/"
	global tables_tex "${tables}tex/"

* ______________________________________________________________________________
* Plot schemes: 

* 	Adds a scheme directory to the beginning of the search path stored in the 
* 	global macro S_ADO.

adopath ++ "${scheme}"
