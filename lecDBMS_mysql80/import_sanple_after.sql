-- "ADMISSIONNO","PATIENTNO","OPEDATE","OPEAGE","入外区分","名称","Kコード","レセプト電算コード","診療科CD","診療科名"
-- "20048831","11398471","2018-01-15","55","入院","脳刺激装置植込術（片側の場合）","K1811","150255110","17","脳神経外科"
-- "20049441","2471802","2018-01-29","72","入院","脳刺激装置植込術（片側の場合）","K1811","150255110","17","脳神経外科"
-- file name : patients.csv


-- CREATE TABLE statement
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