
-- Q1: List all customers along with the total number of orders they have placed
SELECT
    c.customer_id,
    c.name            AS customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto("C:\Users\Precision\OneDrive\Desktop\customers.csv") c
LEFT JOIN read_json_auto("C:\Users\Precision\OneDrive\Desktop\orders.json") o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_orders DESC;


-- Q2: Find the top 3 customers by total order value
SELECT
    c.customer_id,
    c.name              AS customer_name,
    c.city,
    SUM(o.total_amount) AS total_order_value
FROM read_csv_auto("C:\Users\Precision\OneDrive\Desktop\customers.csv") c
JOIN read_json_auto("C:\Users\Precision\OneDrive\Desktop\orders.json") o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_order_value DESC
LIMIT 3;


-- Q3: List all orders placed by customers from Bangalore
SELECT
    c.name         AS customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM read_csv_auto("C:\Users\Precision\OneDrive\Desktop\customers.csv") c
JOIN read_json_auto("C:\Users\Precision\OneDrive\Desktop\orders.json") o
    ON c.customer_id = o.customer_id
WHERE c.city = 'Bangalore'
ORDER BY o.order_date;

-- Q4: Join all three files to show customer name, order date,
--     product name, and quantity
SELECT
    c.name          AS customer_name,
    o.order_date,
    o.order_id,
    o.total_amount,
    o.num_items     AS quantity,
    p.product_name,
    p.category
FROM read_csv_auto("C:\Users\Precision\OneDrive\Desktop\customers.csv") c
JOIN read_json_auto("C:\Users\Precision\OneDrive\Desktop\orders.json") o
    ON c.customer_id = o.customer_id
CROSS JOIN read_parquet("C:\Users\Precision\OneDrive\Desktop\products.parquet") p
ORDER BY o.order_date
LIMIT 20;
