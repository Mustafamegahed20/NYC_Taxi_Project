

------ select all the data from  folder

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=2020/month=01/*',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data

------ select all the data from subfolder


SELECT
     *
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=2020/**',
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data


----- get the data from more than  file

SELECT
     *
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=2020/month=01/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data


----- use more than 1 wildcard charcter
SELECT
     *
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=*/month=*/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data


---- File metadata function filename()


SELECT
     top 100 
     green_data.filename() as file_name,
     green_data.*
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=*/month=*/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data


--- select how many record for each file

SELECT
     top 100 
     green_data.filename() as file_name,
     COUNT(1) as record_count
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=*/month=*/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data
GROUP by green_data.filename()
ORDER by green_data.filename()


---- limit data using filename function


SELECT
     top 100 
     green_data.filename() as file_name,
     COUNT(1) as record_count
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=*/month=*/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data
WHERE green_data.filename() in ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv')
GROUP by green_data.filename()
ORDER by green_data.filename()




---- limit data using filepath function


SELECT
     top 100 
     green_data.filename() as file_name,
    green_data.filepath() as file_path,
     COUNT(1) as record_count
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=*/month=*/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data
WHERE green_data.filename() in ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv')
GROUP by green_data.filename(),green_data.filepath()
ORDER by green_data.filename(),green_data.filepath()



SELECT
     top 100 
     green_data.filename() as file_name,
    green_data.filepath(1) as year,
    green_data.filepath(2) as month,
     COUNT(1) as record_count
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=*/month=*/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data
WHERE green_data.filename() in ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv')
GROUP by green_data.filename(),green_data.filepath(1),green_data.filepath(2)
ORDER by green_data.filename(),green_data.filepath(1),green_data.filepath(2)


----- use file path in where clasue

SELECT
     top 100 
     green_data.filename() as file_name,
    green_data.filepath(1) as year,
    green_data.filepath(2) as month,
     COUNT(1) as record_count
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=*/month=*/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        DATA_SOURCE = 'nyc_taxi_data_raw' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS green_data
WHERE green_data.filepath(1) = '2020' and green_data.filepath(2) in ('06','07','08')
GROUP by green_data.filename(),green_data.filepath(1),green_data.filepath(2)
ORDER by green_data.filename(),green_data.filepath(1),green_data.filepath(2)
