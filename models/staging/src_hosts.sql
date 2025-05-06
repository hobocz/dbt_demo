-- Placeholder CTE
WITH raw_hosts AS (
    SELECT 
        *
    FROM 
        {{ source('airbnb_data', 'hosts') }}
)
-- Select required columns and make some naming clarifications
SELECT
    id AS host_id,
    name AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    raw_hosts