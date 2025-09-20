# MySQLサーバー・クライアント設定とデータベース操作スクリプト

## 概要 (Overview)
このディレクトリには、MySQLサーバーおよびクライアントの設定例、ならびにデータベースの初期化、ユーザー管理、データインポート、テーブル作成、アカウント復旧に関する各種SQLスクリプトが含まれています。

## 利用場面 (Use Case)
Windows (WSL2), Linux (Debian, Ubuntu), macOS など、様々な環境にMySQLを導入する際の設定参考情報として利用できます。

---

## A. 初期サーバー設定 (Initial Server Setup)
MySQLインストール後、最初に行うべき基本的なセキュリティ設定と文字コード設定の手順です。

1. **セキュリティ設定の実行**
以下のコマンドを実行し、対話形式で不要な匿名ユーザーの削除やリモートログインの禁止などを設定します。
```shell
sudo mysql_secure_installation
```

2. **設定ファイルの編集**
MySQLサーバーの文字コードやタイムゾーンを設定します。
**注意:** 設定ファイルの場所はOSにより異なります (例: Ubuntuでは `/etc/mysql/mysql.conf.d/mysqld.cnf`, CentOSでは `/etc/my.cnf`)。

以下の内容を `[mysqld]` セクションに追記または修正します。
```ini
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci
default-time-zone=+09:00
```

3. **MySQLサービスの再起動**
設定を反映させるために、MySQLサーバーを再起動します。
```shell
sudo systemctl restart mysql
```

---

## B. 設定ファイルの詳細例

### 1. MySQLサーバー設定例 (`/etc/my.cnf` or `mysqld.cnf`)
MySQLサーバーの主要な設定パラメータの例です。

```ini
[mysqld]
# 接続設定
bind-address = 0.0.0.0             # サーバーがリッスンするIPアドレス。0.0.0.0 はすべてのインターフェースからの接続を許可

# 文字コード・タイムゾーン設定
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci
default-time-zone=+09:00

# テーブル・ストレージ設定
lower_case_table_names = 2         # テーブル名の大文字・小文字の扱いを設定
innodb_buffer_pool_size = 8G       # InnoDBのデータキャッシュサイズ。物理メモリの7割程度が推奨
innodb_file_per_table=ON           # テーブルごとにデータファイルを分離

# セキュリティ設定
secure-file-priv = ""              # LOAD DATA INFILE などのファイル操作の制限。"" は無制限を意味するが、セキュリティリスクを伴う
```

### 2. MySQLクライアント設定例 (`~/.my.cnf`)
MySQLクライアントの接続情報や表示設定を記述するファイルです。

```shell-session
## ~/.my.cnf の内容
# 例:
# [client]
# user = hogehoe
# password = XXXXXX  # セキュリティ上の理由から、本番環境でのパスワード直書きは推奨されません
# prompt=(\u@\h) [\d]>\_
# loose-local-infile=1 # クライアント側からのファイル読み込みを許可
# pager  = less -XFR
# default-character-set = UTF8MB4
```

## 3. データベース初期化スクリプト
* **`initDB_Training.sql`**: トレーニング用のデータベースを初期化するスクリプトです。
* **`initDB_users.sql`**: データベースユーザーを作成し、適切な権限を付与するためのスクリプトです。

## 4. データインポート・テーブル作成スクリプト
* **`make_table_sample.sql`**: サンプルテーブルを作成するためのSQLスクリプトです。
* **`make_distinctTBL.sql`**: 重複排除されたデータを格納するテーブルを作成する例です。
* **`import_sample_before.sql`**: データインポート前の状態を示すサンプルSQLです。
* **`import_sanple_after.sql`**: データインポート後の状態を示すサンプルSQLです。

## 5. アカウント復旧・権限管理スクリプト
* **`RecoverRootGrants.sql`**: rootアカウントの権限を復旧するためのスクリプトです。rootパスワードを忘れた場合などに利用できます。
* **`RecoverGrant.sql`**: 特定のユーザーの権限を復旧または再設定するためのスクリプトです。
* **`lostRootAccount.sql`**: rootアカウントを紛失した場合の対応に関するスクリプトです。

## 実行方法
SQLスクリプトは、以下のコマンドで実行できます。
`--local-infile=1` オプションは、クライアント側からのファイル読み込みを許可するために必要です。

```shell
mysql --local-infile=1 -u RWDuser -p < import_hoge.sql
```
