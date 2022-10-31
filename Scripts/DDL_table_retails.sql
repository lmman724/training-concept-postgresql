-- Table structure for table department
create table lmman_practice.department(
	department_id int not null,
	department_name varchar(45) not null,
	primary key (department_id)
);

-- Table categories

create table categories(
	category_id int not null,
	category_department_id int not null,
	category_name varchar(45) not null,
	primary key (category_id)
);


-- Table products

create table products(
product_id int not null,
product_category_id int not null,
product_name varchar(45) not null,
product_description varchar(255) not null,
product_price float not null,
product_image varchar(255) not null,
primary key (product_id)
);

-- Table customers

create table customers(
	customer_id int not null,
	customer_fname varchar(45) not null,
	customer_lname varchar(45) not null,
	customer_email varchar(45) not null,
	customer_password varchar(45) not null,
	customer_street varchar(255) not null,
	customer_city varchar(45) not null,
	customer_state varchar(45) not null,
	customer_zipcode varchar(45) not null,
	primary key (customer_id)
);

-- table orders

create table orders(
	order_id int not null,
	order_date timestamp not null,
	order_customer_id int not null,
	order_status varchar(45),
	primary key (order_id)
);


--table orders 

create table order_items(
	order_item_id int not null,
	order_item_order_id int not null,
	order_item_product_id int not null,
	order_item_quantity int not null,
	order_item_subtotal float not null,
	order_item_product_price float not null,
	primary key (order_item_id)
);







