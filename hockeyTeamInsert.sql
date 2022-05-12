set serveroutput on;
set verify off;


CREATE or REPLACE procedure insertTeaminPc(t_id in Hockey_Team.team_id%TYPE, 
										   t_name in Hockey_Team.team_name%TYPE, 
										   leg in Hockey_Team.league%TYPE)
IS

BEGIN

	dbms_output.put_line('---------------------------------------');
	INSERT into Hockey_Team values(t_id,t_name,leg);
	
	commit;
		
End insertTeaminPc;
/

DECLARE
	A Hockey_Team.team_id%TYPE;
	B Hockey_Team.team_name%TYPE;
	C Hockey_Team.league%TYPE;
	
	num1 NUMBER:=0;
	num2 NUMBER:=0;
	
	Total NUMBER:=0;
	
	P Hockey_Team.team_id%TYPE;
	Q Hockey_Team.team_name%TYPE;
	T Hockey_Team.league%TYPE;
	
	invalid_teamId EXCEPTION;
	
BEGIN
	A:= &x;
	B:= '&y';
	C:= '&z';
	
	select count(team_id) into num1 from Hockey_Team;
	select count(team_id) into num2 from hockey_team@siteVmware;
	
	Total:=num1+num2;
	
	--dbms_output.put_line(Total);
	
	IF Total<A THEN
		insertTeaminPc(A,B,C);
		FOR R IN (SELECT team_id, team_name, league from Hockey_Team) LOOP
			P:= R.team_id;
			Q:= R.team_name;
			T:= R.league;
			
			dbms_output.put_line(P ||'   ' || Q || '   '|| T);
		END LOOP;
	ELSE
		RAISE invalid_teamId;
	End IF;
	
	
	
EXCEPTION
	WHEN invalid_teamId THEN
		dbms_output.put_line('This Team Id Already Exist. Insert value greater than ' || Total);
		
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('MANY ROWS DETECTED');
		
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DATA NOT FOUND');
	
	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE('CANNOT DIVIDE BY ZERO');
	
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('OTHER ERRORS FOUND');	
	
	
end;
/