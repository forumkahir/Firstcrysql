CREATE DATABASE FIRSTCRY;
USE FIRSTCRY;

select * from REGISTER_ACC;
select * from all_categories;
select * from GirlsFashionSubcategory;
select * from items;
select * from address;
select * from shopping_cart;
select * from upi_payment;

drop table REGISTER_ACC;
drop table all_categories;
drop table GirlsFashionSubcategory;
drop table items;
drop table address;
drop table shopping_cart;
drop table upi_payment;







CREATE TABLE REGISTER_ACC
(ACCOUNT_ID INT AUTO_INCREMENT, 
FULL_NAME VARCHAR(50) NOT NULL, 
COUNTRY_CODE VARCHAR(5) DEFAULT(+91), 
MOBILE_NUMBER BIGINT NOT NULL unique, 
EMAIL_ID VARCHAR(50) NOT NULL,
PASSWORD VARCHAR(20) NOT NULL,
PRIMARY KEY(ACCOUNT_ID));

INSERT INTO REGISTER_ACC VALUES 
(1,'ABC', '+91', 1234567891, 'ABC@GMAIL.COM', 'ABC@123'),
(2,'XYZ','+91',9876543210,'XYZ@GMAIL.COM','XYZ@123');

select * from REGISTER_ACC;
drop table REGISTER_ACC;
truncate table REGISTER_ACC;

SELECT * FROM REGISTER_ACC WHERE MOBILE_NUMBER = 1234567891 or EMAIL_ID = 'ABC@GMAIL.COM' 
and PASSWORD = 'ABC@123';

CREATE TABLE all_categories(
category_id INT NOT NULL, 
category_name VARCHAR(30) NOT NULL,
primary key(category_id));

Insert into all_categories values 
(1, 'Boys Fashion'),
(2, 'Girls Fashion'),
(3, 'Footwear'),
(4, 'Moms'),
(5, 'Books'),
(6, 'School_Supplies');

select * from all_categories;
drop table all_categories;

select * from all_categories where category_name = 'Girls Fashion';

create table GirlsFashionSubcategory
(
product_id INT NOT NULL,
sub_cat_id varchar(20) NOT NULL, 
sub_cat_name varchar(20) NOT NULL,
primary key(sub_cat_id),
foreign key(product_id) references all_categories(category_id)
);

Insert into GirlsFashionSubcategory 
values (2, 'Tshirt001', 'T-shirts'),
(2, 'CAP001', 'Caps'),
(2,'Sun001', 'Sunglasses'),
(2, 'Bag001', 'Bags'),
(2, 'FF001', 'Flipflops'),
(2, 'Watch001','Watches');
select * from GirlsFashionSubcategory;
drop table GirlsFashionSubcategory;
Select * from GirlsFashionSubcategory where sub_cat_id = 'Bag001';

CREATE TABLE items
(
item_id varchar(20) NOT NUll, 
item_name varchar(20) NOT NUll, 
sub_id varchar(20) NOT NULL, 
cat_id INT NOT NUll, 
description varchar(50) NOT NUll, 
price INT NOT NUll, 
size varchar(20) NOT NUll,
age varchar(20) NOT NUll,
primary key(item_id),
foreign key(cat_id) references all_categories(category_id));

Insert into items values
('Kiduni', 'Backpack', 'Bag001', 2, 'KIDLINGSS Unicorn Printed Backpack - Pink', 935, 'small', '3 to 8 years'),
('hidpid', 'Sling Bag', 'Bag002', 2, 'Hola Bonita Free Size Sling Bag - Blue', 568, 'small', '3 to 5 years'),
('Kiddyie', 'Hand Bag', 'Bag003', 1, 'Hola Bonita Sling Bag - Pink', 569, 'small', '3 to 5 years');

select * from items;
drop table items;
select * from items where price in(select max(price) from items);

create table address(
ACCOUNT_ID INT NOT NULL,
FULL_NAME Varchar(50) NOT NULL, 
House_no Varchar(50) NOT NULL, 
Street_name Varchar(50) NOT NULL, 
Landmark Varchar(50), 
City Varchar(50) NOT NULL, 
state Varchar(50) NOT NULL, 
pincode INT NOT NULL, 
MOBILE_NUMBER BIGINT NOT NULL,
foreign key(ACCOUNT_ID) references REGISTER_ACC(ACCOUNT_ID));
Insert into address values
(1, 'ABC', 123, 'Ramnagar', 'HSR', 'Bangalore', 'Karnataka', 560102, 1234567891);
Select * from address;
drop table address;

Create table upi_payment(
upi_id INT not null , 
virtual_payment_address varchar(50) not null unique, 
ACCOUNT_id INT not null, 
transaction_id varchar(20) not null unique,
primary key(transaction_id),
foreign key(ACCOUNT_id) references REGISTER_ACC(ACCOUNT_ID));
Insert into upi_payment values(1, 'abc@okhdfcbank', 1, '4389MNG593276');
Select * from upi_payment;
drop table upi_payment;

Create table shopping_cart(
order_number varchar(50) not null unique, 
ACC_ID INT not null, 
itm_id varchar(20) unique not null,
item_name varchar(20) not null,
description varchar(50) NOT NUll,
trnsctn_id varchar(20) not null unique,
Order_date datetime not null, 
price_ INT not null,
quantity int default(1) not null,
size varchar(20) NOT NUll,
foreign key(ACC_ID) references REGISTER_ACC(ACCOUNT_ID),
foreign key(itm_id) references items(item_id),
foreign key(trnsctn_id) references upi_payment(transaction_id));

Insert into shopping_cart values
('SHC8BAC5D3', 1, 'Kiduni','Backpack','KIDLINGSS Unicorn Printed Backpack - Pink','4389MNG593276', '2023-07-23 15:23:11', 935, 1, '3 to 8 years');

Select * from shopping_cart;
drop table shopping_cart;



Create table order_completed as 
select s.order_number, s.Order_date, s.price_, s.item_name, s.description, s.ACC_ID, s.size, a.FULL_NAME, a.House_no, 
a.Street_name, a.City, a.pincode, a.MOBILE_NUMBER, u.transaction_id
from shopping_cart s
inner join address a
ON s.ACC_ID = a.ACCOUNT_ID
inner join upi_payment u 
ON a.ACCOUNT_ID = u.ACCOUNT_id;
select * from order_completed;

drop table order_completed;





















