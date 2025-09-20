# -*- mode:sql; mode:outline-minor; coding:utf-8 -*-
## -- 概要:
## -- このSQLクエリは、MySQLの `INFORMATION_SCHEMA.COLUMNS` テーブルを照会し、
## -- 'vaccine' データベース内に存在する指定されたテーブル群（'COVID19ワクチン接種', 'COVID検査'など）
## -- に関する詳細なカラム情報を取得します。
## --
## -- 目的:
## -- このクエリを実行することで、データベースの構造定義書（データディクショナリや
## -- 「イエローブック」とも呼ばれる）を生成するための元データを得ることができます。
## -- このクエリはMySQL 8.4を含む、近年のMySQLバージョンで動作します。
## --
## -- 取得される情報:
## --   - テーブル名
## --   - カラム名
## --   - データ型
## --   - 最大長
## --   - NULL許容か
## --   - デフォルト値
## --   - カラムコメント

query = "SELECT
    TABLE_NAME AS 'テーブル名',
    COLUMN_NAME AS 'カラム名',
    ORDINAL_POSITION AS '順序',
    DATA_TYPE AS 'データ型',
    CHARACTER_MAXIMUM_LENGTH AS '最大長(文字)',
    NUMERIC_PRECISION AS '数値精度',
    NUMERIC_SCALE AS '数値スケール',
    DATETIME_PRECISION AS '日時精度',
    COLUMN_TYPE AS 'カラム型定義',
    IS_NULLABLE AS 'NULL許容',
    COLUMN_DEFAULT AS 'デフォルト値',
    COLUMN_COMMENT AS 'カラムコメント'
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'vaccine'  -- データベース名を指定
    AND TABLE_NAME IN (
        'COVID19ワクチン接種',
        'COVID検査',
        '一般検査',
        '入院情報',
        '処方薬剤',
        '外来情報',
        '患者基本情報',
        '患者基本情報_身長体重',
        '注射薬剤',
        '病名データ_DPC',
        '病名データ_カルテオーダ',
        '請求データ',
        '重症度・転帰'
    )
ORDER BY
    TABLE_NAME,
    ORDINAL_POSITION;
"



## -- SELECT
## --     TABLE_NAME,
## --     COLUMN_NAME,
## --     ORDINAL_POSITION,
## --     DATA_TYPE,
## --     IFNULL(CHARACTER_MAXIMUM_LENGTH, '') AS CHARACTER_MAXIMUM_LENGTH, -- 文字列長など、数値型カラムがNULLの場合、空文字で出力
## --     IFNULL(NUMERIC_PRECISION, '') AS NUMERIC_PRECISION,
## --     IFNULL(NUMERIC_SCALE, '') AS NUMERIC_SCALE,
## --     IFNULL(DATETIME_PRECISION, '') AS DATETIME_PRECISION,
## --     COLUMN_TYPE,
## --     IS_NULLABLE,
## --     IFNULL(COLUMN_DEFAULT, '') AS COLUMN_DEFAULT, -- デフォルト値がNULLの場合、空文字で出力
## --     COLUMN_COMMENT
## -- INTO OUTFILE '/tmp/file.csv'
## -- FIELDS TERMINATED BY ','        -- フィールドの区切り文字をカンマに設定
## -- OPTIONALLY ENCLOSED BY '"'      -- 各フィールドをダブルクォーテーションで囲む（必要な場合のみ）
## -- LINES TERMINATED BY '\n'        -- 行の終わりを改行コードに設定
## -- FROM
## --     INFORMATION_SCHEMA.COLUMNS
## -- WHERE
## --     TABLE_SCHEMA = 'vaccine'      -- データベース名を指定してください
## --     AND TABLE_NAME IN (
## --         'COVID19ワクチン接種',
## --         'COVID検査',
## --         '一般検査',
## --         '入院情報',
## --         '処方薬剤',
## --         '外来情報',
## --         '患者基本情報',
## --         '患者基本情報_身長体重',
## --         '注射薬剤',
## --         '病名データ_DPC',
## --         '病名データ_カルテオーダ',
## --         '請求データ',
## --         '重症度・転帰'
## --     )
## -- ORDER BY
## --     TABLE_NAME,
## --     ORDINAL_POSITION;
