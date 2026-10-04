# Olist E-Commerce SQL Analysis

## Project Overview

This project analyses an e-commerce dataset using SQL to identify trends in sales, revenue, products, delivery performance, customer reviews, sellers, customers, and payment behaviour.

The purpose of the project is to demonstrate practical SQL skills and the ability to turn transactional data into useful business insights.

## Objectives

The analysis focuses on:

- Understanding order and customer activity
- Measuring product revenue and sales volume
- Identifying high-performing product categories
- Analysing delivery performance
- Understanding customer review behaviour
- Evaluating seller performance
- Analysing payment methods
- Identifying trends over time
- Producing insights that could support business decisions

## Tools & Technologies

- **SQL**
- **SQLite**
- **Git**
- **GitHub**
- **VS Code**

## Database Tables

The analysis uses the following tables:

- `customers`
- `orders`
- `order_items`
- `products`
- `payments`
- `reviews`
- `sellers`
- `translation`

## SQL Analysis

### Sales & Revenue

The project analyses:

- Orders by year
- Customers by year
- Product revenue by year
- Monthly revenue
- Average revenue per order
- Highest-revenue months
- Highest-value orders

### Product Analysis

The project identifies:

- Top product categories by revenue
- Top categories by items sold
- Categories with the highest average prices

### Delivery Analysis

Delivery performance is classified as:

- Early
- On Time
- Late

The analysis also measures the percentage of delivered orders in each category and examines the relationship between delivery performance and customer review scores.

### Customer Review Analysis

The project analyses:

- Review score distribution
- Average review scores
- Review scores by order status
- Delivery performance versus customer satisfaction

### Seller Analysis

Seller performance is analysed using:

- Total revenue
- Items sold
- Average item price

The analysis identifies the highest-performing sellers based on revenue and sales volume.

### Payment Analysis

Payment behaviour is analysed by:

- Payment method
- Number of payments
- Total payment value
- Average payment value
- Payment performance by year

## Key Findings

### Revenue Growth

Product revenue increased substantially from 2016 to 2018.

| Year | Product Revenue |
|---|---:|
| 2016 | 49,785.92 |
| 2017 | 6,155,806.98 |
| 2018 | 7,386,050.80 |

### Average Revenue per Order

| Year | Average Revenue per Order |
|---|---:|
| 2016 | 159.57 |
| 2017 | 138.09 |
| 2018 | 137.35 |

Although overall revenue increased strongly, average revenue per order decreased slightly after 2016.

### Delivery Performance

The completed delivery analysis found:

| Delivery Status | Orders | Percentage |
|---|---:|---:|
| Early | 88,649 | 89.15% |
| Late | 7,827 | 7.87% |

There were also **2,965 orders with missing delivery dates** in the analysed data.

### Delivery & Customer Satisfaction

The analysis found a clear difference in average review scores between early and late deliveries:

| Delivery Status | Average Review Score |
|---|---:|
| Early | 4.29 |
| Late | 2.57 |

This indicates that delivery performance is strongly associated with customer satisfaction in the analysed data.

### Payment Behaviour

Credit card payments were the dominant payment method.

| Payment Type | Total Payments | Total Payment Value | Average Payment |
|---|---:|---:|---:|
| Credit card | 76,795 | 12,542,084.19 | 163.32 |
| Boleto | 19,784 | 2,869,361.27 | 145.03 |
| Voucher | 5,775 | 379,436.87 | 65.70 |
| Debit card | 1,529 | 217,989.79 | 142.57 |

Credit cards generated the largest payment value and had the highest average payment value among the main payment methods.

## Example Business Insights

Based on the SQL analysis:

1. **Revenue expanded significantly between 2016 and 2018**, indicating strong growth in transaction activity.

2. **Credit cards were the dominant payment method**, accounting for the largest payment volume and payment value.

3. **Delivery performance appears closely related to customer satisfaction**, with late deliveries receiving substantially lower average review scores than early deliveries.

4. **Product categories differ considerably in revenue, sales volume and average price**, providing opportunities for category-level strategy.

5. **Seller performance varies considerably**, with some sellers generating substantially more revenue or selling more items than others.

## SQL Skills Demonstrated

This project demonstrates practical use of:

- `SELECT`
- `WHERE`
- `CASE`
- `JOIN`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- `COUNT()`
- `COUNT(DISTINCT)`
- `SUM()`
- `AVG()`
- `ROUND()`
- `strftime()`
- Subqueries
- Conditional aggregation
- Data-quality checks

## Project Structure

```text
sql/
├── 01_data_quality_checks.sql
├── load_database.py
└── README.md
```

## Next Step

The next stage of the project is to transform the SQL analysis into an interactive **Power BI dashboard** containing key performance indicators, revenue trends, product performance, delivery performance, customer satisfaction and payment analysis.

## Conclusion

This project demonstrates the ability to work with relational e-commerce data, perform SQL-based analysis, identify meaningful business patterns and communicate findings in a business context.
