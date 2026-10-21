-- вывести ФИО клиентов и названия купленных ими абонементов (виды тренировок)
select c.last_name, c.first_name, tt.name as training_type
from clients c
join membership_sales ms on c.client_id = ms.client_id 
join memberships m on ms.membership_id = m.membership_id 
join training_types tt on m.training_type_id = tt.training_type_id;

--  вывести расписание занятий с указанием ФИО тренера и вида тренировки
select s.class_date, s.start_time, s.end_time, st.last_name || st.first_name || st.middle_name as trainer_name, tt.name as training_type
from schedule s 
join staff st on s.staff_id = st.staff_id 
join training_types tt on s.training_type_id = tt.training_type_id
order by s.class_date, s.start_time;

-- показать, кто из клиентов и на какое занятие пришел (время посещения и название тренировки)
select c.last_name, c.first_name, c.middle_name, sch.class_date, sch.start_time, a.visit_datetime, tt.name
from attendance a 
join membership_sales ms on ms.sale_id = a.sale_id 
join clients c on c.client_id = ms.client_id 
join schedule sch on sch.schedule_id = a.schedule_id 
join training_types tt on tt.training_type_id = sch.training_type_id;

-- вывести список всех клиентов и сумму, которую они потратили на товары
select c.last_name, c.first_name, c.middle_name, SUM(ps.quantity*p.price) as total_price
from clients c
join product_sales ps on ps.client_id = c.client_id 
join products p on p.product_id = ps.product_id
group by c.client_id;

-- найти тренеров, у которых нет запланированных занятий в расписании
select st.last_name, st.first_name
from staff st
left join schedule s on s.staff_id = st.staff_id 
where s.schedule_id is null;