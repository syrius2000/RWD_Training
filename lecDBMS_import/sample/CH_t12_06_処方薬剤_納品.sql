
USE VACCINE;
DROP TABLE IF EXISTS 処方薬剤;

CREATE TABLE 処方薬剤 (
    PATIENTNO VARCHAR(20) NOT NULL,            -- 患者番号
    STARTDATE DATETIME NULL,                   -- 開始日
    -- ENDDATE DATETIME NULL,                     -- 終了日
    ENDDATE DATETIME NULL,                     -- 終了日
    PATIENTTYPE VARCHAR(10),                   -- 患者タイプ
    ORDERDEPARTMENT VARCHAR(10),               -- オーダー部署
    DOSAGECODE VARCHAR(10),                    -- 用量コード
    DOSAGENAME VARCHAR(90),                    -- 用量名
    TIMES INT,                                 -- 回数
    WELFARECODE VARCHAR(30),
    MEDICINENAME VARCHAR(200),                 -- 医薬品名
    QUANTITY INT,                              -- 数量
    UNIT1 VARCHAR(10)                          -- 単位
    -- PRIMARY KEY (PATIENTNO, STARTDATE, MEDICINECODE) -- 複合主キー
);

-- SHOW TABLES;
DESCRIBE 処方薬剤;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t12_06_処方薬剤_納品.txt'
LOAD DATA INFILE '/tmp/CH_t12_06_処方薬剤_納品.txt'
INTO TABLE 処方薬剤
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    PATIENTNO,
    @STARTDATE_STR,
    @ENDDATE_STR,
    PATIENTTYPE,
    ORDERDEPARTMENT,
    DOSAGECODE,
    DOSAGENAME,
    TIMES,
    WELFARECODE,
    MEDICINENAME,
    QUANTITY,
    UNIT1
)
SET
    STARTDATE = STR_TO_DATE(@STARTDATE_STR, '%Y/%m/%d %H:%i:%s'),
    ENDDATE = STR_TO_DATE(@ENDDATE_STR, '%Y/%m/%d %H:%i:%s');

SELECT * FROM 処方薬剤 LIMIT 10;
