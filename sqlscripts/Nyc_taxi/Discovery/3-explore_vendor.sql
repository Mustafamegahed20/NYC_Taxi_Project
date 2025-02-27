SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'vendor_unquoted.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS vendor


SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'vendor_escaped.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ESCAPECHAR = '\\' ,
        ROWTERMINATOR = '\n'
    )AS vendor

    