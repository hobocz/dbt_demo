-- Selects rows which have a Null value in any field
-- (Useful for testing)
{% macro select_any_nulls(model) %}
    SELECT * FROM {{ model }} WHERE
    {% for col in adapter.get_columns_in_relation(model) -%}
        {{ col.column }} IS NULL OR
    {% endfor %}
    FALSE
{% endmacro %}