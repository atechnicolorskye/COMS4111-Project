--Artist and Album
Select *
from Artists A, Albums Al, contributes_to C 
where A.a_id=C.a_id AND Al.al_id=C.al_id AND A.a_name=input;

--Artist and Song
Select *
from Artists A, Song S, contributes_to C 
where A.a_id=C.a_id AND S.s_id=C.s_id AND A.a_name=input;

--Artist and Concert
Select *
from Artist A, Concert C, performs_at P 
where A.a_id=P.a_id AND C.c_id= P.c_id AND A.a_name=input;

--Song and Genre
Select *
from Song S, Genre g, belongs_to B 
where S.s_id=B.s_id AND B.g_id= S.g_id AND S.s_name=input;

--Artist and Label
Select * 
from Artist A, Label L, has_signed H
where A.a_id=H.a_id AND L.l_id=H.l_id AND A.a_name=input;

--Song and playlist
Select * 
from Song S, Playlist P, contains_ C
where s.s_id= C.s_id AND P.p_id=C.p_id AND S.s_name=input;

--Album and Label
Select * 
from Album Al, Label L, release_ R
where Al.al_id=R.al_id AND L.l_id=R.l_id AND L.l_name=input;

