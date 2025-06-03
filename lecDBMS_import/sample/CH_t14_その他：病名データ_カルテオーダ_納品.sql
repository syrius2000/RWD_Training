USE VACCINE;
-- 1186にエラー文字
DROP TABLE IF EXISTS 病名データ_カルテオーダ;

CREATE TABLE 病名データ_カルテオーダ (
    PATIENTNO VARCHAR(20) NOT NULL,    -- 患者番号
    DEPARTMENTCODE VARCHAR(10) NULL,        -- 部署コード
    DISEASECODE VARCHAR(20) NULL,           -- 疾患コード
    DIAGNOSISDISEASE VARCHAR(100) NULL,     -- 診断疾患
    VALIDSTARTDATE DATETIME NULL,      -- 有効開始日
    VALIDENDDATE DATETIME NULL,        -- 有効終了日
    MAINDISEASESTATUS VARCHAR(10) NULL,     -- 主疾患ステータス
    FINISHSTATUS VARCHAR(10) NULL,          -- 終了ステータス
    DIAGNOSISSTATUS VARCHAR(10) NULL        -- 診断ステータス
    -- PRIMARY KEY (PATIENTNO, DISEASECODE, VALIDSTARTDATE) -- 複合主キー
);

-- "021799040","52","I05140","僧帽弁閉鎖不全症Ⅳ度","2021/12/16 0:00:00","","3","","0"
--  Incorrect string value: '\x87W\x93x' for column 'DIAGNOSISDISEASE' at row 1186

-- SHOW TABLES;
DESCRIBE 病名データ_カルテオーダ;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t14_その他：病名データ_カルテオーダ_納品.txt'
LOAD DATA INFILE '/tmp/CH_t14_その他：病名データ_カルテオーダ_納品.txt'
INTO TABLE 病名データ_カルテオーダ
CHARACTER SET sjis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    PATIENTNO,
    DEPARTMENTCODE,
    DISEASECODE,
    DIAGNOSISDISEASE,
    @VALIDSTARTDATE_STR, -- 一時変数に読み込む
    @VALIDENDDATE_STR,   -- 一時変数に読み込む
    MAINDISEASESTATUS,
    FINISHSTATUS,
    DIAGNOSISSTATUS
)
SET
    -- VALIDSTARTDATE カラムの処理: 空文字列の場合NULLに変換
    VALIDSTARTDATE = STR_TO_DATE(NULLIF(@VALIDSTARTDATE_STR, ''), '%Y/%m/%d %H:%i:%s'),
    -- VALIDENDDATE カラムの処理: 空文字列の場合NULLに変換
    VALIDENDDATE = STR_TO_DATE(NULLIF(@VALIDENDDATE_STR, ''), '%Y/%m/%d %H:%i:%s');

select * from 病名データ_カルテオーダ limit 10;
