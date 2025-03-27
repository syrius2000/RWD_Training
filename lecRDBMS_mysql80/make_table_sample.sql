-- ADMISSIONNO,PATIENTNO,入院日,退院日,入院時診療科CD,退院時診療科CD,入院時診療科名,退院時診療科名,DPC病名,ICD10CD,病名区分-- 20118395,11919280,2020-08-12,2021-10-30,10,10,小児科,小児科,発作性寒冷ヘモグロビン尿症,D596,入院後発症疾患名-- 20118395,11919280,2020-08-12,2021-10-30,10,10,小児科,小児科,悪性リンパ腫,C859,主病名-- 20118395,11919280,2020-08-12,2021-10-30,10,10,小児科,小児科,悪性リンパ腫,C859,入院契機病名-- 20118395,11919280,2020-08-12,2021-10-30,10,10,小児科,小児科,後天性凝固因子欠乏症,D684,医療資源病名１-- Vim: set expandtab, set filetype=sql:CREATE DATABASE IF NOT EXISTS COVID ;USE COVID;DROP TABLE IF EXISTS Inpatient;CREATE TABLE IF NOT EXISTS Inpatient(    VAR VARCHAR(10)    ,PTID VARCHAR(13)                        -- 02 - PATIENTNO    ,HospitalCode VARCHAR(15)                -- 01 - ADMISSIONNO    ,HospitalIn DATE                         -- 03 - 入院日    ,HospitalOut DATE                        -- 04 - 退院日    ,HospitalCat VARCHAR(20) DEFAULT NULL    -- 11 - 病名区分 DPCに紐づくのでDPCDiseseCatがいい?    ,DPCName VARCHAR(30) DEFAULT NULL        -- 09 - DPC病名    ,ICD10 VARCHAR(20) DEFAULT NULL          -- 10 - ICD10CD    ,ClinicInCode VARCHAR(20) DEFAULT NULL   -- 05 - 入院時診療科CD    ,ClinicInName VARCHAR(20) DEFAULT NULL   -- 07 - 入院時診療科名    ,ClinicOutCode VARCHAR(20) DEFAULT NULL  -- 06 - 退院時診療科CD    ,ClinicOutName VARCHAR(20) DEFAULT NULL  -- 08 - 退院時診療科名);SET GLOBAL local_infile=1;SET GLOBAL sql_mode='';LOAD DATA LOCAL  infile '/home/fuga/samplefile.csv'  REPLACEINTO TABLE  InpatientFIELDS  TERMINATED BY ','  ENCLOSED BY '"'  LINES TERMINATED BY '\r\n'IGNORE 1 LINES    (@01, @02, @03, @04, @05, @06, @07, @08, @09, @10, @11)SET    VAR ='入院DPC病名'    ,PTID           = @02 -- 02- PATIENTNO    ,HospitalCode   = @01 -- 01- ADMISSIONNO    ,HospitalIn     = nullif(@03, '') -- 03- 入院日    ,HospitalOut    = nullif(@04, '') -- 04- 退院日    ,HospitalCat    = @11 -- 11- 病名区分    ,DPCName        = @09 -- 09- DPC病名    ,ICD10          = @10 -- 10- ICD10CD    ,ClinicInCode   = @05 -- 05- 入院時診療科CD    ,ClinicInName   = @07 -- 07- 入院時診療科名    ,ClinicOutCode  = @06 -- 06- 退院時診療科CD    ,ClinicOutName  = @08 -- 08- 退院時診療科名;