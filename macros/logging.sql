{% macro log_examples() %}

    {{ log("Say hello") }}
    {{ log("Also to the screen", info=True) }} -- Logs to the screen, too
    {# log("Commented out", info=True) #} -- Jinja comment

    -- jinja variables using 'set'
    {% set jinja_var = "FOO: " %}
    {{ log(jinja_var ~ "<-- this is a jinja variable", info=True) }}

    -- dbt variables using 'var'
    -- value is set in dbt_project.yml
    {{ log(var("log_prefix_debug", "Inline default value") ~ 
        " <-- This is a dbt variable", info=True) }}
{% endmacro %}