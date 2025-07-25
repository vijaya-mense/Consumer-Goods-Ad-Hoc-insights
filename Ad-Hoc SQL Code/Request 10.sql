/*10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
The final output contains these fields, division product_code 
product total_sold_quantity rank_order*/

WITH cte AS (
  SELECT
    p.division,
    s.product_code,
    p.product,
    SUM(s.sold_quantity) AS total_sold_quantity,
    ROW_NUMBER() OVER (
      PARTITION BY p.division 
      ORDER BY SUM(s.sold_quantity) DESC
    ) AS rn
  FROM fact_sales_monthly s
  JOIN dim_product p 
    ON s.product_code = p.product_code
  WHERE s.fiscal_year = 2021
  GROUP BY p.division, s.product_code, p.product)
SELECT
  division,
  product_code,
  product,
  total_sold_quantity,
  rn AS rank_order
FROM cte
WHERE rn <= 3
ORDER BY division, rank_order;


