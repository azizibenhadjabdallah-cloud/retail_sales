
 Retail Sales Intelligence — SQL Queries
Author: Aziz Iben Hadj Abdallah| 2026



 1. EXECUTIVE KPI SUMMARY
SELECT 
    ROUND(SUM(Sales), 2)                              AS Total_Revenue,
    ROUND(SUM(Profit), 2)                             AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)          AS Profit_Margin_Pct,
    COUNT(DISTINCT [Order ID])                         AS Total_Orders,
    ROUND(SUM(Sales) / COUNT(DISTINCT [Order ID]), 2) AS Avg_Order_Value
FROM df;


2. CATEGORY PERFORMANCE
SELECT 
    Category,
    ROUND(SUM(Sales), 2)                      AS Total_Revenue,
    ROUND(SUM(Profit), 2)                     AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2)      AS Profit_Margin_Pct,
    COUNT(DISTINCT [Order ID])                 AS Total_Orders
FROM df
GROUP BY Category
ORDER BY Total_Revenue DESC;


 3. LOSS-MAKING PRODUCTS
SELECT 
    [Product Name],
    Category,
    [Sub-Category],
    ROUND(SUM(Sales), 2)    AS Total_Revenue,
    ROUND(SUM(Profit), 2)   AS Total_Profit,
    COUNT([Order ID])        AS Times_Ordered
FROM df
GROUP BY [Product Name]
HAVING Total_Profit < 0
ORDER BY Total_Profit ASC
LIMIT 15;


 4. REVENUE TREND BY YEAR
SELECT 
    Year,
    ROUND(SUM(Sales), 2)       AS Annual_Revenue,
    ROUND(SUM(Profit), 2)      AS Annual_Profit,
    COUNT(DISTINCT [Order ID]) AS Total_Orders
FROM df
GROUP BY Year
ORDER BY Year;


5. REGIONAL PERFORMANCE
SELECT 
    Region,
    ROUND(SUM(Sales), 2)                  AS Total_Revenue,
    ROUND(SUM(Profit), 2)                 AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2)  AS Margin_Pct,
    COUNT(DISTINCT [Order ID])             AS Total_Orders
FROM df
GROUP BY Region
ORDER BY Total_Profit DESC;


6. DISCOUNT IMPACT ANALYSIS
SELECT 
    CASE 
        WHEN Discount = 0 THEN '0% - No Discount'
        WHEN Discount <= 0.2 THEN '1-20% Discount'
        WHEN Discount <= 0.4 THEN '21-40% Discount'
        ELSE '41%+ Discount'
    END AS Discount_Band,
    COUNT(DISTINCT [Order ID])               AS Total_Orders,
    ROUND(AVG(Sales), 2)                     AS Avg_Order_Value,
    ROUND(AVG(Profit), 2)                    AS Avg_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2)     AS Margin_Pct
FROM df
GROUP BY Discount_Band
ORDER BY Margin_Pct DESC;
