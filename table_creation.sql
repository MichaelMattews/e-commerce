CREATE TABLE "dim_users" (
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

CREATE TABLE "dim_products" (
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

CREATE TABLE "dim_distribution_centers" (
  "distribution_center_id" INTEGER PRIMARY KEY,
  "name" VARCHAR(50),
  "latitude" FLOAT,
  "longitude" FLOAT
);

CREATE TABLE "dimtime" (
  "time_id" SERIAL PRIMARY KEY,
  "date" DATE,
  "year" INTEGER,
  "quarter" INTEGER,
  "month" INTEGER,
  "day" INTEGER,
  "day_of_week" VARCHAR(10),
  "week_of_year" INTEGER
);

CREATE TABLE "fact_order_items" (
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

CREATE TABLE "fact_orders" (
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

CREATE TABLE "fact_inventory" (
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