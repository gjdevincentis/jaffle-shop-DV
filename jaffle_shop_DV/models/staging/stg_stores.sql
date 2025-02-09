{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 'raw_stores_dv'
ldts: 'load_ts'
rsrc: 'record_source'
hashed_columns: 
    hk_store_h:
        - store_id
    hd_store_details_s:
        is_hashdiff: true
        columns:
            - name
    hd_store_tax_rate_s:
        is_hashdiff: true
        columns:
            - tax_rate

{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.stage(source_model=metadata_dict.get('source_model'),
                    ldts=metadata_dict.get('ldts'),
                    rsrc=metadata_dict.get('rsrc'),
                    hashed_columns=metadata_dict.get('hashed_columns')) }}