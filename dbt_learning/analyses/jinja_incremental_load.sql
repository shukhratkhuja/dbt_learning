{% set inc_flag = 1 %}

{% set last_load = 3 %}


SELECT *
FROM {{ ref('bronze_sales') }}
WHERE
{% if inc_flag == 1 %}

    date_sk > {{ last_load}}

{% endif %}