{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 'raw_orders_dv'
ldts: 'load_ts'
rsrc: 'record_source'
hashed_columns: 
    hk_order_h:
        - order_id
    hk_order_details_s:
        is_hashdiff: true
        columns:
            - ordered_at
            - subtotal
            - tax_paid
            - order_total
    hk_customer_h:
        - customer_id
    hk_store_h:
        - store_id
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.stage(source_model=metadata_dict.get('source_model'),
                    ldts=metadata_dict.get('ldts'),
                    rsrc=metadata_dict.get('rsrc'),
                    hashed_columns=metadata_dict.get('hashed_columns')) }}