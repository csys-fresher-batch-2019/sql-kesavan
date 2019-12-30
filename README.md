# GROCERY MANAGEMENT SYSTEM

## FEATURES
  USER SHOULD ABLE TO BUY GROCERY PRODUCTS
### FEATURE 1 LIST THE GROCERY PRODUCTS
Query:

```
create table products(
 productname varchar2(30) not null,
 productid int primary key,
 manufacturer varchar2(30),
 price int not null check(price>0),
 quantity int
 );
  
  
  ```
