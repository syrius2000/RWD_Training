-- "ADMISSIONNO","PATIENTNO","OPEDATE","OPEAGE","入外区分","名称","Kコード","レセプト電算コード","診療科CD","診療科名"
-- "20048831","11398471","2018-01-15","55","入院","脳刺激装置植込術（片側の場合）","K1811","150255110","17","脳神経外科"
-- "20049441","2471802","2018-01-29","72","入院","脳刺激装置植込術（片側の場合）","K1811","150255110","17","脳神経外科"

USE VACCINE;

CREATE TABLE gomi (
    ADMISSIONNO INT NOT NULL,
    PATIENTNO INT NOT NULL,
    OPEDATE DATE NOT NULL,
    OPEAGE INT NOT NULL,
    入外区分 VARCHAR(255) NOT NULL,
    名称 VARCHAR(255) NOT NULL,
    Kコード VARCHAR(255) NOT NULL,
    レセプト電算コード VARCHAR(255) NOT NULL,
    診療科CD INT NOT NULL,
    診療科名 VARCHAR(255) NOT NULL
);

-- AIエージェントなし状態（プロンプトなし）で作成した場合のサンプル。

-- 問題1：数字に見えるが桁落ちケース（0xxxなどの場合xxxとなる）があるのでVARCHARにしたい。
-- 問題2：DATEカラムには、1)日付的に不整合なデータ、2)NULLでエラーなどの処理が必要（不完全データ処理）
-- 問題3：CSVのエンコード、ファイルフォーマット、CSV様式（クロージャ、セパレータ）が決め打ち。
-- 問題4：なぜかVARCHAR(255)と長く決め打ち（しかたないか）

-- ## 一般的な問題点（手作業で対応）
-- ## 標準的なインポートSQL
-- ## 1. カラムの文字列のサイズ長
-- ## 2. NULL ケースの存在
-- ## 3. フラットテーブルのEncoding
-- ## 4.フラットテーブルのレコードセパレータ
-- ## 5. 重複レコードがある場合はPrimaryが設定できない
-- ## 6. いわゆる外字とEncodingの問題
-- ## 7. 構造の不正（カラム数がレコードで一定か？）
-- ## 8. 複数のフラットファイルにまたがる場合

-- ----------------------------------------------------------------------------------------------
-- AIエージェントあり状態（プロンプトあり）で作成した場合のサンプル。
-- ----------------------------------------------------------------------------------------------

CREATE TABLE VACCINE.patients (
    ADMISSIONNO VARCHAR(255),
    PATIENTNO VARCHAR(255),
    OPEDATE DATE,
    OPEAGE VARCHAR(255),
    `入外区分` VARCHAR(255),
    `名称` VARCHAR(255),
    `Kコード` VARCHAR(255),
    `レセプト電算コード` VARCHAR(255),
    `診療科CD` VARCHAR(255),
    `診療科名` VARCHAR(255)
);

-- LOAD DATA INFILE statement
LOAD DATA INFILE '/path/to/your/patients.csv'
INTO TABLE VACCINE.patients
CHARACTER SET cp932 -- 文字コードはファイルに合わせて utf8 などに変更
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
IGNORE 1 LINES
(ADMISSIONNO, PATIENTNO, @OPEDATE_str, OPEAGE, `入外区分`, `名称`, `Kコード`, `レセプト電算コード`, `診療科CD`, `診療科名`)
SET
  OPEDATE = STR_TO_DATE(NULLIF(@OPEDATE_str, ''), '%Y-%m-%d');

-- 問題1：解消
-- 問題2：解消
-- 問題3：解消
-- 問題4：解消
-- 問題5：偶然？IndexやPrimaryは設定していない
-- 問題6：解消

