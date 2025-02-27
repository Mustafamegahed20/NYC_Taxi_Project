SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'Delta'

    ) WITH(
    tip_amount FLOAT,
    trip_type int,
    year VARCHAR(4),
    month VARCHAR(2)
) AS trip_data