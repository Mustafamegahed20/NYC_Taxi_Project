-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapsecoursedllll.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    ) AS [result]

EXEC sp_describe_first_result_set N'SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''https://synapsecoursedllll.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) AS [result]'


SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapsecoursedllll.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    ) WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15)

    ) AS [result]


EXEC sp_describe_first_result_set N'SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''https://synapsecoursedllll.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
    ) AS [result]'

CREATE DATABASE nyc_taxi_discovery;

USE nyc_taxi_discovery;

ALTER DATABASE nyc_taxi_discovery collate LATIN1_GENERAL_100_CI_AS_SC_UTF8;

SELECT name , collation_name from sys.databases;

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapsecoursedllll.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    ) WITH(
        LocationID SMALLINT 1,
        Borough VARCHAR(15) 2

    ) AS [result]


create EXTERNAL DATA SOURCE nyc_taxi_data_raw
WITH(
    LOCATION = 'https://synapsecoursedllll.dfs.core.windows.net/nyc-taxi-data/raw'
)

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'raw/taxi_zone.csv',
        DATA_SOURCE = 'nyc_taxi_data' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    ) WITH(
        LocationID SMALLINT 1,
        Borough VARCHAR(15) 2

    ) AS [result]

DROP EXTERNAL DATA SOURCE nyc_taxi_data_raw_

