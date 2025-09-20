USE VACCINE;

DROP TABLE IF EXISTS 病名データ_DPC;
CREATE TABLE 病名データ_DPC (
    PATIENTNO VARCHAR(20) NOT NULL,    -- 患者番号
    NYUINNO VARCHAR(20) NOT NULL,      -- 入院番号
    SEQNO INT NOT NULL,                -- シーケンス番号
    BYOMEICD VARCHAR(20),              -- 病名コード
    BYOMEI VARCHAR(100),               -- 病名
    SHINRYOKACD VARCHAR(10),           -- 診療科コード
    KAISHIYMD DATE NULL,           -- 開始年月日
    SHURYOYMD DATE NULL            -- 終了年月日
    -- KAISHIYMD DATETIME NULL,           -- 開始年月日
    -- SHURYOYMD DATETIME NULL            -- 終了年月日
    -- PRIMARY KEY (PATIENTNO, NYUINNO, SEQNO) -- 複合主キー
);

-- SHOW TABLES;
DESCRIBE 病名データ_DPC;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t14_その他：病名データ_DPC_納品.txt'
LOAD DATA INFILE '/tmp/CH_t14_その他：病名データ_DPC_納品.txt'
INTO TABLE 病名データ_DPC
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    PATIENTNO,
    NYUINNO,
    SEQNO,
    BYOMEICD,
    BYOMEI,
    SHINRYOKACD,
    @KAISHIYMD_STR,    -- 一時変数に読み込む
    @SHURYOYMD_STR     -- 一時変数に読み込む
)
SET
    -- KAISHIYMD カラムの処理: 空文字列の場合NULLに変換
    KAISHIYMD = STR_TO_DATE(NULLIF(@KAISHIYMD_STR, ''), '%Y/%m/%d %H:%i:%s'),
    -- SHURYOYMD カラムの処理: 空文字列の場合NULLに変換
    SHURYOYMD = STR_TO_DATE(NULLIF(@SHURYOYMD_STR, ''), '%Y/%m/%d %H:%i:%s');


select * from 病名データ_DPC limit 10;
