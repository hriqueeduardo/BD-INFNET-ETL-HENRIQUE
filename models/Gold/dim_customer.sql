{{ config(materialized='table') }}

-- Dimensão de Cliente: Lista todos os usuários únicos
SELECT DISTINCT 
    user_id AS sk_customer,
    user_id
FROM {{ ref('stg_events') }}