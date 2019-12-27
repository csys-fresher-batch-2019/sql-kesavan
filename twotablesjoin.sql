drop table books;
create table books(
book_id number primary key,
book_name varchar2(50) not null,
author_name varchar2(50) unique,
price number not null,
publisher varchar2(50) not null,
version number not null
);
insert into books(book_id,book_name,author_name,price,publisher,version)
values(1001,'Code complete','John',235,'Ajay publications',1);
insert into books(book_id,book_name,author_name,price,publisher,version)
values(1002,'Sql book','Michel',237,'Kumar publications',1);
insert into books(book_id,book_name,author_name,price,publisher,version)
values(1003,'Java complete','Rhonda',635,'Lakshmi publications',2);
insert into books(book_id,book_name,author_name,price,publisher,version)
values(1004,'Learn python','Ravi',675,'KPS publications',2);
select * from books;


drop table orders;
create table orders(
order_id number primary key,
user_id number not null,
book_id number not null,
order_date timestamp not null,
delivery_date timestamp not null,
total_amount number not null check(total_amount>0),
quantity number not null,
status varchar2(20) default 'Not ordered',
constraint book_id_fk foreign key(book_id) references books(book_id)
);
insert into orders(order_id,user_id,book_id,order_date,delivery_date,total_amount,quantity)
values(21342,1231,1002,sysdate,sysdate+7,675,1);
insert into orders(order_id,user_id,book_id,order_date,delivery_date,total_amount,quantity)
values(21345,1341,1004,sysdate,sysdate+7,375,0);
update orders
set status='Ordered'
where quantity>0;
update orders
set status='Not Ordered'
where quantity<=0;
select * from orders
select*
from books b
 join orders o
on b.book_id=o.book_id;
