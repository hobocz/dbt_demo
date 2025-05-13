-- Placeholder CTE
WITH fullmoon_reviews AS (
    SELECT * FROM {{ ref('fullmoon_reviews') }}
)
-- Select the amount of reviews as a percent of the total,
-- partitioned by whether it was a full moon or not.
SELECT
    is_full_moon,
    review_sentiment,
    COUNT(*) * 100 / SUM(COUNT(*)) OVER (PARTITION BY is_full_moon) as reviews
FROM
    fullmoon_reviews
GROUP BY
    is_full_moon,
    review_sentiment
ORDER BY
    is_full_moon,
    review_sentiment