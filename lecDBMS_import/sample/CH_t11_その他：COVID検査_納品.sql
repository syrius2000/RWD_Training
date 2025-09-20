USE VACCINE ;

DROP TABLE IF EXISTS COVID検査;
CREATE TABLE COVID検査 (
    PATIENTNO VARCHAR(20) NOT NULL,            -- 患者番号
    COLLECTDATE DATE NULL,                     -- 収集日
    TESTITEMCODE VARCHAR(10),                  -- 検査項目コード
    TESTITEMNAME VARCHAR(50),                  -- 検査項目名
    ADDCOMMENT1 VARCHAR(255),                  -- 追加コメント1
    ADDCOMMENT2 VARCHAR(255),                  -- 追加コメント2
    OUTOFSTANDARD VARCHAR(10),                 -- 基準外フラグ
    REPORTVALUE VARCHAR(255),                  -- 報告値
    MATERIALSNAME VARCHAR(50),                 -- 材料名
    EDITORIALRESULT VARCHAR(255),              -- 編集結果
    SPECIMENCOMMENTFLG VARCHAR(10)             -- 検体コメントフラグ
    -- PRIMARY KEY (PATIENTNO, COLLECTDATE, TESTITEMCODE) -- 複合主キー
);

-- SHOW TABLES;
DESCRIBE COVID検査;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t11_その他：COVID検査_納品.txt'
LOAD DATA INFILE '/tmp/CH_t11_その他：COVID検査_納品.txt'
INTO TABLE COVID検査
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    PATIENTNO,
    @COLLECTDATE_STR,     -- 一時変数に読み込む
    TESTITEMCODE,
    TESTITEMNAME,
    ADDCOMMENT1,
    ADDCOMMENT2,
    OUTOFSTANDARD,
    REPORTVALUE,
    MATERIALSNAME,
    EDITORIALRESULT,
    SPECIMENCOMMENTFLG
)
SET
    -- COLLECTDATEカラムの処理:
    -- NULLIF(@COLLECTDATE_STR, '') は、@COLLECTDATE_STRが空文字列の場合にNULLを返し、
    -- それ以外の場合（空ではない文字列）は@COLLECTDATE_STRをそのまま返します。
    -- STR_TO_DATE(NULL, ...) はNULLを返すため、結果的に空文字列はDATE型NULLとして格納されます。
    -- 日付フォーマットは'YYYYMMDD'形式なので '%Y%m%d' を指定します。
    COLLECTDATE = STR_TO_DATE(NULLIF(@COLLECTDATE_STR, ''), '%Y%m%d');

SELECT * FROM COVID検査 LIMIT 20;
