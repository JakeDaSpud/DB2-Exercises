drop table if exists order_details, orders, customer, products;


create table customer ( customer_id varchar(10) NOT NULL,
customer_name varchar(20),
PRIMARY KEY (customer_id));

create table products ( product_id int NOT NULL,
product_name varchar(20),
unit_price decimal(10,2),
units_in_stock int,
reorder_level int,
PRIMARY KEY (product_id));

create table orders ( order_id int NOT NULL,
customer_id varchar(10),
order_date date ,
PRIMARY KEY (order_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id));

create table order_details (order_id int NOT NULL,
product_id int NOT NULL,
quantity int,
PRIMARY KEY (order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id), 
FOREIGN KEY (product_id) REFERENCES products(product_id));

insert into products values (1, "Word for Windows V6", 250.00, 20, 10);
insert into products values (2, "Powerpoint", 189.00, 17, 25);
insert into products values (3, "Access", 356.00, 13, 25);
insert into products values (4, "Norton Utilities", 78.00, 53, 0);
insert into products values (5, "Lotus 123 for Windows", 267.00, 10, 7);
insert into products values (6, "Lotus 123", 189.00, 30, 25);
insert into products values (7, "Sidekick", 39.00, 15, 10);
insert into products values (8, "Dbase for Windows", 278.00, 6, 0);
insert into products values (9, "Borland C++", 267.00, 29, 0);
insert into products values (10, "Turbo Pascal", 123.00, 11, 0);
insert into products values (11, "Wordperfect", 234.00, 22, 30);
insert into products values (12, "Corel Draw", 450.00, 86, 0);

insert into customer values ("A123", "ABC Computing");
insert into customer values ("C145", "Cork Computers");
insert into customer values ("M234", "Martin Software");
insert into customer values ("N145", "Newry Computers");
insert into customer values ("T157", "Tomorrows World");

insert into orders values (1, "A123", "2001-09-01");
insert into orders values (2, "M234", "2001-09-18");
insert into orders values (3, "N145", "2001-09-26");
insert into orders values (4, "T157", "2001-10-03");

insert into order_details values (1, 1, 3);
insert into order_details values (1, 3, 5);
insert into order_details values (1, 6, 10);
insert into order_details values (1, 11, 6);
insert into order_details values (2, 2, 3);
insert into order_details values (2, 5, 2);
insert into order_details values (2, 6, 12);
insert into order_details values (2, 7, 5);
insert into order_details values (3, 1, 10);
insert into order_details values (3, 2, 10);
insert into order_details values (3, 6, 6);
insert into order_details values (3, 7, 6);
insert into order_details values (4, 1, 4);
insert into order_details values (4, 3, 12);
insert into order_details values (4, 5, 12);
insert into order_details values (4, 6, 13);
insert into order_details values (4, 11, 2);

/*from products p, customer c, orders o, order_details od*/

/*1. List the Product Name, Unit Price and Units in Stock for all products that cost more than 200, sort in ascending price order.*/
select p.product_name, p.unit_price, p.units_in_stock
from products p
where p.unit_price > 200.0
order by p.unit_price asc;

/*2. List the Product Name, Unit Price and Units in Stock and value for all products that have a current stock value greater than £2000. Sort in descending value order.*/
select p.product_name, p.unit_price, p.units_in_stock, (unit_price * units_in_stock) as stock_value
from products p
having stock_value > 2000.0
order by stock_value desc;

/*3. List the Product Name, Unit Price and Units in Stock for all products that have more than 20 Units in Stock or whose name begins with the letter L.*/
select p.product_name, p.unit_price, p.units_in_stock
from products p
where p.units_in_stock > 20
or p.product_name like "l%";

/*4. List the Product Name, Unit Price and Units in Stock for all products that have a reorder level greater than their Units in Stock.*/
select p.product_name, p.unit_price, p.units_in_stock
from products p
where p.reorder_level > p.units_in_stock;

/*5. List the Product Name, Unit Price for all products currently on order 1.*/
select p.product_name, p.unit_price
from products p, order_details od
where p.product_id = od.product_id
and od.order_id = 1;

