# -*- mode:R; mode:outline-minor; coding:utf-8 -*-

# Dupe.R
#
# このファイルは、'VACCINE' データベースの各テーブルに
# 重複レコードが存在するかどうかを確認するためのSQLクエリをまとめたものです。
#
# 各セクションは、特定のテーブルに対する重複チェックの手順を示しています。

# -----------------------------------------------------------------
# VACCINE データベース テーブル一覧
# -----------------------------------------------------------------
#  - COVID19ワクチン接種
#  - COVID検査
#  - 一般検査
#  - 入院情報
#  - 処方薬剤
#  - 外来情報
#  - 患者基本情報
#  - 患者基本情報_身長体重
#  - 注射薬剤
#  - 病名データ_DPC
#  - 病名データ_カルテオーダ
#  - 請求データ
#  - 重症度・転帰
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# 1. テーブル: COVID19ワクチン接種
# 結果: 重複あり
# -----------------------------------------------------------------

# ステップ1: テーブルの全カラム名を取得
query_get_columns_covid19 <- "
SELECT
    GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'VACCINE' AND TABLE_NAME = 'COVID19ワクチン接種';
"

# 取得したカラムリスト:
# PATIENTNO,DEPARTMENTCODE,DEPTNAME,EVENTDATE,更新日時,問診1_過去2週間の曝露歴,
# 問診2_濃厚接触者,問診3_症状の有無,問診4_家族_同僚症状の有無,問診5_接種歴,接種日1回目,日付不明1回目,年1回目,
# 月1回目,接種日2回目,日付不明2回目,年2回目,月2回目,接種日3回目,日付不明3回目,年3回目,月3回目,
# 接種日4回目,日付不明4回目,年4回目,月4回目,問診6_新型コロナ感染症の罹患歴,診断日,
# 診断日日付不明,診断日年1,診断日月1,問診7_過去6か月以内の海外渡航歴

# ステップ2: 全カラムを対象に重複レコードをチェック
query_check_dupes_covid19 <- "
SELECT
    (COUNT(*) > 0) AS has_duplicates
FROM (
    SELECT 1
    FROM COVID19ワクチン接種
    GROUP BY
        PATIENTNO,DEPARTMENTCODE,DEPTNAME,EVENTDATE,更新日時,問診1_過去2週間の曝露歴,
        問診2_濃厚接触者, 問診3_症状の有無,問診4_家族_同僚症状の有無,問診5_接種歴,
        接種日1回目,日付不明1回目,年1回目,月1回目, 接種日2回目,日付不明2回目,年2回目,月2回目,
        接種日3回目,日付不明3回目,年3回目,月3回目,接種日4回目,日付不明4回目,年4回目,月4回目,
        問診6_新型コロナ感染症の罹患歴,診断日,診断日日付不明,診断日年1,診断日月1,問診7_過去6か月以内の海外渡航歴
    HAVING COUNT(*) > 1
    LIMIT 1
) AS subquery_duplicates_check;
"


# -----------------------------------------------------------------
# 2. テーブル: COVID検査
# 結果: 重複なし
# -----------------------------------------------------------------

# ステップ1: テーブルの全カラム名を取得
query_get_columns_covid_test <- "
SELECT
    GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'VACCINE' AND TABLE_NAME = 'COVID検査';
"

# 取得したカラムリスト:
# PATIENTNO,COLLECTDATE,TESTITEMCODE,TESTITEMNAME,ADDCOMMENT1,ADDCOMMENT2,OUTOFSTANDARD,REPORTVALUE,MATERIALSNAME,EDITORIALRESULT,SPECIMENCOMMENTFLG

# ステップ2: 全カラムを対象に重複レコードをチェック
query_check_dupes_covid_test <- "
SELECT
    (COUNT(*) > 0) AS has_duplicates
FROM (
    SELECT 1
    FROM COVID検査
    GROUP BY
        PATIENTNO,COLLECTDATE,TESTITEMCODE,TESTITEMNAME,ADDCOMMENT1,ADDCOMMENT2,OUTOFSTANDARD,REPORTVALUE,
        MATERIALSNAME,EDITORIALRESULT,SPECIMENCOMMENTFLG
    HAVING COUNT(*) > 1
    LIMIT 1
) AS subquery_duplicates_check;
"


