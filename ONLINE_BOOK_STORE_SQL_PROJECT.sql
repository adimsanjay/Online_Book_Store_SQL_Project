CREATE DATABASE ONLINE_BOOK_STORE;
USE ONLINE_BOOK_STORE;

-- Retrieve all the books in  "Fantasy"  genre
SELECT * FROM DBO.Books
WHERE GENRE = 'Fantasy';

-- List all customers from canada
SELECT * FROM DBO.[Customers ]
WHERE Country = 'Canada';

--Show orders placed in oct 2023 
SELECT * FROM DBO.[Orders (1)]
WHERE Order_Date BETWEEN '2023-10-01' AND '2023-10-30';

-- Find the books published in and after 2000 yr
SELECT * FROM DBO.Books
WHERE Published_Year >= 2000;

-- Total stock of books
SELECT SUM(Stock) AS Total_Stock FROM DBO.Books;

--Most expensive book
SELECT TOP 1 * FROM DBO.Books
ORDER BY Price DESC;

--Show all the customers who ordered more than 5 qty of book 
SELECT * FROM DBO.[Orders (1)]
WHERE Quantity > 5

--Select * genre from books
SELECT DISTINCT Genre FROM DBO.Books;

--ALTER COL QTY
ALTER TABLE DBO.[Orders (1)]
ALTER COLUMN Quantity INT;

-- TOTAL NO OF BOOKS SOLD FOR EACH  GENRE
SELECT * FROM DBO.[Orders (1)]
SELECT b.Genre, SUM(o.Quantity) AS Total_books_sold
FROM DBO.[Orders (1)] O
JOIN Books b ON O.Book_ID = b.Book_ID
GROUP BY b.Genre;

--FIND AVG PRICE OF BOOKS IN SPECIFIC GENRE
SELECT AVG(Price) AS Avg_Price FROM DBO.Books
WHERE Genre='Fantasy';

--TOP 3 MOST EXPENSIVE BOOKS OF SPECIFIC GENRE
SELECT top 3 * FROM DBO.Books
WHERE Genre = 'Biography';


--LIST CUSTOMERS NAME WHO HAVE PLACED AT LEAST 5 ORDERS
SELECT o.Customer_ID,c.Name,count(o.order_id) AS Total_orders 
FROM DBO.[Orders (1)] AS O
JOIN Customers c ON o.Customer_ID = c.Customer_ID
group by o.Customer_ID,c.Name
having count(order_id)>=4;

--MOST FREQUENTLY ORDERED BOOK
SELECT top 1 b.Title,o.Book_ID,COUNT(o.Order_ID) AS Order_count
FROM DBO.[Orders (1)] As o
JOIN Books b ON o.Book_ID = b.Book_ID
group by o.Book_ID,b.Title;

--TOTAL QTY OF BOOKS SOLD BY EACH AUTHOR 
SELECT b.Author,SUM(O.Quantity) AS TOTAL_Qty_Books
FROM DBO.[Orders (1)] AS O
JOIN Books b ON O.Book_ID = b.Book_ID
group by  b.Author;

--LIST OF CITIES WHERE CUSTOMER WHO SPENT OVER $200 ARE LOCATED 
SELECT * FROM DBO.[Orders (1)]
SELECT * FROM DBO.[Customers ]

SELECT DISTINCT(c.City), o.Total_Amount 
From DBO.[Orders (1)] AS O
JOIN [Customers ] AS c ON o.Customer_ID = c.Customer_ID
WHERE  o.Total_Amount >= $200;

--FIND CUSTOMER WHO SPEND HIGH ON ORDERS
SELECT top 5 c.customer_id,c.name,sum(total_amount) as total_spent
from [Orders (1)] as o
join [Customers ] as c on c.customer_id = o.customer_id
group by c.customer_id,c.name
order by total_spent desc;

--CALCULATE STOCK REMAINING AFTER FULLFILLING ORDERS
SELECT * FROM DBO.[Orders (1)]
SELECT * FROM DBO.Books

SELECT b.Book_id, b.title,b.Stock, ISNULL(SUM(Quantity),0) AS Order_quantity,(b.Stock - ISNULL(SUM(Quantity),0)) AS Remaining_stock
FROM Books b
LEFT JOIN [Orders (1)] O ON b.Book_id = O.Book_id
GROUP BY b.Book_id,b.title,b .Stock;