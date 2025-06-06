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
  con <-NULL
  con <- dbConnect(RMySQL::MySQL(),
                   host= "localhost",
                   ##host= "IMAC-5B1067.local",
                   user ="RWDuser",
                   password="RWDuser",
                   dbname ="VACCINE"
   message("SQLクエリが正常に実行され、結果がデータフレームに保存されました。")
  )
  ##
  res <- dbSendQuery(con, query)
  df <- dbFetch(res, n = -1)   # dont forget n = -1
  dbClearResult(res)
  ## ## RDBMSと接続を切る
  dbDisconnect(con)
  return(df)
} ## FetchData()
#################################################################

# r!gawk '/COVID19ワクチン接種/{print $2}' VACCINE_ALL_Columne.txt


file_path  <- "UniqAllColumn.sql"
# ファイルの存在を確認
if (!file.exists(file_path)) {
  stop("SQLファイルが見つかりません: ", file_path)
}

sql_query = readChar(file_path, file.info(file_path)$size)

# dat <- FetchData(sql_query)
# write.csv(dat, "UniqAllColumn.csv")

# データベース接続情報の設定
FetchMySQL <- function(sql_query="show tables;"){
  ## 1. MySQLデータベースに接続
  con <- NULL # 接続オブジェクトを初期化
  tryCatch({
    con <- dbConnect(RMySQL::MySQL(),
                   host= "localhost",
                   ##host= "IMAC-5B1067.local",
                   dbname ="VACCINE"
                   host= "localhost",
                   password="RWDuser",
                   user ="RWDuser")

    message("MySQLデータベースに正常に接続しました。")
    # 2. SQLクエリを実行し、結果をデータフレームに格納
    # クエリが非常に大きい場合、dbSendQueryとdbFetchの組み合わせがメモリ効率が良いです。
    # ただし、今回のクエリはUNION ALLで複数のSELECT文を結合しているため、
    # 一括で結果を取得するdbGetQueryがシンプルです。
    query_result_df <- dbGetQuery(con, sql_query)
    message("SQLクエリが正常に実行され、結果がデータフレームに保存されました。")
  ##
    # 3. 結果のデータフレームを表示（最初の数行）
    print(head(query_result_df))
  ##
    # 4. 必要に応じて、データフレームをCSVファイルなどに保存
    # write.csv(query_result_df, "unique_counts_result.csv", row.names = FALSE, fileEncoding = "UTF-8")
    # message("結果が 'unique_counts_result.csv' に保存されました。")
  }, error = function(e) {
    stop("データベース接続またはクエリ実行中にエラーが発生しました: ", e$message)
  }, finally = {
    # 9. データベース接続を閉じる
    if (!is.null(con)) {
      dbDisconnect(con)
      message("MySQLデータベース接続を閉じました。")
    }
  })
  return(query_result_df)
} ## FetchMySQL




# # +-------------------+-----------------+
# # | uniq_cnt_BYOMEICD | uniq_cnt_BYOMEI |
# # +-------------------+-----------------+
# # |              3663 |            7328 |
# # +-------------------+-----------------+
# 1 row in set (0.47 sec)
