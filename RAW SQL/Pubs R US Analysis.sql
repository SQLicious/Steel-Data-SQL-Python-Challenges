
USE STEEL_DATA;
CREATE TABLE pubs (
pub_id INT PRIMARY KEY,
pub_name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50)
);

-- Create the 'beverages' table
CREATE TABLE beverages (
beverage_id INT PRIMARY KEY,
beverage_name VARCHAR(50),
category VARCHAR(50),
alcohol_content FLOAT,
price_per_unit DECIMAL(8, 2)
);

-- Create the 'sales' table
CREATE TABLE sales (
sale_id INT PRIMARY KEY,
pub_id INT,
beverage_id INT,
quantity INT,
transaction_date DATE,
FOREIGN KEY (pub_id) REFERENCES pubs(pub_id),
FOREIGN KEY (beverage_id) REFERENCES beverages(beverage_id)
);

-- Create the 'ratings' table 
CREATE TABLE ratings (
    rating_id INT PRIMARY KEY,
    pub_id INT,
    customer_name VARCHAR(50),
    rating FLOAT,
    review TEXT,
    FOREIGN KEY (pub_id)
        REFERENCES pubs (pub_id)
);
--------------------
-- Insert sample data into the 'pubs' table
INSERT INTO pubs (pub_id, pub_name, city, state, country)
VALUES
(1, 'The Red Lion', 'London', 'England', 'United Kingdom'),
(2, 'The Dubliner', 'Dublin', 'Dublin', 'Ireland'),
(3, 'The Cheers Bar', 'Boston', 'Massachusetts', 'United States'),
(4, 'La Cerveceria', 'Barcelona', 'Catalonia', 'Spain');

-- Insert sample data into the 'beverages' table
INSERT INTO beverages (beverage_id, beverage_name, category, alcohol_content, price_per_unit)
VALUES
(1, 'Guinness', 'Beer', 4.2, 5.99),
(2, 'Jameson', 'Whiskey', 40.0, 29.99),
(3, 'Mojito', 'Cocktail', 12.0, 8.99),
(4, 'Chardonnay', 'Wine', 13.5, 12.99),
(5, 'IPA', 'Beer', 6.8, 4.99),
(6, 'Tequila', 'Spirit', 38.0, 24.99);

INSERT INTO sales (sale_id, pub_id, beverage_id, quantity, transaction_date)
VALUES
(1, 1, 1, 10, '2023-05-01'),
(2, 1, 2, 5, '2023-05-01'),
(3, 2, 1, 8, '2023-05-01'),
(4, 3, 3, 12, '2023-05-02'),
(5, 4, 4, 3, '2023-05-02'),
(6, 4, 6, 6, '2023-05-03'),
(7, 2, 3, 6, '2023-05-03'),
(8, 3, 1, 15, '2023-05-03'),
(9, 3, 4, 7, '2023-05-03'),
(10, 4, 1, 10, '2023-05-04'),
(11, 1, 3, 5, '2023-05-06'),
(12, 2, 2, 3, '2023-05-09'),
(13, 2, 5, 9, '2023-05-09'),
(14, 3, 6, 4, '2023-05-09'),
(15, 4, 3, 7, '2023-05-09'),
(16, 4, 4, 2, '2023-05-09'),
(17, 1, 4, 6, '2023-05-11'),
(18, 1, 6, 8, '2023-05-11'),
(19, 2, 1, 12, '2023-05-12'),
(20, 3, 5, 5, '2023-05-13');

-- Insert sample data into the 'ratings' table
INSERT INTO ratings (rating_id, pub_id, customer_name, rating, review)
VALUES
(1, 1, 'John Smith', 4.5, 'Great pub with a wide selection of beers.'),
(2, 1, 'Emma Johnson', 4.8, 'Excellent service and cozy atmosphere.'),
(3, 2, 'Michael Brown', 4.2, 'Authentic atmosphere and great beers.'),
(4, 3, 'Sophia Davis', 4.6, 'The cocktails were amazing! Will definitely come back.'),
(5, 4, 'Oliver Wilson', 4.9, 'The wine selection here is outstanding.'),
(6, 4, 'Isabella Moore', 4.3, 'Had a great time trying different spirits.'),
(7, 1, 'Sophia Davis', 4.7, 'Loved the pub food! Great ambiance.'),
(8, 2, 'Ethan Johnson', 4.5, 'A good place to hang out with friends.'),
(9, 2, 'Olivia Taylor', 4.1, 'The whiskey tasting experience was fantastic.'),
(10, 3, 'William Miller', 4.4, 'Friendly staff and live music on weekends.');

-- 1. How many pubs are located in each country?

SELECT country,
       COUNT(*) as num_pubs
FROM pubs
GROUP BY country;

/* Insight: Pubs Distribution by Country:
United Kingdom, Ireland, United States, and Spain each have 1 pub.
*/

-- 2. What is the total sales amount for each pub, including the beverage price and quantity sold?
SELECT p.pub_id,
       p.pub_name, p.city,
       SUM(s.quantity * b.price_per_unit) as total_sales_amount
FROM pubs p
JOIN sales s ON p.pub_id = s.pub_id
JOIN beverages b ON s.beverage_id = b.beverage_id
GROUP BY p.pub_id, p.pub_name, p.city;

/* Total Sales Amount by Pub:

The Red Lion in London, England has the highest total sales amount(532.66).
La Cerveceria in Barcelona, Spain has the lowest total sales amount (308.62).
*/

-- 3. Which pub has the highest average rating?
SELECT p.pub_id, p.pub_name, p.city, 
       ROUND(AVG(r.rating),2) as avg_rating
FROM pubs p
JOIN ratings r ON p.pub_id = r.pub_id
GROUP BY p.pub_id, p.pub_name
ORDER BY avg_rating DESC
LIMIT 1;

/* Pub with Highest Average Rating: The Red Lion Pub in London,UK */

-- 4. What are the top 5 beverages by sales quantity across all pubs?
SELECT b.beverage_name,
       b.category,
       SUM(s.quantity) as total_quantity_sold
FROM sales s
JOIN beverages b ON s.beverage_id = b.beverage_id
GROUP BY b.beverage_name, b.category
ORDER BY total_quantity_sold DESC
LIMIT 5;
/* Insight : The top-selling beverages by sales quantity are: Guinness, Mojito, Tequila, Chardonnay, and IPA. */

-- 5. How many sales transactions occurred on each date?
SELECT transaction_date,
	   COUNT(*) as num_transactions
FROM sales
GROUP BY transaction_date;

-- 6. Find the name of someone that had cocktails and which pub they had it in.
SELECT r.customer_name, p.pub_name
FROM ratings r
JOIN pubs p ON r.pub_id = p.pub_id
JOIN sales s ON p.pub_id = s.pub_id
JOIN beverages b ON s.beverage_id = b.beverage_id
WHERE b.category = 'Cocktail'
LIMIT 1;

-- 7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
SELECT category,
      ROUND( AVG(price_per_unit),2) as avg_price_per_unit
FROM beverages
WHERE category != 'Spirit'
GROUP BY category;

/* Result : Whiskey has the highest average price per unit, followed by Wines an cocktails. */

-- 8. Which pubs have a rating higher than the average rating of all pubs?

SELECT p.pub_id,
       p.pub_name,
       p.city,
       ROUND(AVG(r.rating),2) as avg_rating
FROM pubs p
JOIN ratings r ON p.pub_id = r.pub_id
GROUP BY p.pub_id, p.pub_name, p.city, p.state, p.country
HAVING AVG(r.rating) > (SELECT AVG(rating) FROM ratings);

-- The Red Lion in London, La Cerveceria in Barcelona have ratings higher than the average(4.5).

-- 9. What is the running total of sales amount for each pub, ordered by the transaction date?
SELECT p.pub_id, p.pub_name, p.city, p.state, p.country,
       s.transaction_date, 
       SUM(b.price_per_unit * s.quantity) 
       OVER (PARTITION BY p.pub_id ORDER BY s.transaction_date) as running_total
FROM pubs p
JOIN sales s ON p.pub_id = s.pub_id
JOIN beverages b ON s.beverage_id = b.beverage_id
ORDER BY p.pub_id, s.transaction_date;

/*  10. For each country, what is the average price per unit of beverages 
in each category, and what is the overall average price per unit of beverages across all categories? */

SELECT 
    b.beverage_name AS Beverage_Name,
    p.country AS Country, 
    b.category AS Category,
    ROUND(AVG(b.price_per_unit), 2) AS Avg_Price,
    ROUND((SELECT AVG(price_per_unit) FROM beverages), 2) AS Overall_Average_Price_Per_Unit
FROM pubs AS p
LEFT JOIN sales AS s
    ON s.pub_id = p.pub_id
LEFT JOIN beverages AS b
    ON b.beverage_id = s.beverage_id
GROUP BY Beverage_Name, Country, Category;


/*  11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount,
 and what is the pub's overall sales amount? */
 WITH PubCategorySales AS (
    SELECT 
        p.pub_id,
        p.pub_name, 
        b.category,
        SUM(b.price_per_unit * s.quantity) as total_category_sales
    FROM pubs p
    JOIN sales s ON p.pub_id = s.pub_id
    JOIN beverages b ON s.beverage_id = b.beverage_id
    GROUP BY p.pub_id, p.pub_name, b.category
),

PubTotalSales AS (
    SELECT 
        p.pub_id,
        SUM(b.price_per_unit * s.quantity) as total_sales_amount
    FROM pubs p
    JOIN sales s ON p.pub_id = s.pub_id
    JOIN beverages b ON s.beverage_id = b.beverage_id
    GROUP BY p.pub_id
)

SELECT 
    p.pub_id, 
    p.pub_name, 
    p.city, 
    p.state, 
    p.country,
    pcs.category,
    ROUND((pcs.total_category_sales / pts.total_sales_amount) * 100, 2) as category_contribution_percentage
    FROM pubs p
JOIN PubCategorySales pcs ON p.pub_id = pcs.pub_id
JOIN PubTotalSales pts ON p.pub_id = pts.pub_id
ORDER BY p.pub_id, pcs.category;




