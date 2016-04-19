CREATE TABLE Artist(
a_id int8,
a_name varchar(64) NOT NULL,
a_year jsonb,
a_country varchar(64) NOT NULL,
PRIMARY KEY(a_id)
);

CREATE TABLE Album(
al_id int8,
al_name varchar(64) NOT NULL,
al_dur jsonb,
al_num_songs int8,
CHECK(al_num_songs>=1),
PRIMARY KEY(al_id)
);

CREATE TABLE Song(
s_id int8,
s_name varchar(64) NOT NULL,
s_no int8 CHECK(s_no>=1),
s_dur jsonb,
s_compose varchar(64),
PRIMARY KEY(s_id)
);

CREATE TABLE Genre(
g_id int8 CHECK(g_id >=1),
g_name varchar(64) NOT NULL,
PRIMARY KEY(g_id)
);

CREATE TABLE Label(
l_id int8 CHECK(l_id>=1),
l_name varchar(64) NOT NULL,
PRIMARY KEY(l_id)
);

CREATE TABLE Playlist(
p_id int8 CHECK(p_id >=1),
p_name varchar(64) NOT NULL,
p_time timestamptz,
p_num_songs int8 CHECK (p_num_songs >=1),
p_dur interval,
p_user varchar(64) NOT NULL,
PRIMARY KEY(p_id)
);

CREATE TABLE Concert(
c_id int8,
c_name varchar(64),
c_timestamp timestamptz,
c_loc varchar(64) NOT NULL,
PRIMARY KEY(c_id),
UNIQUE(c_name, c_timestamp)
);

CREATE TABLE performs_at(
a_id int8,
c_id int8,
PRIMARY KEY(a_id, c_id),
FOREIGN KEY(a_id) REFERENCES Artist,
FOREIGN KEY(c_id) REFERENCES Concert
);

-- CREATE TABLE performs_at(
-- a_id int8,
-- c_id int8,
-- c_name varchar(64),
-- c_timestamp timestamptz,
-- c_loc varchar(64),
-- PRIMARY KEY(a_id, c_id),
-- FOREIGN KEY(a_id) REFERENCES Artist,
-- FOREIGN KEY(c_id) REFERENCES Concert(c_id),
-- FOREIGN KEY(c_name, c_timestamp, c_loc) REFERENCES Concert(c_name, c_timestamp, c_loc)
-- );

CREATE TABLE belongs_to(
s_id int8,
g_id int8 NOT NULL,
PRIMARY KEY(s_id),
FOREIGN KEY(g_id) REFERENCES Genre,
FOREIGN KEY(s_id) REFERENCES Song
);

CREATE TABLE release_(
al_id int8,
l_id int8,
r_year date CHECK(r_year>= DATE '1950-01-01' AND r_year< DATE '2016-05-01'),
PRIMARY KEY(l_id,al_id),
FOREIGN KEY(al_id) REFERENCES Album,
FOREIGN KEY(l_id) REFERENCES Label
);

CREATE TABLE has_signed(
l_id int8 NOT NULL,
a_id int8,
PRIMARY KEY(a_id),
FOREIGN KEY(l_id) REFERENCES Label
);

CREATE TABLE contains_(
p_id int8,
s_id int8,
PRIMARY KEY(p_id, s_id),
FOREIGN KEY(p_id) REFERENCES Playlist,
FOREIGN KEY(s_id) REFERENCES Song
);

CREATE TABLE contributes_to(
a_id int8 NOT NULL,
s_id int8,
al_id int8,
PRIMARY KEY(s_id),
FOREIGN KEY(a_id) REFERENCES Artist,
FOREIGN KEY(s_id) REFERENCES Song,
FOREIGN KEY(al_id) REFERENCES Album
);