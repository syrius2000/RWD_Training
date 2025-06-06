# -*- mode:R; mode:outline-minor; coding:utf-8 -*-
options(nvimcom.verbose = 5)
options(width=102, length=1000)# {{{
library(quietly=T, "MASS");
library(quietly=T, "stats");
library(quietly=T, "Matrix");
library(quietly=T, "R.utils");
library(quietly=T, "ggplot2");
library(quietly=T, 'RMySQL');
library(quietly=T, 'stringr');
library(quietly=T, "tidyverse");
# }}}
## #########################[ 104 ]  start script        ##############################################
## Document :
## Description カラムの内容リスト（いわゆるYellowBook）を作成する
##             処方薬剤, 注射薬剤, 病名データ_DPC, 病名データ_カルテオーダのコード表と玉を作成する
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
  df <- dbFetch(res, n = -1)   # dont forget n-1
  dbClearResult(res)
  ## RDBMSと接続を切る
  dbDisconnect(con)
  return(df)
} ## FetchData()

## Data fetch --------------------------------------------------------------
## SQLを回してDFに保存する
## 注意：YMはHospitalIn：入院日を基準にYYYY_MMでコーディングしている
## 重複レコードを確認する
##    +-------------------------+
##    | Tables_in_VACCINE       |
##    +-------------------------+
##  1 | COVID19ワクチン接種     |
##  2 | COVID検査               |
##  3 | 一般検査                |
##  4 | 入院情報                |
##  5 | 処方薬剤                |
##  6 | 外来情報                |
##  7 | 患者基本情報            |
##  8 | 患者基本情報_身長体重   |
##  9 | 注射薬剤                |
## 10 | 病名データ_DPC          |
## 11 | 病名データ_カルテオーダ |
## 12 | 請求データ              |
## 13 | 重症度・転帰            |
##    +-------------------------+
## ListAllColumn.sqlに全テーブル名をハードコードして回す（ださOrz
## SQLで直接OUTFILE指定しても良い。
## ただ、セーブ権限の設定とSQLデーモンの権限の確認調整が必要なので複雑。/tmp/に逃げる

source("ListAllColumn.sql")
file_path  <- "ListAllColumn.sql"
# ファイルの存在を確認
if (!file.exists(file_path)) {
  stop("SQLファイルが見つかりません: ", file_path)
}

## SQLをストリームするのでR形式ではいかんよ。
sql_query = readChar(file_path, file.info(file_path)$size)
res <- FetchData(sql_query)
write.csv(res, "VACCINE_ALL_Columne_Name.txt")


#  5 | 処方薬剤                |
## {{{ 処方薬剤, Walface , medicin code
query="
SELECT
   WELFARECODE
  ,MEDICINENAME
  ,COUNT(MEDICINENAME) as CNT
FROM 処方薬剤
GROUP BY
   WELFARECODE
  ,MEDICINENAME
ORDER BY
   WELFARECODE;
"
res <-FetchData(query)
write.csv(res, file = "Code処方薬剤WELFARE.csv")
## }}}

#  9 | 注射薬剤                |
## {{{ 注射薬剤, Walface , medicin code
query="
SELECT
   WELFARECODE
  ,MEDICINENAME1
  ,COUNT(MEDICINENAME1 ) as CNT
FROM 注射薬剤
GROUP BY
   WELFARECODE
  ,MEDICINENAME1
ORDER BY
   WELFARECODE;
"
res <-FetchData(query)
write.csv(res, file = "Code注射薬剤WELFARE1.csv")
## }}}

# 10 | 病名データ_DPC          |
## {{{ 病名データ_DPC
query="
SELECT
   BYOMEICD
  ,BYOMEI
  ,COUNT(BYOMEICD) as CNT
FROM 病名データ_DPC
GROUP BY
  BYOMEICD
 ,BYOMEI
ORDER BY
  BYOMEICD
  ,BYOMEI ;
"
res <-FetchData(query)
write.csv(res, file="Code病名データ.csv")
## }}}

# 11 | 病名データ_カルテオーダ |
## {{{ {病名データ_カルテオーダ
query="
SELECT
   DISEASECODE
  ,DIAGNOSISDISEASE
  ,COUNT(DISEASECODE) as CNT
FROM 病名データ_カルテオーダ
GROUP BY
   DISEASECODE
  ,DIAGNOSISDISEASE
ORDER BY
   DISEASECODE
  ,DIAGNOSISDISEASE ;
"
res <-FetchData(query)
write.csv(res, file="Code病名データ_カルテオーダ.csv")
## }}}



# ## {{{
# query="
# SELECT
#
# ,COUNT() as CNT
# FROM
# GROUP BY
# ORDER BY
#
# ; "
# res <-FetchData(query)
# write.csv(res, file="Code.csv")
# ## }}}

## Local Variables:
## fill-column   : 88
## comment-column: 0
## eval: (flycheck-mode 0)
## eval: (linum-mode 1)
## eval: (setq linum-format "%3d ")
## End:
