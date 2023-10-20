# Marketing Analysis

## Intro
Sustainable Clothing Co. has been running several marketing campaigns. Acting as a Marketing Analyst at 'Sustainable Clothing Co.', I have been asked to provide my insights into whether they have been successful or not. I analyzed the following data and answered the questions to form my answer for this Challenge.

![Case Study Theme](image_file_path.png)
<!-- Insert an image that accurately captures this case study theme -->

## Tables
Here are the tables I created and used in MySQL Workbench 8.0:

![Image 1](https://steeldata.org.uk/sql6tables.png)

## Table Creation:
-- SQL code to create the required tables
```sql
CREATE TABLE sustainable_clothing (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
size VARCHAR(10),
price FLOAT
);
-- Insert data into the table
INSERT INTO sustainable_clothing (product_id, product_name, category, size, price)
VALUES
(1, 'Organic Cotton T-Shirt', 'Tops', 'S', 29.99),
(2, 'Recycled Denim Jeans', 'Bottoms', 'M', 79.99),
(3, 'Hemp Crop Top', 'Tops', 'L', 24.99),
(4, 'Bamboo Lounge Pants', 'Bottoms', 'XS', 49.99),
(5, 'Eco-Friendly Hoodie', 'Outerwear', 'XL', 59.99),
(6, 'Linen Button-Down Shirt', 'Tops', 'M', 39.99),
(7, 'Organic Cotton Dress', 'Dresses', 'S', 69.99),
(8, 'Sustainable Swim Shorts', 'Swimwear', 'L', 34.99),
(9, 'Recycled Polyester Jacket', 'Outerwear', 'XL', 89.99),
(10, 'Bamboo Yoga Leggings', 'Activewear', 'XS', 54.99),
(11, 'Hemp Overalls', 'Bottoms', 'M', 74.99),
(12, 'Organic Cotton Sweater', 'Tops', 'L', 49.99),
(13, 'Cork Sandals', 'Footwear', 'S', 39.99),
(14, 'Recycled Nylon Backpack', 'Accessories', 'One Size', 59.99),
(15, 'Organic Cotton Skirt', 'Bottoms', 'XS', 34.99),
(16, 'Hemp Baseball Cap', 'Accessories', 'One Size', 24.99),
(17, 'Upcycled Denim Jacket', 'Outerwear', 'M', 79.99),
(18, 'Linen Jumpsuit', 'Dresses', 'L', 69.99),
(19, 'Organic Cotton Socks', 'Accessories', 'M', 9.99),
(20, 'Bamboo Bathrobe', 'Loungewear', 'XL', 69.99);
-- Create the table
CREATE TABLE marketing_campaigns (
campaign_id INT PRIMARY KEY,
campaign_name VARCHAR(100),
product_id INT,
start_date DATE,
end_date DATE,
FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
);
-- Insert data into the table
INSERT INTO marketing_campaigns (campaign_id, campaign_name, product_id, start_date, end_date)
VALUES
(1, 'Summer Sale', 2, '2023-06-01', '2023-06-30'),
(2, 'New Collection Launch', 10, '2023-07-15', '2023-08-15'),
(3, 'Super Save', 7, '2023-08-20', '2023-09-15');
-- Create the table
CREATE TABLE transactions2 (
transaction_id INT PRIMARY KEY,
product_id INT,
quantity INT,
purchase_date DATE,
FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
);
-- Insert data into the table
INSERT INTO transactions2 (transaction_id, product_id, quantity, purchase_date)
VALUES
(1, 2, 2, '2023-06-02'),
(2, 14, 1, '2023-06-02'),
(3, 5, 2, '2023-06-05'),
(4, 2, 1, '2023-06-07'),
(5, 19, 2, '2023-06-10'),
(6, 2, 1, '2023-06-13'),
(7, 16, 1, '2023-06-13'),
(8, 10, 2, '2023-06-15'),
(9, 2, 1, '2023-06-18'),
(10, 4, 1, '2023-06-22'),
(11, 18, 2, '2023-06-26'),
(12, 2, 1, '2023-06-30'),
(13, 13, 1, '2023-06-30'),
(14, 4, 1, '2023-07-04'),
(15, 6, 2, '2023-07-08'),
(16, 15, 1, '2023-07-08'),
(17, 9, 2, '2023-07-12'),
(18, 20, 1, '2023-07-12'),
(19, 11, 1, '2023-07-16'),
(20, 10, 1, '2023-07-20'),
(21, 12, 2, '2023-07-24'),
(22, 5, 1, '2023-07-29'),
(23, 10, 1, '2023-07-29'),
(24, 10, 1, '2023-08-03'),
(25, 19, 2, '2023-08-08'),
(26, 3, 1, '2023-08-14'),
(27, 10, 1, '2023-08-14'),
(28, 16, 2, '2023-08-20'),
(29, 18, 1, '2023-08-27'),
(30, 12, 2, '2023-09-01'),
(31, 13, 1, '2023-09-05'),
(32, 7, 1, '2023-09-05'),
(33, 6, 1, '2023-09-10'),
(34, 15, 2, '2023-09-14'),
(35, 9, 1, '2023-09-14'),
(36, 11, 2, '2023-09-19'),
(37, 17, 1, '2023-09-23'),
(38, 2, 1, '2023-09-28'),
(39, 14, 1, '2023-09-28'),
(40, 5, 2, '2023-09-30'),
(41, 16, 1, '2023-10-01'),
(42, 12, 2, '2023-10-01'),
(43, 1, 1, '2023-10-01'),
(44, 7, 1, '2023-10-02'),
(45, 18, 2, '2023-10-03'),
(46, 12, 1, '2023-10-03'),
(47, 13, 1, '2023-10-04'),
(48, 4, 1, '2023-10-05'),
(49, 12, 2, '2023-10-05'),
(50, 7, 1, '2023-10-06'),
(51, 4, 2, '2023-10-08'),
(52, 8, 2, '2023-10-08'),
(53, 16, 1, '2023-10-09'),
(54, 19, 1, '2023-10-09'),
(55, 1, 1, '2023-10-10'),
(56, 18, 2, '2023-10-10'),
(57, 2, 1, '2023-10-10'),
(58, 15, 2, '2023-10-11'),
(59, 17, 2, '2023-10-13'),
(60, 13, 1, '2023-10-13'),
(61, 10, 2, '2023-10-13'),
(62, 9, 1, '2023-10-13'),
(63, 19, 2, '2023-10-13'),
(64, 20, 1, '2023-10-14');
```
## Ad-Hoc Questions and Solutions
### 1. How many transactions were completed during each marketing campaign?
```sql
SELECT  mc.campaign_name,
       COUNT(t.transaction_id) as transaction_count
FROM 
    marketing_campaigns mc
JOIN 
    transactions2 t ON mc.product_id = t.product_id
GROUP BY 
    mc.campaign_name;
```

### 2. Which product had the highest sales quantity?

```sql
SELECT 
    sc.product_name,
    SUM(t.quantity) as total_quantity_sold
FROM 
    sustainable_clothing sc
JOIN 
    transactions2 t ON sc.product_id = t.product_id
GROUP BY 
    sc.product_name
ORDER BY 
    total_quantity_sold DESC
LIMIT 1;
```
### 3. What is the total revenue generated from each marketing campaign?

```sql
SELECT 
    mc.campaign_name,
    ROUND(SUM(t.quantity * sc.price),2) as total_revenue
FROM 
    marketing_campaigns mc
JOIN 
    transactions2 t ON mc.product_id = t.product_id
JOIN 
    sustainable_clothing sc ON mc.product_id = sc.product_id
GROUP BY 
    mc.campaign_name;
```
### 4. What is the top-selling product category based on the total revenue generated?
```sql
SELECT 
    sc.category,
    ROUND(SUM(t.quantity * sc.price),2) as total_revenue
FROM 
    sustainable_clothing sc
JOIN 
    transactions2 t ON sc.product_id = t.product_id
GROUP BY 
    sc.category
ORDER BY 
    total_revenue DESC
LIMIT 1;
```
### 5. Which products had a higher quantity sold compared to the average quantity sold?

```sql
SELECT 
    sc.product_name,
    SUM(t.quantity) as total_quantity_sold
FROM 
    sustainable_clothing sc
JOIN 
    transactions2 t ON sc.product_id = t.product_id
GROUP BY 
    sc.product_name
HAVING 
    total_quantity_sold > (SELECT AVG(quantity) FROM transactions2)
ORDER BY total_quantity_sold DESC;    

```
### 6. What is the average revenue generated per day during the marketing campaigns?

```sql
SELECT 
    mc.campaign_name,
    ROUND(AVG(t.quantity * sc.price),2) as average_daily_revenue
FROM 
    marketing_campaigns mc
JOIN 
    transactions2 t ON mc.product_id = t.product_id
JOIN 
    sustainable_clothing sc ON mc.product_id = sc.product_id
GROUP BY 
    mc.campaign_name
ORDER BY 
    mc.campaign_name;
```
### 7. What is the percentage contribution of each product to the total revenue?

```sql
WITH product_revenue AS (
    SELECT 
        sc.product_name,
        ROUND(SUM(t.quantity * sc.price),2) as total_revenue
    FROM 
        sustainable_clothing sc
    JOIN 
        transactions2 t ON sc.product_id = t.product_id
    GROUP BY 
        sc.product_name
)
SELECT 
    product_name,
    total_revenue,
    ROUND((total_revenue / (SELECT SUM(total_revenue) FROM product_revenue)) * 100,2) as percentage_contribution
FROM 
    product_revenue
ORDER BY 
    total_revenue DESC;
```
### 8. Compare the average quantity sold during marketing campaigns to outside marketing campaigns.

```sql
WITH campaign_quantity AS (
    SELECT mc.campaign_name,
           AVG(t.quantity) as average_quantity_sold
    FROM 
           marketing_campaigns mc
    JOIN 
           transactions2 t ON mc.product_id = t.product_id
    GROUP BY 
           mc.campaign_name
),
outside_campaign_quantity AS (
    SELECT 'Outside Campaigns' as campaign_name,
        AVG(t.quantity) as average_quantity_sold
    FROM 
        transactions2 t
    WHERE 
        t.product_id NOT IN (SELECT product_id FROM marketing_campaigns)
)
SELECT * FROM campaign_quantity
UNION ALL
SELECT * FROM outside_campaign_quantity;
```

### 9. Compare the revenue generated by products inside the marketing campaigns to those outside the campaigns.

```sql
WITH campaign_revenue AS (
    SELECT 
        mc.campaign_name,
        ROUND(SUM(t.quantity * sc.price),2) as total_revenue
    FROM 
        marketing_campaigns mc
    JOIN 
        transactions2 t ON mc.product_id = t.product_id
    JOIN 
        sustainable_clothing sc ON mc.product_id = sc.product_id
    GROUP BY 
        mc.campaign_name
),
outside_campaign_revenue AS (
    SELECT 
        'Outside Campaigns' as campaign_name,
        ROUND(SUM(t.quantity * sc.price),2) as total_revenue
    FROM 
        transactions2 t
    JOIN 
        sustainable_clothing sc ON t.product_id = sc.product_id
    WHERE 
        t.product_id NOT IN (SELECT product_id FROM marketing_campaigns)
)
SELECT * FROM campaign_revenue
UNION ALL
SELECT * FROM outside_campaign_revenue;
```
### 10. Rank the products by their average daily quantity sold.

```sql
WITH product_avg_quantity AS (
    SELECT 
        sc.product_name,
        ROUND(AVG(t.quantity),2) as average_daily_quantity_sold
    FROM 
        transactions2 t
    JOIN 
        sustainable_clothing sc ON t.product_id = sc.product_id
    GROUP BY 
        sc.product_name
)
SELECT * 
FROM product_avg_quantity
ORDER BY average_daily_quantity_sold DESC;
```






