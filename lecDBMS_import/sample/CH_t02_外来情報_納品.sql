USE VACCINE;

DROP TABLE IF EXISTS 外来情報;
CREATE TABLE 外来情報 (
    APPOINTMENTNO VARCHAR(20) NOT NULL,          -- 予約番号
    PATIENTNO VARCHAR(20) NOT NULL,              -- 患者番号
    DEPARTMENTCODE VARCHAR(10),                  -- 部署コード
    DEPARTMENTNAME VARCHAR(50),                  -- 部署名
    SEX VARCHAR(1),                              -- 性別
    PATIENTAGE INT,                              -- 患者年齢
    VISITDATE DATE NULL,                         -- 受診日（日付のみ、NULL許容）
    VISITTIME VARCHAR(10),                       -- 受診時刻（文字列として保持）
    CONSULTSTARTTIME VARCHAR(10),                -- 診察開始時刻（文字列として保持）
    CONSULTENDTIME VARCHAR(10),                  -- 診察終了時刻（文字列として保持）
    ADMISSIONDEPT VARCHAR(10),                   -- 入院部署
    ADMISSIONDEPTNAME VARCHAR(50),               -- 入院部署名
    ADMISSIONWARD VARCHAR(10)                    -- 入院病棟
);

-- SHOW TABLES;
DESCRIBE 外来情報;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t02_外来情報_納品.txt'
LOAD DATA INFILE '/tmp/CH_t02_外来情報_納品.txt'
INTO TABLE 外来情報
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    APPOINTMENTNO,
    PATIENTNO,
    DEPARTMENTCODE,
    DEPARTMENTNAME,
    SEX,
    PATIENTAGE,
    @VISITDATE_STR,
    VISITTIME,
    CONSULTSTARTTIME,
    CONSULTENDTIME,
    ADMISSIONDEPT,
    ADMISSIONDEPTNAME,
    ADMISSIONWARD
)
SET
    VISITDATE = STR_TO_DATE(NULLIF(@VISITDATE_STR, ''), '%Y/%m/%d %H:%i:%s');

SELECT * FROM 外来情報 LIMIT 40;
