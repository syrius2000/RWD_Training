# -*- mode:R; mode:outline-minor; coding:utf-8 -*-
options(nvimcom.verbose = 5)
options(width=102, length=1000)# {{{
library(quietly=T, "MASS");
library(quietly=T, "stats");
library(quietly=T, "Matrix");
library(quietly=T, "R.utils");
library(quietly=T, "ggplot2");
library(quietly=T,'RMySQL');
library(quietly=T,'stringr');
library(quietly=T, "tidyverse");
# }}}
## #########################[ 104 ]  start script        ##############################################
## Document :
## section
## Description カラムの内容リスト（いわゆるYellowBook）を作成する
###

############
FetchData <- function(query="show tables;") {
  con <- dbConnect(RMySQL::MySQL(),
                   host= "localhost",
                   ##host= "IMAC-5B1067.local",
                   user ="RWDuser",
                   password="RWDuser",
                   dbname ="VACCINE"
  )
  ##
  res <- dbSendQuery(con, query)
  df <- dbFetch(res, n=-1)   # dont forget n=-1
  dbClearResult(res)
  ## ## RDBMSと接続を切る
  dbDisconnect(con)
  return(df)
} ## FetchData()

# Data fetch --------------------------------------------------------------
## SQLを回してDF0に保存する
## 注意：YMはHospitalIn：入院日を基準にYYYY_MMでコーディングしている

## 重複レコードを確認する
  #  1 +-------------------------+
  #  2 | Tables_in_vaccine       |
  #  3 +-------------------------+
  #  4 | COVID19ワクチン接種     |
  #  5 | COVID検査               |
  #  6 | 一般検査                |
  #  7 | 入院情報                |
  #  8 | 処方薬剤                |
  #  9 | 外来情報                |
  # 10 | 患者基本情報            |
  # 11 | 患者基本情報_身長体重   |
  # 12 | 注射薬剤                |
  # 13 | 病名データ_DPC          |
  # 14 | 病名データ_カルテオーダ |
  # 15 | 請求データ              |
  # 16 | 重症度・転帰            |
  # 17 +-------------------------+


source("ListAllColumn.sql")

FetchData(query="describe ClinicalExam;")

FetchData()

## Addressに重複なし

### ClinicalExam
FetchData(query="describe ClinicalExam;")

Qstr="
SELECT * FROM (
  SELECT count(VAR) as CNT,
    VAR ,YR ,PTID ,HospitalIn ,HospitalOut ,ExamDate ,ExamOrder ,ExamName ,ExamValue
  FROM ClinicalExam
  GROUP BY
    VAR ,YR ,PTID ,HospitalIn ,HospitalOut ,ExamDate ,ExamOrder ,ExamName ,ExamValue
  ) t
WHERE t.CNT > 1;
"
##
##
##
Dup.clinicalexam <- FetchData(query=Qstr)
dim(Dup.clinicalexam)
write.csv(Dup.clinicalexam, file="Dup.ClinicalExam.CSV")


### DrugDS
Qstr="
SELECT * FROM (
  SELECT count(VAR) as CNT,
    VAR ,PTID ,Kubun ,OrderNO ,Department ,DoseStartDate ,DoseEndDate ,DrugCODE ,DrugName ,YJCode ,Dose ,Unit ,DoseRoute ,DoseComment1 ,DoseComment2
  FROM DrugDS
  GROUP BY
    VAR ,PTID ,Kubun ,OrderNO ,Department ,DoseStartDate ,DoseEndDate ,DrugCODE ,DrugName ,YJCode ,Dose ,Unit ,DoseRoute ,DoseComment1 ,DoseComment2
  ) t
WHERE t.CNT > 1;
"
## 2234 重複
## 2234 rows in set
## Time: 241.594s
Dup.DrugDS <- FetchData(query=Qstr)
write.csv(Dup.DrugDS, file="Dup.DrugDS.CSV")


### DrugIV
Qstr="
SELECT * FROM (
    SELECT count(VAR) AS CNT,
VAR ,PTID ,Kubun ,OrderNO ,DrugCode ,YJCode ,DrugName ,DoseStartDate ,Department ,Dose ,Unit ,DoseRoute ,DoseTimes ,DosageName
    FROM DrugIV
    GROUP BY
VAR ,PTID ,Kubun ,OrderNO ,DrugCode ,YJCode ,DrugName ,DoseStartDate ,Department ,Dose ,Unit ,DoseRoute ,DoseTimes ,DosageName
    ) t
