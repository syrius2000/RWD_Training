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
#################################################################

QuerySTR="
"

FetchData(QuerySTR)
