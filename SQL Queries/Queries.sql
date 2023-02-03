-- 1. BIG TABLE QUERY connects all tables together 
select title, c.name,length,rating,l.name as language, concat(a.first_name, ' ',a.last_name) as actor , description, store_id, customer_id, days_rented,rental_date,return_date
from inventory as i
left join film as f
on f.film_id = i.film_id
left join language as l
on l.language_id = f.language_id
left join old_hdd as h
on h.film_id = f.film_id
left join actor as a
on a.actor_id = h.actor_id
left join category as c
on c.category_id = h.category_id
left join rental as r
on r.inventory_id = i.inventory_id;


-- 2. TOP 5 MOST RENTED FILMS

select title, group_concat(distinct concat(a.first_name,' ', a.last_name)) as featuring,count(rental_id) as times_rented,sum(days_rented) as days_rented, c.name as category from
film as f 
left join old_hdd as h 
on f.film_id = h.film_id
left join actor as a
on a.actor_id = h.actor_id
left join category as c
on c.category_id = h.category_id
left join inventory as i
on i.film_id = f.film_id 
left join rental as r
on r.inventory_id=i.inventory_id

group by f.title, c.name
order by days_rented desc
limit 5;


-- 3. MOST POPULAR CATEGORIES

select c.name as category, count(title) as titles, sum(days_rented) as days_rented, count(rental_id) as times_rented

from category as c

left join old_hdd as h
on c.category_id = h.category_id
left join film as f
on f.film_id = h.film_id
left join actor as a
on a.actor_id = h.actor_id

left join inventory as i
on i.film_id = f.film_id 
left join rental as r
on r.inventory_id=i.inventory_id

group by c.name

order by titles desc;


-- 4. PROFIT PER TITLE

select title, times_rented*rental_rate as profit_generated
from 
(select f.film_id,count(rental_id) as times_rented

from film as f

left join inventory as i
on i.film_id = f.film_id 
left join rental as r
on r.inventory_id=i.inventory_id

group by f.film_id) as counts

left join

(select f.title,f.film_id,f.rental_rate

from film as f 
left join old_hdd as h 
on f.film_id = h.film_id
left join actor as a
on a.actor_id = h.actor_id
left join category as c
on c.category_id = h.category_id
left join inventory as i
on i.film_id = f.film_id 
left join rental as r
on r.inventory_id=i.inventory_id

group by f.title, f.film_id,f.rental_rate) as rates

on rates.film_id = counts.film_id

order by profit_generated desc


-- 5. STORE ACTIVITY AND STOCK

select store_id, count(rental_id) as rental_amount, count(f.title) as stock

from inventory as i

left join film as f
on f.film_id = i.film_id
left join rental as r
on r.inventory_id = i.inventory_id

group by store_id



-- 6. PROFIT PER ACTOR 

select concat(first_name,' ',last_name) as full_name, sum(profit_generated) as profit_by_actor, sum(profit_generated)/times_rented as profit_by_actor_per_rent
from actor as a
left join old_hdd as h
on a.actor_id = h.actor_id
left join film as f
on f.film_id = h.film_id

left join
(select title, times_rented*rental_rate as profit_generated,times_rented
from 
(select f.film_id,count(rental_id) as times_rented

from film as f

left join inventory as i
on i.film_id = f.film_id 
left join rental as r
on r.inventory_id=i.inventory_id

group by f.film_id) as counts

left join

(select f.title,f.film_id,f.rental_rate

from film as f 
left join old_hdd as h 
on f.film_id = h.film_id
left join actor as a
on a.actor_id = h.actor_id
left join category as c
on c.category_id = h.category_id
left join inventory as i
on i.film_id = f.film_id 
left join rental as r
on r.inventory_id=i.inventory_id

group by f.title, f.film_id,f.rental_rate) as rates

on rates.film_id = counts.film_id) as profit

on profit.title = f.title

group by full_name, times_rented

order by profit_by_actor desc

-- 7. RENTAL FREQUENCY AND MONEY SPENT PER CUSTOMER

select r.customer_id, count(r.customer_id) as frequency,money_spent as spent

from rental as r
left join inventory as i
on i.inventory_id = r.inventory_id
left join film as f
on f.film_id = i.film_id

left join 

(select customer_id ,sum(rental_rate) as money_spent

from film as f

left join inventory as i
on i.film_id = f.film_id
left join rental as r
on i.inventory_id = r.inventory_id

where customer_id is not null
group by customer_id
order by money_spent desc) as spent

 on spent.customer_id = r.customer_id
 
 group by r.customer_id, money_spent
 order by spent desc


 -- 8. PREFERRED CATEGORY PER STAFF

 select  staff_id as staff, c.name as category,count(rental_id) as rentals

from rental as r
left join inventory as i
on i.inventory_id = r.inventory_id
left join old_hdd as h
on h.film_id = i.film_id
left join category as c
on c.category_id = h.category_id
where c.name is not null
group by staff, c.name
order by staff_id,rentals desc
