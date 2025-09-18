# Aircargo-Analysis-with-SQL
SQL project for managing and analyzing Flight, Passenger, and Ticket data in an air cargo system.

# ✈️ AirCargo SQL Project

This project demonstrates a complete SQL-based solution for managing and analyzing data in an air cargo system. It includes everything from raw data and queries to advanced features like views, stored procedures, and index optimization.

## 📂 Project Structure

- `schema/`: Contains SQL scripts for database and table creation.
- `queries/`: Includes business-related SQL queries (e.g., revenue, passenger analysis).
- `procedures/`: Stored procedures for reusable logic.
- `views/`: SQL views for simplified data retrieval.
- `index_optimization/`: Indexing and query performance examples.

## 💡 Features

- Complex JOINs and subqueries
- EER Diagram
- Aggregation using `GROUP BY`, `ROLLUP`, and window functions
- Views and stored procedures
- Index creation and analysis with `EXPLAIN`
- Revenue analysis and customer insights

## 🛠 Technologies Used

- MySQL 8.x
- SQL (Standard & MySQL-specific)
- MySQL Workbench (for development)

## 🔍 Sample Queries

### 📊 Average Number of Passengers per Flight Route

```sql
SELECT
    route_id,
    ROUND(AVG(passenger_count), 2) AS Avg_Passengers
FROM (
    SELECT
        r.flight_num,
        r.route_id,
        COUNT(p.customer_id) AS passenger_count
    FROM routes r
    INNER JOIN passengers_on_flights p
        ON r.route_id = p.route_id
    GROUP BY r.route_id, r.flight_num
) AS route_details
GROUP BY route_id;


📌 Create a stored procedure to fetch long routes:
DELIMITER //

CREATE PROCEDURE routes_more_than_2000()
BEGIN
    SELECT * FROM routes
    WHERE distance_miles > 2000;
END //

DELIMITER ;


🏁 How to Use

1. Clone the repo
2. Run the schema SQL files to create tables
3. Load sample data
4. Execute the queries from queries
5. Use MySQL Workbench to view the EER diagram


👨‍💻 Author
Mohit Sharma
Email:mohit20195@gmail.com

