-- Select All 
SELECT *
FROM SP1

--Product Frequency Section
SELECT *
FROM Commonly_Paired_Products

  CREATE TABLE Commonly_Paired_Products (
    Product1 VARCHAR(255),
    Product2 VARCHAR(255),
    Frequency INT
);

INSERT INTO Commonly_Paired_Products (Product1, Product2, Frequency)
SELECT
    s1.Product AS Product1,
    s2.Product AS Product2,
    COUNT(*) AS Frequency
FROM
    SP1 s1
    INNER JOIN SP1 s2 ON s1."Order ID" = s2."Order ID" AND s1.Product < s2.Product
GROUP BY
    s1.Product, s2.Product
ORDER BY
    Frequency DESC;

-- Order_Summary Section
  CREATE TABLE Order_Summary (
    Ord_ID INT,
    Ord_Month VARCHAR(255),
    Total_Amount INT
);

INSERT INTO Order_Summary (Ord_ID, Ord_Month, Total_Amount)
SELECT DISTINCT [Order ID], [Month], SUM([Amount Spent on Order]) AS Total
FROM SP1
GROUP BY [Order ID], [Month]
