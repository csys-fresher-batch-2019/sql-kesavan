# GROCERY MANAGEMENT SYSTEM

## FEATURES
  * USER SHOULD ABLE TO VIEW SOME GROCERY PRODUCTS
  * USER CAN ORDER SOME GROCERY PRODUCTS
  * USER SHOULD ABLE TO CANCEL THE ORDER
  * USER CAN VIEW THE ORDER SUMMARY

### FEATURE 1   LIST THE GROCERY PRODUCTS

```sql
create table products(
 product_name varchar2(30) not null,
 product_id number primary key,
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
| Coconut oil   | 234        | VVD           | 1        | LTRS | 200   | 0     |OUTOFSTOCK |
+---------------+------------+---------------+----------+------+-------+-------+-----------+
 ```
