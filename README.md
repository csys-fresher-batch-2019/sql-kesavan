# E-GROCERY

## FEATURES
  * USER SHOULD ABLE TO VIEW SOME GROCERY PRODUCTS
  * USER CAN ORDER SOME GROCERY PRODUCTS
  * USER SHOULD ABLE TO CANCEL THE ORDER
  * USER CAN VIEW THE ORDER SUMMARY

### FEATURE 1   LIST THE GROCERY PRODUCTS

```sql
create table products(
 product_name varchar2(30) not null,
 product_id number primay key,
 manufacturer varchar2(30),
 quantity float,
 unit varchar2(25),
 price float not null,
 stock int,
 status varchar2(25),
 constraint price_cq check(price>0)
 );
 insert into products(product_name,product_id,manufacturer,price,quantity,stock,unit)
 values('Coffee Powder',231,'Nescafe',400,0.5,100,'KG');
 insert into products(product_name,product_id,manufacturer,price,quantity,stock,unit)
 values('Tea Powder',232,'Tata Tea Gold',200,1,100,'KG');
 insert into products(product_name,product_id,manufacturer,price,quantity,stock,unit)
 values('Cashews',233,'Fruitri',900,1,100,'KG');
 insert into products(product_name,product_id,manufacturer,price,quantity,stock,unit)
 values('Coconut oil',234,'VVD',200,1,100,'LTRS');
 update products
 set status='AVAILABLE'
 where stock>0;
 update products
 set status='OUT OF STOCK'
 where stock<=0;
 
 select * from products
 
 
 +---------------+------------+---------------+----------+------+-------+-------+-----------+
| PRODUCT_NAME  | PRODUCT_ID | MANUFACTURER  | QUANTITY | UNIT | PRICE | STOCK | STATUS    |
+---------------+------------+---------------+----------+------+-------+-------+-----------+
| Coffee Powder | 231        | Nescafe       | .5       | KG   | 400   | 100   | AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+-----------+
| Tea Powder    | 232        | Tata Tea Gold | 1        | KG   | 200   | 100   | AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+-----------+
| Cashews       | 233        | Fruitri       | 1        | KG   | 900   | 100   | AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+-----------+
| Coconut oil   | 234        | VVD           | 1        | LTRS | 200   |   0   | OUTOFSTOCK|
+---------------+------------+---------------+----------+------+-------+-------+-----------+

 ```
  ### FEATURE 2   ADD THE USERDATA

```sql
--Create userdata

create table usersdata(
user_id number primary key,
user_name varchar2(25) not null,
delivery_address varchar2(60)
);
insert into usersdata(user_id,user_name,delivery_address)
values(1101,'Ravi','243,Bharathi nagar Chennai-600043');
insert into usersdata(user_id,user_name,delivery_address)
values(1102,'Kumar','345,Kumaran nagar Chennai-600048');
insert into usersdata(user_id,user_name,delivery_address)
values(1103,'Suresh','64,Gajendra nagar Chennai-610045');
insert into usersdata(user_id,user_name,delivery_address)
values(1104,'Ramesh','624,Gandhi nagar Chennai-610045');

select * from usersdata

+---------+-----------+-----------------------------------+
| USER_ID | USER_NAME | DELIVERY_ADDRESS                  |
+---------+-----------+-----------------------------------+
| 1101    | Ravi      | 243,Bharathi nagar Chennai-600043 |
+---------+-----------+-----------------------------------+
| 1102    | Kumar     | 345,Kumaran nagar Chennai-600048  |
+---------+-----------+-----------------------------------+
| 1103    | Suresh    | 64,Gajendra nagar Chennai-610045  |
+---------+-----------+-----------------------------------+
| 1104    | Ramesh    | 624,Gandhi nagar Chennai-610045   |
+---------+-----------+-----------------------------------+

```
### FEATURE 3   PLACE THE ORDER DETAILS

```sql

--Create order details

create table orderdata(
user_id number not null,
order_id number not null,
product_id number not null,
no_of_items  number not null,
price_per_item float,
total_amount float,
order_date date  not null,
delivery_date date,
order_status varchar2(30) default 'NOT ORDERED',
constraint product_id_fk foreign key(product_id) references products(product_id),
constraint user_id_fk foreign key(user_id) references userdata(user_id)
);
insert into orderdata(user_id,order_id,product_id,order_date,delivery_date,no_of_items,price_per_item)
values(1101,1001,231,trunc(sysdate),trunc(sysdate+5),5,400);
insert into orderdata(user_id,order_id,product_id,order_date,delivery_date,no_of_items,price_per_item)
values(1102,1002,232,trunc(sysdate),trunc(sysdate+6),10,200);
insert into orderdata(user_id,order_id,product_id,order_date,delivery_date,no_of_items,price_per_item)
values(1103,1003,233,trunc(sysdate),trunc(sysdate+8),2,900);
--update total amount for purchased item
update orderdata
set total_amount=no_of_items*price_per_item;
--update order status
update orderdata
set order_status='ORDERED'
where no_of_items>0;
alter table orderdata
add payment varchar2(20) default 'COD';

select * from orderdata

+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| USER_ID | ORDER_ID | PRODUCT_ID | NO_OF_ITEMS | PRICE_PER_ITEM | TOTAL_AMOUNT | ORDER_DATE | DELIVERY_DATE | ORDER_STATUS | PAYMENT |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| 1101    | 1001     | 231        | 5           | 400            | 2000         | 03-JAN-20  | 08-JAN-20     | ORDERED      | COD     |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| 1102    | 1002     | 232        | 10          | 200            | 2000         | 03-JAN-20  | 09-JAN-20     | ORDERED      | COD     |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| 1103    | 1003     | 233        | 2           | 900            | 1800         | 03-JAN-20  | 11-JAN-20     | ORDERED      | COD     |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+

```
###  FEATURE 4   CHANGE STOCK VALUE AFTER ORDERED

```sql
--Alter products table for stock after ordered

update products p
set p.stock=p.stock-(select o.no_of_items from orderdata o where o.product_id = p.product_id)
where product_id = (select product_id from orderdata where product_id = p.product_id);
update products
set stock= 0
where stock<=0;
update products
set status=' OUT OF STOCK'
where stock=0;
update products
set status=' AVAILABLE'
where stock>0;
select * from products

+---------------+------------+---------------+----------+------+-------+-------+------------+
| PRODUCT_NAME  | PRODUCT_ID | MANUFACTURER  | QUANTITY | UNIT | PRICE | STOCK | STATUS     |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Coffee Powder | 231        | Nescafe       | .5       | KG   | 400   | 95    |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Tea Powder    | 232        | Tata Tea Gold | 1        | KG   | 200   | 90    |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Cashews       | 233        | Fruitri       | 1        | KG   | 900   | 98    |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Coconut oil   | 234        | VVD           | 1        | LTRS | 200   | 0     | OUTOFSTOCK |
|               |            |               |          |      |       |       |            |
+---------------+------------+---------------+----------+------+-------+-------+------------+

```
###  FEATURE 5   CANCEL THE ORDER

