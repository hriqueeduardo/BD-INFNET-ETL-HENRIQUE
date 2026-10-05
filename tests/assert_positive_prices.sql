-- Teste específico: Garante que não existem preços negativos ou zerados nas vendas
SELECT 
    event_time,
    user_id,
    product_id,
    price
FROM {{ ref('fct_sales') }}
WHERE price <= 0