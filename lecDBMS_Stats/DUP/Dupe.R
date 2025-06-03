# -*- mode:R; mode:outline-minor; coding:utf-8 -*-
## #########################[ 104 ]  start script        ##############################################
## Document :
## section

      3 +-------------------------+
      4 | COVID19ワクチン接種     |
      5 | COVID検査               |
      6 | 一般検査                |
      7 | 入院情報                |
      8 | 処方薬剤                |
      9 | 外来情報                |
     10 | 患者基本情報            |
     11 | 患者基本情報_身長体重   |
     12 | 注射薬剤                |
     13 | 病名データ_DPC          |
     14 | 病名データ_カルテオーダ |
     15 | 請求データ              |
     16 | 重症度・転帰            |
     17 +-------------------------+

------ COVID19ワクチン接種
-- 重複あり

SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'VACCINE'  -- 実際のデータベース名に置き換え
  AND TABLE_NAME = 'COVID19ワクチン接種'; -- 例: 'COVID19ワクチン接種'

PATIENTNO,DEPARTMENTCODE,DEPTNAME,EVENTDATE,更新日時,問診1_過去2週間の曝露歴,問診2_濃厚接触者,問診3_症状の有無,問診4_家族_同僚症状の有無,問診5_接種歴,接種日1回目,日付不明1回目,年1回目,月1回目,接種日2回目,日付不明2回目,年2回目,月2回目,接種日3回目,日付不明3回目,年3回目,月3回目,接種日4回目,日付不明4回目,年4回目,月4回目,問診6_新型コロナ感染症の罹患歴,診断日,診断日日付不明,診断日年1,診断日月1,問診7_過去6か月以内の海外渡航歴


-- 'ここにテーブル名を入力' と 'ここにステップ2で取得したカンマ区切りの全カラム名を入力' を置き換えてください
SELECT
    (COUNT(*) > 0) AS has_duplicates -- 重複があれば 1 (True)、なければ 0 (False)
FROM (
    SELECT
        1 -- この値は重要ではありません
    FROM
         COVID19ワクチン接種
    GROUP BY
        PATIENTNO,DEPARTMENTCODE,DEPTNAME,EVENTDATE,更新日時,問診1_過去2週間の曝露歴,問診2_濃厚接触者,問診3_症状の有無,問診4_家族_同僚症状の有無,問診5_接種歴,接種日1回目,日付不明1回目,年1回目,月1回目,接種日2回目,日付不明2回目,年2回目,月2回目,接種日3回目,日付不明3回目,年3回目,月3回目,接種日4回目,日付不明4回目,年4回目,月4回目,問診6_新型コロナ感染症の罹患歴,診断日,診断日日付不明,診断日年1,診断日月1,問診7_過去6か月以内の海外渡航歴
    HAVING
        COUNT(*) > 1
    LIMIT 1 -- 1件でも重複グループが見つかれば十分
) AS subquery_duplicates_check;


-------------------------------------------
-- COVID検査: 0

SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'VACCINE'
  AND TABLE_NAME = 'COVID検査';

-- PATIENTNO,COLLECTDATE,TESTITEMCODE,TESTITEMNAME,ADDCOMMENT1,ADDCOMMENT2,OUTOFSTANDARD,REPORTVALUE,MATERIALSNAME,EDITORIALRESULT,SPECIMENCOMMENTFLG

-- 'ここにテーブル名を入力' と 'ここにステップ2で取得したカンマ区切りの全カラム名を入力' を置き換え
SELECT
    (COUNT(*) > 0) AS has_duplicates -- 重複があれば 1 (True)、なければ 0 (False)
FROM (
    SELECT
        1 -- この値は重要ではありません
    FROM
         COVID検査
    GROUP BY
PATIENTNO,COLLECTDATE,TESTITEMCODE,TESTITEMNAME,ADDCOMMENT1,ADDCOMMENT2,OUTOFSTANDARD,REPORTVALUE,MATERIALSNAME,EDITORIALRESULT,SPECIMENCOMMENTFLG
    HAVING
        COUNT(*) > 1
    LIMIT 1 -- 1件でも重複グループが見つかれば十分
) AS subquery_duplicates_check;

-------------------------------------------
-- 一般検査 : 0

SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'VACCINE'
  AND TABLE_NAME = '一般検査';

-- 'ここにテーブル名を入力' と 'ここにステップ2で取得したカンマ区切りの全カラム名を入力' を置き換え
SELECT
    (COUNT(*) > 0) AS has_duplicates -- 重複があれば 1 (True)、なければ 0 (False)
FROM (
    SELECT
        1 -- この値は重要ではありません
    FROM
         一般検査
    GROUP BY
PATIENTNO,COLLECTDATE,COLLECTTIME,TESTITEMCODE,TESTITEMNAME,ADDCOMMENT1,ADDCOMMENT2,OUTOFSTANDARD,REPORTVALUE,MATERIALSNAME,EDITORIALRESULT,SPECIMENCOMMENTFLG
    HAVING
        COUNT(*) > 1
    LIMIT 1 -- 1件でも重複グループが見つかれば十分
) AS subquery_duplicates_check;

-------------
---      7 | 入院情報 :0


SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'VACCINE'
  AND TABLE_NAME = '入院情報';

-- 'ここにテーブル名を入力' と 'ここにステップ2で取得したカンマ区切りの全カラム名を入力' を置き換え
SELECT
    (COUNT(*) > 0) AS has_duplicates -- 重複があれば 1 (True)、なければ 0 (False)
FROM (
    SELECT
        1 -- この値は重要ではありません
    FROM
         入院情報
    GROUP BY
ADMISSIONNO,DETAILNO,PATIENTNO,SEX,PATIENTAGE,STARTSTATUS,STARTDATE,ENDSTATUS,ENDDATE,DEPTCODE,DEPTNAME,WARDCODE,ROOMCODE,ADMISSIONDATE,PURPOSECODE,PURPOSENAME,DISFINALDATE,DISREASONCODE,DISREASONNAME
    HAVING
        COUNT(*) > 1
    LIMIT 1 -- 1件でも重複グループが見つかれば十分
) AS subquery_duplicates_check;


      8 | 処方薬剤                |


SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS all_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'VACCINE'
  AND TABLE_NAME = '処方薬剤';

-- 'ここにテーブル名を入力' と 'ここにステップ2で取得したカンマ区切りの全カラム名を入力' を置き換え
SELECT
    (COUNT(*) > 0) AS has_duplicates -- 重複があれば 1 (True)、なければ 0 (False)
FROM (
    SELECT
        1 -- この値は重要ではありません
    FROM
         処方薬剤
    GROUP BY
PATIENTNO,STARTDATE,ENDDATE,PATIENTTYPE,ORDERDEPARTMENT,DOSAGECODE,DOSAGENAME,TIMES,MEDICINECODE,MEDICINENAME,QUANTITY,UNIT1
    HAVING
        COUNT(*) > 1
    LIMIT 1 -- 1件でも重複グループが見つかれば十分
) AS subquery_duplicates_check;

## Local Variables:
## fill-column   : 88
## comment-column: 0
## eval: (flycheck-mode 0)
## eval: (linum-mode 1)
## eval: (setq linum-format "%3d ")
## End:
