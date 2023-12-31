

/*Finding the average amount paid by the top 5 customers. (Using a sub-query)*/

  
    SELECT AVG(total_paid)
    FROM (SELECT PAY.customer_id, first_name, last_name, city, country, SUM(amount) AS total_paid
    FROM payment PAY
    INNER JOIN customer CUST ON PAY.customer_id = CUST.customer_id
    INNER JOIN address ADDR ON CUST.address_id = ADDR.address_id
    INNER JOIN city CITY ON ADDR.city_id = CITY.city_id
    INNER JOIN country CTRY ON CITY.country_id = CTRY.country_id
    WHERE city in (SELECT city FROM top_10_cities)
    GROUP BY PAY.customer_id, first_name, last_name, city, country
    ORDER BY SUM(amount) DESC
    LIMIT 5) AS average

/*Finding out how many of the top 5 customers are based within each country. (Using a CTE)*/

  
    WITH top5 AS (SELECT ctry.country, ctry.count_of_customers AS all_customer_count,
    COUNT(cust.country) AS top_customer_count
    FROM top_10_country ctry LEFT JOIN top_5_customers cust
    ON ctry.country = cust.country
    GROUP BY ctry.country, ctry.count_of_customers
    ORDER BY count_of_customers DESC
    LIMIT 5)
    SELECT * FROM top5
