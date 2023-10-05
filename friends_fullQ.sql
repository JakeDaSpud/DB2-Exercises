drop table if exists hobbies,friend;

create table friend ( friend_id int NOT NULL,
name varchar(20),
Address varchar(20),
Telephone varchar(20),
PRIMARY KEY (friend_id));
Describe friend;
create table hobbies ( friend_id int NOT NULL,
hobby varchar (20) NOT NULL,
PRIMARY KEY (friend_id, hobby),
FOREIGN KEY (friend_id) REFERENCES friend(friend_id));
insert into friend values (1, "Joe Bloggs", "2 Old Rd", "04273619");
insert into friend values (2, "Fred Bloggs", "21 New Rd", "04134816");
insert into friend values (3, "Sam Smith", "10 High St", "04291062");
insert into friend values (4, "Lucy Murphy", "37 Old Rd", "04274356");
insert into friend values (5, "John Clarke", "29 High St", "04275674");
insert into friend values (6, "Frank Smith", "12 Chapel St", "04123432");
insert into friend values (7, "Mary Clarke", "14 New Rd", "04267545");
insert into friend values (8, "Sarah Smith", "12 Chapel St", "04123432");
insert into friend values (9, "Kevin Jones", "34 High St", "04267564");
insert into friend values (10, "Laura King", "23 New Rd", "04123423");
insert into friend values (11, "Bill Daly", "45 Chapel St", "04234323");
insert into friend values (12, "Jane Smyth", "11 Chapel St", "04198783");
insert into friend values (13, "Jim Byrne", "61 New Rd", "04165215");
insert into friend values (14, "Ciara Smyth", "11 Chapel St", "04198783");
insert into friend values (15, "Ben Jones", "34 High St", "04267564");
insert into hobbies values (1, "golf");
insert into hobbies values (1, "pool");
insert into hobbies values (1, "snooker");
insert into hobbies values (2, "football");
insert into hobbies values (2, "snooker");
insert into hobbies values (3, "golf");
insert into hobbies values (3, "running");
insert into hobbies values (3, "swimming");
insert into hobbies values (4, "swimming");
insert into hobbies values (4, "tennis");
insert into hobbies values (5, "football");
insert into hobbies values (6, "pool");
insert into hobbies values (6, "squash");
insert into hobbies values (7, "running");
insert into hobbies values (8, "swimming");
insert into hobbies values (8, "tennis");
insert into hobbies values (9, "football");
insert into hobbies values (9, "golf");
insert into hobbies values (9, "tennis");
insert into hobbies values (10, "football");
insert into hobbies values (10, "squash");
insert into hobbies values (11, "swimming");
insert into hobbies values (12, "running");
insert into hobbies values (12, "squash");
insert into hobbies values (12, "swimming");
insert into hobbies values (13, "football");
insert into hobbies values (13, "golf");
insert into hobbies values (13, "snooker");
insert into hobbies values (14, "swimming");
insert into hobbies values (14, "tennis");
insert into hobbies values (15, "football");

select * from friend;
-- Shows whole friend table

select friend.name from friend 
join hobbies using (friend_id);
-- Shows the name of all friends and makes friend_id a foreign key

select friend.name from friend 
join hobbies using (friend_id) 
where hobby = "golf";
-- Shows friend names and makes friend_id an fk, only showing friends who golf

select friend.name, friend.address from friend 
join hobbies using (friend_id) 
where hobby = "football";
-- Shows friend name and address that play football

select friend.name, friend.address from friend 
where address like "%old%";
-- Shows names and addresses of people who live somewhere with "old" in the address

select distinct friend.name, friend.address from friend
where name like "%Byrne";
-- SHow names and address of people whose name ends in Byrne

select * from friend 
join hobbies using (friend_id) 
where hobby = "golf";
-- Show all from people who golf

select * from friend 
join hobbies using (friend_id) 
where name = "Joe Bloggs" 
and hobby = "snooker";
-- Show all from Joe Bloggs that also plays snooker

--1. Lucy Murphy’s details
select distinct * from friend, hobbies 
join hobbies using (friend_id) 
where name = "Lucy Murphy";

--2.	Friends who have surname Jones
select friend.name from friend 
where name like "%Jones";

--3.	Friends who live on Chapel St
select friend.name, friend.address from friend 
where address like "%Chapel St%";

--4.	Friends who live in the 042 area
select friend.name, friend.Telephone from friend 
where Telephone like "042%";

--5.	Bill Daly’s address and phone no
select friend.name, friend.Address, friend.Telephone from friend 
where friend.name like "Bill Daly";

--6.	Friends with surname Bloggs and live in the 042 area
select friend.name from friend 
where friend.name like "%Bloggs" 
and friend.Telephone like "042%";

--7.	Friends with surname Smith (Smyth)
select friend.name from friend 
where name like "%Smith";

--8.	Friends with surname King or live on Chapel St
select friend.name from friend 
where name like "%King"
or address like "%Chapel St%";

--9.	Friends who play squash
select friend.name from friend 
join hobbies using (friend_id) 
where hobby = "squash";

--10.Friends who live in the 042 area and play football
select friend.name from friend, hobbies
join hobbies using (friend_id)
where hobbies.hobby like "football" 
and friend.Telephone like "042%";

--11.Friends with surname Clarke who swim
select friend.name from friend, hobbies
join hobbies using (friend_id)
where name like "%Clarke"
and hobbies.hobby like "football";

--12.Friends who play tennis or golf
select friend.name from friend, hobbies
join hobbies using (friend_id)
where hobbies.hobby like "golf"
or hobbies.hobby like "tennis";

--13.Friends who live on chapel street who play tennis or swim
select friend.name from friend, hobbies
join hobbies using (friend_id)
where friend.address like "%Chapel St%"
and hobbies.hobby like "swim"
or hobbies.hobby like "tennis";

--14.Name and address of friends who like to run or play pool
select friend.name, friend.address from friend, hobbies
join hobbies using (friend_id)
where hobbies.hobby like "running"
or hobbies.hobby like "pool";
