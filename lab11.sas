proc printto log='/home/u49497589/BIOS511/Logs/lab11_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 11
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-09-27
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

ods pdf file = '/home/u49497589/BIOS511/Output/lab11_730317945.pdf';

LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Use PROC SGPANEL with prostate data;
proc sgpanel data = class.prostate;
	title "1. Vertical Box Plots of Prostate Data";
	where tumorsize ^= -9999;
	panelby treatment stage / columns=2;
	vbox tumorsize / displaystats=(mean) outlierattrs=(color=red);
run; 

* 2. Use PROC SGPANEL with preemies;
proc sgpanel data = class.preemies noautolegend;
	title "2. Histograms and Density Curves of Preemies Data (sgpanel)";
	panelby sex / novarname;
	histogram bw;
	density bw / lineattrs=(color=black);
	label bw = "Birth Weight";
	rowaxis label = "Percent (%)";
	rowaxis values = (0 to 50 by 10);
run;


* 3. Replicate 2 with PROC SGPLOT;
proc sort data = class.preemies out = preemiessort;
	by sex;
run;

options nobyline;
proc sgplot data = preemiessort noautolegend;
	title "3. Histograms and Density Curves of Preemies Data (sgplot)";
	title2 "#byvar1 = #byval1";
	by sex;
	histogram bw / nbins = 8;
	density bw / lineattrs=(color=black);
	label bw = "Birth Weight";
	yaxis label = "Percent (%)";
	yaxis values = (0 to 50 by 10);
run;

ods _all_ close;
proc printto; run;