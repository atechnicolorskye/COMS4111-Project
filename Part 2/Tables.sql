CREATE TABLE Artist(
a_id int8,
a_name varchar(64),
a_year date,
a_country varchar(64),
PRIMARY KEY(a_id)
);

CREATE TABLE Album(
al_id int8,
al_name varchar(64),
al_dur interval,
al_num_songs int8,
PRIMARY KEY(al_id)
);

CREATE TABLE Song(
s_id int8,
s_name varchar(64),
s_no int8,
s_dur interval,
s_compose varchar(64),
PRIMARY KEY(s_id)
);

CREATE TABLE Genre(
g_id int8,
g_name varchar(64),
PRIMARY KEY(g_id)
);

CREATE TABLE Label(
l_id int8,
l_name varchar(64),
PRIMARY KEY(l_id)
);

CREATE TABLE Playlist(
p_id int8,
p_name varchar(64),
p_time timestamptz,
p_num_songs int8,
p_dur interval,
p_user varchar(64),
PRIMARY KEY(p_id)
);

CREATE TABLE Concert(
c_id int8,
c_name varchar(64),
c_timestamp timestamptz,
c_loc varchar(64),
PRIMARY KEY(c_id)
);

CREATE TABLE performs_at(
a_id int8,
c_id int8,
c_timestamp timestamptz,
c_loc varchar(64),
PRIMARY KEY(a_id, c_id),
FOREIGN KEY(a_id) REFERENCES Artist,
FOREIGN KEY(c_id, c_timestamp, c_loc) REFERENCES Concert(c_id, c_timestamp, c_loc)
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

CREATE TABLE belongs_to(
s_id int8,
g_id int8 NOT NULL,
PRIMARY KEY(s_id),
FOREIGN KEY(g_id) REFERENCES Genre,
FOREIGN KEY(s_id) REFERENCES Song
);

CREATE TABLE release(
al_id int8,
l_id int8,
r_year date,
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

CREATE TABLE contains(
p_id int8,
s_id int8,
PRIMARY KEY(p_id, s_id),
FOREIGN KEY(p_id) REFERENCES Playlist,
FOREIGN KEY(s_id) REFERENCES Song
);

