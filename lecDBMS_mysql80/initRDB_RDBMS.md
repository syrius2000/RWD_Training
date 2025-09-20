# MySQLのインストール

MySQLのサーバーをインストールします。
```bash
sudo apt install mysql-server
```

## サーバーサイドの設定
'/etc/mysql/mysql.conf.d/mysqld.cnf'を編集

``` ini-file
# サーバー側
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci
default-time-zone=+09:00

# クライアント側
[client]
default-character-set=utf8mb4
```
`utf8mn4`は4バイト文字。 `utf8`は3バイト文字。`CP932`,`SJIS`は2バイトマルチバイト文字に注意！

設定後サーバの再起動
`sudo systemctl restart mysql`

https://documentation.ubuntu.com/server/how-to/databases/install-mysql/index.html

## 初期設定とセキュリティ強化

MySQLのインストール後、セキュリティ設定スクリプトを実行します。これにより、不要な匿名ユーザーの削除、rootユーザーのリモートログインの禁止、テストデータベースの削除などが行われます。

```bash
sudo mysql_secure_installation
sudo mysql -u root -p
```

## データベースユーザの作成と権限設定

``` SQL
CREATE USER 'ユーザー名'@'localhost' IDENTIFIED BY 'パスワード';
GRANT ALL PRIVILEGES ON データベース名.* TO 'ユーザー名'@'localhost';
FLUSH PRIVILEGES;
```

