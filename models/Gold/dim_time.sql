{{ config(materialized='table') }}

-- Dimensão de Tempo: Extrai as partes da data para análise
SELECT DISTINCT
    DATE(event_time) AS sk_date,
    DATE(event_time) AS full_date,
    EXTRACT(YEAR FROM event_time) AS year,
    EXTRACT(MONTH FROM event_time) AS month,
    EXTRACT(DAY FROM event_time) AS day,
    FORMAT_DATE('%A', DATE(event_time)) AS day_of_week
FROM {{ ref('stg_events') }}