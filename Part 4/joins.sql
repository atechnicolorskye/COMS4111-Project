select * from artist a, label l, has_signed h where a.a_id=h.a_id and l.l_id=h.l_id and (a.a_year->>'y')::int >2000; 
select * from artist a, album al, contributes_to c where a.a_id=c.a_id and c.al_id=al.al_id and ( (al.al_dur->>'m')::int >58 or (al.al_dur->>'h')::int >=1 );




create function f1() returns trigger as
$$

$$ language plgpsql;