/*7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . 
This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
The final report contains these columns: Month Year Gross sales Amount*/

select concat(monthname(s.date),'(',year(s.date),')') as 'month',s.fiscal_year, 
round(sum(g.gross_price*s.sold_quantity),2) as gross_sale_amount 
from fact_gross_price g
join fact_sales_monthly s
on g.product_code=s.product_code
join dim_customer d 
on s.customer_code=d.customer_code
where customer='Atliq Exclusive'
group by month,s.fiscal_year
order by s.fiscal_year;
