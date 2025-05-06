-- Selects rows where the given field value is negative or zero
{% test non_positive_value(model, column_name) %}
    SELECT *
    FROM {{ model }}
    WHERE
        {{ column_name}} < 1
{% endtest %}