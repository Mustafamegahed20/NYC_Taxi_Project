
----- basic Quilty Checks

SELECT
    MIN(total_amount) as min_total_amount,
    MAX(total_amount) as max_total_amount,
    AVg(total_amount) as AVG_total_amount,
    SUM(total_amount) as total_amount,
    count(1) as total_number_of_records,
    count(total_amount) as not_nulls_total_amount
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'parquet'

    )AS trip_data


--- we see that the min value is -210.3 so we make see this case and try to solve it
SELECT *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'parquet'

    )AS trip_data
where total_amount < 0



SELECT payment_type , COUNT(1) as number_of_records
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'parquet'

    )AS trip_data
where total_amount < 0
GROUP by payment_type
order by payment_type
