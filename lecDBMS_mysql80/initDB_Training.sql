-- 2023/06/15
--
-- initialize DB(RWD) , initial user and grants ALL
-- SET APPROPRIATE PASSWORDS

CREATE DATABASE IF NOT EXISTS RWD ;
CREATE DATABASE IF NOT EXISTS DWH ;
CREATE DATABASE IF NOT EXISTS COVID ;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'fuga';
ALTER USER 'root'@'%' IDENTIFIED BY 'fuga';


-- 2023/09/14
DROP  USER 'root'@'127.0.0.1';
CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED BY 'fuga';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY 'fuga';
GRANT ALL ON *.* TO 'root'@'127.0.0.1';

DROP  USER 'root'@'%';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'fugafuga';
ALTER USER 'root'@'%' IDENTIFIED BY 'fuga';
GRANT ALL ON *.* TO 'root'@'%';

FLUSH PRIVILEGES;

-- Define user account
DROP USER IF EXISTS RWDadmin;
DROP USER IF EXISTS RWDuser;

-- Define user password
DROP USER 'RWDadmin'@'%';
CREATE USER IF NOT EXISTS 'RWDadmin'@'%' IDENTIFIED BY 'fugafuga';
GRANT ALL ON *.* TO 'RWDadmin'@'%' ;

DROP USER 'RWDadmin'@'localhost';
CREATE USER IF NOT EXISTS "RWDadmin"@"localhost" IDENTIFIED BY 'fugafuga';
GRANT ALL ON *.* TO 'RWDadmin'@'localhost';

DROP USER 'RWDadmin'@'127.0.0.1';
CREATE USER IF NOT EXISTS "RWDadmin"@"127.0.0.1" IDENTIFIED BY 'fugafuga';
GRANT ALL ON *.* TO 'RWDadmin'@'127.0.0.1' ;


-- DBに対するアクセスを設定 ------------------------------------------------
DROP USER IF EXISTS RWDuser;
CREATE USER IF NOT EXISTS 'RWDuser'@'%' IDENTIFIED BY 'fugafuga';
GRANT ALL ON RWD.* TO 'RWDuser'@'%';
GRANT ALL ON DWH.* TO 'RWDuser'@'%';
GRANT ALL ON COVID.*   TO 'RWDuser'@'%';

CREATE USER IF NOT EXISTS "RWDuser"@"localhost" IDENTIFIED BY 'fugafuga';
GRANT ALL ON RWD.* TO 'RWDuser'@'localhost';
GRANT ALL ON DWH.* TO 'RWDuser'@'localhost';
GRANT ALL ON COVID.* TO 'RWDuser'@'localhost';

CREATE USER IF NOT EXISTS "RWDuser"@"127.0.0.1" IDENTIFIED BY 'fugafuga';
GRANT ALL ON RWD.* TO 'RWDuser'@'127.0.0.1';
GRANT ALL ON DWH.* TO 'RWDuser'@'127.0.0.1';
GRANT ALL ON COVID.* TO 'RWDuser'@'127.0.0.1';

-- -- dont foget it !
FLUSH PRIVILEGES;
