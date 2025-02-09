{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
hashkey: 'hk_store_h'
business_keys: 
    - store_id
source_models: 
    - name: stg_stores
      hk_column: 'hk_store_h'
      rscs_static: 'raw_stores'
    - name: stg_orders
      hk_column: 'hk_store_h'
      rscs_static: 'raw_orders'

{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.hub(hashkey=metadata_dict.get('hashkey'),
                    business_keys=metadata_dict.get('business_keys'),
                    source_models=metadata_dict.get('source_models')
                    ) }}