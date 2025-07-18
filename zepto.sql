drop table if exists zepto;

create table zepto(
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--data exploration

--count of rows
select count(*) from zepto;

--sample data 
select * from zepto
limit 10;

--null values
select * from zepto
where name is null
or
category is null
or
mrp is null
or
discountPercent is null
or
discountedSellingPrice is null
or
weightInGms is null
or
availableQuantity is null
or
outOfStock is null
or
quantity is null;

--different product categories
select distinct category
from zepto
order by category;

--data cleaning 

--products with price = 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0;

delete from zepto
where mrp = 0;

--conver paise to rupees
update zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

select mrp, discountedSellingPrice from zepto

--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp
FROM zepto
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;

--Q10. Identify Duplicate Products with Varying Prices
SELECT name, COUNT(DISTINCT discountedSellingPrice) as price_variants
FROM zepto
GROUP BY name
HAVING price_variants > 1
ORDER BY price_variants DESC;
