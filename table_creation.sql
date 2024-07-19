CREATE TABLE "users" (
  "user_id" INTEGER PRIMARY KEY,
  "first_name" VARCHAR(20),
  "last_name" VARCHAR(20),
  "email" VARCHAR(30),
  "age" INTEGER,
  "gender" VARCHAR(10),
  "state" VARCHAR(30),
  "street_address" VARCHAR(30),
  "postal_code" VARCHAR(30),
  "city" VARCHAR(30),
  "country" VARCHAR(30),
  "latitude" FLOAT,
  "longitude" FLOAT,
  "traffic_source" VARCHAR(30),
  "created_at" TIMESTAMP
);

CREATE TABLE "products" (
  "product_id" INTEGER PRIMARY KEY,
  "cost" FLOAT,
  "category" VARCHAR(30),
  "name" VARCHAR(30),
  "brand" VARCHAR(30),
  "retail_price" FLOAT,
  "department" VARCHAR(30),
  "sku" VARCHAR(50),
  "distribution_center_id" INTEGER,
  "role" VARCHAR(30),
  "created_at" TIMESTAMP
);

CREATE TABLE "distribution_centers" (
  "distribution_center_id" INTEGER PRIMARY KEY,
  "name" VARCHAR(50),
  "latitude" FLOAT,
  "longitude" FLOAT
);


CREATE TABLE dim_time (
    time_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_of_week VARCHAR(10) NOT NULL,
    week_of_year INTEGER NOT NULL
);

INSERT INTO dim_time (date, year, quarter, month, day, day_of_week, week_of_year)
SELECT 
    current_date + (n * interval '1 day') AS date,
    EXTRACT(YEAR FROM current_date + (n * interval '1 day')) AS year,
    EXTRACT(QUARTER FROM current_date + (n * interval '1 day')) AS quarter,
    EXTRACT(MONTH FROM current_date + (n * interval '1 day')) AS month,
    EXTRACT(DAY FROM current_date + (n * interval '1 day')) AS day,
    TO_CHAR(current_date + (n * interval '1 day'), 'Day') AS day_of_week,
    EXTRACT(WEEK FROM current_date + (n * interval '1 day')) AS week_of_year
FROM 
    generate_series(0, (date '2024-12-31' - date '2020-01-01')) n;



CREATE TABLE "order_items" (
  "order_item_id" INTEGER PRIMARY KEY,
  "order_id" INTEGER,
  "user_id" INTEGER,
  "product_id" INTEGER,
  "inventory_item_id" INTEGER,
  "status" VARCHAR(30),
  "created_at" TIMESTAMP,
  "returned_at" TIMESTAMP,
  "shipped_at" TIMESTAMP,
  "delivered_at" TIMESTAMP,
  "sale_price" FLOAT
);

CREATE TABLE "orders" (
  "order_id" INTEGER PRIMARY KEY,
  "user_id" INTEGER,
  "status" VARCHAR(30),
  "created_at" TIMESTAMP,
  "returned_at" TIMESTAMP,
  "shipped_at" TIMESTAMP,
  "delivered_at" TIMESTAMP,
  "num_of_item" INTEGER,
  "total_sale_price" FLOAT
);

CREATE TABLE "inventory" (
  "inventory_item_id" INTEGER PRIMARY KEY,
  "product_id" INTEGER,
  "created_at" TIMESTAMP,
  "sold_at" TIMESTAMP,
  "cost" FLOAT,
  "product_category" VARCHAR(30),
  "product_name" VARCHAR(30),
  "product_brand" VARCHAR(30),
  "product_retail_price" FLOAT,
  "product_department" VARCHAR(30),
  "product_sku" VARCHAR(30),
  "product_distribution_center_id" INTEGER
);
