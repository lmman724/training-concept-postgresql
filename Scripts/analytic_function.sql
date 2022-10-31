
create table lmman_practice.daily_revenue
as
SELECT ord.order_date,
	round(sum(oi.order_item_subtotal)::numeric , 2) as revenue
FROM lmman_practice.orders ord JOIN lmman_practice.order_items oi
on ord.order_id  = oi.order_item_order_id 
where ord.order_status in ('COMPLETE','CLOSED')
group by ord.order_date


-----

create table lmman_practice.daily_product_revenue
as
SELECT ord.order_date,
	oi.order_item_product_id, 
	round(sum(oi.order_item_subtotal)::numeric , 2) as revenue	
FROM lmman_practice.orders ord JOIN lmman_practice.order_items oi
on ord.order_id  = oi.order_item_order_id 
where ord.order_status in ('COMPLETE','CLOSED')
group by ord.order_date, oi.order_item_product_id


-----

select * 
from lmman_practice.daily_product_revenue

------

select * from lmman_practice.employees


-----

------- employee_id	department_id	salary	department_salary_expense	avg_salary_expense


