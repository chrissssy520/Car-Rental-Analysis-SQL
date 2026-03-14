
-- CAR RENTAL SQL ANALYSIS  by Christian Kho Aler
    
-- Top 10 profitable vehicle

WITH rank_car AS (
SELECT 	
    c.make,
    c.model,
    SUM(r.total_amount) as total_profit,
    DENSE_RANK() OVER(ORDER BY SUM(r.total_amount)  DESC) as rnk
    FROM cars c JOIN rentals r ON r.car_id = c.car_id
    WHERE r.payment_status = "Paid"
    GROUP BY c.make,c.model
    )
    
SELECT * FROM rank_car 
	WHERE rnk <= 10;

-- Top 10 least profitable vehicle

WITH rank_car AS (
SELECT 	
    c.make,
    c.model,
    SUM(r.total_amount) as total_profit,
    DENSE_RANK() OVER(ORDER BY SUM(r.total_amount) ASC  ) as rnk
    FROM cars c JOIN rentals r ON r.car_id = c.car_id
    WHERE r.payment_status = "Paid"
    GROUP BY c.make,c.model
    )
    
SELECT * FROM rank_car 
	WHERE rnk <= 10;
    
-- Most Rented Vehicle

WITH rank_car AS (
SELECT 	
    c.make,
    c.model,
    COUNT(*) as total_rent,
    DENSE_RANK() OVER(ORDER BY COUNT(*)  DESC) as rnk
    FROM cars c JOIN rentals r ON r.car_id = c.car_id
        WHERE r.payment_status = "Paid"
    GROUP BY c.make,c.model
    )

SELECT * FROM rank_car 
	WHERE rnk <= 10;
    
-- Vehicle type Total Rent
SELECT 
	c.vehicle_type,
    COUNT(*) as total_type
    FROM cars c JOIN rentals r ON c.car_id = r.car_id
    GROUP BY c.vehicle_type;

-- Average rental days per vehicle

SELECT 
	c.make,
    c.model,
    ROUND(AVG(rental_days),2) as avg_rental_days
    FROM cars c JOIN rentals r ON c.car_id = r.car_id
    GROUP BY c.make,c.model
    ORDER BY avg_rental_days DESC;
    
-- Customers who rent multiple times

SELECT 
	customer_name,
    COUNT(*) as total_rent
    FROM rentals
    GROUP BY customer_name
    HAVING total_rent > 1
    ORDER BY total_rent DESC;

-- Customers per city

SELECT 
	customer_city,
    COUNT(*) as total_city
    FROM rentals 
    GROUP BY customer_city
    ORDER BY total_city DESC;
    
-- Payment Status Breakdown

SELECT 
	payment_status,
    COUNT(*) as total_status
    FROM rentals
    GROUP BY payment_status
    ORDER BY total_status DESC;
    
-- Color preference per model by customers with percentage rate

SELECT 
	c.make,
	c.model,
    c.color,
    COUNT(color) as total_colors,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rentals r),2) as percent_rate
	FROM cars c JOIN rentals r ON c.car_id = r.car_id
    GROUP BY c.make,c.model,c.color
    ORDER BY total_colors DESC;
    
-- Top 3 Color preference with percentage rate

SELECT 
	c.color,
    COUNT(*) as total_color,
    ROUND(COUNT(*)  * 100.0 / (SELECT COUNT(*) FROM rentals r),2) as percentage_rate
    FROM cars c JOIN rentals r ON c.car_id = r.car_id
    GROUP BY c.color
    ORDER BY total_color DESC LIMIT 3;
    
-- Year/Monthly Profit


SELECT
	YEAR(end_date) as year_profit,
	MONTH(end_date) as monthly_profit,
    SUM(total_amount) as total_profit
    FROM rentals
	WHERE payment_status = "Paid"
    GROUP BY year_profit,monthly_profit
    ORDER BY year_profit asc;
    
-- Total profit per year

SELECT
        YEAR(end_date) AS year_profit,
        SUM(total_amount) AS total_profit
    FROM rentals
	WHERE payment_status = "Paid"
    GROUP BY YEAR(end_date);

    
-- Profit - Running total per year

SELECT
    YEAR(end_date) AS year_profit,
    MONTH(end_date) AS monthly_profit,
    SUM(total_amount) AS monthly_total,
    SUM(SUM(total_amount)) OVER (
        PARTITION BY YEAR(end_date) 
        ORDER BY MONTH(end_date)
    ) AS running_total
FROM rentals
WHERE payment_status = "Paid"
GROUP BY year_profit, monthly_profit
ORDER BY year_profit, monthly_profit;
    
    