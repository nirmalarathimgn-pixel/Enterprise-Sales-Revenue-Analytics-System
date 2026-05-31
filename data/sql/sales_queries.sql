-- =====================================================
-- ENTERPRISE SALES & REVENUE ANALYTICS SYSTEM
-- COMPLETE MYSQL PROJECT
-- =====================================================
DROP DATABASE  sales_analytics_project;

-- =====================================================
-- 1. CREATE DATABASE
-- =====================================================

CREATE DATABASE sales_analytics_project;


-- =====================================================
-- 2. USE DATABASE
-- =====================================================

USE sales_analytics_project;


-- =====================================================
-- 3. CREATE TABLE
-- =====================================================

CREATE TABLE sales_data (

    order_id VARCHAR(20),
    order_date DATE,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    region VARCHAR(50),
    product_category VARCHAR(100),
    product_name VARCHAR(200),
    sales FLOAT,
    quantity INT,
    profit FLOAT

);


-- =====================================================
-- 4. INSERT SAMPLE DATA
-- =====================================================

INSERT INTO sales_data VALUES

('ORD001','2023-01-05','Aman Sharma','Delhi','North','Technology','Laptop',85000,2,15000),

('ORD002','2023-01-08','Rohit Jain','Mumbai','West','Furniture','Office Chair',12000,3,2500),

('ORD003','2023-01-12','Priya Verma','Jaipur','North','Office Supplies','Printer Paper',2500,10,500),

('ORD004','2023-01-15','Neha Singh','Bangalore','South','Technology','Mobile Phone',45000,2,8000),

('ORD005','2023-01-18','Karan Mehta','Chennai','South','Furniture','Table',15000,1,3000),

('ORD006','2023-01-21','Simran Kaur','Kolkata','East','Technology','Monitor',18000,2,3500),

('ORD007','2023-01-25','Ankit Gupta','Delhi','North','Office Supplies','Notebook',1200,15,250),

('ORD008','2023-02-02','Riya Kapoor','Mumbai','West','Technology','Keyboard',3000,5,700),

('ORD009','2023-02-05','Mohit Sharma','Hyderabad','South','Furniture','Sofa',55000,1,12000),

('ORD010','2023-02-10','Pooja Jain','Pune','West','Technology','Tablet',28000,2,5000);


-- =====================================================
-- 5. VIEW COMPLETE DATA
-- =====================================================

SELECT *
FROM sales_data;


-- =====================================================
-- 6. TOTAL SALES
-- =====================================================

SELECT 

    ROUND(
        SUM(sales),
        2
    ) AS total_sales

FROM sales_data;


-- =====================================================
-- 7. TOTAL PROFIT
-- =====================================================

SELECT 

    ROUND(
        SUM(profit),
        2
    ) AS total_profit

FROM sales_data;


-- =====================================================
-- 8. TOTAL ORDERS
-- =====================================================

SELECT 

    COUNT(order_id) AS total_orders

FROM sales_data;


-- =====================================================
-- 9. TOTAL CUSTOMERS
-- =====================================================

SELECT 

    COUNT(DISTINCT customer_name) AS total_customers

FROM sales_data;


-- =====================================================
-- 10. SALES BY REGION
-- =====================================================

SELECT 

    region,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit

FROM sales_data

GROUP BY region

ORDER BY total_sales DESC;


-- =====================================================
-- 11. SALES BY CATEGORY
-- =====================================================

SELECT 

    product_category,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit

FROM sales_data

GROUP BY product_category

ORDER BY total_sales DESC;


-- =====================================================
-- 12. TOP 5 PRODUCTS BY SALES
-- =====================================================

SELECT 

    product_name,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales

FROM sales_data

GROUP BY product_name

ORDER BY total_sales DESC

LIMIT 5;


-- =====================================================
-- 13. TOP CUSTOMERS
-- =====================================================

SELECT 

    customer_name,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales

FROM sales_data

GROUP BY customer_name

ORDER BY total_sales DESC

LIMIT 5;


-- =====================================================
-- 14. MONTHLY SALES TREND
-- =====================================================

SELECT 

    MONTH(order_date) AS month_number,

    ROUND(
        SUM(sales),
        2
    ) AS monthly_sales

FROM sales_data

GROUP BY MONTH(order_date)

ORDER BY month_number;


-- =====================================================
-- 15. MONTHLY PROFIT TREND
-- =====================================================

SELECT 

    MONTH(order_date) AS month_number,

    ROUND(
        SUM(profit),
        2
    ) AS monthly_profit

FROM sales_data

GROUP BY MONTH(order_date)

ORDER BY month_number;


-- =====================================================
-- 16. PROFIT MARGIN ANALYSIS
-- =====================================================

SELECT 

    product_category,

    ROUND(
        SUM(profit) / SUM(sales) * 100,
        2
    ) AS profit_margin_percentage

FROM sales_data

GROUP BY product_category

ORDER BY profit_margin_percentage DESC;


-- =====================================================
-- 17. HIGH PROFIT PRODUCTS
-- =====================================================

SELECT 

    product_name,

    sales,

    profit

FROM sales_data

WHERE profit > 5000

ORDER BY profit DESC;


-- =====================================================
-- 18. LOW PROFIT PRODUCTS
-- =====================================================

SELECT 

    product_name,

    sales,

    profit

FROM sales_data

WHERE profit < 1000

ORDER BY profit ASC;


-- =====================================================
-- 19. CUSTOMER SEGMENTATION
-- =====================================================

SELECT 

    customer_name,

    SUM(sales) AS total_purchase,

    CASE

        WHEN SUM(sales) >= 50000
        THEN 'Premium Customer'

        WHEN SUM(sales) >= 20000
        THEN 'Standard Customer'

        ELSE 'Basic Customer'

    END AS customer_segment

FROM sales_data

GROUP BY customer_name

ORDER BY total_purchase DESC;


-- =====================================================
-- 20. CITY PERFORMANCE ANALYSIS
-- =====================================================

SELECT 

    city,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit

FROM sales_data

GROUP BY city

ORDER BY total_sales DESC;


-- =====================================================
-- 21. BEST REGION BY PROFIT
-- =====================================================

SELECT 

    region,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit

FROM sales_data

GROUP BY region

ORDER BY total_profit DESC

LIMIT 1;


-- =====================================================
-- 22. AVERAGE ORDER VALUE
-- =====================================================

SELECT 

    ROUND(
        AVG(sales),
        2
    ) AS average_order_value

FROM sales_data;


-- =====================================================
-- 23. REVENUE CONTRIBUTION BY CATEGORY
-- =====================================================

SELECT 

    product_category,

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(sales) * 100 /
        (SELECT SUM(sales) FROM sales_data),
        2
    ) AS revenue_percentage

FROM sales_data

GROUP BY product_category

ORDER BY revenue_percentage DESC;


-- =====================================================
-- 24. EXECUTIVE SUMMARY
-- =====================================================

SELECT 

    ROUND(
        SUM(sales),
        2
    ) AS total_sales,

    ROUND(
        SUM(profit),
        2
    ) AS total_profit,

    COUNT(order_id) AS total_orders,

    COUNT(DISTINCT customer_name) AS total_customers,

    ROUND(
        AVG(sales),
        2
    ) AS average_order_value

FROM sales_data;


-- =====================================================
-- END OF PROJECT
-- =====================================================
