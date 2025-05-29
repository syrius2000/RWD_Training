# サーバー、クライアントの設定

MySQLのサーバ、クライアント設定を行う。

## 利用場面 Use Case

Open Source RDBMS の設定を　Windows(WSL2), Linux(Debian,Ubuntu,...), OS Xなど広く利用可能のPCに
導入するときの設定参考情報に利用できる。

設定ファイルにセキュリティを施す代わりに、コマンドラインを単純化できるようになる。

## MySQL Server setting exampe

```shell-session
/etc/my.cnf
[mysqld]
# allow ALL connections
bind-address = 0.0.0.0
mysqlx-bind-address = 127.0.0.1
lower_case_table_names = 2

# スレッドキャッシュ
thread_cache_size=2

# InnoDBのデータとインデックスをキャッシュするバッファのサイズ(推奨は物理メモリの7割)
innodb_buffer_pool_size = 8G

innodb_redo_log_capacity = 128M

# InnoDB のデータ領域をテーブル単位に保存
innodb_file_per_table=ON

skip-name-resolve = 1
join_buffer_size = 256K
binlog_cache_size = 16M
binlog_expire_logs_seconds = 60
binlog-expire-logs-seconds = 7200
key_buffer_size=0

# 削除されたバージョン: MySQL 8.0.3.
# expire_logs_days = 2

# ファイル出力無制限
secure-file-priv = ""
```

### MySQL Client setting exampe

```mysql --verbose --help```  により位置が判明される ```~/.my.cnf``` に適切なパーミッションを設定する。

その前提に於いて、IDやPASSWORDを設定すると実務的に便利です。

```shell-session
## ~/.my.cnf

[mysqldump]
# dummy paragraph

[client]
# this must be enabled on both the client and server side
user = hogehoe
password = XXXXXX

prompt=(\u@\h) [\d]>\_

loose-local-infile=1

pager  = less -XFR
# 色分け表示したい場合、USE grc!  https://github.com/garabik/grc
# pager  = grcat ~/.grcat | less -XFR

default-character-set = UTF8MB4
```

よく理解して設定すれば良い。


## ROOT の復活

``` RecoverRootGrants.sql``` が参考になる。


