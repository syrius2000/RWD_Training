USE VACCINE;

DROP TABLE IF EXISTS 患者基本情報;
CREATE TABLE 患者基本情報 (
    PATIENTNO VARCHAR(20) NULL,
    SEX VARCHAR(2),
    BIRTHDAY DATE
);

-- SHOW TABLES;
DESCRIBE 患者基本情報;

-- LOAD DATA LOCAL INFILE '/Users/myamaguchi/Data/Vaccin/CH_t01_患者基本情報_納品.txt'
LOAD DATA LOCAL INFILE '/tmp/CH_t01_患者基本情報_納品.txt'
INTO TABLE 患者基本情報
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(PATIENTNO, SEX, @BIRTHDAY_STR)
SET BIRTHDAY = STR_TO_DATE(@BIRTHDAY_STR, '%Y%m%d');

select * from  患者基本情報 limit 10;

-- 重複削除のSQLを作成する。
-- 1. 元のテーブルと同じ構造で、重複を除いたデータを持つ新しいテーブルを作成する
CREATE TABLE 患者基本情報_new LIKE 患者基本情報;
INSERT INTO 患者基本情報_new SELECT DISTINCT * FROM 患者基本情報;

-- 2. 元のテーブルをバックアップとしてリネームし、新しいテーブルを元のテーブル名に変更する
-- この操作はアトミックに行われるため、処理中にテーブルにアクセスできなくなる時間が非常に短い
RENAME TABLE 患者基本情報 TO 患者基本情報_old, 患者基本情報_new TO 患者基本情報;

-- 3. 不要になった古いテーブルを削除する
DROP TABLE 患者基本情報_old;
