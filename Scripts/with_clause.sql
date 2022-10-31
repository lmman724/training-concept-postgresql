SELECT * FROM lmman_practice.orders
union
select * from  lmman_practice.order_items

----

select ord.order_id ,ord.order_date,oi.order_item_quantity, oi.order_item_product_price, order_item_subtotal, ord.order_status 
from lmman_practice.order_items oi left join lmman_practice.orders ord
on oi.order_item_order_id = ord.order_id


with order_details_nq as (
	select * from 
		lmman_practice.orders ord join lmman_practice.order_items oi
		on ord.order_id = oi.order_item_order_id 
) select * from order_details_nq limit 10

------

create or replace view daily_product_revenue_v
as
with order_details_nq as (
	select * from lmman_practice.orders ord join lmman_practice.order_items oi
	on ord.order_id = oi.order_item_order_id 
) select order_date,order_item_product_id, 
	round(sum(order_item_subtotal)::numeric, 2) as revenue
	from order_details_nq
	group by order_date, order_item_product_id  
	
----
	
select * from lmman_practice.daily_product_revenue_v