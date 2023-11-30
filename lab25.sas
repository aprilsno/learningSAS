proc printto log='/home/u49497589/BIOS511/Logs/lab25_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 25 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-11-15
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Send output to pdf file;
ods pdf file = '/home/u49497589/BIOS511/Output/lab25_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Write a title statement;
%let title = %sysfunc(today(),date9.);

title "&title.";

* 2. Use an appropriate macro function;

%let gen=f;

%macro q2 (ds=, vars=);
	%let var1 = %scan(&vars, 1, ',');
	%let var2 = %scan(&vars, 2, ',');
	proc freq data = &ds;
		where sex = "%UPCASE(&gen)";
		tables &var1*&var2;
	run;
%mend q2;

%q2(ds=class.depression, vars=%str(regulardoctor, treatmentrecommended));

* 3. Print 5 obs ;
proc print data = class.dm (obs=5);
run;

* 4. Copy code from #11 in lab 23;

proc sort data=class.vs(keep=vstestcd vstest) out=vs nodupkey;
 by vstestcd;
run;

data _null_;
 set vs;
 call symputx(cats('vstest', _n_), vstestcd);
 call symputx(cats('vsname', _n_), vstest);
run;

* 5. Rewrite #12 and #13 from lab 23 with macro program;
%macro loop;
	%do i=1 %to 5;
		proc report data = class.vs;
			title1 "&title.";
			title2 "&&vsname&i";
			where vstestcd = "&&vstest&i";
			column visitnum visit vsstresn;
			define visitnum / group noprint;
			define visit / group;
			define vsstresn / mean "VS Result";
		run;
	%end;
%mend loop;

%loop;

* End of code;

ods _all_ close;
proc printto; 
run;