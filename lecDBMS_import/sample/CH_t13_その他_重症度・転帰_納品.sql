USE VACCINE;

DROP TABLE IF EXISTS 重症度・転帰;

CREATE TABLE 重症度・転帰 (
    ADMISSIONNO VARCHAR(20) NOT NULL,          -- 入院番号
    PATIENTNO VARCHAR(20) NOT NULL,            -- 患者番号
    ADMISSIONDATE DATETIME NULL,               -- 入院日
    SHIBOU INT NULL,                           -- 死亡フラグ
    NYUINJCS INT NULL,                         -- 入院時JCS
    TAIINJCS INT NULL,                         -- 退院時JCS
    NYUINADL1 INT NULL,                        -- 入院時ADL1
    NYUINADL2 INT NULL,                        -- 入院時ADL2
    NYUINADL3 INT NULL,                        -- 入院時ADL3
    NYUINADL4 INT NULL,                        -- 入院時ADL4
    NYUINADL5 INT NULL,                        -- 入院時ADL5
    NYUINADL6 INT NULL,                        -- 入院時ADL6
    NYUINADL7 INT NULL,                        -- 入院時ADL7
    NYUINADL8 INT NULL,                        -- 入院時ADL8
    NYUINADL9 INT NULL,                        -- 入院時ADL9
    NYUINADL10 INT NULL,                       -- 入院時ADL10
    TAIINADL1 INT NULL,                        -- 退院時ADL1
    TAIINADL2 INT NULL,                        -- 退院時ADL2
    TAIINADL3 INT NULL,                        -- 退院時ADL3
    TAIINADL4 INT NULL,                        -- 退院時ADL4
    TAIINADL5 INT NULL,                        -- 退院時ADL5
    TAIINADL6 INT NULL,                        -- 退院時ADL6
    TAIINADL7 INT NULL,                        -- 退院時ADL7
    TAIINADL8 INT NULL,                        -- 退院時ADL8
    TAIINADL9 INT NULL,                        -- 退院時ADL9
    TAIINADL10 INT NULL,                       -- 退院時ADL10
    SHUYAKUKBN INT NULL                        -- 集約区分
    -- PRIMARY KEY (ADMISSIONNO)                  -- 入院番号を主キーに設定
);

-- SHOW TABLES;
DESCRIBE 重症度・転帰;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t13_その他_重症度・転帰_納品.txt'
LOAD DATA INFILE '/tmp/CH_t13_その他_重症度・転帰_納品.txt'
INTO TABLE 重症度・転帰
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    ADMISSIONNO,
    PATIENTNO,
    @ADMISSIONDATE_STR,     -- DATETIME型の一時変数
    @SHIBOU_STR,            -- INT型の一時変数
    @NYUINJCS_STR,          -- INT型の一時変数
    @TAIINJCS_STR,          -- INT型の一時変数
    @NYUINADL1_STR,         -- INT型の一時変数
    @NYUINADL2_STR,
    @NYUINADL3_STR,
    @NYUINADL4_STR,
    @NYUINADL5_STR,
    @NYUINADL6_STR,
    @NYUINADL7_STR,
    @NYUINADL8_STR,
    @NYUINADL9_STR,
    @NYUINADL10_STR,
    @TAIINADL1_STR,
    @TAIINADL2_STR,
    @TAIINADL3_STR,
    @TAIINADL4_STR,
    @TAIINADL5_STR,
    @TAIINADL6_STR,
    @TAIINADL7_STR,
    @TAIINADL8_STR,
    @TAIINADL9_STR,
    @TAIINADL10_STR,
    @SHUYAKUKBN_STR
)
SET
    -- DATETIME型カラムの処理: 空文字列の場合NULLに変換
    ADMISSIONDATE = STR_TO_DATE(NULLIF(@ADMISSIONDATE_STR, ''), '%Y/%m/%d %H:%i:%s'),
    -- INT型カラムの処理: 空文字列の場合NULLに変換
    SHIBOU = NULLIF(@SHIBOU_STR, ''),
    NYUINJCS = NULLIF(@NYUINJCS_STR, ''),
    TAIINJCS = NULLIF(@TAIINJCS_STR, ''),
    NYUINADL1 = NULLIF(@NYUINADL1_STR, ''),
    NYUINADL2 = NULLIF(@NYUINADL2_STR, ''),
    NYUINADL3 = NULLIF(@NYUINADL3_STR, ''),
    NYUINADL4 = NULLIF(@NYUINADL4_STR, ''),
    NYUINADL5 = NULLIF(@NYUINADL5_STR, ''),
    NYUINADL6 = NULLIF(@NYUINADL6_STR, ''),
    NYUINADL7 = NULLIF(@NYUINADL7_STR, ''),
    NYUINADL8 = NULLIF(@NYUINADL8_STR, ''),
    NYUINADL9 = NULLIF(@NYUINADL9_STR, ''),
    NYUINADL10 = NULLIF(@NYUINADL10_STR, ''),
    TAIINADL1 = NULLIF(@TAIINADL1_STR, ''),
    TAIINADL2 = NULLIF(@TAIINADL2_STR, ''),
    TAIINADL3 = NULLIF(@TAIINADL3_STR, ''),
    TAIINADL4 = NULLIF(@TAIINADL4_STR, ''),
    TAIINADL5 = NULLIF(@TAIINADL5_STR, ''),
    TAIINADL6 = NULLIF(@TAIINADL6_STR, ''),
    TAIINADL7 = NULLIF(@TAIINADL7_STR, ''),
    TAIINADL8 = NULLIF(@TAIINADL8_STR, ''),
    TAIINADL9 = NULLIF(@TAIINADL9_STR, ''),
    TAIINADL10 = NULLIF(@TAIINADL10_STR, ''),
    SHUYAKUKBN = NULLIF(@SHUYAKUKBN_STR, '');


select * from 重症度・転帰 limit 10;
