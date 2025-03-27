-- データベース名RWD内に存在するDrogPOの重複削除は例えば簡単には以下の事例が

USE RWD;

-- 元になるDrugPOの構造をコピーした「カラの」テーブルをつくる
DROP TABLE IF EXISTS newTAB;
CREATE TABLE newTAB LIKE DrugPO;

--  カーソル命令distinctを使って重複削除した結果をカラのテーブルに挿入
INSERT INTO newTAB SELECT distinct * FROM DrugPO;

-- 古いテーブルを削除し、RENAMEする
DROP TABLE IF EXISTS DrugPO;
RENAME TABLE newTAB TO DrugPO;


-- 極めて単純だが、極めて破壊的操作なので注意して行う
-- 実行にはギガオーダーのテーブルではインデックスがないので極めて遅い



