USE VACCINE ;

DROP TABLE IF EXISTS 請求データ;

CREATE TABLE 請求データ (
    PATIENTNO VARCHAR(20) NULL,           -- 患者番号
    ADMISSIONNO VARCHAR(20) NULL,         -- 入院番号
    ADMISSIONDATE DATETIME NULL,          -- 入院日
    DISFINALDATE DATETIME NULL,           -- 退院最終日
    RENNO VARCHAR(10) NULL,               -- 連番
    APKBN VARCHAR(10) NULL,               -- APKBN
    SEIKYUFROMDTE DATETIME NULL,          -- 請求開始日
    SEIKYUENDDTE DATETIME NULL,           -- 請求終了日
    HOUKATSUTEN INT NULL,                 -- 包括点
    DPCDEKIDAKATEN INT NULL,              -- DPC出来高点
    DPCSYOKUJI INT NULL                   -- DPC食事
    -- 主キーはNOT NULL制約が必要なため、ここでは指定しません。
    -- データに一意性を保証できるカラムの組み合わせがある場合のみ、
    -- テーブル作成後にALTER TABLEで主キーを追加してください。
    -- 例: PRIMARY KEY (PATIENTNO, ADMISSIONNO, SEIKYUFROMDTE)
);

-- SHOW TABLES;
DESCRIBE 請求データ;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t17_4_8請求データ_納品.txt'
LOAD DATA INFILE '/tmp/CH_t17_4_8請求データ_納品.txt'
INTO TABLE 請求データ
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    @PATIENTNO_STR,
    @ADMISSIONNO_STR,
    @ADMISSIONDATE_STR,
    @DISFINALDATE_STR,
    @RENNO_STR,
    @APKBN_STR,
    @SEIKYUFROMDTE_STR,
    @SEIKYUENDDTE_STR,
    @HOUKATSUTEN_STR,
    @DPCDEKIDAKATEN_STR,
    @DPCSYOKUJI_STR
)
SET
    -- VARCHAR型カラムの処理: 空文字列の場合NULLに変換
    PATIENTNO = NULLIF(@PATIENTNO_STR, ''),
    ADMISSIONNO = NULLIF(@ADMISSIONNO_STR, ''),
    RENNO = NULLIF(@RENNO_STR, ''),
    APKBN = NULLIF(@APKBN_STR, ''),

    -- DATETIME型カラムの処理: 空文字列の場合NULLに変換
    ADMISSIONDATE = STR_TO_DATE(NULLIF(@ADMISSIONDATE_STR, ''), '%Y/%m/%d %H:%i:%s'),
    DISFINALDATE = STR_TO_DATE(NULLIF(@DISFINALDATE_STR, ''), '%Y/%m/%d %H:%i:%s'),
    SEIKYUFROMDTE = STR_TO_DATE(NULLIF(@SEIKYUFROMDTE_STR, ''), '%Y/%m/%d %H:%i:%s'),
    SEIKYUENDDTE = STR_TO_DATE(NULLIF(@SEIKYUENDDTE_STR, ''), '%Y/%m/%d %H:%i:%s'),

    -- INT型カラムの処理: 空文字列の場合NULLに変換
    HOUKATSUTEN = NULLIF(@HOUKATSUTEN_STR, ''),
    DPCDEKIDAKATEN = NULLIF(@DPCDEKIDAKATEN_STR, ''),
    DPCSYOKUJI = NULLIF(@DPCSYOKUJI_STR, '');


select * from 請求データ limit 10;
