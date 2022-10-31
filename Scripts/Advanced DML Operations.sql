create table lmman_practice.customer_order_metrics_mthly(
	customers_id int,
	order_month char(7),
	order_count int,
	order_revenue float
)

ALTER TABLE lmman_practice.customer_order_metrics_mthly
    ADD PRIMARY KEY (order_month, customers_id)


insert into lmman_practice.customer_order_metrics_mthly 
select ord.order_customer_id,
	to_char(ord.order_date, 'yyyy-MM') as order_month,
	count(1) as order_count,
	round(sum(oi.order_item_subtotal)::numeric,2) as order_revenue
from lmman_practice.orders ord join lmman_practice.order_items oi
on ord.order_id  =oi.order_item_order_id
group by ord.order_customer_id , to_char(ord.order_date,'yyyy-MM')
order by order_month
limit 10

select * from lmman_practice.customer_order_metrics_mthly comm


select * from lmman_practice.employees

------

select * from lmman_practice.users