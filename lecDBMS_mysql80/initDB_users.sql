-- 2025-05-21
--
-- initialize DB(RWD) , initial user and grants ALL
-- SET APPROPRIATE PASSWORDS

CREATE DATABASE IF NOT EXISTS RWD ;
CREATE DATABASE IF NOT EXISTS DWH ;
CREATE DATABASE IF NOT EXISTS COVID ;
CREATE DATABASE IF NOT EXISTS VACCIN ;

-- root grants
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'fuga';
-- GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
--
-- ALTER USER 'root'@'%' IDENTIFIED BY 'fuga';
-- GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'         WITH GRANT OPTION;


DROP  USER 'RWDadmin'@'%';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'fugafuga';
ALTER USER 'RWDadmin'@'%' IDENTIFIED BY 'fuga';
GRANT ALL ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;


-- DBに対するALLアクセスを設定 ------------------------------------------------
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
GRANT ALL ON VACCIN.*   TO 'RWDuser'@'%';

CREATE USER IF NOT EXISTS "RWDuser"@"localhost" IDENTIFIED BY 'fugafuga';
GRANT ALL ON RWD.* TO 'RWDuser'@'localhost';
GRANT ALL ON DWH.* TO 'RWDuser'@'localhost';
GRANT ALL ON COVID.* TO 'RWDuser'@'localhost';
GRANT ALL ON VACCIN.*   TO 'RWDuser'@'%';


-- dont foget !
FLUSH PRIVILEGES;
