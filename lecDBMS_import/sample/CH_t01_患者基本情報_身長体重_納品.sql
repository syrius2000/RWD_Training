USE VACCINE;

DROP TABLE IF EXISTS 患者基本情報_身長体重;
CREATE TABLE 患者基本情報_身長体重 (
    PATIENTNO VARCHAR(20) NOT NULL,            -- 患者番号
    SEX VARCHAR(1),                            -- 性別
    HEIGHTWEIGHTSTATUS VARCHAR(2),             -- 身長体重ステータス
    HEIGHTWEIGHT DECIMAL(5,2),                 -- 身長または体重（例: 156.7）
    HEIGHTWEIGHTDATE DATE                      -- 身長体重測定日（日付のみ）
    -- PRIMARY KEY (PATIENTNO, HEIGHTWEIGHTDATE)  -- 患者番号と日付の組み合わせを主キーに設定
);

-- SHOW TABLES;
DESCRIBE 患者基本情報_身長体重;

LOAD DATA LOCAL
    -- INFILE '/Users/myamaguchi/Data/Vaccin/CH_t01_患者基本情報_身長体重_納品.txt'
    INFILE '/tmp/CH_t01_患者基本情報_身長体重_納品.txt'
INTO TABLE 患者基本情報_身長体重                -- データを挿入するテーブル名
    CHARACTER SET CP932                         -- CSVファイルのエンコーディングをCP932に指定
    FIELDS TERMINATED BY ','                    -- 各フィールドがカンマで区切られている
    ENCLOSED BY '"'                             -- フィールドがダブルクォーテーションで囲まれている場合
    LINES TERMINATED BY '\r\n'                  -- 各行が改行コードで終わる
    IGNORE 1 ROWS                               -- CSVのヘッダー行をスキップする場合
(PATIENTNO, SEX, HEIGHTWEIGHTSTATUS, HEIGHTWEIGHT, @HEIGHTWEIGHTDATE_STR) -- 一時的に日付文字列を格納する変数
SET HEIGHTWEIGHTDATE = STR_TO_DATE(@HEIGHTWEIGHTDATE_STR, '%Y/%m/%d %H:%i:%s'); -- 日付と時刻のフォーマットを指定

SELECT * FROM 患者基本情報_身長体重 LIMIT 10;

-- テーブルの重複を削除する。TMPTABLEに一時的に重複を削除したデータを格納し、元のテーブルをクリアしてから再挿入する。
CREATE TABLE TMPTABLE AS SELECT DISTINCT * FROM 患者基本情報_身長体重;
-- 元のテーブルを削除する。
DROP TABLE 患者基本情報_身長体重;
-- 一時テーブルの名前を元のテーブル名に変更する。
ALTER TABLE TMPTABLE RENAME TO 患者基本情報_身長体重;

SELECT * FROM 患者基本情報_身長体重 LIMIT 10;