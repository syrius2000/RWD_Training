# -*- mode:R; mode:outline-minor; coding:utf-8 -*-
options(nvimcom.verbose = 5)
options(width = 102, length = 1000)# {{{
library(quietly = TRUE, "MASS");
library(quietly = TRUE, "stats");
library(quietly = TRUE, "Matrix");
library(quietly = TRUE, "R.utils");
library(quietly = TRUE, "ggplot2");
library(quietly = TRUE, 'stringr');
library(quietly = TRUE, 'DBI')
library(quietly = TRUE, 'RMySQL')
# }}}

# ----------------------------------------------------------------
# 2. データベース接続情報の設定
db_config <- list(
  host      = "127.0.0.1",
  user      = "RWDuser",
  password  = "RWDuser",
  dbname    = "VACCINE"
)

# ----------------------------------------------------------------
# 3. SQLファイルのパス設定
# ----------------------------------------------------------------
sql_file_path <- "UniqCount.SQL"

# ----------------------------------------------------------------
# 4. メイン処理
# ----------------------------------------------------------------

# データベース接続を確立
# エラーが発生しても必ず接続が閉じるように on.exit を設定します
con <- NULL
on.exit(if (!is.null(con)) dbDisconnect(con), add = TRUE)

tryCatch({
  # データベースに接続
  con <- dbConnect(
    RMySQL::MySQL(),
    host = db_config$host,
    user = db_config$user,
    password = db_config$password,
    dbname = db_config$dbname
  )

  # MySQL接続時の文字コードを設定（文字化け対策）
  dbExecute(con, "SET NAMES utf8mb4")

  # --- SQLファイルの読み込み ---
  # readLinesでファイルを行ごとに読み込み、pasteで1つの文字列に結合します
  message(paste("SQLファイルを読み込んでいます:", sql_file_path))
  sql_query <- paste(readLines(sql_file_path, encoding = "UTF-8"), collapse = " ")

  # --- SQLの実行とデータフレームへの格納 ---
  message("SQLクエリを実行し、結果を取得しています...")
  # dbGetQueryはクエリを実行し、結果全体をデータフレームとして返します
  result_df <- dbGetQuery(con, sql_query)
  message("クエリの実行が完了しました。")

  # --- 結果の確認 ---
  print("取得したデータの先頭部分:")
  print(head(result_df))

  print("取得したデータの構造:")
  str(result_df)

}, error = function(e) {
  # エラーが発生した場合の処理
  message("エラーが発生しました:")
  message(e$message)

}, finally = {
  # --- データベース接続の切断 ---
  if (!is.null(con) && dbIsValid(con)) {
    dbDisconnect(con)
    message("データベース接続を閉じました。")
  }
})

# `result_df` というデータフレームに集計結果が格納
write.csv(result_df, "UniqCount.csv")
