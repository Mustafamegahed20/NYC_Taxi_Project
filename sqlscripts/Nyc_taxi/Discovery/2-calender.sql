SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapsecoursedllll.dfs.core.windows.net/nyc-taxi-data/raw/calendar.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    ) AS [result]

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'raw/calendar.csv.csv',
        DATA_SOURCE = 'nyc_taxi_data' ,
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ROWTERMINATOR = '\n'
    )AS [result]
