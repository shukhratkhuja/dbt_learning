{% macro multiply(column_one, column_two) %}
    {{ column_one }} * {{ column_two }}
{% endmacro %}