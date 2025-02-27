
SELECT JSON_VALUE(BulkColumn, '$.payment_type') payment_type,
    JSON_VALUE(BulkColumn, '$.payment_type_desc') payment_type_desc
FROM OPENROWSET(
    BULK 'payment_type.json',
    DATA_SOURCE = 'nyc_taxi_data_raw',
    FORMAT = 'CSV',
    FIELDTERMINATOR = '0x0b', -- Unused character as JSON has no delimiter
    FIELDQUOTE = '0x0b', 
    ROWTERMINATOR = '0x0a'   -- Newline character for each JSON object
) WITH (
    BulkColumn NVARCHAR(MAX) -- Single column for raw JSON text
) AS payment_type;


SELECT payment_type,payment_type_desc
FROM OPENROWSET(
    BULK 'payment_type.json',
    DATA_SOURCE = 'nyc_taxi_data_raw',
    FORMAT = 'CSV',
    FIELDTERMINATOR = '0x0b', -- Unused character as JSON has no delimiter
    FIELDQUOTE = '0x0b'
) WITH (
    BulkColumn NVARCHAR(MAX) -- Single column for raw JSON text
) AS payment_type
CROSS APPLY OPENJSON(BulkColumn)
WITH (
    payment_type INT,
    payment_type_desc NVARCHAR(100)
) AS jsonData;



-------reading file from json array 

SELECT payment_type,payment_type_dec_value
FROM OPENROWSET(
    BULK 'payment_type_array.json',
    DATA_SOURCE = 'nyc_taxi_data_raw',
    FORMAT = 'CSV',
    FIELDTERMINATOR = '0x0b', -- Unused character as JSON has no delimiter
    FIELDQUOTE = '0x0b'
) WITH (
    BulkColumn NVARCHAR(MAX) -- Single column for raw JSON text
) AS payment_type
CROSS APPLY OPENJSON(BulkColumn)
WITH (
    payment_type INT,
    payment_type_desc NVARCHAR(max) as Json
) CROSS APPLY OPENJSON(payment_type_desc)
 WITH (
    sub_type INT,
    payment_type_dec_value VARCHAR(20) '$.value'
 );


