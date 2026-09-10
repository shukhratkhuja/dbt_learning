select 
 {{ multiply('units', 'amount') }} as total_sales
from 
{{ ref('sales') }}