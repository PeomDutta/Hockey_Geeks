set serveroutput on;
set verify off;

DECLARE

	SearchRank NUMBER:=&x;
	
	R NUMBER:=0;
	
	PID Hockey_Player.player_id%TYPE;
	PNAME Hockey_Player.player_name%TYPE;
	TNAME Hockey_Team.team_name%TYPE;
	PSCORE Hockey_Player.score%TYPE;
	
	
BEGIN	

	select RANKS, player_id, player_name, team_name, score into R, PID, PNAME, TNAME, PSCORE from (select RANK() over(ORDER BY score DESC) AS Ranks, player_id, player_name, team_name, score from (select * from ((select * from Hockey_Team natural join Hockey_Player) UNION (select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)))) where RANKS=SearchRank;
	
	dbms_output.put_line(chr(10));
	
	dbms_output.put_line('RANK: ' || R);
	dbms_output.put_line('PLAYER ID: ' || PID);
	dbms_output.put_line('PLAYER NAME: ' || PNAME);
	dbms_output.put_line('TEAM NAME: ' || TNAME);
	dbms_output.put_line('SCORE: ' || PSCORE);
	
END;
/
