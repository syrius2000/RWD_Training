
-- root 権限で実施する必要があることに注意
-- fugafuga を適切に！

ALTER USER 'root'@'localhost' IDENTIFIED BY 'ROOT3543';
ALTER USER 'root'@'%'         IDENTIFIED BY 'ROOT3543';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY 'ROOT3543';


-- localhostからの接続を許可する root ユーザーに全権限を付与
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'         WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;


-- 権限をすぐに反映させる
FLUSH PRIVILEGES;

