create function update_album() returns trigger as
$$
    declare
        temp1 int:= (al_dur->>'m')::int from album a where a.al_id  = 6;
        temp2 int:= (s_dur->>'m')::int from song s where s.s_id = 6;
        temp3 jsonb:= to_jsonb(temp1+temp2);
    begin
        update album set al_dur = jsonb_set(al_dur, '{m}', temp3, true) where al_id  = 6;
        RAISE NOTICE 'i want to print % and %', temp1,temp2;
        return NULL;
    end
$$
LANGUAGE plpgsql;
 
create trigger updateAlbum
after insert on contributes_to
    for each row execute procedure update_album();
 
insert into contributes_to VALUES(6, 6, 7);
 
--ignore
 
CREATE OR REPLACE FUNCTION strip_all_triggers() RETURNS text AS $$ DECLARE
    triggNameRecord RECORD;
    triggTableRecord RECORD;
BEGIN
    FOR triggNameRecord IN select distinct(trigger_name) from information_schema.triggers where trigger_schema = 'public' LOOP
        FOR triggTableRecord IN SELECT distinct(event_object_table) from information_schema.triggers where trigger_name = triggNameRecord.trigger_name LOOP
            RAISE NOTICE 'Dropping trigger: % on table: %', triggNameRecord.trigger_name, triggTableRecord.event_object_table;
            EXECUTE 'DROP TRIGGER ' || triggNameRecord.trigger_name || ' ON ' || triggTableRecord.event_object_table || ';';
        END LOOP;
    END LOOP;
 
    RETURN 'done';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
 
select strip_all_triggers();
 
 
drop function update_album();
 
create function update_test1() returns trigger as
$$
    declare
        temp1 int:= (obj->>'a')::int from test1 where aid=2;
        temp2 int:= (obj->>'a')::int from test1 where aid=2;
        temp3 jsonb:= to_jsonb(temp1+temp2);
    begin
        update test1 set obj = jsonb_set(obj, '{a}', temp3, true) where aid=2;
        --RAISE NOTICE 'i want to print % and %', temp1,temp3;
        return null;
    end
$$
LANGUAGE plpgsql;
 
create trigger updateTest
after insert on test1
    for each row execute procedure update_test1();
 
INSERT INTO test1 VALUES(1, '[1,2,3]');