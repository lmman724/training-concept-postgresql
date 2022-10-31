
------

update lmman_practice.courses 
set course_status = 'published',
	course_published_dt  = current_date 
where course_name like '%Python%' or course_name like '%Scala%';
-----
select  * from lmman_practice.courses c

delete from lmman_practice.courses
where course_status not in ('published', 'draft')
returning *;

-----
select c.course_auhor, count(1) as course_count
from lmman_practice.courses c
where course_status  = 'published'
group by course_auhor;
