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

select employee_id, department_id, salary 
from lmman_practice.employees
order by employee_id
limit 10

------

select department_id, sum(salary) as department_salary_expense, round(avg(salary), 2) as avg_salary_expense
from lmman_practice.employees
group by department_id
order by department_id
limit 10

------

select e.employee_id, e.department_id,e.salary, round(avg(e.salary), 2) as avg_salary_expense
from lmman_practice.employees e
where e.employee_id = 202
group by e.employee_id, e.department_id


