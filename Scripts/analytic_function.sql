
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


select employee_id, department_id , sum(salary), round(avg(salar),2)
from lmman_practice.employees

-----USING GROUP BY

select employee_id, a.department_id, salary , department_salary_expense, avg_salary_expense
from employees as a
join
(select department_id, sum(salary) as department_salary_expense, round(avg(salary), 2) as avg_salary_expense
from lmman_practice.employees
group by department_id) as b
on a.department_id  = b.department_id
order by department_id, salary 

----USING PARTITION

select employee_id, department_id, salary,
	sum(salary) over (
		partition by department_id) as department_salary_expense,
	round(avg(salary) over(
		partition by department_id),2) as avg_salary_expense,
	min(salary) over(
		partition by department_id) as min_salary_expense,
	max(salary) over(
		partition by department_id) as max_salary_expense,
	count(salary) over(
		partition by department_id) as count_salary_expense
from lmman_practice.employees

----USING RANK - WINDOW FUNCTION

SELECT employee_id, department_id, salary,
	rank() OVER(
		PARTITION  BY department_id 
		ORDER BY salary) AS rank_,
	DENSE_RANK() over(
		PARTITION BY department_id
		ORDER BY salary) AS dense_rak
FROM lmman_practice.employees

---USING FILTER FUNCTION

SELECT * 
FROM  lmman_practice.orders 
-----
SELECT *
FROM lmman_practice.order_items

----- USING CONDITON HAVING
SELECT ord.order_date, round(sum(oi.order_item_subtotal)::NUMERIC , 2) AS revenue
FROM lmman_practice.orders ord 
LEFT JOIN lmman_practice.order_items oi
ON ord.order_id  = oi.order_item_order_id
WHERE ord.order_status  IN ('COMPLETE','CLOSED')
GROUP BY ord.order_date
	HAVING  round(sum(oi.order_item_subtotal)::NUMERIC , 2) > 50000
ORDER BY ord.order_date DESC 

--USING SUBQUERY TO ADD MORE CONDITION 

SELECT *
FROM 
	(SELECT ord.order_date, round(sum(oi.order_item_subtotal)::NUMERIC , 2) AS revenue
		FROM lmman_practice.orders ord 
		LEFT JOIN lmman_practice.order_items oi
		ON ord.order_id  = oi.order_item_order_id
		WHERE ord.order_status  IN ('COMPLETE','CLOSED')
		GROUP BY ord.order_date
		ORDER BY ord.order_date DESC) AS A
WHERE A.revenue > 50000

---
SELECT * FROM lmman_practice.daily_product_revenue_v
--

SELECT order_date,order_item_product_id, revenue,
	dense_rank() over(
		PARTITION  BY order_date 
		ORDER BY revenue DESC  ) AS dense_rak
FROM lmman_practice.daily_product_revenue_v


SELECT * 
FROM (
	SELECT order_date,order_item_product_id, revenue,
	dense_rank() over(
		PARTITION  BY order_date 
		ORDER BY revenue DESC  ) AS dense_rak
	FROM lmman_practice.daily_product_revenue_v
	) AS B
WHERE B.dense_rak <= 5

