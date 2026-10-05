{{ config(materialized='table') }}

-- CTE (Common Table Expression) para calcular métricas por usuário
WITH customer_metrics AS (
    SELECT 
        user_id,
        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_spent,
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_purchases,
        COUNT(CASE WHEN event_type = 'view' THEN 1 END) AS total_views
    FROM {{ ref('stg_events') }}
    GROUP BY user_id
)

-- Aplicação da Regra de Negócio: Segmentação de Clientes
SELECT 
    user_id AS sk_customer,
    ROUND(total_spent, 2) AS total_spent,
    total_purchases,
    total_views,
    
    CASE 
        WHEN total_purchases >= 3 AND total_spent > 5000 THEN 'VIP'
        WHEN total_purchases >= 1 AND total_spent > 1000 THEN 'Regular'
        WHEN total_purchases = 0 AND total_views > 5 THEN 'Lead Engajado'
        ELSE 'Novo/Inativo'
    END AS customer_segment

FROM customer_metrics