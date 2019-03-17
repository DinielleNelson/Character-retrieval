USE sakila;

-- * 1a. Display the first and last names of all actors from the table `actor`.
SELECT first_name, last_name FROM actor;

-- * 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS "Actor Name" FROM actor;

-- * 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

-- * 2b. Find all actors whose last name contain the letters `GEN`:
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE '%GEN%';

-- * 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- * 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- * 3a. create a column in the table `actor` named `description` and use the data type `BLOB` 
ALTER TABLE actor
ADD COLUMN description BLOB;

-- * 3b. Delete the `description` column.
ALTER TABLE actor
DROP COLUMN description;

-- * 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name;

-- * 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name
HAVING COUNT(*) >=2;

-- * 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE actor
SET first_name='HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

-- * 4d. In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
UPDATE actor
SET first_name='GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

-- * 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT first_name, last_name, address.address FROM STAFF
INNER JOIN address
USING (address_id);

-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT first_name, last_name, SUM(payment.amount) AS 'Total rung up' FROM staff
INNER JOIN payment
USING (staff_id)
GROUP BY staff_id;

-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT first_name, last_name, SUM(payment.amount) AS 'Total rung up' FROM staff
INNER JOIN payment
USING (staff_id)
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 08
GROUP BY staff_id;

-- * 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
SELECT title, COUNT(film_actor.actor_id) AS 'No. of Films' FROM film
INNER JOIN film_actor
USING (film_id)
GROUP BY title;

-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT COUNT(*) AS 'No. of Copies' FROM inventory
WHERE film_id IN (
	SELECT film_id FROM film
    WHERE title = 'Hunchback Impossible')
;

-- * 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT first_name, last_name, SUM(amount) AS 'Total Paid' FROM customer
INNER JOIN payment USING (customer_id)
GROUP BY customer_id
ORDER BY last_name;

-- * 7a. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
SELECT title FROM film
WHERE title LIKE 'K%' OR 'Q%' AND language_id IN (
	SELECT language_id FROM language
    WHERE name = "English")
;

/*
* 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.

* 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

* 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.

* 7e. Display the most frequently rented movies in descending order.

* 7f. Write a query to display how much business, in dollars, each store brought in.

* 7g. Write a query to display for each store its store ID, city, and country.

* 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

* 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

* 8b. How would you display the view that you created in 8a?

* 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

## Appendix: List of Tables in the Sakila DB

* A schema is also available as `sakila_schema.svg`. Open it with a browser to view.

```sql
'actor'
'actor_info'
'address'
'category'
'city'
'country'
'customer'
'customer_list'
'film'
'film_actor'
'film_category'
'film_list'
'film_text'
'inventory'
'language'
'nicer_but_slower_film_list'
'payment'
'rental'
'sales_by_film_category'
'sales_by_store'
'staff'
'staff_list'
'store'
```

## Uploading Homework

* To submit this homework using BootCampSpot:

  * Create a GitHub repository.
  * Upload your .sql file with the completed queries.
  * Submit a link to your GitHub repo through BootCampSpot.
*/