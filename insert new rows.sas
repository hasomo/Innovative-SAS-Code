/*
***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
BY: Mohammad Haddad
5 ways how to insert new rows into an existing SAS dataset.
***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
*/

data m_data;
	input name $ salary birthdate date9.;
	format salary dollar12.0 birthdate date9.;
	datalines;
michael	45000 05jan1993
emma	50000 17sep1982
alex	55000 23apr1987
;
run;

/***** method 1: data step & set statement */
data m_data_ext;
	input name $ salary birthdate date9.;
	format salary dollar12.0 birthdate date9.;
	datalines;
james	50000 04feb1999
sophia	45000 27may1984
;
run;
 
data m_data;
	set
		m_data
        m_data_ext;
run;

/***** method 2: proc append */
data m_data_ext;
	input name $ salary birthdate date9.;
	format salary dollar12.0 birthdate date9.;
	datalines;
james	50000 04feb1999
sophia	45000 27may1984
;
run;
 
proc append
	base = m_data
	data = m_data_ext;
run;

/***** method 3: data step & output statement */
data m_data;
	set m_data
	end = eof;
	output;
 
	if eof
	then do;	
		name = "james";
		salary = 50000;
		birthdate = "04feb1999"d;
		output;

		name = "sophia";
		salary = 45000;
		birthdate = "27may1984"d;
		output;	
	end;
run;

/***** method 4: insert into & set statement */
proc sql;
	insert into m_data
	set
		name = "james",
		salary = 50000,
		birthdate = "04feb1999"d
	set
		name = "sophia",
		salary = 45000,
		birthdate = "27may1984"d
	;
quit;


/***** method 5: insert into & values statement */
proc sql;
	insert into m_data
		values("james",  50000, "04feb1999"d)
		values("sophia", 45000, "27may1984"d)
	;
quit;
