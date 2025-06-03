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


setwd("/Users/myamaguchi/Documents/RWD_import/00Presentation/20250228/RWD_Training/lecDBMS_Stats/")
source("ListAllColumn.sql")

res <- FetchData(query)

FetchData("
describe COVID検査
")


### ClinicalExam
## dim(Dup.clinicalexam)
## write.csv(Dup.clinicalexam, file="Dup.ClinicalExam.CSV")



## Local Variables:
## fill-column   : 88
## comment-column: 0
## eval: (flycheck-mode 0)
## eval: (linum-mode 1)
## eval: (setq linum-format "%3d ")
## End:
