{{
    config(
        materialized = 'incremental',
        on_schema_change='fail'
    )
}}
-- Placeholder CTE
WITH src_reviews AS (
    SELECT 
        * 
    FROM 
        {{ ref('src_reviews') }}
)
SELECT 
    -- Add a new surrogate key
    {{ dbt_utils.generate_surrogate_key([
        'listing_id', 'review_date', 'reviewer_name', 'review_text'
    ]) }}
        AS review_id,
    * 
FROM 
    src_reviews
WHERE 
    review_text IS NOT NULL
    -- If this is an incremental update
    {% if is_incremental() %}
        -- If start/end dates are given, load using that criteria
        {% if var("start_date", False) and var("end_date", False) %}
            {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
            AND review_date >= '{{ var("start_date") }}'
            AND review_date < '{{ var("end_date") }}'
        -- If start/end dates are not given, load everything new
        {% else %}
            AND review_date > (select max(review_date) from {{ this }})
            {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
        {% endif %}
    {% endif %}