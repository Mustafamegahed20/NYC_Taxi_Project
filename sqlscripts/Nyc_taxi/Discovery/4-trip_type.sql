SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_type.tsv',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        FIELDTERMINATOR = '\t' ,
        ROWTERMINATOR = '\n'
    )AS trip_type