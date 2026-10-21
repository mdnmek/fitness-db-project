-- вывести клиента, чей номер телефона заканчивается на 33
select last_name, first_name, middle_name, phone 
from clients 
where phone 
like '%33';

-- вывести самого молодого клиента фитнес клуба
select last_name, first_name, middle_name, birth_date 
from clients 
order by birth_date desc 
limit 1;

-- вывести имена и телефон клиентов в отсортированном по фамилии порядке
select client_id, last_name, first_name, phone 
from clients 
order by last_name asc;

-- найти всех сотрудников, чья зарплата превышает 70 000 рублей
select last_name, first_name, salary 
from staff 
where salary > 70000;

-- вывести товары, которых на складе осталось меньше 50 штук
select name, stock_quantity
from products 
where stock_quantity < 50;

-- найти всех клиентов, родившихся после 1990 года.
select last_name, first_name, birth_date 
from clients 
where birth_date > '1990-12-31';

-- найти все услуги, в названии которых встречается слово "тренировка" (без учета регистра).
SELECT service_id, name 
FROM services 
WHERE name ILIKE '%тренировка%';
