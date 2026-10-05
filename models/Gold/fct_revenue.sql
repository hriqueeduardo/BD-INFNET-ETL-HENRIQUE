{{ config(materialized='table') }}

-- Modelo de Fato Financeiro: Cálculo de Impostos e Receita Líquida
SELECT 
    event_time,
    user_id,
    product_id,
    brand,
    category_code,
    
    -- Receita Bruta (Preço original do produto)
    price AS gross_revenue,
    
    -- Cálculo de Imposto (Simulação de 18% de ICMS para varejo de eletrônicos)
    ROUND(price * 0.18, 2) AS tax_amount,
    
    -- Receita Líquida (O que realmente sobra para a empresa após o imposto)
    ROUND(price - (price * 0.18), 2) AS net_revenue,
    
    -- Margem de Lucro Estimada (Considerando um custo fixo de 60% do preço para o produto)
    ROUND((price - (price * 0.18) - (price * 0.60)), 2) AS estimated_profit

FROM {{ ref('stg_events') }}
WHERE event_type = 'purchase'