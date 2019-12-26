drop table work;
create table work (
task varchar2(20) not null,
name varchar2(20) not null,
deadline date default to_date('26-12-2019','dd-MM-yyyy'),
completedon date,
status varchar2(15)
);
insert into work(task,name,completedon)
values('Install oracle','Naresh',to_date('25-12-2019','dd-MM-yyyy'));
insert into work(task,name,completedon)
values('Install jdk','Suresh',to_date('28-12-2019','dd-MM-yyyy'));
insert into  work(task,name,completedon)
values('Install python','Ramesh',to_date('17-12-2019','dd-MM-yyyy'));
update work
set status = 'Completed'
where deadline>completedon;
update work
set status = 'Incompleted'
where deadline<completedon;
select * from work
