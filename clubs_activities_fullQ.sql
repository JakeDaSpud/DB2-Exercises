create database friends_and_clubs;
use friends_and_clubs;

create table club ( club_id varchar(20) NOT NULL,
name varchar(30),
address varchar(30),
subscription varchar(20),
membership_cost decimal(10,2),
PRIMARY KEY (club_id));

create table activities (club_id varchar(20) NOT NULL,
activity varchar (20) NOT NULL,
PRIMARY KEY (club_id, activity),
FOREIGN KEY (club_id) REFERENCES club(club_id));

--Inserting
insert into club values ("CouSP", "Court Sport", "Railway Rd Drogheda", "Yearly", 50.00);
insert into club values ("CueCL", "Cue Club", "Newline Drogheda", "Session", 5.00);
insert into club values ("DroSC", "Drogheda Swimming Centre", "Park St Drogheda", "Session", 7.00);
insert into club values ("DunAC", "Dundalk Athletics Club", "Coast Rd Blackrock", "Yearly", 75.00);
insert into club values ("DunLC", "Dundalk Leisure Complex", "Hillside Dundalk", "Session", 5.00);
insert into club values ("KicFO", "Kickabout Football", "Marsh Pitches Dundalk", "None", 0.00);
insert into club values ("NewGC", "Newtown Golf Club", "Newtown Rd Dundalk", "Yearly", 200.00);
insert into club values ("PocSC", "Pockets Snooker Club", "Keepers Close Dundalk", "Session", 4.00);
insert into club values ("RacCL", "Racket Club", "Community Courts Drogheda", "None", 0.00);
insert into club values ("SeaTC", "Seaview Tennis Club", "Seaview Blackrock", "Yearly", 70.00);
insert into club values ("TeeGC", "Tee Time Golf Club", "Avenue Lane Blackrock", "Session", 10.00);

insert into activities values ("CouSP", "Badminton");
insert into activities values ("CouSP", "Tennis");
insert into activities values ("CueCL", "Pool");
insert into activities values ("CueCL", "Snooker");
insert into activities values ("DroSC", "Swimming");
insert into activities values ("DunAC", "Running");
insert into activities values ("DunLC", "Football");
insert into activities values ("DunLC", "Pool");
insert into activities values ("DunLC", "Squash");
insert into activities values ("DunLC", "Swimming");
insert into activities values ("DunLC", "Tennis");
insert into activities values ("KicFO", "Football");
insert into activities values ("NewGC", "Golf");
insert into activities values ("PocSC", "Pool");
insert into activities values ("PocSC", "Snooker");
insert into activities values ("RacCL", "Tennis");
insert into activities values ("SeaTC", "Tennis");
insert into activities values ("TeeGC", "Golf");

--Questions
--select f.name, f.address
--FROM friend f, hobbies h
--WHERE f.friend-id = h.friend-id
--AND f.address LIKE "%Chapel%";

--1. Where is Pockets Snooker Club
SELECT club.address 
FROM club
WHERE club.name LIKE "Pockets Snooker Club";

--2. What activities are offered at Dundalk Leisure Complex
SELECT a.activities
FROM club c, activities a
WHERE a.club_id = c.club_id
AND c.address LIKE "Dundalk Leisure Complex";

--3. What clubs are in Blackrock
SELECT c.name
FROM club c
WHERE c.address LIKE "%Blackrock%";

--4. What clubs offer free subscription
SELECT c.name
FROM club c
WHERE c.membership_cost = 0.00;

--5. What clubs have an annual membership fee
SELECT c.name
FROM club
WHERE c.subscription LIKE "%Yearly%";

--6. Where can I play golf in Dundalk
SELECT c.name
FROM club c, activities a
WHERE a.club_id = c.club_id
AND a.activity LIKE "%Golf%";

--7. What activity can I take part in for free
SELECT a.activity
FROM club c, activities a
WHERE a.club_id = c.club_id
AND c.membership_cost = 0.00;

--8. What activity in Dundalk can I take part in for less than €5
SELECT a.activity
FROM club c, activities a
WHERE a.club_id = c.club_id
AND c.membership_cost < 5.00;

--9. Where activities are not free but cost less than €10 subscription to play
SELECT a.activity
FROM club c, activities a
WHERE a.club_id = c.club_id
AND c.membership_cost < 10.00
AND c.membership_cost > 0.00;

--10. What activities can I play annually for less than €100
SELECT a.activity
FROM club c, activities a
WHERE a.club_id = c.club_id
AND c.subscription LIKE "%Yearly%"
AND c.membership_cost < 100.00;