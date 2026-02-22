-- Analysis & Reports

-- Order Volumne Analysis queries
-- StaleHolder(Operation manager)

-- We ara trying to understand our order volumne in detail so we can meassure store performance and benchmark grwoth
-- Instead to just knowing the total number of unique order.I would like  a deeper backdown.

-- 1. What is the total number of unique order places so far.
Select count(distinct order_id) from orders;

-- how has this order volumne changed month-over month and year-over-year.
WITH monthly_orders AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m-01') AS month,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
)
SELECT month,order_count,
    LAG(order_count) OVER (ORDER BY month) AS previous_month,
    ROUND(100 * (order_count - LAG(order_count) OVER (ORDER BY month)) 
        / NULLIF(LAG(order_count) OVER (ORDER BY month), 0),2) AS monthly_growth
FROM monthly_orders
ORDER BY month;

-- Can we identify peak and offpeak ordering days
-- order by day of week
Select Dayname(order_date)as weekday,
count(distinct order_id )as total_orders
from orders
group by dayname(order_date)
order by total_orders ;

-- Average order per customer
Select 
	round(count(distinct order_id)*1.0/
    count(distinct custid),2)as Avg_per_cust
from orders;

-- Can you also project the expected order growth trend based on historial data
-- Cumulative order trend
Select order_date,
		count(order_id)as daily_orders,
        Sum(count(order_id))over(order by order_date)as cumulative_orders
        from orders
        group by order_date 
        order by order_date;
