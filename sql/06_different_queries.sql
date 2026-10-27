-- найти самого высокооплачиваемого сотрудника
select last_name, first_name, middle_name, salary
from staff
where salary = (select max(salary) from staff);

-- вывести список клиентов, которые ни разу не покупали товары
select last_name, first_name, middle_name 
from clients
where client_id not in (select client_id from product_sales);

-- найти клиентов, которые потратили на абонементы больше средней цены абонемента
select c.last_name, c.first_name, c.middle_name, m.price 
from clients c
join membership_sales ms on ms.client_id = c.client_id 
join memberships m on m.membership_id = ms.membership_id 
where m.price > (select avg(price) from memberships);

-- вычислить возраст каждого клиента на текущую дату
select last_name, first_name, birth_date,
date_part('year', age(current_date, birth_date)) as age
from clients;

-- найти все посещения, которые произошли в октябре 2023 года
select visit_id, visit_datetime
from attendance 
where visit_datetime >= '2023-10-01' and visit_datetime < '2023-11-01';

--  вывести клиента с самой высокой посещаемостью
select last_name, first_name, count(a.visit_id) as visits_count
from clients c
join membership_sales ms on ms.client_id = c.client_id 
join attendance a on a.sale_id = ms.sale_id 
group by c.client_id, c.last_name, c.first_name
order by visits_count desc 
limit 1;