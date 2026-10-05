{{ config(materialized='table') }}

-- Dimensão de Sessão: Lista todas as sessões de navegação únicas
SELECT DISTINCT 
    user_session AS sk_session,
    user_session
FROM {{ ref('stg_events') }}