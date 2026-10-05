{{ config(materialized='table') }}

-- Aqui está a dependência declarada com ref()
SELECT 
    event_time,
    user_id,
    product_id,
    price,
    event_type
FROM {{ ref('stg_events') }}
WHERE event_type = 'purchase'
