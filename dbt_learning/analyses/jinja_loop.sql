{%- set apples = ["Fuji", "Gala", "Honeycrisp", "Granny Smith", "Red Delicious"] -%}

{%- for apple in apples -%}
    {%- if apple != "Red Delicious" -%}
        {{ apple }}
    {% else %}
        Its too delicious: {{ apple }}
    {%- endif -%}
{% endfor %}