```sql
--Cancel the order

update orderdata
set order_status= 'CANCELLED',total_amount=0,delivery_date=NULL,payment=='NULL'
where order_id=1001;
select * from orderdata

+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| USER_ID | ORDER_ID | PRODUCT_ID | NO_OF_ITEMS | PRICE_PER_ITEM | TOTAL_AMOUNT | ORDER_DATE | DELIVERY_DATE | ORDER_STATUS | PAYMENT |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| 1101    | 1001     | 231        | 5           | 400            | 0            | 03-JAN-20  |  -            | CANCELLED    | NULL    |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| 1102    | 1002     | 232        | 10          | 200            | 2000         | 03-JAN-20  | 09-JAN-20     | ORDERED      | COD     |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+
| 1103    | 1003     | 233        | 2           | 900            | 1800         | 03-JAN-20  | 11-JAN-20     | ORDERED      | COD     |
+---------+----------+------------+-------------+----------------+--------------+------------+---------------+--------------+---------+

--Update products after cancelled

update products p
set p.stock=p.stock+(select no_of_items from orderdata  where product_id = 231)
where product_id = 231;
update products
set stock= 0
where stock<=0;
update products
set status=' AVAILABLE'
where stock>0;
update products
set status=' OUT OF STOCK'
where stock<=0;

select * from products;

+---------------+------------+---------------+----------+------+-------+-------+------------+
| PRODUCT_NAME  | PRODUCT_ID | MANUFACTURER  | QUANTITY | UNIT | PRICE | STOCK | STATUS     |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Coffee Powder | 231        | Nescafe       | .5       | KG   | 400   | 100   |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Tea Powder    | 232        | Tata Tea Gold | 1        | KG   | 200   | 90    |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Cashews       | 233        | Fruitri       | 1        | KG   | 900   | 98    |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Coconut oil   | 234        | VVD           | 1        | LTRS | 200   | 0     | OUTOFSTOCK |
+---------------+------------+---------------+----------+------+-------+-------+------------+

```
### FEATURE 6   FINALIZE THE ORDERSUMMARY

```sql
--View the order summary 

select user_name,order_id,product_name,manufacturer,quantity,no_of_items,total_amount,order_date,delivery_date,delivery_address,order_status,payment from orderdata o
inner join products p
on p.product_id=o.product_id
inner join usersdata u
on o.user_id=u.user_id and total_amount>0;

+-----------+----------+--------------+---------------+----------+-------------+--------------+------------+---------------+----------------------------------+--------------+---------+
| USER_NAME | ORDER_ID | PRODUCT_NAME | MANUFACTURER  | QUANTITY | NO_OF_ITEMS | TOTAL_AMOUNT | ORDER_DATE | DELIVERY_DATE | DELIVERY_ADDRESS                 | ORDER_STATUS | PAYMENT |
+-----------+----------+--------------+---------------+----------+-------------+--------------+------------+---------------+----------------------------------+--------------+---------+
| Kumar     | 1002     | Tea Powder   | Tata Tea Gold | 1        | 10          | 2000         | 03-JAN-20  | 09-JAN-20     | 345,Kumaran nagar Chennai-600048 | ORDERED      | COD     |
+-----------+----------+--------------+---------------+----------+-------------+--------------+------------+---------------+----------------------------------+--------------+---------+
| Suresh    | 1003     | Cashews      | Fruitri       | 1        | 2           | 1800         | 03-JAN-20  | 11-JAN-20     | 64,Gajendra nagar Chennai-610045 | ORDERED      | COD     |
+-----------+----------+--------------+---------------+----------+-------------+--------------+------------+---------------+----------------------------------+--------------+---------+

```
##FEATURE 7   UPDATE THE PRODUCTS STOCK VALUE

```sql


update products
set stock=stock+100
where product_id=234;
update products
set status=' AVAILABLE'
where stock>0;
update products
set status=' OUT OF STOCK'
where stock<=0;
select * from products


+---------------+------------+---------------+----------+------+-------+-------+------------+
| PRODUCT_NAME  | PRODUCT_ID | MANUFACTURER  | QUANTITY | UNIT | PRICE | STOCK | STATUS     |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Coffee Powder | 231        | Nescafe       | .5       | KG   | 400   | 100   |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Tea Powder    | 232        | Tata Tea Gold | 1        | KG   | 200   | 90    |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Cashews       | 233        | Fruitri       | 1        | KG   | 900   | 98    |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
| Coconut oil   | 234        | VVD           | 1        | LTRS | 200   | 100   |  AVAILABLE |
+---------------+------------+---------------+----------+------+-------+-------+------------+
  
  ```

 
 
 ```
