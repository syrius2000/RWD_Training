-- データベース名RWD内に存在するDrogPOの重複削除は例えば簡単には以下の事例が利用できる。

USE RWD;

-- 元になるDrugPOの構造をコピーした「カラの」テーブルをつくる
DROP TABLE IF EXISTS TMP_Table;
CREATE TABLE TMP_Table LIKE DrugPO;

--  カーソル命令distinctを使って重複削除した結果をカラのテーブルに挿入
INSERT INTO TMP_Table SELECT distinct * FROM DrugPO;

-- 古いテーブルを削除し、RENAMEする
DROP TABLE IF EXISTS DrugPO;
RENAME TABLE TMP_Table TO DrugPO;


-- 極めて単純だが、極めて破壊的操作なので注意して行う
-- 実行にはギガオーダーのテーブルではインデックスがないので極めて遅い
