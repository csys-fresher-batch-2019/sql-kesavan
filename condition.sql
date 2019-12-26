drop table work;
create table work (
emp_id int,
task varchar2(200) not null,
name varchar2(20) not null,
deadline date default to_date('26-12-2019','dd-MM-yyyy'),
completedon date,
status varchar2(15)
);
insert into work(emp_id,task,name,completedon)
values(2000,'Install oracle and oreo and rent','Naresh',to_date('25-12-2019','dd-MM-yyyy'));
insert into work(emp_id,task,name,completedon)
values(2003,'Install jdk','Suresh',to_date('28-12-2019','dd-MM-yyyy'));
insert into  work(emp_id,task,name,completedon)
values(2005,'Install python','Ramesh',to_date('17-12-2019','dd-MM-yyyy'));
update work
set status = 'Completed'
where deadline>completedon;
update work
set status = 'Incompleted'
where deadline<completedon;
alter table work add emp_id varchar2(78);
select * from work
where status='Completed';
