use mavenmovies;

-- Basic Aggregate Functions: 

-- Q1 Retrieve the total number of rentals made in the Sakila database.
Select count(distinct rental_id) as num_of_rental from rental;

-- Q2 Find the average rental duration (in days) of movies rented from the Sakila database.
select avg(rental_duration) from film;

-- String Functions: 

-- Q3 Display the first name and last name of customers in uppercase. 
select upper(first_name),upper(last_name) from customer;

-- Q4 Extract the month from the rental date and display it alongside the rental ID. 
select rental_id, month(rental_date) from rental;

-- GROUP BY:

-- Q5 Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 
select customer_id, count(rental_id) from rental group by customer_id;

-- Q6 Find the total revenue generated by each store. 
Select sum(amount) as total_revenue, store_id from payment inner join staff on staff.staff_id=payment.staff_id group by store_id;

-- Joins:

-- Q7 Display the title of the movie, customer s first name, and last name who rented it. 
select title, first_name,last_name from film inner join inventory on film.film_id=inventory.film_id inner join rental on rental.inventory_id=inventory.inventory_id inner join customer on customer.customer_id=rental.customer_id;

-- Q8 Retrieve the names of all actors who have appeared in the film "Gone trouble." 
select title,concat(first_name," ",last_name) as name from film inner join film_actor on film.film_id=film_actor.film_id inner join actor on actor.actor_id=film_actor.actor_id where title="gone trouble";

-- GROUP BY: 

-- Q1 Determine the total number of rentals for each category of movies. 
select  name,count(rental_id) as count_of_rental from film_category inner join film on film_category.film_id=film.film_id inner join inventory on inventory.film_id=film.film_id inner join rental on rental.inventory_id=inventory.inventory_id inner join category on category.category_id=film_category.category_id group by name;

-- Q2 Find the average rental rate of movies in each language. 
select name, avg(rental_rate) as avg_rate from film inner join language on language.language_id=film.language_id group by name;

-- Joins:

-- Q3 Retrieve the customer names along with the total amount they've spent on rentals. 
select concat(first_name," ",last_name) as full_name, sum(amount) from customer inner join rental on rental.customer_id=customer.customer_id inner join payment on payment.rental_id=rental.rental_id group by full_name;

-- Q4 List the titles of movies rented by each customer in a particular city (e.g., 'London'). 
select title,concat(first_name," ",last_name) as full_name, city from film inner join inventory on inventory.film_id=film.film_id inner join rental on rental.inventory_id=inventory.inventory_id inner join customer on customer.customer_id=rental.customer_id inner join address on address.address_id=customer.address_id inner join city on city.city_id=address.city_id where city="london" group by rental_id;

-- Advanced Joins and GROUP BY:

-- Q5 Display the top 5 rented movies along with the number of times they've been rented. 
select title,count(rental_id) as count_of_rental from film inner join inventory on inventory.film_id=film.film_id inner join rental on rental.inventory_id=inventory.inventory_id group by title order by count_of_rental desc limit 5;

-- Q6 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 
select c.customer_id, c.first_name,c.last_name from customer c inner join rental on rental.customer_id=c.customer_id inner join inventory on inventory.inventory_id=rental.inventory_id inner join store s on s.store_id=inventory.store_id where s.store_id in (1,2) group by c.customer_id,c.first_name,c.last_name having count(distinct s.store_id)=2;
