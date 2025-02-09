{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 'raw_customers_dv'
ldts: 'load_ts'
rsrc: 'record_source'
hashed_columns: 
    hk_customer_h:
        - customer_id
    hd_customer_s:
        is_hashdiff: true
        columns:
            - name
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.stage(source_model=metadata_dict.get('source_model'),
                    ldts=metadata_dict.get('ldts'),
                    rsrc=metadata_dict.get('rsrc'),
                    hashed_columns=metadata_dict.get('hashed_columns')) }}