CREATE DATABASE aircargo;

USE aircargo;



#3. Write a query to display all the passengers who have traveled on routes 01 to 25 from the passengers_on_flights table.
SELECT 
*
FROM passengers_on_flights
WHERE route_id BETWEEN 01 AND 25;



#4. Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.
SELECT 
	customer_id,
    COUNT(customer_id) AS 'No. of Passengers',
    SUM(no_of_tickets * Price_per_ticket) AS 'Total Revenue'
FROM ticket_details
WHERE class_id = "business"
GROUP BY customer_id;



#5. Write a query to display the full name of the customer by extracting the first name and last name from the customer table.
SELECT 
	CONCAT(first_name," ",last_name) AS Name
FROM customer;



#6. Write a query to extract the customers who have registered and booked a ticket from the customer and ticket_details tables.
SELECT
	c.customer_id,
	c.first_name,
    c.last_name,
    t.aircraft_id,
    t.class_id,
    t.brand
FROM customer c
INNER JOIN ticket_details t
ON c.customer_id=t.customer_id;



#7. Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) from the ticket_details table.
SELECT
	c. customer_id,
    c.first_name,
    c.last_name,
    t.brand
FROM customer c
INNER JOIN ticket_details t
ON c.customer_id = t.customer_id
WHERE brand = "Emirates";




#8. Write a query to identify the customers who have traveled by Economy Plus class using the sub-query on the passengers_on_flights table. 
SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    p.aircraft_id,
    p.class_id,
    p.flight_num
FROM customer c
INNER JOIN passengers_on_flights p
ON c.customer_id = p.customer_id
WHERE p.class_id = "Economy Plus";




#9. Write a query to determine whether the revenue has crossed 10000 using the IF clause on the ticket_details table. 
SELECT 
    IF(SUM(no_of_tickets * price_per_ticket) > 10000, 
       'Revenue has crossed 10000', 
       'Revenue is 10000 or below') AS Revenue_Status
FROM ticket_details;




#10. Write a query to create and grant access to a new user to perform database operations.
CREATE USER 'mohit'@'localhost' IDENTIFIED BY 'Kailash@10';

GRANT ALL PRIVILEGES ON bajaj TO 'mohit'@'localhost';

FLUSH PRIVILEGES;




#11. Write a query to find the maximum ticket price for each class using window functions on the ticket_details table.
SELECT 
	DISTINCT class_id,
	MAX(price_per_ticket) OVER(PARTITION BY class_id) AS "Classwise Max Price"
FROM ticket_details;




#12. Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table using the index.
CREATE INDEX route4_passengers 
ON passengers_on_flights(route_id);
    
SELECT 
	*
FROM passengers_on_flights
WHERE route_id=4;

EXPLAIN SELECT 
	*
FROM passengers_on_flights
WHERE route_id = 4;

DROP INDEX route4_passengers 
ON passengers_on_flights;



#13. For route ID 4, write a query to view the execution plan of the passengers_on_flights table.
SELECT 
	*
FROM passengers_on_flights
WHERE route_id=4;




#14. Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using the rollup function. 
SELECT 
	IFNULL(customer_id,"Grand Total") AS Customer,
    IFNULL(aircraft_id,"Subtotal") AS Aircraft_ID,
    SUM(price_per_ticket) AS Total_Revenue
FROM ticket_details
GROUP BY customer_id,aircraft_id
WITH ROLLUP;




#15. Write a query to create a view with only business class customers and the airline brand.
CREATE VIEW v_ticket_details 
	AS
		SELECT
			customer_id,
			class_id,
			brand
		FROM ticket_details
		WHERE class_id="Business";
        
SELECT * FROM v_ticket_details;





#16. Write a query to create a stored procedure that extracts all the details from the routes table where the traveled distance is more than 2000 miles.
DELIMITER //

CREATE PROCEDURE routes_more_than_2000()
BEGIN
	SELECT * FROM routes
	WHERE distance_miles > 2000;
END //

DELIMITER ;

call routes_more_than_2000();





#17. Using GROUP BY, determine the total number of tickets purchased by each customer and the total price paid. 
SELECT
	customer_id,
    SUM(no_of_tickets) AS Ticket_Purchased,
    SUM(no_of_tickets * price_per_ticket) AS Total_Price_Paid
FROM ticket_details
GROUP BY customer_id;



#18. Calculate the average number of passengers per flight route. 
SELECT
	route_id,
    ROUND(AVG(passenger_count),2) AS Avg_Passengers
FROM (SELECT
			r.flight_num,
            r.route_id,
            COUNT(p.customer_id) AS passenger_count
	  FROM routes r
      INNER JOIN passengers_on_flights p
      ON r.route_id = p.route_id
      GROUP BY r.route_id,r.flight_num) AS route_details
GROUP BY route_id;