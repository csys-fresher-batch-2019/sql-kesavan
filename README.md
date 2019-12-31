# GROCERY MANAGEMENT SYSTEM

## FEATURES
  USER SHOULD ABLE TO BUY GROCERY PRODUCTS
### FEATURE 1 LIST THE GROCERY PRODUCTS
Query:

```

create table products(
 product_name varchar2(30) not null,
 product_id number primary key,
 manufacturer varchar2(30),
 quantity float,
 unit varchar2(25),
 price float not null,
 stock int not null,
 status varchar2(25),
 constraint price_cq check(price>0)
 );
  
  
  ```
