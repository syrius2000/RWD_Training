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
    .resultDF <<- NULL
  con <- dbConnect(RMySQL::MySQL(),
                   host= "localhost",
                   ##host= "IMAC-5B1067.local",
                   user ="RWDuser",
                   password="RWDuser",
                   dbname ="VACCINE"
  )
  ##
  time_result = system.time({
      message("SQLクエリを実行し、結果を取得しています...")
      ## dbGetQueryはクエリを実行し、結果全体をデータフレームとして返します
      df <- dbGetQuery(con, query)
      message("クエリの実行が完了しました。")
      ## RDBMSと接続を切る
      if (!is.null(con) && dbIsValid(con)) {
          dbDisconnect(con)
          message("データベース接続を閉じました。")
      }
  })
  ## 経過時間だけを取り出す
  cat("経過時間 (elapsed):", time_result["elapsed"], "秒\n")
  ## print(df, 5)
  .resultDF <<- df
  return(df)
} ## FetchData()
#################################################################

res <- FetchData()
res

QuerySTR="
SELECT
  COUNT(DISTINCT BYOMEICD) AS uniq_cnt_BYOMEICD
 ,COUNT(DISTINCT BYOMEI)   AS uniq_cnt_BYOMEI
FROM 病名データ_DPC;
"
res <- FetchData(QuerySTR)
.resultDF

# # +-------------------+-----------------+
# # | uniq_cnt_BYOMEICD | uniq_cnt_BYOMEI |
# # +-------------------+-----------------+
# # |              3663 |            7328 |
# # +-------------------+-----------------+
# 1 row in set (0.47 sec)
