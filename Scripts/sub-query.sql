select count(1) from lmman_practice.order_items oi
where oi.order_item_order_id 
	in (
		select ord.order_id  from lmman_practice.orders ord
		where ord.order_id = oi.order_item_order_id 
	)
	
-----
	
select * from lmman_practice.order_items oi
where oi.order_item_order_id 
	in (
		select ord.order_id 
		from lmman_practice.orders ord
		where oi.order_item_order_id  = ord.order_id 
	)

	
----
	
	select * from lmman_practice.order_items oi
where oi.order_item_order_id 
	in (
		select ord.order_id 
		from lmman_practice.orders ord
		where oi.order_item_order_id  = ord.order_id 
	)
	
------
	
	