create function update_album() returns trigger as
$$
    begin
        update album a set(al_dur, al_num_songs) = (al_dur + s_, al_num_songs + 1)
            from contributes_to c, song s
            where a.al_id  = c.al_id and s.s_id = c.s_id;
        return NULL;
    end
$$
LANGUAGE plpgsql;

create trigger updateAlbum
after insert on contributes_to
    for each row execute procedure update_album();

insert into contributes_to VALUES(1, 2, 1);
