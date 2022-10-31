select count(*)
from
	lmman_practice.orders
where order_status in ('COMPLETE','PENDING')
limit 10

select
	order_customer_id
	, to_char(order_date, 'yyyy-MM') as order_date
	, order_status
from
	lmman_practice.orders;

select
	count(1)
from
	lmman_practice.orders;

select
	count(distinct to_char(order_date, 'yyyy-MM')) as order_months
from
	lmman_practice.orders
	
--join table
	
select * from lmman_practice.orders
--order_id

select * from lmman_practice.order_items

--order_item_order_id

select o.order_id, o.order_date,o.order_status,oi.order_item_subtotal  from

lmman_practice.orders o join lmman_practice.order_items oi on o.order_id = oi.order_item_order_id


--pracice join 
select count(*)  from

lmman_practice.orders o join lmman_practice.order_items oi on o.order_id = oi.order_item_order_id

--using groupby

select order_date, count(1) from lmman_practice.orders
group by order_date
order by order_date 
limit 10


select * from lmman_practice.order_items;

select order_item_order_id, sum(order_item_subtotal) as sum_total from lmman_practice.order_items
group by order_item_order_id
order by order_item_order_id desc 
limit 10;

--daily product revernue

select * from lmman_practice.products limit 10;

--prodcut_id, product_category_id, product_name, product_price

select * from lmman_practice.order_items
--order_item_product_id, order_item_subtotal

--query

select pro.product_id , ordi.order_item_product_id,pro.product_name, ordi.order_item_subtotal  from 
lmman_practice.products pro 
join lmman_practice.order_items ordi
	on pro.product_id =ordi.order_item_product_id
join lmman_practice.orders ord on pro.
where ordi.order_status  in ('COMPLETE','CLOSED')
group by ordi.order_date, ordi.order_customer_id 
limit 10

select ord.order_date ,oi.order_item_product_id,pro.product_name, sum(oi.order_item_subtotal)  from 
order_items oi
join lmman_practice.products pro on oi.order_item_product_id = pro.product_id 
join lmman_practice.orders ord on oi.order_item_order_id = ord.order_id
where ord.order_status in ('COMPLETE', 'CLOSED')
group by ord.order_date, oi.order_item_product_id,pro.product_name 
order by ord.order_date 
limit 10

--count all
select count(1) from 
(select ord.order_date ,oi.order_item_product_id,pro.product_name, sum(oi.order_item_subtotal)  from 
order_items oi
join lmman_practice.products pro on oi.order_item_product_id = pro.product_id 
join lmman_practice.orders ord on oi.order_item_order_id = ord.order_id
where ord.order_status in ('COMPLETE', 'CLOSED')
group by ord.order_date, oi.order_item_product_id,pro.product_name 
order by ord.order_date) q



