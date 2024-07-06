Use mavenmovies;
-- 1- **Join Practice:**
-- Write a query to display the customer's first name, last name, email, and city they live in.
Select first_name,last_name,email,city from customer inner join address on address.address_id=customer.address_id 
inner join city on city.city_id=address.city_id;

-- 2- **Subquery Practice (Single Row):**
-- Retrieve the film title, description, and release year for the film that has the longest duration.
Select title,description,release_year from film where length in (select max(length) from film);

-- 3- **Join Practice (Multiple Joins):**
-- List the customer name, rental date, and film title for each rental made. Include customers who have never rented a film.
Select first_name,last_name,rental_date,title from customer as c left join rental as r on r.customer_id=c.customer_id 
left join inventory as i on i.inventory_id=r.inventory_id left join film as f on f.film_id=i.film_id;

-- 4- **Subquery Practice (Multiple Rows):**
-- Find the number of actors for each film. Display the film title and the number of actors for each film.
Select title, count(actor_id) as num_of_actor from film left join film_actor on film.film_id=film_actor.film_id group by film.film_id;

-- 5- **Join Practice (Using Aliases):**
-- Display the first name, last name, and email of customers along with the rental date, film title, and rental return date.
Select first_name,last_name,email,rental_date,title,return_date from customer as c inner join rental as r on r.customer_id=c.customer_id
inner join inventory as i on i.inventory_id=r.inventory_id inner join film as f on f.film_id=i.film_id;

-- 6- **Subquery Practice (Conditional):**
-- Retrieve the film titles that are rented by customers whose email domain ends with '.net'.
Select title from film where film_id in (select film_id from inventory where inventory_id in (select inventory_id from rental 
where customer_id in (Select customer_id from customer where email like ".net")));

-- 7- **Join Practice (Aggregation):**
-- Show the total number of rentals made by each customer, along with their first and last names.
Select count(rental_id) as num_of_rental, concat(first_name," ",last_name) as full_name from customer inner join
 rental on rental.customer_id=customer.customer_id group by full_name;

-- 8- **Subquery Practice (Aggregation):**
-- List the customers who have made more rentals than the average number of rentals made by all customers.
Select concat(first_name," ", last_name) as full_name from customer where customer_id in (Select customer_id from rental where 
rental_id>(select avg(rental_id) from rental));

-- 9- **Join Practice (Self Join):**
-- Display the customer first name, last name, and email along with the names of other customers living in the same city.
Select first_name,last_name,email,city from customer right join address on address.address_id=customer.address_id right join
city on city.city_id=address.city_id;

-- 10- **Subquery Practice (Correlated Subquery):**
-- Retrieve the film titles with a rental rate higher than the average rental rate of films in the same category.
Select title from film where rental_rate>(Select avg(rental_rate) from film where film_id in (Select film_id from film_category where category_id in
(Select min(category_id) from category)));

-- 11- **Subquery Practice (Nested Subquery):**
-- Retrieve the film titles along with their descriptions and lengths that have a rental rate greater than the 
-- average rental rate of films released in the same year.
Select title,description,length from film where rental_rate>(Select avg(rental_rate) from film where release_year=film.release_year);

-- 12- **Subquery Practice (IN Operator):**
-- List the first name, last name, and email of customers who have rented at least one film in the 'Documentary' category.
Select first_name,last_name,email from customer where customer_id in (Select customer_id from rental where inventory_id in
 (Select inventory_id from inventory where film_id in (Select film_id from film_category where category_id in
 (Select category_id from category where name="documentary"))));

-- 13- **Subquery Practice (Scalar Subquery):**
-- Show the title, rental rate, and difference from the average rental rate for each film. 
Select title,rental_rate, rental_rate-(Select avg(rental_rate) from film) as Diff_rental_rate from film group by film_id 
order by diff_rental_rate desc;

-- 14- **Subquery Practice (Existence Check):**
-- Retrieve the titles of films that have never been rented.
Select title from film where film_id not in (Select distinct film_id from inventory where film_id is not null);

-- 15- **Subquery Practice (Correlated Subquery - Multiple Conditions):**
-- List the titles of films whose rental rate is higher than the average rental rate of films released in the same 
-- year and belong to the 'Sci-Fi' category.
Select title from film where rental_rate>(Select avg(rental_rate) from film where release_year=film.release_year and film_id in
(Select film_id from film_category where category_id in (Select category_id from category where name="Sci-fi")));

-- 16- **Subquery Practice (Conditional Aggregation):**
-- Find the number of films rented by each customer, excluding customers who have rented fewer than five films.
Select customer_id,count(rental_id) as num_of_rental from rental group by customer_id having count(rental_id)>5;
