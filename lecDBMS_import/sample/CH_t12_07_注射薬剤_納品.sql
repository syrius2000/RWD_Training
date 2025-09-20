USE VACCINE;

-- 225472に不正文字
DROP TABLE IF EXISTS 注射薬剤;
CREATE TABLE 注射薬剤 (
    PATIENTNO VARCHAR(20) NOT NULL,            -- 患者番号
    STARTDATE DATETIME NULL,                   -- 開始日
    PATIENTTYPE VARCHAR(10),                   -- 患者タイプ
    ORDERDEPARTMENT VARCHAR(10),               -- オーダー部署
    ACCOUNTSTATUS2 VARCHAR(10),                -- アカウントステータス2
    ROUTECODE VARCHAR(10),                     -- 経路コード
    ROUTENAME VARCHAR(100),                    -- 経路名
    TIMES INT,                                 -- 回数
    WELFARECODE VARCHAR(20),                   -- 医薬品コード
    MEDICINENAME1 VARCHAR(100),                -- 医薬品名1
    QUANTITY DECIMAL(10,2),                    -- 数量
    SELECTEDUNIT VARCHAR(10),                  -- 選択単位
    QUANTITY1 DECIMAL(10,2),                   -- 数量1
    UNIT1 VARCHAR(10),                         -- 単位1
    QUANTITY2 DECIMAL(10,2),                   -- 数量2
    UNIT2 VARCHAR(10),                         -- 単位2
    QUANTITY3 DECIMAL(10,2),                   -- 数量3
    UNIT3 VARCHAR(10)                          -- 単位3
);

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t12_07_注射薬剤_納品.txt'
LOAD DATA INFILE '/tmp/CH_t12_07_注射薬剤_納品.txt'
INTO TABLE 注射薬剤
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    PATIENTNO,
    @STARTDATE_STR,     -- 一時変数に読み込む
    PATIENTTYPE,
    ORDERDEPARTMENT,
    ACCOUNTSTATUS2,
    ROUTECODE,
    ROUTENAME,
    TIMES,
    MEDICINECODE,
    MEDICINENAME1,
    QUANTITY,
    SELECTEDUNIT,
    QUANTITY1,
    UNIT1,
    QUANTITY2,
    UNIT2,
    QUANTITY3,
    UNIT3
)
SET
    -- STARTDATEカラムの処理:
    -- NULLIF(@STARTDATE_STR, '') は、@STARTDATE_STRが空文字列の場合にNULLを返し、
    -- それ以外の場合（空ではない文字列）は@STARTDATE_STRをそのまま返します。
    -- STR_TO_DATE(NULL, ...) はNULLを返すため、結果的に空文字列はDATETIME型NULLとして格納されます。
    STARTDATE = STR_TO_DATE(NULLIF(@STARTDATE_STR, ''), '%Y/%m/%d %H:%i:%s');


SELECT * FROM 注射薬剤 LIMIT 10;
