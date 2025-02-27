SELECT
    LocationID,
    COUNT(1) as number_of_records
FROM
    OPENROWSET(
        BULK 'taxi_zone.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    ) WITH(
        LocationID SMALLINT 1,
        Borough VARCHAR(15) 2 ,
        zone  VARCHAR(50) 3 ,
        service_zone VARCHAR(15) 4

    ) AS [result]
GROUP by LocationID
Having COUNT(1) > 1

