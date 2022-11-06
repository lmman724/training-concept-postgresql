---CHECK NUMBER OF RECORD IN TABLE IN HR_DATABASE 

SELECT count(1) FROM lmman_practice.products
UNION ALL
SELECT COUNT(1) FROM lmman_practice.order_items;


----Get all the employees who is making more than average salary with in each department.


SELECT * FROM lmman_practice.employees WHERE employee_id = 100

--employee_id, first_name, last_name, hire_date, salary, department_id

SELECT * FROM lmman_practice.departments

-- department_id, department_name


-- LEFT JOIN TABLE TO PREVIEW

SELECT emp.employee_id, emp.first_name, emp.last_name, emp.hire_date, emp.salary AS personal_salary, dep.department_name 
FROM lmman_practice.employees emp
LEFT JOIN lmman_practice.departments dep
ON emp.department_id = dep.department_id

--AVG SALARY IN DEPARTMENT

SELECT dep.department_id, dep.department_name, round(avg(salary), 2) AS AVG_salary_departmet 
FROM lmman_practice.employees emp
LEFT JOIN lmman_practice.departments dep
ON emp.department_id = dep.department_id
WHERE dep.department_id  IS NOT NULL
GROUP BY dep.department_id


-- ADD SUBQUY FOR COMBINE OUTPUT 2 QUERY ABOVE
SELECT emp.employee_id, emp.first_name, emp.last_name, emp.hire_date, 
emp.salary AS personal_salary, avg_salary_query.department_name,
avg_salary_query.avg_salary_departmet
FROM lmman_practice.employees emp
LEFT JOIN
	(
	SELECT dep.department_id, dep.department_name, round(avg(salary), 2) AS AVG_salary_departmet 
	FROM lmman_practice.employees emp
	LEFT JOIN lmman_practice.departments dep
	ON emp.department_id = dep.department_id
	WHERE dep.department_id  IS NOT NULL
	GROUP BY dep.department_id
	) AS avg_salary_query
ON emp.department_id = avg_salary_query.department_id
WHERE emp.salary  > avg_salary_query.AVG_salary_departmet
ORDER BY avg_salary_query.department_id, emp.salary DESC

----Get cumulative salary with in each department for Finance and IT department along with department name.




---Get top 3 paid employees with in each department by salary (use dense_rank)

SELECT * FROM lmman_practice.departments


SELECT * FROM lmman_practice.employees

--GET AVG_SALARY IN EACH DEPARTMENT

SELECT dep.department_id, dep.department_name, round(avg(emp.salary),2) AS avg_salary_department  
FROM lmman_practice.departments dep
right JOIN lmman_practice.employees emp
ON dep.department_id  = emp.department_id
WHERE dep.department_id  IS NOT NULL 
GROUP BY dep.department_id

--USING SUBQUERY

SELECT *
FROM 
	(SELECT emp.employee_id,emp.department_id,emp.salary AS personal_salary,
	DENSE_RANK() OVER (
	PARTITION BY emp.department_id
	ORDER BY emp.salary DESC) AS dense_rak
	FROM lmman_practice.employees emp) AS emp_all
LEFT JOIN
(
	SELECT dep.department_id, dep.department_name, round(avg(emp.salary),2) AS avg_salary_department  
	FROM lmman_practice.departments dep
	right JOIN lmman_practice.employees emp
	ON dep.department_id  = emp.department_id
	WHERE dep.department_id  IS NOT NULL 
	GROUP BY dep.department_id
) AS dep_avg
ON emp_all.department_id = dep_avg.department_id
WHERE emp_all.dense_rak <= 3