WHERE t.CNT > 1;
"
##
##
##
Dup.DrugIV <- FetchData(query=Qstr)
dim(Dup.DrugIV)
## [1] 238107     15
write.csv(Dup.DrugIV, file="Dup.DrugIV.CSV")

### Inpatient
Qstr="
SELECT * FROM (
    SELECT count(VAR) as CNT,
VAR ,PTID ,Sex ,Birthday ,HospitalCode ,HospitalIn ,HospitalOut ,HospitalCat ,DPCName ,ICD10 ,DiagDate ,ClinicInCode ,ClinicInName ,ClinicOutCode ,ClinicOutName
    FROM Inpatient
    GROUP BY
VAR ,PTID ,Sex ,Birthday ,HospitalCode ,HospitalIn ,HospitalOut ,HospitalCat ,DPCName ,ICD10 ,DiagDate ,ClinicInCode ,ClinicInName ,ClinicOutCode ,ClinicOutName
    ) t
WHERE t.CNT > 1;
"
##
##
Dup.Inpatient <- FetchData(query=Qstr)
dim(Dup.Inpatient)
write.csv(Dup.Inpatient, file="Dup.Inpatient.CSV")


### Outpatient
Qstr="
SELECT * FROM (
    SELECT count(VAR) as CNT,
        VAR ,PTID ,AppointmentDate ,Birthday ,Sex ,ClinicInCode
    FROM Outpatient
    GROUP BY
    VAR ,PTID ,AppointmentDate ,Birthday ,Sex ,ClinicInCode
    ) t
WHERE t.CNT > 1;
"
##
##
Dup.Outpatient <- FetchData(query=Qstr)
dim(Dup.Outpatient)
write.csv(Dup.Outpatient, file="Dup.Outpatient.CSV")


### Rezept
Qstr="
SELECT * FROM (
    SELECT count(VAR) as CNT,
        VAR ,PTID ,Sex ,Birthday ,DiseaseCode ,DiseaseName ,DateDiag ,DateRemission
    FROM Rezept
    GROUP BY
        VAR ,PTID ,Sex ,Birthday ,DiseaseCode ,DiseaseName ,DateDiag ,DateRemission
    ) t
WHERE t.CNT > 1;
"
##
##
Dup.Rezept <- FetchData(query=Qstr)
dim(Dup.Rezept)
write.csv(Dup.Rezept, file="Dup.Rezept.CSV")


### Vital
Qstr="
SELECT * FROM (
  SELECT count(VAR) as CNT,
    var ,yr ,ptid ,hospitalcode ,hospitalin ,hospitalout ,measurementdate ,measurementtime ,vitalsigns ,vitalresult
  FROM Vital
  GROUP BY
    VAR ,YR ,PTID ,HospitalCode ,HospitalIn ,HospitalOut ,measurementDate ,measurementTime ,VitalSigns ,VitalResult
    ) t
WHERE t.CNT > 1;
"
##
##
Dup.Vital <- FetchData(query=Qstr)
dim(Dup.Vital)
write.csv(Dup.Vital, file="Dup.Vital.CSV")

## summary 重複ファイルのSummary
# % for i in *.CSV;do echo $i,"\t";wc $i;done
## Dup.ClinicalExam.CSV,
##     2235    2349  239529 Dup.ClinicalExam.CSV
## Dup.DrugDS.CSV,
##    47112  205925 10606748 Dup.DrugDS.CSV
## Dup.DrugIV.CSV,
##   238108  903503 54935396 Dup.DrugIV.CSV
## Dup.Inpatient.CSV,
##    17079  136559 3648906 Dup.Inpatient.CSV
## Dup.Outpatient.CSV,
##      881    2297   73562 Dup.Outpatient.CSV
## Dup.Rezept.CSV,
##        1       1      94 Dup.Rezept.CSV
## Dup.Vital.CSV,
##    14782   44344 2102011 Dup.Vital.CSV

print(dim(Dup.clinicalexam))
print(dim(Dup.DrugIV))
print(dim(Dup.Inpatient))
print(dim(Dup.Outpatient))
print(dim(Dup.Rezept))
print(dim(Dup.Vital))

## Local Variables:
## fill-column   : 88
## comment-column: 0
## eval: (flycheck-mode 0)
## eval: (linum-mode 1)
## eval: (setq linum-format "%3d ")
## End:
