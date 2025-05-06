{{ 
    config(
        materialized = 'table',
    ) 
}}
-- Placeholder CTEs
WITH fct_reviews AS (
    SELECT * FROM {{ ref('fct_reviews') }}
),
full_moon_dates AS (
    SELECT * FROM {{ ref('seed_full_moon_dates') }}
)
-- Join all reviews with the full moon dates.
-- Add a boolean column to flag the reviews from 
-- *the day after* a full moon.
SELECT
    r.*,
    CASE
        WHEN fm.full_moon_date IS NULL THEN False
        ELSE True
    END AS is_full_moon
FROM
    fct_reviews AS r
LEFT JOIN full_moon_dates AS fm
ON (TO_DATE(r.review_date) = DATEADD(DAY, 1, fm.full_moon_date))