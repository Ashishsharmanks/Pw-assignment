Use mavenmovies;
-- 1- **Rank the customers based on the total amount they've spent on rentals.**
   Select customer_id,sum(amount),rank() over (order by sum(amount) desc) as cust_rank from payment group by customer_id;
   
-- 2- **Calculate the cumulative revenue generated by each film over time.**
Select film.film_id,title,rental_date,sum(amount) over (partition by rental_date) as cumulative_revenue from film inner join
inventory on inventory.film_id=film.film_id inner join rental on rental.inventory_id=inventory.inventory_id inner join payment
on payment.rental_id=rental.rental_id;

-- 3- **Determine the average rental duration for each film, considering films with similar lengths.**
Select film_id,title,avg(rental_duration) over (partition by length) as avg_rental_duration from film group by film_id;

-- 4- **Identify the top 3 films in each category based on their rental counts.**
With rental_count as
(Select title,film.film_id,category_id,count(rental_id) as rental_count, dense_rank() over(partition by category_id order by
count(rental_id)desc) as rank_by_count from film inner join film_category on film.film_id=film_category.film_id inner join inventory on
inventory.film_id=film.film_id inner join rental on rental.inventory_id=inventory.inventory_id group by film_id,category_id)
Select title, rental_count,rank_by_count,category_id from rental_count where rank_by_count in (1,2,3);

-- 5- **Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.**
With rental_count as
(Select customer_id,count(rental_id) as rental_count from rental group by customer_id),
avg_rental_count as
(Select customer_id,rental_count,avg(rental_count) over() as avg_rental_count from rental_count group by customer_id)
Select customer_id,rental_count,avg_rental_count, rental_count-avg_rental_count as rental_diff from avg_rental_count group by customer_id;

-- 6- **Find the monthly revenue trend for the entire rental store over time.**
Select store.store_id , monthname(rental_date) as month ,sum(amount) as revenue_trend from rental inner join 
payment on payment.rental_id=rental.rental_id inner join staff on staff.staff_id=payment.staff_id inner join
store on store.store_id=staff.store_id group by month,store.store_id;

-- 7- **Identify the customers whose total spending on rentals falls within the top 20% of all customers.**
With total_spend as
(Select customer_id, sum(amount) as total_spend, rank() over(order by sum(amount) desc) as customer_rank from payment group by customer_id)
Select customer_id,total_spend,customer_rank from total_spend where customer_rank<=(select count(customer_rank) from total_spend)*20/100;

-- 8- **Calculate the running total of rentals per category, ordered by rental count.**
Select category_id, count(rental.rental_id) as rental_count, sum(amount) from film_category inner join inventory on 
inventory.film_id=film_category.film_id inner join rental on rental.inventory_id=inventory.inventory_id inner join 
payment on payment.rental_id=rental.rental_id group by category_id order by rental_count desc;

-- 9- **Find the films that have been rented less than the average rental count for their respective categories.**
With rental_count as
(Select title,film.film_id,film_category.category_id, count(rental_id) as rental_count from film inner join film_category on film_category.film_id=film.film_id inner join inventory
on inventory.film_id=film_category.film_id inner join rental on rental.inventory_id=inventory.inventory_id group by film_id,category_id),
avg_rental_count as
(Select title,film_id,category_id,rental_count,avg(rental_count) over(partition by category_id) as avg_rental from rental_count group by film_id,category_id)
Select title from avg_rental_count where rental_count<avg_rental;

-- 10- **Identify the top 5 months with the highest revenue and display the revenue generated in each month.**
Select monthname(payment_date) as month, sum(amount) as revenue, rank() over(order by sum(amount)desc) as Revenue_rank from payment
group by month limit 5;
