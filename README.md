### Advanced SQL Joins Assignment: CRM Database

#### Background

In this assignment, you will work with a complex CRM (Customer Relationship Management) database for a hypothetical company, "CRMCo". The database consists of eight tables that store detailed information about customers, sales, employees, products, and interactions. Your task is to demonstrate advanced proficiency in SQL joins, specifically in PostgreSQL, by writing queries that address real-world business questions.

#### Database Schema

The CRM database, named `crm_database`, consists of the following tables:

1. **customers**

| Column Name    | Type    |
|----------------|---------|
| customer_id    | Integer |
| name           | Text    |
| email          | Text    |
| region_id      | Integer |

2. **sales**

| Column Name    | Type    |
|----------------|---------|
| sale_id        | Integer |
| product_id     | Integer |
| customer_id    | Integer |
| employee_id    | Integer |
| sale_date      | Date    |
| amount         | Numeric |

3. **employees**

| Column Name    | Type    |
|----------------|---------|
| employee_id    | Integer |
| name           | Text    |
| department_id  | Integer |

4. **products**

| Column Name    | Type    |
|----------------|---------|
| product_id     | Integer |
| name           | Text    |
| price          | Numeric |

5. **interactions**

| Column Name    | Type    |
|----------------|---------|
| interaction_id | Integer |
| customer_id    | Integer |
| employee_id    | Integer |
| interaction_date | Date  |
| notes          | Text    |

6. **regions**

| Column Name    | Type    |
|----------------|---------|
| region_id      | Integer |
| name           | Text    |

7. **departments**

| Column Name    | Type    |
|----------------|---------|
| department_id  | Integer |
| name           | Text    |

8. **feedback**

| Column Name    | Type    |
|----------------|---------|
| feedback_id    | Integer |
| customer_id    | Integer |
| rating         | Integer |
| comment        | Text    |

#### Tasks

1. **List All Customers and Their Regions**

   Join the `customers` table with the `regions` table to display customer names alongside their region names. (Hint: LEFT JOIN on `region_id`)

2. **Sales Report by Product**

   Generate a sales report that lists product names, the number of times each product was sold, and the total sales amount. (Hint: INNER JOIN `sales` and `products` on `product_id`, then GROUP BY product name)

3. **Employee-Customer Interactions**

   List all employees along with the names of customers they have interacted with, including the date of the last interaction. (Hint: FULL OUTER JOIN on `employee_id` and `customer_id` between `employees` and `interactions`)

4. **Customer Feedback and Sales**

   For each customer who has provided feedback, list their name, feedback rating, and the total amount they have spent on purchases. (Hint: Use multiple JOINs among `customers`, `feedback`, and `sales`)

5. **Region-Wise Sales Performance**

   Display each region's name along with the total sales amount and the number of sales transactions in that region. (Hint: JOIN `sales` with `customers` and then `regions`, aggregating sales data by region)

6. **Department Interaction Report**

   Show each department's name and the count of customer interactions by employees of that department. (Hint: JOIN `departments`, `employees`, and `interactions`)

#### Bonus Tasks

1. **High-Value Customers**

   Identify customers who have spent above a certain threshold (e.g., $10,000) in total purchases. (Hint: JOIN `customers` and `sales`, then use HAVING to filter based on the sum of `amount`)

2. **Product Feedback Analysis**

   List products alongside the average feedback rating of customers who purchased them. (Hint: You'll need to JOIN across `products`, `sales`, and `feedback`)

3. **Employee Sales vs. Interactions**

   For each employee, calculate the total sales amount they have generated and the number of customer interactions they've had. Compare these metrics to find top performers. (Hint: Use subqueries or CTEs with JOINs)

4. **Unsatisfied Customer Follow-ups**

   Find all customers who have given a feedback rating below a certain level (e.g., 3) and have not been interacted with since giving feedback. List their names and the date of their last interaction. (Hint: JOIN `feedback` with `interactions` and use WHERE to filter based on `rating` and `interaction_date`)

#### Submission Guidelines

- Write your SQL queries in a text file named `Solution.md`.
- Comment each query with the task number and a brief description.
- For the bonus tasks, clearly mark them as "Bonus" and include the specific criteria you chose (e.g., threshold amounts or rating levels).
- There is no deadline or evaluation criteria for this assignment; it is intended for practice and skill enhancement.
- Submit your `.md` file with the GitHub repository .

This assignment is designed to challenge your understanding of complex SQL joins and data analysis in a realistic business context. Good luck!
