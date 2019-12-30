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
 quantity_KG float,
 price float not null,
 stock number not null,
 status varchar2(25),
 constraint price_cq check(price>0)
 );
  
  
  ```
