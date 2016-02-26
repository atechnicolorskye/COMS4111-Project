-- Find artists who have contributed to more than 2 albums
-- Get Andrew Bird

select a.a_name
from Artist a
where a.a_id in (select c.a_id
                 from contributes_to c
                 group by c.a_id
                 having count(c.a_id) >= 2);


-- Find names of artists who have contributed exactly 10 songs to an album
-- Get Rahman, Green Day, Andrew Bird

select a_name
from Artist
where a_id IN ( select DISTINCT C.a_id
				from contributes_to As C, Album As A
				where A.al_num_songs=10 and A.al_id=C.al_id);

-- Find all songs from the album Perfect Darkness
-- Get Berlin Sunrise in s_name and Perfect Darkness in al_name

select s.s_name, al.al_name
from song s, album al
where s.s_id in (select c.s_id
                 from contributes_to c
                 where c.al_id = al.al_id and al.al_name='Perfect Darkness');