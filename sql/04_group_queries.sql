select count(*) as total_amount from clients;

select round(avg(salary),2) as average_salary from staff;

select product_id, sum(quantity) as total_sold from product_sales group by product_id;

-- найти общую сумму выручки от продаж абонементов
select sum(price) as total_profit 
from memberships m 
join membership_sales ms on m.membership_id = ms.membership_id;

-- посчитать количество проданных абонементов для каждого вида тренировок
select tt.name as training_type, count(sale_id) as total_sold
from training_types tt 
left join memberships m on tt.training_type_id = m.training_type_id
left join membership_sales ms on m.membership_id = ms.membership_id
group by tt.name;