/*6. List the Product Name, Unit Price, Quantity and total price for each product on order 2.*/
select p.product_name, p.unit_price, od.quantity, sum(p.unit_price * od.quantity) as total_price
from products p, order_details od
where p.product_id = od.product_id
and od.order_id = 2
group by p.product_id;

/*7. List the Customer name, order number and order year for orders that were placed in September.*/
select c.customer_name, o.order_id, year(o.order_date) as order_year
from customer c, orders o, order_details od
where o.order_id = od.order_id
and c.customer_id = o.customer_id
and month(o.order_date) = 9
group by od.order_id;

/* PRACTICAL 2, SAME TABLES */

/*1. Display all customers who have bought “Word for Windows V6”.*/
select c.customer_name
from customer c, orders o, order_details od
where o.order_id = od.order_id
and c.customer_id = o.customer_id
and od.product_id = 1;

/*2. Display all customers who have bought “Powerpoint”.*/
select c.customer_name
from customer c, orders o, order_details od
where o.order_id = od.order_id
and c.customer_id = o.customer_id
and od.product_id = 2;

/*3. Display all customers who have bought “Word for Windows V6” or “Powerpoint”.*/
select c.customer_name
from customer c, orders o, order_details od
where o.order_id = od.order_id
and c.customer_id = o.customer_id
and od.product_id = 1
or od.product_id = 2
group by c.customer_name;

/*4. Display all products which have a unit price more than £200.*/
select p.product_name, p.unit_price
from products p
where p.unit_price > 200.0;

/*5. Display all products whose units in stock is more than 50.*/
select p.product_name, p.units_in_stock
from products p
where p.units_in_stock > 50;

/*6. Display all products which have a unit price more than £200 or whose units in stock is more than 50.*/
select p.product_name, p.unit_price, p.units_in_stock
from products p
where p.unit_price > 200.0
or p.units_in_stock > 50;

/*7. Display all products which have a unit price more than £200 and whose units in stock is more than 50.*/
select p.product_name, p.unit_price, p.units_in_stock
from products p
where p.unit_price > 200.0
and p.units_in_stock > 50;

/*8. Display all products which have a unit price between £100 and £200.*/
select p.product_name, p.unit_price
from products p
where p.unit_price < 200.0
and p.unit_price > 100.0;

/*9. Return the product value of sales made in September*/
select o.order_id, c.customer_name, p.product_name, od.quantity, sum(p.unit_price * od.quantity) as total_value
from customer c, orders o, order_details od, products p
where o.order_id = od.order_id
and c.customer_id = o.customer_id
and od.product_id = p.product_id
and month(o.order_date) = 9
group by p.product_name, c.customer_name
order by total_value asc;

/*10. Return the total value of each order*/
select o.order_id, c.customer_name, sum(p.unit_price * od.quantity) as total_value
from customer c, orders o, order_details od, products p
where o.order_id = od.order_id
and c.customer_id = o.customer_id
and od.product_id = p.product_id
group by o.order_id;

/*11. Set the reorder level to 10 for all products which have a unit price greater than 100 and currently have a Reorder Level of 0.*/
update products
set reorder_level = 10
where unit_price > 100
and reorder_level = 0;

/*12. Return the total stock value of products*/
select p.product_name, p.unit_price, p.units_in_stock, sum(p.unit_price * p.units_in_stock) as stock_value
from products p
group by p.product_id
order by stock_value asc;

/*13. Return Products that are low in stock*/
select p.product_name, p.units_in_stock, p.reorder_level, (p.reorder_level - p.units_in_stock) as shortfall
from products p
having (p.reorder_level - p.units_in_stock) > 0
order by shortfall asc;

/*14. Return the total number of products sold*/
select p.product_name, sum(od.quantity) as total_quantity
from customer c, orders o, order_details od, products p
where o.order_id = od.order_id
and c.customer_id = o.customer_id
and od.product_id = p.product_id
group by p.product_id
order by total_quantity desc;

/*15. Find all products which have a unit price between £100 and £200 and raise the unit price by £30.*/
update products
set unit_price = unit_price + 30
where unit_price > 100
and unit_price < 200;
