{{ config(materialized='view') }}

SELECT 
    event_time,
    event_type,
    CAST(product_id AS STRING) AS product_id,
    CAST(category_id AS STRING) AS category_id,
    category_code,
    brand,
    CAST(price AS FLOAT64) AS price,
    CAST(user_id AS STRING) AS user_id,
    user_session
FROM {{ source('globalstream_raw', 'fato_eventos') }}