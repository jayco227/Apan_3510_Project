--Question #1 - Which of our locations perform the best regarding sales?
SELECT locations.location_address, SUM(sales.total_amount) AS total_sales
FROM locations
JOIN sales ON sales.location_id = locations.location_id
GROUP BY locations.location_address
ORDER BY total_sales DESC;

--QUESTION #2 - Is there a specific day of the week that performs better/worse than the rest?
SELECT TO_CHAR(sales.sale_date, 'Day') AS day_of_week, COUNT(DISTINCT transactions.transaction_id)
FROM sales
JOIN transactions ON sales.sale_id = transactions.sale_id
GROUP BY day_of_week;

--QUESTION #3 - What are our most popular items sold?
SELECT items.item_name, SUM(transactions.quantity_sold) AS total_quantity_sold
FROM items
JOIN transactions ON transactions.item_id = items.item_id
GROUP BY items.item_name
ORDER BY total_quantity_sold DESC;

--QUESTION #4 - How many transactions are there for each day, and are there any outliers (certain days with extremely high or low amounts of transactions)?
SELECT sales.sale_date, COUNT(DISTINCT(transactions.transaction_id)) as total_transactions
FROM sales
JOIN transactions on transactions.sale_id = sales.sale_id
GROUP BY sales.sale_date;

--QUESTION #5 - What are our most profitable items sold?
SELECT item_name, items.selling_price - items.purchase_price AS item_profitability
FROM items
ORDER BY item_profitability DESC
LIMIT 10;

--QUESTION #6 - What main category do our highest and lowest selling products fall into?
SELECT main_categories.main_category_name, SUM(sales.total_amount) as total_sales
FROM sales
JOIN transactions ON sales.sale_id = transactions.sale_id
JOIN items ON items.item_id = transactions.item_id
JOIN sub_categories on sub_categories.sub_category_id = items.sub_category_id
JOIN main_categories on sub_categories.main_category_id = main_categories.main_category_id
GROUP BY main_categories.main_category_name
ORDER BY total_sales DESC;

--QUESTION #7 - What sub category do our highest and lowest selling products fall into?
SELECT sub_categories.sub_category_name, SUM(sales.total_amount) as total_sales
FROM sales
JOIN transactions ON sales.sale_id = transactions.sale_id
JOIN items ON items.item_id = transactions.item_id
JOIN sub_categories on sub_categories.sub_category_id = items.sub_category_id
GROUP BY sub_categories.sub_category_name
ORDER BY total_sales DESC;

--QUESTION #8 - Who are our biggest suppliers and how many deliveries do each of them perform?
SELECT suppliers.supplier_name, SUM(quantity_delivered) as volume_delivered
FROM suppliers
JOIN deliveries ON deliveries.supplier_id = suppliers.supplier_id
GROUP BY suppliers.supplier_name
ORDER BY volume_delivered DESC;

--QUESTION #9 - What is the breakdown of employees by position, and how much do we pay them on an hourly basis?
--Breakdown of employees by position
SELECT employees.employee_position, COUNT(*) AS count_position_employees
FROM employees
GROUP BY employees.employee_position;

--How much each position gets paid (hourly wage)?
SELECT employees.employee_position, employees.hourly_wage
FROM employees
ORDER BY employees.hourly_wage DESC;

--QUESTION #10 - What is our total expense amount, and what departments account for the largest amount of expenses?
--Total Expense Amount
SELECT SUM(expenses.expense_amount)
FROM expenses;

--What departments account for the largest amount of total expenses?
SELECT expenses.expense_description, SUM(expenses.expense_amount) AS total_expense_amount
FROM expenses
GROUP BY expenses.expense_description
ORDER BY total_expense_amount DESC;








