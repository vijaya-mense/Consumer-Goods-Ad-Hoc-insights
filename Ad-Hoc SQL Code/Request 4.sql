/*4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
The final output contains these fields, segment product_count_2020 product_count_2021 difference*/

WITH joint AS (
  SELECT
    p.segment,
    p.product_code,
    s.fiscal_year
  FROM dim_product p
  JOIN fact_sales_monthly s
    ON p.product_code = s.product_code
)
SELECT
  segment,
  COUNT(distinct CASE WHEN fiscal_year = 2020 THEN product_code END) AS products_count_2020,
  COUNT(distinct  CASE WHEN fiscal_year = 2021 THEN product_code END) AS products_count_2021,
  COUNT(distinct CASE WHEN fiscal_year = 2021 THEN product_code END)
    - COUNT(distinct CASE WHEN fiscal_year = 2020 THEN product_code END) AS difference
FROM joint
GROUP BY segment;
