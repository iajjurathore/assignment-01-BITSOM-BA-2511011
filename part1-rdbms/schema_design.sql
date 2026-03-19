
-- Drop tables 
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales_reps;
DROP TABLE IF EXISTS customers;

-- Table 1: customers

CREATE TABLE customers (
    customer_id   VARCHAR(10)  PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50)  NOT NULL
);

-- 
-- Table 2: sales_reps

CREATE TABLE sales_reps (
    rep_id         VARCHAR(10)  PRIMARY KEY,
    rep_name       VARCHAR(100) NOT NULL,
    rep_email      VARCHAR(100) NOT NULL,
    office_address VARCHAR(200) NOT NULL
);


-- Table 3: products
-- 
CREATE TABLE products (
    product_id   VARCHAR(10)   PRIMARY KEY,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL
);

-- 
-- Table 4: orders
CREATE TABLE orders (
    order_id    VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    rep_id      VARCHAR(10) NOT NULL,
    order_date  DATE        NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (rep_id)      REFERENCES sales_reps(rep_id)
);

-- 
-- Table 5: order_items

CREATE TABLE order_items (
    item_id  INT  GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    order_id   VARCHAR(10)   NOT NULL,
    product_id VARCHAR(10)   NOT NULL,
    quantity   INT           NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
	);


-- INSERT DATA
-- ===========

-- customers 
INSERT INTO customers VALUES
('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi'),
('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore'),
('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi'),
('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore'),
('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');

-- sales_reps 
INSERT INTO sales_reps VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');


-- products 
INSERT INTO products VALUES
('P001', 'Laptop',        'Electronics', 55000.00),
('P002', 'Mouse',         'Electronics',   800.00),
('P003', 'Desk Chair',    'Furniture',    8500.00),
('P004', 'Notebook',      'Stationery',    120.00),
('P005', 'Headphones',    'Electronics',  3200.00),
('P006', 'Standing Desk', 'Furniture',   22000.00),
('P007', 'Pen Set',       'Stationery',    250.00),
('P008', 'Webcam',        'Electronics',  2100.00);

-- orders 
INSERT INTO orders VALUES
('1001', 'C001', 'SR01', '2023-01-14'),
('1002', 'C002', 'SR02', '2023-01-17'),
('1012', 'C001', 'SR01', '2023-05-29'),
('1021', 'C008', 'SR03', '2023-08-23'),
('1022', 'C005', 'SR01', '2023-10-15'),
('1025', 'C008', 'SR01', '2023-02-26'),
('1027', 'C002', 'SR02', '2023-11-02'),
('1033', 'C004', 'SR02', '2023-03-24'),
('1035', 'C002', 'SR02', '2023-05-03'),
('1037', 'C002', 'SR03', '2023-03-06');


-- order_items 
INSERT INTO order_items (order_id, product_id, quantity) VALUES
('1001', 'P001', 2),
('1002', 'P005', 1),
('1012', 'P006', 1),
('1021', 'P004', 2),
('1022', 'P002', 5),
('1025', 'P001', 2),
('1027', 'P004', 4),
('1033', 'P002', 5),
('1035', 'P003', 1),
('1037', 'P007', 2);


