WITH
  customer_details AS (
    SELECT
      created_at,
      id,
      age,
      gender,
      country,
      traffic_source
    FROM
      users
  ),
  order_details AS (
    SELECT
      o.user_id,
      o.order_id,
      oi.product_id,
      p.category,
      p.name,
      o.num_of_item AS quantity,
      oi.sale_price,
      o.created_at AS order_created,
      oi.shipped_at AS order_shipped,
      oi.delivered_at AS order_delivered
    FROM 
      orders o
    INNER JOIN order_items oi
      ON o.order_id = oi.order_id
    INNER JOIN products p
      ON oi.product_id = p.id
    WHERE o.status NOT IN ('Cancelled', 'Returned')
    ORDER BY user_id
  ),
  customer_spending AS (
    SELECT
      user_id,
      SUM(quantity * sale_price) AS total_spent,
      COUNT(DISTINCT order_id) AS order_count,
      MAX(order_created::DATE) AS last_order_date,
      MIN(order_created::DATE) AS first_order_date
    FROM
      order_details
    GROUP BY
      user_id
  ),
  rfm_analysis AS (
    SELECT
      user_id,
      EXTRACT(DAY FROM AGE(CURRENT_DATE, MAX(order_created::DATE))) AS recency,
      COUNT(order_id) AS frequency,
      SUM(quantity * sale_price) AS monetary
    FROM
      order_details
    GROUP BY
      user_id
  )
SELECT
  cd.id AS customer_id,
  CASE 
    WHEN age <= 18 THEN 'young'
    WHEN age > 18 AND age <= 25 THEN 'young adult'
    WHEN age > 25 AND age <= 40 THEN 'adult'
    WHEN age > 40 AND age <= 60 THEN 'middle-aged'
    ELSE 'senior'
  END AS age_group,
  cd.gender,
  cd.country,
  cd.traffic_source,
  cs.total_spent,
  cs.order_count,
  EXTRACT(DAY FROM AGE(CURRENT_DATE, cs.first_order_date)) AS customer_tenure,
  CASE
    WHEN cs.order_count > 1 THEN EXTRACT(DAY FROM AGE(cs.last_order_date, cs.first_order_date)) / (cs.order_count - 1)
    ELSE NULL
  END AS avg_days_between_orders,
  ra.recency,
  ra.frequency,
  ra.monetary,
  od.category AS product_category,
  od.name AS product_name,
  (od.quantity * od.sale_price) AS product_total_spent
FROM 
  customer_details cd
INNER JOIN 
  customer_spending cs ON cd.id = cs.user_id
INNER JOIN 
  rfm_analysis ra ON cd.id = ra.user_id
INNER JOIN 
  order_details od ON cd.id = od.user_id
ORDER BY 
  customer_id;
