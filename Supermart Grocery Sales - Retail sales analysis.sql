
-- Retrieve all orders
SELECT * FROM  market.dbo.supermart_sales;

-- Remove null values
SELECT * FROM market.dbo.supermart_sales
WHERE [Order date]<>'';

--Retrieve the total sales for each category

SELECT Category, SUM(Sales) AS TotalSales
FROM market.dbo.supermart_sales
GROUP BY Category;

-- Retrive the average profit for each sub-category

SELECT "Sub Category", AVG(Profit) AS AverageProfit
FROM market.dbo.supermart_sales
GROUP BY "Sub Category";

-- total sales and profit for each region

SELECT Region, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM market.dbo.supermart_sales
GROUP BY Region;

-- customers with the total sales in descending order

SELECT "Customer Name", SUM(Sales) AS TotalSales
FROM market.dbo.supermart_sales
GROUP BY "Customer Name"
ORDER BY TotalSales DESC
LIMIT 1;

-- total discount given for each category


SELECT Category, SUM(Discount) AS TotalDiscount
FROM market.dbo.supermart_sales
GROUP BY Category;

-- number of orders for each sub-category

SELECT "Sub Category", COUNT(*) AS OrderCount
FROM market.dbo.supermart_sales
GROUP BY "Sub Category";

-- Retrieve the total sales and profit for each city

SELECT City, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM market.dbo.supermart_sales
GROUP BY City;

-- the cumulative sales over time for each category

SELECT"Order Date",Category,
    SUM(Sales) OVER (PARTITION BY Category ORDER BY "Order Date" ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSales
FROM market.dbo.supermart_sales;

-- the top 3 cities with the highest average sales per order:

SELECT City, AVG(Sales) AS AverageSales
FROM market.dbo.supermart_sales
GROUP BY City
ORDER BY AverageSales DESC
LIMIT 3;

-- Rank the customers by their total sales

SELECT "Customer Name", SUM(Sales) AS TotalSales, RANK() OVER (ORDER BY SUM(Sales) DESC) AS SalesRank
FROM market.dbo.supermart_sales
GROUP BY "Customer Name"
ORDER BY SalesRank;

-- Determine the impact of discount on profit for each sub-category

SELECT "Sub Category", SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit, SUM(Discount) AS TotalDiscount,
    (SUM(Profit) / SUM(Sales)) * 100 AS ProfitMargin, (SUM(Discount) / SUM(Sales)) * 100 AS DiscountImpact
FROM market.dbo.supermart_sales
GROUP BY "Sub Category"
ORDER BY DiscountImpact DESC;

-- Calculate the average order value for each customer

SELECT "Customer Name", AVG(Sales) AS AverageOrderValue
FROM market.dbo.supermart_sales
GROUP BY "Customer Name"
ORDER BY AverageOrderValue DESC;

-- Identify the impact of discounts on the average order size in each region

SELECT Region, AVG(Sales) AS AverageOrderSize, AVG(Sales * Discount) AS AverageDiscountImpact
FROM market.dbo.supermart_sales
GROUP BY Region;

-- Calculate the lifetime value of each customer based on their total sales and profit

SELECT "Customer Name", SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit,
    (SUM(Profit) / SUM(Sales)) * 100 AS ProfitMargin, (SUM(Sales) + SUM(Profit)) AS LifetimeValue
FROM market.dbo.supermart_sales
GROUP BY "Customer Name"
ORDER BY LifetimeValue DESC;

-- Analyze the distribution of order sizes and categorize them into small, medium, and large orders

SELECT "Order ID", Sales,
    CASE
        WHEN Sales < 100 THEN 'Small'
        WHEN Sales BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'Large'
    END AS OrderSizeCategory
FROM market.dbo.supermart_sales;
=
-- Calculate the average profit margin (profit as a percentage of sales) for each sub-category

SELECT "Sub Category", (SUM(Profit) / SUM(Sales)) * 100 AS ProfitMargin
FROM market.dbo.supermart_sales
GROUP BY "Sub Category";

-- Calculate the total number of orders and the average sales per order for each state

SELECT State, COUNT("Order ID") AS NumberOfOrders, AVG(Sales) AS AverageSales
FROM market.dbo.supermart_sales
GROUP BY State;

-- Determine the total profit for each city for orders placed on weekends

SELECT City, SUM(Profit) AS TotalProfit
FROM Orders
WHERE EXTRACT(dow FROM "Order Date") IN (0, 6)
GROUP BY City
ORDER BY TotalProfit DESC;

-- Identify the sub-category with the highest profit margin

SELECT "Sub Category", (SUM(Profit) / SUM(Sales)) * 100 AS ProfitMargin
FROM market.dbo.supermart_sales
GROUP BY "Sub Category"
ORDER BY ProfitMargin DESC;

-- Calculate the total number of orders and total sales for each customer

SELECT "Customer Name", COUNT("Order ID") AS TotalOrders, SUM(Sales) AS TotalSales
FROM market.dbo.supermart_sales
GROUP BY "Customer Name";

--Retrieve the total sales for each sub-category in a specific region (e.g., 'West')

SELECT "Sub Category", SUM(Sales) AS TotalSales
FROM market.dbo.supermart_sales
WHERE Region = 'West'
GROUP BY "Sub Category";

-- The number of unique customers in each state

SELECT State, COUNT(DISTINCT "Customer Name") AS UniqueCustomers
FROM market.dbo.supermart_sales
GROUP BY State;

-- The month with the highest sales for each category

SELECT Category, DATEPART(month, "Order Date") AS OrderMonth, SUM(Sales) AS TotalSales
FROM market.dbo.supermart_sales
GROUP BY Category, DATEPART(month, "Order Date")
ORDER BY Category, TotalSales DESC;