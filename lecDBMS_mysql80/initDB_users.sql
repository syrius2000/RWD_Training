-- データベースとユーザーを初期化するスクリプト
--
-- 改善日: 2025-09-10
-- 変更点:
-- - 冗長なユーザー作成と権限付与のコマンドを統合
-- - セキュリティに関する注意喚起のコメントを追加
-- - FLUSH PRIVILEGES の重複を削除
-- - 引用符のスタイルを統一

-- =================================================================
-- 注意:
-- このスクリプト内のパスワード 'changeme' は安全ではありません。
-- 本番環境で使用する前に、必ず強力なパスワードに変更してください。
-- =================================================================

-- データベースの作成
CREATE DATABASE IF NOT EXISTS RWD;
CREATE DATABASE IF NOT EXISTS DWH;
CREATE DATABASE IF NOT EXISTS COVID;
CREATE DATABASE IF NOT EXISTS VACCIN;

-- -----------------------------------------------------------------
-- 管理者ユーザー (RWDadmin)
-- -----------------------------------------------------------------
-- 用途: すべてのデータベースに対する管理操作
-- 注意: 'ALL ON *.*' は非常に強力な権限です。
--       可能であれば、管理対象のデータベースに権限を限定してください。
--       例: GRANT ALL ON RWD.* TO ...;
-- -----------------------------------------------------------------
CREATE USER IF NOT EXISTS 'RWDadmin'@'localhost' IDENTIFIED BY 'changeme';
GRANT ALL ON *.* TO 'RWDadmin'@'localhost' WITH GRANT OPTION;

CREATE USER IF NOT EXISTS 'RWDadmin'@'%' IDENTIFIED BY 'changeme';
GRANT ALL ON *.* TO 'RWDadmin'@'%' WITH GRANT OPTION;


-- -----------------------------------------------------------------
-- 一般ユーザー (RWDuser)
-- -----------------------------------------------------------------
-- 用途: アプリケーションからの通常アクセス
-- 注意: 'ALL' 権限ではなく、必要な権限（SELECT, INSERT, UPDATE, DELETEなど）のみを
--       付与することが推奨されます。
-- -----------------------------------------------------------------
CREATE USER IF NOT EXISTS 'RWDuser'@'localhost' IDENTIFIED BY 'changeme';
GRANT ALL ON RWD.* TO 'RWDuser'@'localhost';
GRANT ALL ON DWH.* TO 'RWDuser'@'localhost';
GRANT ALL ON COVID.* TO 'RWDuser'@'localhost';
GRANT ALL ON VACCIN.* TO 'RWDuser'@'localhost';

CREATE USER IF NOT EXISTS 'RWDuser'@'%' IDENTIFIED BY 'changeme';
GRANT ALL ON RWD.* TO 'RWDuser'@'%';
GRANT ALL ON DWH.* TO 'RWDuser'@'%';
GRANT ALL ON COVID.* TO 'RWDuser'@'%';
GRANT ALL ON VACCIN.* TO 'RWDuser'@'%';


-- -----------------------------------------------------------------
-- 権限の反映
-- -----------------------------------------------------------------
-- GRANT文の実行後、権限は通常自動的にリロードされるため、
-- FLUSH PRIVILEGESは多くの場合不要ですが、明示的に実行します。
-- -----------------------------------------------------------------
FLUSH PRIVILEGES;
