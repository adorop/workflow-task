CREATE EXTERNAL TABLE HOTELS_COUNTS
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION '${hivevar:hotelcountslocation}'
TBLPROPERTIES (
    'avro.schema.literal'='{
        "type":"record",
        "name":"topLevelRecord",
        "fields":[
            {"name":"hotel",
            "type":{
                "type":"record",
                "name":"hotel",
                "namespace":".hotel",
                "fields":[
                    {"name":"hotel_continent_id","type":["int","null"]},
                    {"name":"hotel_country_id","type":["int","null"]},
                    {"name":"hotel_market_id","type":["int","null"]}]}
            },
            {"name":"count",
            "type":"long"}]}'
);