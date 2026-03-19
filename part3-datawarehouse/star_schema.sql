
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;



CREATE TABLE dim_date (
    date_id    INT          PRIMARY KEY,
    full_date  DATE         NOT NULL,
    day        INT          NOT NULL,
    month      INT          NOT NULL,
    month_name VARCHAR(20)  NOT NULL,
    year       INT          NOT NULL,
    quarter    INT          NOT NULL
);


CREATE TABLE dim_store (
    store_id   INT    PRIMARY KEY ,
    store_name VARCHAR(100) NOT NULL,
    city       VARCHAR(50)  NOT NULL,
    region     VARCHAR(50)  NOT NULL
);


CREATE TABLE dim_product (
    product_id   INT     PRIMARY KEY ,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50)  NOT NULL
);


CREATE TABLE fact_sales (
    sale_id       INT     GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    date_id       INT            NOT NULL,
    store_id      INT            NOT NULL,
    product_id    INT            NOT NULL,
    units_sold    INT            NOT NULL,
    unit_price    DECIMAL(10,2)  NOT NULL,
    total_revenue DECIMAL(12,2)  NOT NULL,
    FOREIGN KEY (date_id)    REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id)   REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);


INSERT INTO dim_date VALUES
(20230101,'2023-01-01',1, 1,'January',  2023,1),
(20230201,'2023-02-01',1, 2,'February', 2023,1),
(20230301,'2023-03-01',1, 3,'March',    2023,1),
(20230401,'2023-04-01',1, 4,'April',    2023,2),
(20230501,'2023-05-01',1, 5,'May',      2023,2),
(20230601,'2023-06-01',1, 6,'June',     2023,2),
(20230701,'2023-07-01',1, 7,'July',     2023,3),
(20230801,'2023-08-01',1, 8,'August',   2023,3),
(20230901,'2023-09-01',1, 9,'September',2023,3),
(20231001,'2023-10-01',1,10,'October',  2023,4),
(20231101,'2023-11-01',1,11,'November', 2023,4),
(20231201,'2023-12-01',1,12,'December', 2023,4);

INSERT INTO dim_store (store_id, store_name, city, region) VALUES
(1, 'Bangalore MG',   'Bangalore', 'South'),
(2, 'Chennai Anna',   'Chennai',   'South'),
(3, 'Delhi South',    'Delhi',     'North'),
(4, 'Mumbai Central', 'Mumbai',    'West'),
(5, 'Pune FC Road',   'Pune',      'West');

INSERT INTO dim_product (product_id, product_name, category) VALUES
(1,'Headphones','Electronics'), (2,'Laptop','Electronics'),
(3,'Phone','Electronics'),      (4,'Smartwatch','Electronics'),
(5,'Speaker','Electronics'),    (6,'Tablet','Electronics'),
(7,'Jacket','Clothing'),        (8,'Jeans','Clothing'),
(9,'Saree','Clothing'),         (10,'T-Shirt','Clothing'),
(11,'Atta 10kg','Groceries'),   (12,'Biscuits','Groceries'),
(13,'Milk 1L','Groceries'),     (14,'Oil 1L','Groceries'),
(15,'Pulses 1kg','Groceries'),  (16,'Rice 5kg','Groceries');


INSERT INTO fact_sales (date_id,store_id,product_id,units_sold,unit_price,total_revenue) VALUES
(20230801,2,5,  3, 49262.78,147788.34),  
(20231201,2,6, 11, 23226.12,255487.32),  
(20230201,2,3, 20, 48703.39,974067.80),  
(20230201,3,6, 14, 23226.12,325165.68),  
(20230101,2,4, 10, 58851.01,588510.10),  
(20230801,1,11,12, 52464.00,629568.00),  
(20230301,5,4,  6, 58851.01,353106.06),  
(20231001,5,8, 16,  2317.47, 37079.52),  
(20231201,1,12, 9, 27469.99,247229.91),  
(20230801,1,4,  3, 58851.01,176553.03);  

