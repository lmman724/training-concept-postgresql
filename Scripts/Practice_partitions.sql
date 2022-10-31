--create table user

create table lmman_practice.users_range_part (
	user_id SERIAL,
	user_first_name varchar(30) not null,
	user_last_name varchar(30) not null ,
	user_email_id varchar(50) not null,
	user_email_validated boolean default false,
	user_password varchar(200),
	user_role varchar(1) not null default 'U', --U and A
	is_active boolean default false,
	create_dt date default current_date,
	last_updated_ts timestamp default  current_timestamp ,
	primary key (user_id, create_dt)
) partition  by range (create_dt);


----
select * from lmman_practice.users_range_part;

---change name user_first_name and created_dt

alter table lmman_practice.users_range_part
rename column user_fisrt_name to user_first_name

alter table lmman_practice.users_range_part
rename column create_dt to created_dt
--drop table users_range_part

--create partition defaut

create table lmman_practice.users_range_part_2016
partition of lmman_practice.users_range_part
for values from ('2016-01-01') to ('2016-12-31') 

---
create table lmman_practice.users_range_part_2017
partition of lmman_practice.users_range_part
for values from ('2017-01-01') to ('2017-12-31')
---

create table lmman_practice.users_range_part_2018
partition of lmman_practice.users_range_part
for values from ('2018-01-01') to ('2018-12-31')

---
create table lmman_practice.users_range_part_2019
partition of lmman_practice.users_range_part
for values from ('2019-01-01') to ('2019-12-31')

-- insert data to lmman_practice.users_range_part

INSERT into lmman_practice.users_range_part
    (user_first_name, user_last_name, user_email_id, created_dt)
VALUES 
    ('Scott', 'Tiger', 'scott@tiger.com', '2018-10-01'),
    ('Donald', 'Duck', 'donald@duck.com', '2019-02-10'),
    ('Mickey', 'Mouse', 'mickey@mouse.com', '2017-06-22')
    
---    
    
select * from lmman_practice.users_range_part_2017

--practice excersice

select * from lmman_practice.orders

select distinct(order_date) from lmman_practice.orders

select count(distinct(order_date)) from lmman_practice.orders

---
create table lmman_practice.orders_partition_part_default
partition of lmman_practice.orders_partition default

drop table lmman_practice.orders_partition_part_default

    
--order_id, order_date, order_customer_id, order_status

--CREATE TABLE lmman_practice.orders (
--	order_id int4 NOT NULL,
--	order_date timestamp NOT NULL,
--	order_customer_id int4 NOT NULL,
--	order_status varchar(45) NULL,
--	CONSTRAINT orders_pkey PRIMARY KEY (order_id)
--);

create table lmman_practice.orders_partition(
	order_id int not null,
	order_date timestamp not null,
	order_customer_id int not null,
	order_status varchar(45),
	primary key (order_id, order_date)
) partition by range (order_date)

insert into lmman_practice.orders_partition(order_id, order_date, order_customer_id,order_status)
select order_id, order_date, order_customer_id , order_status  from lmman_practice.orders


select distinct(order_date) from lmman_practice.orders_partition
order by order_date
   
select table_catalog
	tabble_schema,
	table_name from information_schema.tables
where table_name ~ 'orders_partition_part'
