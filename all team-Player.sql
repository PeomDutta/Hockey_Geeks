


create or replace view teamView(tid,tname,leg) as (select * from Hockey_Team UNION select * from hockey_team@siteVmware);
select * from teamView;

create or replace view playerView(pid,pname,pos,tid,scor,cntry) as (select * from Hockey_Player UNION select * from hockey_player@siteVmware);
select * from playerView;


(select * from Hockey_Team natural join Hockey_Player) 
UNION
(select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware);



select * from ((select * from Hockey_Team natural join Hockey_Player) 
UNION 
(select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)) 
ORDER BY 
score DESC;


select RANK() over(ORDER BY score DESC) AS Rank, player_id, player_name, team_name, score from (select * from ((select * from Hockey_Team natural join Hockey_Player) 
UNION 
(select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)));


select RANKS,player_name from (select RANK() over(ORDER BY score DESC) AS Ranks, player_id, player_name, team_name, score from (select * from ((select * from Hockey_Team natural join Hockey_Player) 
UNION 
(select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)))) where RANKS<=5;


select score from (select RANK() over(ORDER BY score DESC) AS Ranks, player_id, player_name, team_name, score from (select * from ((select * from Hockey_Team natural join Hockey_Player) 
UNION 
(select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)))) where player_id=21;



(select * from Hockey_Assist 
UNION 
select * from hockey_assist@siteVmware);  


select RANK() over(ORDER BY score DESC) AS Rank, player_id, player_name, team_name, score, assist_number from (select * from ((select * from Hockey_Team natural join Hockey_Player) 
UNION 
(select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)) natural join (select * from Hockey_Assist 
UNION 
select * from hockey_assist@siteVmware));


select RANKS,player_id,player_name,team_name,score,assist_number from(select RANK() over(ORDER BY score DESC) AS Ranks, player_id, player_name, team_name, score, assist_number from (select * from ((select * from Hockey_Team natural join Hockey_Player) 
UNION 
(select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)) natural join (select * from Hockey_Assist 
UNION 
select * from hockey_assist@siteVmware))) where Ranks<=5;


select * from (select RANK() over(ORDER BY score+assist_number DESC) AS TED_RANK, player_id, player_name, team_name, score, assist_number,score+assist_number AS tedLinslayAward from (select RANKS,player_id,player_name,team_name,score,assist_number from(select RANK() over(ORDER BY score DESC) AS Ranks, player_id, player_name, team_name, score, assist_number from (select * from ((select * from Hockey_Team natural join Hockey_Player) UNION (select * from hockey_team@siteVmware natural join Hockey_Player@siteVmware)) natural join (select * from Hockey_Assist UNION select * from hockey_assist@siteVmware))) where Ranks<=5)) where TED_Rank=1;
