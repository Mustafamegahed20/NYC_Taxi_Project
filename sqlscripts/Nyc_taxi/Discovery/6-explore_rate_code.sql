SELECT rate_code_id,rate_code
FROM OPENROWSET(
    BULK 'rate_code.json',
    DATA_SOURCE = 'nyc_taxi_data_raw',
    FORMAT = 'CSV',
    FIELDTERMINATOR = '0x0b', -- Unused character as JSON has no delimiter
    FIELDQUOTE = '0x0b',
    ROWTERMINATOR = '0x0b'
) WITH (
    BulkColumn NVARCHAR(MAX) -- Single column for raw JSON text
) AS rate_code
CROSS APPLY OPENJSON(BulkColumn)
WITH (
    rate_code_id INT,
    rate_code NVARCHAR(100)
) AS jsonData;


----- multiline json 

SELECT rate_code_id,rate_code
FROM OPENROWSET(
    BULK 'rate_code_multi_line.json',
    DATA_SOURCE = 'nyc_taxi_data_raw',
    FORMAT = 'CSV',
    FIELDTERMINATOR = '0x0b', -- Unused character as JSON has no delimiter
    FIELDQUOTE = '0x0b',
    ROWTERMINATOR = '0x0b'

) WITH (
    BulkColumn NVARCHAR(MAX) -- Single column for raw JSON text
) AS rate_code
CROSS APPLY OPENJSON(BulkColumn)
WITH (
    rate_code_id INT,
    rate_code NVARCHAR(100)
) AS jsonData;
