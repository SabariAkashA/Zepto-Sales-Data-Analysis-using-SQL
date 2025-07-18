# 🛒 Zepto Sales Data Analysis using SQL

A hands-on SQL project analyzing a dataset inspired by Zepto's product catalog. The goal is to clean the data, analyze pricing, discounts, stock availability, and derive actionable insights using advanced SQL queries.

---
## 📌 Project Overview

The goal is to simulate how real data analysts in e-commerce or retail industries use SQL to:

✅ Create and populate a realistic inventory database  
✅ Explore product categories, prices, and stock inconsistencies  
✅ Clean data (fix nulls, remove invalids, normalize prices)  
✅ Generate actionable insights with business-driven SQL queries

---
## 🛠️ Skills Used
- SQL (DDL, DML, Aggregations, CASE, JOINS)
- Data Cleaning & Validation
- Pricing & Revenue Analysis
- Categorization & Conditional Logic
---
## 📁 Dataset Description
The dataset was sourced from Kaggle and was originally scraped from Zepto’s official product listings. It mimics what you’d typically encounter in a real-world e-commerce inventory system.

Duplicate product names exist because the same product may appear multiple times in different package sizes, weights, discounts, or categories to improve visibility – exactly how real catalog data looks.

Columns:
- `category`: Product category
- `name`: Product name
- `mrp`: Maximum retail price
- `discountPercent`: Discount percentage
- `availableQuantity`: Units in stock
- `discountedSellingPrice`: Final price
- `weightInGms`: Product weight
- `outOfStock`: Boolean flag
- `quantity`: Units per order
---
## 📊 Key Analysis
- Null and invalid value detection
- MRPs with value `0` cleanup
- Price normalization (`/100.0`)
- Top discounted and high-priced items
- Category-wise revenue calculation
- Price per gram calculation
- Weight classification: Low, Medium, Bulk
- Products with multiple price variants
---
## 🧠 Project Workflow

### 1. 🗃️ Table Creation
```sql
CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
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
```

---

### 2. 📥 Data Import
Use `pgAdmin` import or this command in PostgreSQL:

```sql
\copy zepto(category,name,mrp,discountPercent,availableQuantity,
discountedSellingPrice,weightInGms,outOfStock,quantity)
FROM 'data/zepto.csv' WITH (FORMAT csv, HEADER true);
```

---

### 3. 🔍 Data Exploration
- Count total records
- Check sample data
- Identify nulls or missing fields
- List all categories
- Compare stock vs out-of-stock items
- Find duplicate product names with different prices

---

### 4. 🧹 Data Cleaning
- Removed rows where MRP or Discounted Price = 0
- Converted MRP and prices from paise to ₹
- Fixed inconsistent category column header
- Removed nulls and corrected data types

---

### 5. 📊 Business Insights
- Top 10 highest discounted products
- High MRP items that are out of stock
- Potential revenue per category
- Expensive products with low discounts
- Average discounts by category (top 5)
- Best price per gram products
- Weight category classification (Low, Medium, Bulk)
- Total stock weight per category
- Products with multiple pricing SKUs

---
