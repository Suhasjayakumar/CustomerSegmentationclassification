**Customer Segmentation Analysis - SQL Project**

## Overview
This project focuses on analyzing customer data using SQL to extract meaningful insights related to demographics, spending behavior, and professional backgrounds. Various SQL techniques, including indexing, ranking, and temporary tables, have been used to optimize data retrieval and analysis.

## Objectives
- Retrieve and filter customer data based on specific attributes.
- Analyze spending patterns and professional segmentation.
- Implement advanced SQL techniques for optimized query performance.

## SQL Techniques Used
### 1. Data Retrieval & Filtering
- Selected customers who are **Female, Graduated, and work in Entertainment**.
- Retrieved the **top 5 youngest customers** using `ORDER BY` and `LIMIT`.
- Filtered customers with a **Work Experience greater than the average**.

### 2. Aggregation & Grouping
- Counted customers in each **Profession** using `GROUP BY`.
- Computed the **average age per Spending Score category**.
- Identified the **Profession with the highest average Work Experience**.

### 3. Ranking & Sorting
- Ranked customers based on **Work Experience** using `RANK() OVER()`.
- Retrieved the **top 3 most common professions** using a **Common Table Expression (CTE)**.

### 4. Advanced SQL Optimization
- **Created an Index** on the `Profession` column to improve search performance.
- **Utilized a Temporary Table** to store high spenders for quick access.
- **Categorized customers** with Family Size greater than 5 based on Spending Score.

## Key Insights
- **Spending Score Distribution:** Customers were grouped into spending categories to understand purchasing behavior.
- **Professional Segmentation:** Certain professions had higher spending tendencies.
- **Family Size Impact:** Larger family sizes correlated with different spending behaviors.
- **Query Optimization:** Indexing and temporary tables improved query execution speed.


## SQL Queries for Customer Segmentation Analysis

### Retrieve all customers who are Female, Graduated, and work in Entertainment 
```sql
SELECT gender, Graduated, profession 
FROM cleaned_train
WHERE Gender = 'Female' AND Graduated = 'yes' AND profession = 'Entertainment';
```

### Find the top 5 youngest customers
```sql
SELECT * FROM cleaned_train
ORDER BY age 
LIMIT 5;
```

### Count the number of customers in each profession
```sql
SELECT profession, COUNT(*) AS members 
FROM cleaned_train
GROUP BY Profession;
```

### Find the average age of customers for each Spending Score category.
```sql
SELECT AVG(age), Spending_Score 
FROM cleaned_train
GROUP BY Spending_Score;
```

### Get the profession with the highest average Work Experience
```sql
SELECT profession, ROUND(AVG(Work_Experience), 2) AS average_exp
FROM cleaned_train
GROUP BY Profession
ORDER BY AVG(Work_Experience) DESC
LIMIT 1;
```

### Find customers whose Work Experience is greater than the average Work Experience of all customers
```sql
SELECT *
FROM cleaned_train
WHERE Work_Experience > (SELECT AVG(Work_Experience) FROM cleaned_train);
```

### Rank customers based on Work Experience in descending order
```sql
SELECT ID, Work_Experience, RANK() OVER(ORDER BY Work_Experience DESC) AS Rank
FROM cleaned_train;
```

### Retrieve the top 3 most common professions.
```sql
WITH common AS (
    SELECT Profession, COUNT(*) AS total 
    FROM cleaned_train
    GROUP BY profession
    ORDER BY total DESC
    LIMIT 3
)
SELECT * FROM common;
```

### Find customers with Family Size greater than 5 and categorize them based on Spending Score
```sql
SELECT ID, Family_Size, Spending_Score,
    CASE
        WHEN Spending_Score = 'high' THEN 'premium customer'
        WHEN Spending_Score = 'avg' THEN 'average customer'
        ELSE 'low customer'
    END AS Category
FROM cleaned_train
WHERE Family_Size > 5;
```

### Create an index on the Profession column to speed up search queries
```sql
CREATE INDEX ind_prof ON cleaned_train(Profession(102));
```

### Create a temporary table storing customers with a High Spending Score
```sql
CREATE TEMPORARY TABLE highspenders AS 
SELECT * FROM cleaned_train
WHERE Spending_Score = 'high';

SELECT * FROM highspenders;
```





## Future Scope
- Implement **Machine Learning models** to predict customer spending behavior.
- Integrate the analysis with **BI tools** for interactive visualizations.
- Optimize database storage and indexing for **better performance at scale**.

---
This project successfully leveraged SQL for customer segmentation analysis, providing data-driven insights to enhance business decision-making. 🚀

