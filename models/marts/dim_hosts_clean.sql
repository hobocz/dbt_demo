{{
config(
        materialized = 'view'
    )
}}

-- Placeholder CTE
WITH src_hosts AS (
    SELECT
        *
    FROM
        {{ ref('src_hosts') }}
)
-- Select required columns and perform simple cleaning
SELECT
    host_id,
    COALESCE(host_name, 'Anonymous') AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    src_hosts