# -----------------------------------------------------------------
# 3. テーブル: 一般検査
# 結果: 重複なし
# -----------------------------------------------------------------

# ステップ1: テーブルの全カラム名を取得
query_get_columns_clinical_exam <- "
SELECT
    GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'VACCINE' AND TABLE_NAME = '一般検査';
"

# 取得したカラムリスト:
# PATIENTNO,COLLECTDATE,COLLECTTIME,TESTITEMCODE,TESTITEMNAME,ADDCOMMENT1,ADDCOMMENT2,OUTOFSTANDARD,REPORTVALUE,MATERIALSNAME,EDITORIALRESULT,SPECIMENCOMMENTFLG

# ステップ2: 全カラムを対象に重複レコードをチェック
query_check_dupes_clinical_exam <- "
SELECT
    (COUNT(*) > 0) AS has_duplicates
FROM (
    SELECT 1
    FROM 一般検査
    GROUP BY
        PATIENTNO,COLLECTDATE,COLLECTTIME,TESTITEMCODE,TESTITEMNAME,ADDCOMMENT1,ADDCOMMENT2,OUTOFSTANDARD,REPORTVALUE,MATERIALSNAME,EDITORIALRESULT,SPECIMENCOMMENTFLG
    HAVING COUNT(*) > 1
    LIMIT 1
) AS subquery_duplicates_check;
"


# -----------------------------------------------------------------
# 4. テーブル: 入院情報
# 結果: 重複なし
# -----------------------------------------------------------------

# ステップ1: テーブルの全カラム名を取得
query_get_columns_inpatient <- "
SELECT
    GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'VACCINE' AND TABLE_NAME = '入院情報';
"

# 取得したカラムリスト:
# ADMISSIONNO,DETAILNO,PATIENTNO,SEX,PATIENTAGE,STARTSTATUS,STARTDATE,ENDSTATUS,ENDDATE,DEPTCODE,DEPTNAME,WARDCODE,ROOMCODE,ADMISSIONDATE,PURPOSECODE,PURPOSENAME,DISFINALDATE,DISREASONCODE,DISREASONNAME

# ステップ2: 全カラムを対象に重複レコードをチェック
query_check_dupes_inpatient <- "
SELECT
    (COUNT(*) > 0) AS has_duplicates
FROM (
    SELECT 1
    FROM 入院情報
    GROUP BY
        ADMISSIONNO,DETAILNO,PATIENTNO,SEX,PATIENTAGE,STARTSTATUS,STARTDATE,ENDSTATUS,ENDDATE,DEPTCODE,DEPTNAME,WARDCODE,ROOMCODE,ADMISSIONDATE,PURPOSECODE,PURPOSENAME,DISFINALDATE,DISREASONCODE,DISREASONNAME
    HAVING COUNT(*) > 1
    LIMIT 1
) AS subquery_duplicates_check;
"


# -----------------------------------------------------------------
# 5. テーブル: 処方薬剤
# 結果: (要確認)
# -----------------------------------------------------------------

# ステップ1: テーブルの全カラム名を取得
query_get_columns_drug <- "
SELECT
    GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'VACCINE' AND TABLE_NAME = '処方薬剤';
"

# 取得したカラムリスト:
# PATIENTNO,STARTDATE,ENDDATE,PATIENTTYPE,ORDERDEPARTMENT,DOSAGECODE,DOSAGENAME,TIMES,MEDICINECODE,MEDICINENAME,QUANTITY,UNIT1

# ステップ2: 全カラムを対象に重複レコードをチェック
query_check_dupes_drug <- "
SELECT
    (COUNT(*) > 0) AS has_duplicates
FROM (
    SELECT 1
    FROM 処方薬剤
    GROUP BY
        PATIENTNO,STARTDATE,ENDDATE,PATIENTTYPE,ORDERDEPARTMENT,DOSAGECODE,DOSAGENAME,TIMES,MEDICINECODE,MEDICINENAME,QUANTITY,UNIT1
    HAVING COUNT(*) > 1
    LIMIT 1
) AS subquery_duplicates_check;
"


## Local Variables:
## fill-column   : 88
## comment-column: 0
## eval: (flycheck-mode 0)
## eval: (linum-mode 1)
## eval: (setq linum-format "%3d ")
## End:
