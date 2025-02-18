{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
hashkey: 'hk_order_h'
business_keys: 
    - order_id
source_models: 
    - name: stg_orders
      hk_column: 'hk_order_h'
      rscs_static: 'raw_orders' 

{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.hub(hashkey=metadata_dict.get('hashkey'),
                    business_keys=metadata_dict.get('business_keys'),
                    source_models=metadata_dict.get('source_models')
                    ) }}