/*9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? 
The final output contains these fields, channel gross_sales_mln percentage*/

select c.channel,concat(round(sum(g.gross_price*m.sold_quantity/1000000),2),'M') as gross_sales_mln,
concat(round(SUM(gross_price * sold_quantity) /SUM(SUM(gross_price * sold_quantity)) OVER () * 100,2),'%') AS pct_of_total
from fact_sales_monthly m
join fact_gross_price g
on m.product_code=g.product_code
join dim_customer c
on c.customer_code=m.customer_code
where m.fiscal_year=2021
group by c.channel
order by pct_of_total desc;