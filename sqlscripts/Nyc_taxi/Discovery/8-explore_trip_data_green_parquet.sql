SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'parquet'

    )
WITH(
    tip_amount FLOAT,
    trip_type int 
)AS green_data


--- query from folder using wildcard 

SELECT
    TOP 100 
    trip_data.filename() as file_name,
    trip_data.*
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=*/month=*/*.parquet',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'parquet'
    ) AS trip_data

----- query using file name


