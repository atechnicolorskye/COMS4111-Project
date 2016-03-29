INSERT INTO Artist VALUES(06, 'Bananas', '1993-06-06', 'USA');
INSERT INTO Artist VALUES(07, 'Jackson', '1999-04-21', 'England');
INSERT INTO Artist VALUES(08, 'Rahman', '1996-01-05', 'India');
INSERT INTO Artist VALUES(09, 'Apples', '2015-09-09', 'China');
INSERT INTO Artist VALUES(10, 'Eminem', '1998-08-08', 'USA');

INSERT INTO Album VALUES(06, 'Hits', '58:06', 8);
INSERT INTO Album VALUES(07, 'Welcome', '34:55', 5);
INSERT INTO Album VALUES(08, 'Hits', '45:06', 6);
INSERT INTO Album VALUES(09, 'Hits', '1:49:06', 7);
INSERT INTO Album VALUES(10, 'Hits', '1:45:00', 10);

INSERT INTO Song VALUES(06, 'singer', 3, '0:05:06', 'Bananas');
INSERT INTO Song VALUES(07, 'hello', 5, '0:02:45', 'Jackson');
INSERT INTO Song VALUES(08, 'uptown', 6, '0:04:56', 'Rahman');
INSERT INTO Song VALUES(09, 'funk', 2, '0:07:23', 'Apples');
INSERT INTO Song VALUES(10, 'purple hills', 4, '0:05:06', 'Eminem');

INSERT INTO Genre VALUES(06,'Punk rock');
INSERT INTO Genre VALUES(07,'Alternate rock');
INSERT INTO Genre VALUES(08,'Metal');
INSERT INTO Genre VALUES(09,'Blues');
INSERT INTO Genre VALUES(10,'Jazz');

INSERT INTO Label VALUES(06, 'Alters');
INSERT INTO Label VALUES(07, 'Future');
INSERT INTO Label VALUES(08, 'Past');
INSERT INTO Label VALUES(09, 'Present');
INSERT INTO Label VALUES(10, 'Every');

INSERT INTO Playlist VALUES(06, 'play6', '2016-01-11', 10, '1:23:23', 'Maruthi');
INSERT INTO Playlist VALUES(07, 'play7', '2016-04-12', 9, '56:23', 'Sky');
INSERT INTO Playlist VALUES(08, 'play8', '2016-05-23', 8, '1:43:00', 'Evan');
INSERT INTO Playlist VALUES(09, 'play9', '2016-02-13', 12, '59:59', 'Ethan');
INSERT INTO Playlist VALUES(10, 'play10', '2015-09-10', 6, '56:40', 'Boyu');

INSERT INTO Concert VALUES(06,'Tour 6', '2015-02-17 09:38:53.556804+00', 'Atlanta');
INSERT INTO Concert VALUES(07,'Tour 7', '2014-01-07 09:38:53.556804+00', 'New York');
INSERT INTO Concert VALUES(08,'Tour 8', '2013-06-27 15:48:53.556804+00', 'Chicago');
INSERT INTO Concert VALUES(09,'Tour 9', '2014-05-19 18:00:00.556804+00', 'Dallas');
INSERT INTO Concert VALUES(10,'Tour 10', '2015-02-04 21:30:00.556804+00', 'Atlanta');

INSERT INTO performs_at VALUES(06, 06);
INSERT INTO performs_at VALUES(07, 08);
INSERT INTO performs_at VALUES(08, 09);
INSERT INTO performs_at VALUES(09, 10);
INSERT INTO performs_at VALUES(10, 07);

INSERT INTO contributes_to VALUES(06, 06, 06);
INSERT INTO contributes_to VALUES(07, 08, 09);
INSERT INTO contributes_to VALUES(09, 07, 08);
INSERT INTO contributes_to VALUES(08, 09, 10);
INSERT INTO contributes_to VALUES(10, 10, 07);

INSERT INTO belongs_to VALUES(06, 07);
INSERT INTO belongs_to VALUES(08, 09);
INSERT INTO belongs_to VALUES(09, 10);
INSERT INTO belongs_to VALUES(10, 06);
INSERT INTO belongs_to VALUES(07, 08);

INSERT INTO release VALUES(06, 07, '2014-09-07');
INSERT INTO release VALUES(07, 08, '2015-03-19');
INSERT INTO release VALUES(08, 10, '2013-02-25');
INSERT INTO release VALUES(09, 08, '2012-10-23');
INSERT INTO release VALUES(10, 09, '2014-06-12');

INSERT INTO has_signed VALUES(06,07);
INSERT INTO has_signed VALUES(07,08);
INSERT INTO has_signed VALUES(08,09);
INSERT INTO has_signed VALUES(09,10);
INSERT INTO has_signed VALUES(10,06);

INSERT INTO contains VALUES(06,10);
INSERT INTO contains VALUES(07,09);
INSERT INTO contains VALUES(09,07);
INSERT INTO contains VALUES(10,08);
INSERT INTO contains VALUES(08,06);

