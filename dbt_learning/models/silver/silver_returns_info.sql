WITH returns AS
(
    SELECT 
        sales_id,
        store_sk,
        product_sk,
        returned_qty,
        return_reason,
        refund_amount
    FROM {{ ref('bronze_returns') }}
),

sales AS(
    SELECT 
        sales_id,
        product_sk,
        customer_sk
    FROM {{ ref('bronze_sales') }}
),
product AS(
    SELECT 
        product_sk,
        list_price,
        category
    FROM {{ ref('bronze_product') }}
),

customer AS(
    SELECT 
        customer_sk,
        gender
    FROM {{ ref('bronze_customer') }}
),

joined_sales_customer AS (
    SELECT 
        sales.sales_id,
        sales.customer_sk,
        customer.gender
    FROM sales
    JOIN 
        customer ON sales.customer_sk = customer.customer_sk
),
joined_query AS (
    SELECT 
        {{multiply('returns.returned_qty', 'product.list_price')}} as calculated_refund_amount,
        returns.refund_amount,
        product.category,
        returns.return_reason,
        joined_sales_customer.gender
    FROM returns
    JOIN 
        product ON returns.product_sk = product.product_sk
    JOIN
        joined_sales_customer ON joined_sales_customer.sales_id = returns.sales_id
)
SELECT
    category, 
    return_reason,
    gender,
    sum(refund_amount) as total_refunds
FROM joined_query
GROUP BY
    category,
    return_reason,
    gender
ORDER BY
    total_refunds DESC,
    category,
    return_reason,
    gender