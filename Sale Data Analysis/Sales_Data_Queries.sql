-- Select All 
SELECT *
FROM dbo.Sales_Data

WHERE YEAR([Order_Date_Only]) = 2020

-- Format Date 
Alter TABLE Sales_Data
ADD "Order_Date_Only" DATE;

Delete FROM Sales_Data
WHERE "Order ID" IS NULL

DELETE FROM Sales_Data
WHERE YEAR([Order_Date_Only]) = 2020


UPDATE Sales_Data
SET Order_Date_Only = CAST("Order Date" AS DATE) 

ALTER TABLE Sales_Data
ADD Order_Time_Only TIME;

UPDATE Sales_Data
SET Order_Time_Only = CAST("Order Time" AS TIME) 

Alter TABLE Sales_Data
Drop Column "Order Date" ;

Alter TABLE Sales_Data
Drop Column "Order Time" ;


  CREATE TABLE Product_Frequency (
    Product1 VARCHAR(255),
    Product2 VARCHAR(255),
    Frequency INT
);

INSERT INTO Product_Frequency (Product1, Product2, Frequency)
SELECT
    s1.Product AS Product1,
    s2.Product AS Product2,
    COUNT(*) AS Frequency
FROM
    Sales_Data s1
    INNER JOIN Sales_Data s2 ON s1."Order ID" = s2."Order ID" AND s1.Product < s2.Product
GROUP BY
    s1.Product, s2.Product
ORDER BY
    Frequency DESC;


  CREATE TABLE Orders (
    Ord_ID INT,
    Ord_Month VARCHAR(255),
    Total_Amount INT
);

INSERT INTO Orders (Ord_ID, Ord_Month, Total_Amount)
SELECT DISTINCT [Order ID], [Month], SUM([Amount Spent on Order]) AS Total
FROM Sales_Data
GROUP BY [Order ID], [Month]

SELECT *
From sales_probability

CREATE TABLE sales_probability (
  Product VARCHAR(255),
  Sales_Probability DECIMAL(10,2),
  Leftover_Amount DECIMAL(10,2)
);

WITH total_sales AS (
  SELECT SUM("Amount Spent on Order") AS total_sales
  FROM Sales_Data
), product_sales AS (
  SELECT "Product", SUM("Amount Spent on Order") AS product_sales
  FROM Sales_Data
  GROUP BY "Product"
)
INSERT INTO sales_probability (Product, Sales_Probability, Leftover_Amount)
SELECT product_sales."Product", 
       ROUND(product_sales.product_sales / total_sales.total_sales * 100, 2) AS Sales_Probability,
       ROUND(100 - (product_sales.product_sales / total_sales.total_sales * 100), 2) AS Leftover_Amount
FROM product_sales, total_sales
WHERE product_sales.product_sales IS NOT NULL;

UPDATE sales_probability
SET Sales_Probability = ROUND(Sales_Probability, 1),
    Leftover_Amount = ROUND(Leftover_Amount, 1)

UPDATE sales_probability
SET Sales_Probability = CONCAT('%', CAST(Sales_Probability AS VARCHAR)),
    Leftover_Amount = CONCAT('%', CAST(Leftover_Amount AS VARCHAR))