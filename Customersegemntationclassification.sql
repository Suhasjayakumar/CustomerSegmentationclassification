#Customer Segmentation Classification

#Retrieve all customers who are Female, Graduated, and work in Entertainment 
select gender,Graduated,profession from cleaned_train
where Gender='Female' and Graduated='yes'and profession='Entertainment';

#Find the top 5 youngest customers
select * from cleaned_train
order by age 
limit 5;

#Count the number of customers in each profession
select profession,count(*)as members from cleaned_train
group by Profession;

#Find the average age of customers for each Spending Score category.
select avg(age),Spending_Score from cleaned_train
group by Spending_Score;

#Get the profession with the highest average Work Experience
SELECT 
    profession, ROUND(AVG(Work_Experience), 2) AS average_exp
FROM
    cleaned_train
GROUP BY Profession
ORDER BY AVG(Work_Experience) DESC
LIMIT 1;

#Find customers whose Work Experience is greater than the average Work Experience of all customers
SELECT 
    *
FROM
    cleaned_train
WHERE
    Work_Experience > (SELECT 
            AVG(Work_Experience)
        FROM
            cleaned_train);

#Rank customers based on Work Experience in descending order
select ID,Work_Experience,RANK()OVER(ORDER BY Work_Experience desc) from cleaned_train;

#Retrieve the top 3 most common professions.
with common as (select Profession,count(*)as total from cleaned_train
group by profession
order by total desc
limit 3)
select * from common;

#Find customers with Family Size greater than 5 and categorize them based on Spending Score
SELECT 
    ID,
    Family_Size,
    Spending_Score,
    CASE
        WHEN Spending_Score = 'high' THEN 'premium customer'
        WHEN Spending_Score = 'avg' THEN 'average customer'
        ELSE 'low customer'
    END AS Category
FROM
    cleaned_train
    where Family_Size>5;
    
 #Create an index on the Profession column to speed up search queries
CREATE INDEX ind_prof on cleaned_train(Profession(102));

#Create a temporary table storing customers with a High Spending Score
CREATE TEMPORARY TABLE highspenders as 
select * from cleaned_train
where Spending_Score='high';
select * from highspenders