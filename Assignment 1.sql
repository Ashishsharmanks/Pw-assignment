use mavenmovies;

-- Q1-- Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
show tables;
describe actor; -- actor_id is primary key and last_name is foreign key.
describe actor_award; -- actor_award_id is primary key and last_name is foreign key.
describe actor_info; -- No primary key or foreign key.
describe address; -- address_id is primary key and city_id is foreign key.
describe advisor; -- advisor_id is primary key and there is no foreign key.
describe category; -- category_id is primary key and there is no foreign key.
describe city; -- city_id is primary key and country_id is foreign key.
describe country; -- country_id is primary key and there is no foreign key.
describe customer; -- customer_id is primary key and store_id,last_name,address_id is foreign key.
describe customer_list; -- No primary key or foreign key.
describe film; -- film_id is primary key and title,language_id,original_language_id is foreign key.
describe film_actor; -- actor_id,film_id is primary key and there is no foreign key.
describe film_category; -- film_id,category_id is primary key and there is no foreign key.
describe film_list; -- No primary key or foreign key.
describe film_text; -- film_id is primary key and title is foreign key.
describe inventory; -- inventory_id is primary key and film_id,store_id is foreign key.
describe investor; -- investor_id is primary key and there is no foreign key.
describe language; -- language_id is primary key and there is no foreign key.
describe payment; -- payment_id is primary key and customer_id,staff_id,rental_id is foreign key.
describe rental; -- rental_id is primary key and rental_date,inventory_id,customer_id, staff_id is foreign key.
describe sales_by_film_category; -- No primary key or foreign key.
describe sales_by_store; -- No primary key or foreign key.
describe staff; -- staff_id is primary key and address_id,store_id is foreign key.
describe staff_list; -- No primary key or foreign key.
describe store; -- store_id is primary key and address_id is foreign key.

-- primary key is a unique key which is only one in a table.
-- foreign key is a key which can be primary key in other table which is used to create refrences between two tables, foreign key can be multiple in a table.

-- Q2-- List all details of actors.
select * from actor;

-- Q3-- List all customer information from DB. 
select * from customer;

-- Q4-- List different countries. 
select country from country;

-- Q5-- Display all active customers.
select * from customer where active=1;
 
-- Q6-- List of all rental IDs for customer with ID 1. 
select rental_id,customer_id from rental where customer_id=1;

-- Q7-- Display all the films whose rental duration is greater than 5 .
select title,rental_duration from film where rental_duration>5;
 
-- Q8-- List the total number of films whose replacement cost is greater than $15 and less than $20. 
select title,replacement_cost from film where replacement_cost between 15 and 20;

-- Q9-- Display the count of unique first names of actors. 
select count(distinct first_name) from actor;

-- Q10-- Display the first 10 records from the customer table . 
select * from customer limit 10;

-- Q11-- Display the first 3 records from the customer table whose first name starts with ‘b’. 
select * from customer where first_name like "b%" limit 3;

-- Q12-- Display the names of the first 5 movies which are rated as ‘G’. 
select title, rating from film where rating="g" limit 5;

-- Q13-- Find all customers whose first name starts with "a". 
select first_name,last_name from Customer where first_name like "a%";

-- Q14-- Find all customers whose first name ends with "a". 
select first_name,last_name from customer where first_name like "%a";

-- Q15-- Display the list of first 4 cities which start and end with ‘a’ . 
select * from city where city like "a%a" limit 4;

-- Q16-- Find all customers whose first name have "NI" in any position. 
select first_name,last_name from customer where first_name like "%NI%";

-- Q17-- Find all customers whose first name have "r" in the second position .
select first_name,last_name from customer where first_name like "_r%";

-- Q18-- Find all customers whose first name starts with "a" and are at least 5 characters in length. 
select first_name,last_name from customer where first_name like "a____";

-- Q19-- Find all customers whose first name starts with "a" and ends with "o". 
select first_name,last_name from customer where first_name like "a%o";

-- Q20-- Get the films with pg and pg-13 rating using IN operator. 
select title,rating from film where rating in ("PG","PG-13");

-- Q21-- Get the films with length between 50 to 100 using between operator. 
select title, length from film where length between 50 and 100;

-- Q22-- Get the top 50 actors using limit operator. 
select * from actor order by actor_id limit 50;

-- Q23-- Get the distinct film ids from inventory table.
select distinct film_id from inventory;