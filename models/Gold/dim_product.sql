{{ config(materialized='table') }}

-- Dimensão de Produto: Apenas produtos que foram efetivamente comprados
SELECT DISTINCT 
    product_id,
    category_id,
    category_code,
    brand
FROM {{ ref('stg_events') }}
WHERE product_id IS NOT NULL
  AND event_type = 'purchase'