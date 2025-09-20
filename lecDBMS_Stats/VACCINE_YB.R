# -*- mode:R; mode:outline-minor; coding:utf-8 -*-
#
# Author: M.Y
#
# このスクリプトは、'VACCINE' データベースに接続し、
# 各テーブルの重複レコードを検出してCSVファイルに出力します。
#
options(nvimcom.verbose = 5)# {{{
options(width=102, length=1000)
library(quietly = TRUE, "MASS")
library(quietly = TRUE, "Matrix")
library(quietly = TRUE, "R.utils")
library(quietly = TRUE, "RMySQL")
library(quietly = TRUE, "ggplot2")
library(quietly = TRUE, "stats")
library(quietly = TRUE, "stringr")
library(quietly = TRUE, "tidyverse")
# }}}
## #########################[ 104 ]  start script        ##############################################
## Document :
## section
## Description 各テーブルの重複行をしらべて、重複分をCSVで保存する。
###

############
# MySQLデータベースに接続し、クエリを実行して結果をデータフレームとして返す関数
FetchData <- function(query="show tables;") {
  con <- dbConnect(RMySQL::MySQL(),
                   host= "localhost",
                   user ="RWDuser",
                   password="RWDuser",
                   dbname ="VACCINE"
  )
  ##
  res <- dbSendQuery(con, query)
  df <- dbFetch(res, n=-1)   # n=-1を指定して全てのレコードを取得
  dbClearResult(res)
  ## ## RDBMSと接続を切る
  dbDisconnect(con)
  return(df)
} ## FetchData()

# Data fetch --------------------------------------------------------------
# 各テーブルから重複レコードを検出し、CSVファイルとして出力します。
#
# データベース 'VACCINE' のテーブル一覧:
#  - COVID19ワクチン接種
#  - COVID検査
#  - 一般検査 (ClinicalExam)
#  - 入院情報 (Inpatient)
#  - 処方薬剤 (DrugDS)
#  - 外来情報 (Outpatient)
#  - 患者基本情報
#  - 患者基本情報_身長体重
#  - 注射薬剤 (DrugIV)
#  - 病名データ_DPC
#  - 病名データ_カルテオーダ (Rezept)
#  - 請求データ
#  - 重症度・転帰
#  - Vital (Vital)

# 'ClinicalExam' テーブルの重複レコードを確認
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
Dup.clinicalexam <- FetchData(query=Qstr)
dim(Dup.clinicalexam)
write.csv(Dup.clinicalexam, file="DUP/Dup.ClinicalExam.CSV")


# 'DrugDS' (処方薬剤) テーブルの重複レコードを確認
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
Dup.DrugDS <- FetchData(query=Qstr)
write.csv(Dup.DrugDS, file="DUP/Dup.DrugDS.CSV")


# 'DrugIV' (注射薬剤) テーブルの重複レコードを確認
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
Dup.DrugIV <- FetchData(query=Qstr)
dim(Dup.DrugIV)
write.csv(Dup.DrugIV, file="DUP/Dup.DrugIV.CSV")

# 'Inpatient' (入院情報) テーブルの重複レコードを確認
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
Dup.Inpatient <- FetchData(query=Qstr)
dim(Dup.Inpatient)
write.csv(Dup.Inpatient, file="DUP/Dup.Inpatient.CSV")


# 'Outpatient' (外来情報) テーブルの重複レコードを確認
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
Dup.Outpatient <- FetchData(query=Qstr)
dim(Dup.Outpatient)
write.csv(Dup.Outpatient, file="DUP/Dup.Outpatient.CSV")


# 'Rezept' (病名データ) テーブルの重複レコードを確認
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
Dup.Rezept <- FetchData(query=Qstr)
dim(Dup.Rezept)
write.csv(Dup.Rezept, file="DUP/Dup.Rezept.CSV")


# 'Vital' テーブルの重複レコードを確認
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
Dup.Vital <- FetchData(query=Qstr)
dim(Dup.Vital)
write.csv(Dup.Vital, file="DUP/Dup.Vital.CSV")

# -------------------------------------------------------------------------
# サマリー: 各テーブルで検出された重複レコード数を出力
# -------------------------------------------------------------------------
# コマンドラインで以下のコマンドを実行すると、各CSVファイルの行数を確認できます。
# for i in DUP/*.CSV;do echo $i; wc -l $i;done
#
# Dup.ClinicalExam.CSV:   2235
# Dup.DrugDS.CSV:         47112
# Dup.DrugIV.CSV:         238108
# Dup.Inpatient.CSV:      17079
# Dup.Outpatient.CSV:     881
# Dup.Rezept.CSV:         1
# Dup.Vital.CSV:          14782

print("--- Duplicate Record Counts ---")
print(paste("ClinicalExam:", nrow(Dup.clinicalexam)))
print(paste("DrugDS:", nrow(Dup.DrugDS)))
print(paste("DrugIV:", nrow(Dup.DrugIV)))
print(paste("Inpatient:", nrow(Dup.Inpatient)))
print(paste("Outpatient:", nrow(Dup.Outpatient)))
print(paste("Rezept:", nrow(Dup.Rezept)))
print(paste("Vital:", nrow(Dup.Vital)))
print("-----------------------------")

## Local Variables:
## fill-column   : 88
## comment-column: 0
## eval: (flycheck-mode 0)
## eval: (linum-mode 1)
## eval: (setq linum-format "%3d ")
## End:
