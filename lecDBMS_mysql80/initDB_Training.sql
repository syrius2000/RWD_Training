-- 2023/06/15
--
-- initialize DB(Training) , initial user and grants ALL
-- SET APPROPRIATE PASSWORDS

CREATE DATABASE IF NOT EXISTS Training ;

DROP USER IF EXISTS user;
ALTER USER 'user'@'localhost' IDENTIFIED BY 'user';
ALTER USER 'user'@'%' IDENTIFIED BY 'user';

GRANT ALL ON Training.* TO 'user'@'localhost';
GRANT ALL ON Training.* TO 'user'@'%';

-- -- dont foget it !
FLUSH PRIVILEGES;

--

/* 既存のコード体系を新しい体系に変換して集計 */
CREATE TABLE PopTbl
(pref_name VARCHAR(32) PRIMARY KEY,
 population INTEGER NOT NULL);

INSERT INTO PopTbl VALUES('徳島', 100);
INSERT INTO PopTbl VALUES('香川', 200);
INSERT INTO PopTbl VALUES('愛媛', 150);
INSERT INTO PopTbl VALUES('高知', 200);
INSERT INTO PopTbl VALUES('福岡', 300);
INSERT INTO PopTbl VALUES('佐賀', 100);
INSERT INTO PopTbl VALUES('長崎', 200);
INSERT INTO PopTbl VALUES('東京', 400);
INSERT INTO PopTbl VALUES('群馬', 50);


/* 異なる条件の集計を1つのSQLで行う */
CREATE TABLE PopTbl2
(pref_name VARCHAR(32),
 sex CHAR(1) NOT NULL,
 population INTEGER NOT NULL,
    PRIMARY KEY(pref_name, sex));

INSERT INTO PopTbl2 VALUES('徳島', '1',	60 );
INSERT INTO PopTbl2 VALUES('徳島', '2',	40 );
INSERT INTO PopTbl2 VALUES('香川', '1',	100);
INSERT INTO PopTbl2 VALUES('香川', '2',	100);
INSERT INTO PopTbl2 VALUES('愛媛', '1',	100);
INSERT INTO PopTbl2 VALUES('愛媛', '2',	50 );
INSERT INTO PopTbl2 VALUES('高知', '1',	100);
INSERT INTO PopTbl2 VALUES('高知', '2',	100);
INSERT INTO PopTbl2 VALUES('福岡', '1',	100);
INSERT INTO PopTbl2 VALUES('福岡', '2',	200);
INSERT INTO PopTbl2 VALUES('佐賀', '1',	20 );
INSERT INTO PopTbl2 VALUES('佐賀', '2',	80 );
INSERT INTO PopTbl2 VALUES('長崎', '1',	125);
INSERT INTO PopTbl2 VALUES('長崎', '2',	125);
INSERT INTO PopTbl2 VALUES('東京', '1',	250);
INSERT INTO PopTbl2 VALUES('東京', '2',	150);


/* CHECK制約で複数の列の条件関係を定義する */
CREATE TABLE TestSal
(sex CHAR(1) ,
 salary INTEGER,
    CONSTRAINT check_salary CHECK
             ( CASE WHEN sex = '2'
                    THEN CASE WHEN salary <= 200000
                              THEN 1 ELSE 0 END
                    ELSE 1 END = 1 ));

INSERT INTO TestSal VALUES(1, 200000);
INSERT INTO TestSal VALUES(1, 300000);
INSERT INTO TestSal VALUES(1, NULL);
INSERT INTO TestSal VALUES(2, 200000);
INSERT INTO TestSal VALUES(2, 300000);  --error
INSERT INTO TestSal VALUES(2, NULL);
INSERT INTO TestSal VALUES(1, 300000);


/* 条件を分岐させたUPDATE */
CREATE TABLE SomeTable
(p_key CHAR(1) PRIMARY KEY,
 col_1 INTEGER NOT NULL,
 col_2 CHAR(2) NOT NULL);

INSERT INTO SomeTable VALUES('a', 1, 'あ');
INSERT INTO SomeTable VALUES('b', 2, 'い');
INSERT INTO SomeTable VALUES('c', 3, 'う');


/* テーブル同士のマッチング */
CREATE TABLE CourseMaster
(course_id   INTEGER PRIMARY KEY,
 course_name VARCHAR(32) NOT NULL);

INSERT INTO CourseMaster VALUES(1, '経理入門');
INSERT INTO CourseMaster VALUES(2, '財務知識');
INSERT INTO CourseMaster VALUES(3, '簿記検定');
INSERT INTO CourseMaster VALUES(4, '税理士');

CREATE TABLE OpenCourses
(month       INTEGER ,
 course_id   INTEGER ,
    PRIMARY KEY(month, course_id));

INSERT INTO OpenCourses VALUES(201806, 1);
INSERT INTO OpenCourses VALUES(201806, 3);
INSERT INTO OpenCourses VALUES(201806, 4);
INSERT INTO OpenCourses VALUES(201807, 4);
INSERT INTO OpenCourses VALUES(201808, 2);
INSERT INTO OpenCourses VALUES(201808, 4);


/* CASE式の中で集約関数を使う */
CREATE TABLE StudentClub
(std_id  INTEGER,
 club_id INTEGER,
 club_name VARCHAR(32),
 main_club_flg CHAR(1),
 PRIMARY KEY (std_id, club_id));

INSERT INTO StudentClub VALUES(100, 1, '野球',        'Y');
INSERT INTO StudentClub VALUES(100, 2, '吹奏楽',      'N');
INSERT INTO StudentClub VALUES(200, 2, '吹奏楽',      'N');
INSERT INTO StudentClub VALUES(200, 3, 'バドミントン','Y');
INSERT INTO StudentClub VALUES(200, 4, 'サッカー',    'N');
INSERT INTO StudentClub VALUES(300, 4, 'サッカー',    'N');
INSERT INTO StudentClub VALUES(400, 5, '水泳',        'N');
INSERT INTO StudentClub VALUES(500, 6, '囲碁',        'N');

-- code 1-2

CREATE TABLE Shohin
(shohin_id     CHAR(4) NOT NULL,
 shohin_mei    VARCHAR(100) NOT NULL,
 shohin_bunrui VARCHAR(32) NOT NULL,
 hanbai_tanka  INTEGER ,
 shiire_tanka  INTEGER ,
 torokubi      DATE ,
     PRIMARY KEY (shohin_id));

INSERT INTO Shohin VALUES ('0001', 'Tシャツ' ,'衣服', 1000, 500, '2009-09-20');
INSERT INTO Shohin VALUES ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO Shohin VALUES ('0003', 'カッターシャツ', '衣服', 4000, 2800, NULL);
INSERT INTO Shohin VALUES ('0004', '包丁', 'キッチン用品', 3000, 2800, '2009-09-20');
INSERT INTO Shohin VALUES ('0005', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15');
INSERT INTO Shohin VALUES ('0006', 'フォーク', 'キッチン用品', 500, NULL, '2009-09-20');
INSERT INTO Shohin VALUES ('0007', 'おろしがね', 'キッチン用品', 880, 790, '2008-04-28');
INSERT INTO Shohin VALUES ('0008', 'ボールペン', '事務用品', 100, NULL, '2009-11-11');


SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG (hanbai_tanka) OVER (ORDER BY shohin_id
                                ROWS BETWEEN 2 PRECEDING
                                         AND CURRENT ROW) AS moving_avg
  FROM Shohin;


SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG(hanbai_tanka) OVER W AS moving_avg
  FROM Shohin
WINDOW W AS (ORDER BY shohin_id
                 ROWS BETWEEN 2 PRECEDING
                          AND CURRENT ROW);

SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG(hanbai_tanka)   OVER W AS moving_avg,
       SUM(hanbai_tanka)   OVER W AS moving_sum,
       COUNT(hanbai_tanka) OVER W AS moving_count,
       MAX(hanbai_tanka)   OVER W AS moving_max
  FROM Shohin
WINDOW W AS (ORDER BY shohin_id
                 ROWS BETWEEN 2 PRECEDING
                          AND CURRENT ROW);


CREATE TABLE LoadSample
(sample_date   DATE PRIMARY KEY,
 load_val      INTEGER NOT NULL);

INSERT INTO LoadSample VALUES('2018-02-01',   1024);
INSERT INTO LoadSample VALUES('2018-02-02',   2366);
INSERT INTO LoadSample VALUES('2018-02-05',   2366);
INSERT INTO LoadSample VALUES('2018-02-07',    985);
INSERT INTO LoadSample VALUES('2018-02-08',    780);
INSERT INTO LoadSample VALUES('2018-02-12',   1000);

-- code 1-3
CREATE TABLE Products
(name VARCHAR(16) PRIMARY KEY,
 price INTEGER NOT NULL);

--重複順列・順列・組み合わせ
DELETE FROM Products;
INSERT INTO Products VALUES('りんご',	100);
INSERT INTO Products VALUES('みかん',	50);
INSERT INTO Products VALUES('バナナ',	80);

DROP TABLE Products;
CREATE TABLE Products
(name VARCHAR(16) NOT NULL,
 price INTEGER NOT NULL);


-- 重複するレコード
INSERT INTO Products VALUES('りんご',	50);
INSERT INTO Products VALUES('みかん',	100);
INSERT INTO Products VALUES('みかん',	100);
INSERT INTO Products VALUES('みかん',	100);
INSERT INTO Products VALUES('バナナ',	80);

-- 部分的に不一致なキーの検索
CREATE TABLE Addresses
(name VARCHAR(32),
 family_id INTEGER,
 address VARCHAR(32),
 PRIMARY KEY(name, family_id));

INSERT INTO Addresses VALUES('前田 義明', '100', '東京都港区虎ノ門3-2-29');
INSERT INTO Addresses VALUES('前田 由美', '100', '東京都港区虎ノ門3-2-92');
INSERT INTO Addresses VALUES('加藤 茶',   '200', '東京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES('加藤 勝',   '200', '東京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES('ホームズ',  '300', 'ベーカー街221B');
INSERT INTO Addresses VALUES('ワトソン',  '400', 'ベーカー街221B');

DELETE FROM Products;
INSERT INTO Products VALUES('りんご',	50);
INSERT INTO Products VALUES('みかん',	100);
INSERT INTO Products VALUES('ぶどう',	50);
INSERT INTO Products VALUES('スイカ',	80);
INSERT INTO Products VALUES('レモン',	30);
INSERT INTO Products VALUES('いちご',	100);
INSERT INTO Products VALUES('バナナ',	100);

-- code 1-4

CREATE TABLE Students
(name CHAR(16) PRIMARY KEY,
 age  INTEGER  );

INSERT INTO Students VALUES('ブラウン',  22);
INSERT INTO Students VALUES('ラリー',    19);
INSERT INTO Students VALUES('ジョン',    NULL);
INSERT INTO Students VALUES('ボギー',    21);

CREATE TABLE EmptyStr
( str CHAR(8),
  description CHAR(16));

INSERT INTO EmptyStr VALUES('', 'empty string');
INSERT INTO EmptyStr VALUES(NULL, 'NULL' );

-- code 1-5
/* テーブルに存在「しない」データを探す */
CREATE TABLE Meetings
(meeting CHAR(32) NOT NULL,
 person  CHAR(32) NOT NULL,
 PRIMARY KEY (meeting, person));

INSERT INTO Meetings VALUES('第１回', '伊藤');
INSERT INTO Meetings VALUES('第１回', '水島');
INSERT INTO Meetings VALUES('第１回', '坂東');
INSERT INTO Meetings VALUES('第２回', '伊藤');
INSERT INTO Meetings VALUES('第２回', '宮田');
INSERT INTO Meetings VALUES('第３回', '坂東');
INSERT INTO Meetings VALUES('第３回', '水島');
INSERT INTO Meetings VALUES('第３回', '宮田');

-- /* 全称量化　その１：肯定⇔二重否定の変換に慣れよう */
CREATE TABLE TestScores
(student_id INTEGER,
 subject    VARCHAR(32) ,
 score      INTEGER,
  PRIMARY KEY(student_id, subject));

INSERT INTO TestScores VALUES(100, '算数',100);
INSERT INTO TestScores VALUES(100, '国語',80);
INSERT INTO TestScores VALUES(100, '理科',80);
INSERT INTO TestScores VALUES(200, '算数',80);
INSERT INTO TestScores VALUES(200, '国語',95);
INSERT INTO TestScores VALUES(300, '算数',40);
INSERT INTO TestScores VALUES(300, '国語',90);
INSERT INTO TestScores VALUES(300, '社会',55);
INSERT INTO TestScores VALUES(400, '算数',80);

-- /* 全称量化　その２：集合VS 述語――凄いのはどっちだ？ */
CREATE TABLE Projects
(project_id VARCHAR(32),
 step_nbr   INTEGER ,
 status     VARCHAR(32),
  PRIMARY KEY(project_id, step_nbr));

INSERT INTO Projects VALUES('AA100', 0, '完了');
INSERT INTO Projects VALUES('AA100', 1, '待機');
INSERT INTO Projects VALUES('AA100', 2, '待機');
INSERT INTO Projects VALUES('B200',  0, '待機');
INSERT INTO Projects VALUES('B200',  1, '待機');
INSERT INTO Projects VALUES('CS300', 0, '完了');
INSERT INTO Projects VALUES('CS300', 1, '完了');
INSERT INTO Projects VALUES('CS300', 2, '待機');
INSERT INTO Projects VALUES('CS300', 3, '待機');
INSERT INTO Projects VALUES('DY400', 0, '完了');
INSERT INTO Projects VALUES('DY400', 1, '完了');
INSERT INTO Projects VALUES('DY400', 2, '完了');


-- /* 列に対する量化：オール１の行を探せ */
CREATE TABLE ArrayTbl
 (keycol CHAR(1) PRIMARY KEY,
  col1  INTEGER,
  col2  INTEGER,
  col3  INTEGER,
  col4  INTEGER,
  col5  INTEGER,
  col6  INTEGER,
  col7  INTEGER,
  col8  INTEGER,
  col9  INTEGER,
  col10 INTEGER);

--オールNULL
INSERT INTO ArrayTbl VALUES('A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO ArrayTbl VALUES('B', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--オール1
INSERT INTO ArrayTbl VALUES('C', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
--少なくとも一つは9
INSERT INTO ArrayTbl VALUES('D', NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO ArrayTbl VALUES('E', NULL, 3, NULL, 1, 9, NULL, NULL, 9, NULL, NULL);

-- 演習問題
/* 5-1：配列テーブル――行持ちの場合 */
CREATE TABLE ArrayTbl2
 (key   CHAR(1) NOT NULL,
    i   INTEGER NOT NULL,
  val   INTEGER,
  PRIMARY KEY (key, i));

/* AはオールNULL、Bは一つだけ非NULL、Cはオール非NULL */
INSERT INTO ArrayTbl2 VALUES('A', 1, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 2, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 3, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 4, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 5, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 6, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 7, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 8, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 9, NULL);
INSERT INTO ArrayTbl2 VALUES('A',10, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 1, 3);
INSERT INTO ArrayTbl2 VALUES('B', 2, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 3, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 4, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 5, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 6, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 7, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 8, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 9, NULL);
INSERT INTO ArrayTbl2 VALUES('B',10, NULL);
INSERT INTO ArrayTbl2 VALUES('C', 1, 1);
INSERT INTO ArrayTbl2 VALUES('C', 2, 1);
INSERT INTO ArrayTbl2 VALUES('C', 3, 1);
INSERT INTO ArrayTbl2 VALUES('C', 4, 1);
INSERT INTO ArrayTbl2 VALUES('C', 5, 1);
INSERT INTO ArrayTbl2 VALUES('C', 6, 1);
INSERT INTO ArrayTbl2 VALUES('C', 7, 1);
INSERT INTO ArrayTbl2 VALUES('C', 8, 1);
INSERT INTO ArrayTbl2 VALUES('C', 9, 1);
INSERT INTO ArrayTbl2 VALUES('C',10, 1);

-- code 1-6

/* データの歯抜けを探す */
CREATE TABLE SeqTbl
(seq  INTEGER PRIMARY KEY,
 name VARCHAR(16) NOT NULL);

INSERT INTO SeqTbl VALUES(1,	'ディック');
INSERT INTO SeqTbl VALUES(2,	'アン');
INSERT INTO SeqTbl VALUES(3,	'ライル');
INSERT INTO SeqTbl VALUES(5,	'カー');
INSERT INTO SeqTbl VALUES(6,	'マリー');
INSERT INTO SeqTbl VALUES(8,	'ベン');


-- 欠番を探せ：発展版
CREATE TABLE SeqTbl
( seq INTEGER NOT NULL PRIMARY KEY);

-- 歯抜けなし：開始値が1
DELETE FROM SeqTbl;
INSERT INTO SeqTbl VALUES(1);
INSERT INTO SeqTbl VALUES(2);
INSERT INTO SeqTbl VALUES(3);
INSERT INTO SeqTbl VALUES(4);
INSERT INTO SeqTbl VALUES(5);

-- 歯抜けあり：開始値が1
DELETE FROM SeqTbl;
INSERT INTO SeqTbl VALUES(1);
INSERT INTO SeqTbl VALUES(2);
INSERT INTO SeqTbl VALUES(4);
INSERT INTO SeqTbl VALUES(5);
INSERT INTO SeqTbl VALUES(8);

-- 歯抜けなし：開始値が1ではない
DELETE FROM SeqTbl;
INSERT INTO SeqTbl VALUES(3);
INSERT INTO SeqTbl VALUES(4);
INSERT INTO SeqTbl VALUES(5);
INSERT INTO SeqTbl VALUES(6);
INSERT INTO SeqTbl VALUES(7);

-- 歯抜けあり：開始値が1ではない
DELETE FROM SeqTbl;
INSERT INTO SeqTbl VALUES(3);
INSERT INTO SeqTbl VALUES(4);
INSERT INTO SeqTbl VALUES(7);
INSERT INTO SeqTbl VALUES(8);
INSERT INTO SeqTbl VALUES(10);

CREATE TABLE Graduates
(name   VARCHAR(16) PRIMARY KEY,
 income INTEGER NOT NULL);

INSERT INTO Graduates VALUES('サンプソン', 400000);
INSERT INTO Graduates VALUES('マイク',     30000);
INSERT INTO Graduates VALUES('ホワイト',   20000);
INSERT INTO Graduates VALUES('アーノルド', 20000);
INSERT INTO Graduates VALUES('スミス',     20000);
INSERT INTO Graduates VALUES('ロレンス',   15000);
INSERT INTO Graduates VALUES('ハドソン',   15000);
INSERT INTO Graduates VALUES('ケント',     10000);
INSERT INTO Graduates VALUES('ベッカー',   10000);
INSERT INTO Graduates VALUES('スコット',   10000);


CREATE TABLE NullTbl (col_1 INTEGER);

INSERT INTO NullTbl VALUES (NULL);
INSERT INTO NullTbl VALUES (NULL);
INSERT INTO NullTbl VALUES (NULL);


/* NULL を含まない集合を探す */
CREATE TABLE Students
(student_id   INTEGER PRIMARY KEY,
 dpt          VARCHAR(16) NOT NULL,
 sbmt_date    DATE);

INSERT INTO Students VALUES(100,  '理学部',   '2018-10-10');
INSERT INTO Students VALUES(101,  '理学部',   '2018-09-22');
INSERT INTO Students VALUES(102,  '文学部',   NULL);
INSERT INTO Students VALUES(103,  '文学部',   '2018-09-10');
INSERT INTO Students VALUES(200,  '文学部',   '2018-09-22');
INSERT INTO Students VALUES(201,  '工学部',   NULL);
INSERT INTO Students VALUES(202,  '経済学部', '2018-09-25');


-- 集合にきめ細かな条件を設定する
CREATE TABLE TestResults
(student_id CHAR(12) NOT NULL PRIMARY KEY,
 class   CHAR(1)  NOT NULL,
 sex     CHAR(1)  NOT NULL,
 score   INTEGER  NOT NULL);

INSERT INTO TestResults VALUES('001', 'A', '男', 100);
INSERT INTO TestResults VALUES('002', 'A', '女', 100);
INSERT INTO TestResults VALUES('003', 'A', '女',  49);
INSERT INTO TestResults VALUES('004', 'A', '男',  30);
INSERT INTO TestResults VALUES('005', 'B', '女', 100);
INSERT INTO TestResults VALUES('006', 'B', '男',  92);
INSERT INTO TestResults VALUES('007', 'B', '男',  80);
INSERT INTO TestResults VALUES('008', 'B', '男',  80);
INSERT INTO TestResults VALUES('009', 'B', '女',  10);
INSERT INTO TestResults VALUES('010', 'C', '男',  92);
INSERT INTO TestResults VALUES('011', 'C', '男',  80);
INSERT INTO TestResults VALUES('012', 'C', '女',  21);
INSERT INTO TestResults VALUES('013', 'D', '女', 100);
INSERT INTO TestResults VALUES('014', 'D', '女',   0);
INSERT INTO TestResults VALUES('015', 'D', '女',   0);


-- 全称文を述語で表現する
CREATE TABLE Teams
(member  CHAR(12) NOT NULL PRIMARY KEY,
 team_id INTEGER  NOT NULL,
 status  CHAR(8)  NOT NULL);

INSERT INTO Teams VALUES('ジョー',   1, '待機');
INSERT INTO Teams VALUES('ケン',     1, '出動中');
INSERT INTO Teams VALUES('ミック',   1, '待機');
INSERT INTO Teams VALUES('カレン',   2, '出動中');
INSERT INTO Teams VALUES('キース',   2, '休暇');
INSERT INTO Teams VALUES('ジャン',   3, '待機');
INSERT INTO Teams VALUES('ハート',   3, '待機');
INSERT INTO Teams VALUES('ディック', 3, '待機');
INSERT INTO Teams VALUES('ベス',     4, '待機');
INSERT INTO Teams VALUES('アレン',   5, '出動中');
INSERT INTO Teams VALUES('ロバート', 5, '休暇');
INSERT INTO Teams VALUES('ケーガン', 5, '待機');

-- 一意集合と多重集合
CREATE TABLE Materials
(center         CHAR(12) NOT NULL,
 receive_date   DATE     NOT NULL,
 material       CHAR(12) NOT NULL,
 PRIMARY KEY(center, receive_date));

INSERT INTO Materials VALUES('東京'	,'2018-4-01',	'錫');
INSERT INTO Materials VALUES('東京'	,'2018-4-12',	'亜鉛');
INSERT INTO Materials VALUES('東京'	,'2018-5-17',	'アルミニウム');
INSERT INTO Materials VALUES('東京'	,'2018-5-20',	'亜鉛');
INSERT INTO Materials VALUES('大阪'	,'2018-4-20',	'銅');
INSERT INTO Materials VALUES('大阪'	,'2018-4-22',	'ニッケル');
INSERT INTO Materials VALUES('大阪'	,'2018-4-29',	'鉛');
INSERT INTO Materials VALUES('名古屋',	'2018-3-15',	'チタン');
INSERT INTO Materials VALUES('名古屋',	'2018-4-01',	'炭素鋼');
INSERT INTO Materials VALUES('名古屋',	'2018-4-24',	'炭素鋼');
INSERT INTO Materials VALUES('名古屋',	'2018-5-02',	'マグネシウム');
INSERT INTO Materials VALUES('名古屋',	'2018-5-10',	'チタン');
INSERT INTO Materials VALUES('福岡'	,'2018-5-10',	'亜鉛');
INSERT INTO Materials VALUES('福岡'	,'2018-5-28',	'錫');


/* 関係除算でバスケット解析 */
CREATE TABLE Items
(item VARCHAR(16) PRIMARY KEY);

CREATE TABLE ShopItems
(shop VARCHAR(16),
 item VARCHAR(16),
    PRIMARY KEY(shop, item));

INSERT INTO Items VALUES('ビール');
INSERT INTO Items VALUES('紙オムツ');
INSERT INTO Items VALUES('自転車');

INSERT INTO ShopItems VALUES('仙台',  'ビール');
INSERT INTO ShopItems VALUES('仙台',  '紙オムツ');
INSERT INTO ShopItems VALUES('仙台',  '自転車');
INSERT INTO ShopItems VALUES('仙台',  'カーテン');
INSERT INTO ShopItems VALUES('東京',  'ビール');
INSERT INTO ShopItems VALUES('東京',  '紙オムツ');
INSERT INTO ShopItems VALUES('東京',  '自転車');
INSERT INTO ShopItems VALUES('大阪',  'テレビ');
INSERT INTO ShopItems VALUES('大阪',  '紙オムツ');
INSERT INTO ShopItems VALUES('大阪',  '自転車');

-- code 1-7

-- 成長・後退・現状維持
CREATE TABLE Sales
(year INTEGER NOT NULL ,
 sale INTEGER NOT NULL ,
 PRIMARY KEY (year));

INSERT INTO Sales VALUES (1990, 50);
INSERT INTO Sales VALUES (1991, 51);
INSERT INTO Sales VALUES (1992, 52);
INSERT INTO Sales VALUES (1993, 52);
INSERT INTO Sales VALUES (1994, 50);
INSERT INTO Sales VALUES (1995, 50);
INSERT INTO Sales VALUES (1996, 49);
INSERT INTO Sales VALUES (1997, 55);

-- 時系列に歯抜けがある場合：直近と比較
CREATE TABLE Sales2
(year INTEGER NOT NULL ,
 sale INTEGER NOT NULL ,
 PRIMARY KEY (year));

INSERT INTO Sales2 VALUES (1990, 50);
INSERT INTO Sales2 VALUES (1992, 50);
INSERT INTO Sales2 VALUES (1993, 52);
INSERT INTO Sales2 VALUES (1994, 55);
INSERT INTO Sales2 VALUES (1997, 55);

-- オーバーラップする期間を調べる
CREATE TABLE Reservations
(reserver    VARCHAR(30) PRIMARY KEY,
 start_date  DATE  NOT NULL,
 end_date    DATE  NOT NULL);

INSERT INTO Reservations VALUES('木村', '2018-10-26', '2018-10-27');
INSERT INTO Reservations VALUES('荒木', '2018-10-28', '2018-10-31');
INSERT INTO Reservations VALUES('堀',   '2018-10-31', '2018-11-01');
INSERT INTO Reservations VALUES('山本', '2018-11-03', '2018-11-04');
INSERT INTO Reservations VALUES('内田', '2018-11-03', '2018-11-05');
INSERT INTO Reservations VALUES('水谷', '2018-11-06', '2018-11-06');


-- 山本・内田・水谷の3人が重複
DELETE FROM Reservations;
INSERT INTO Reservations VALUES('木村', '2018-10-26', '2018-10-27');
INSERT INTO Reservations VALUES('荒木', '2018-10-28', '2018-10-31');
INSERT INTO Reservations VALUES('堀',   '2018-10-31', '2018-11-01');
INSERT INTO Reservations VALUES('山本', '2018-11-03', '2018-11-04');
INSERT INTO Reservations VALUES('内田', '2018-11-03', '2018-11-05');
INSERT INTO Reservations VALUES('水谷', '2018-11-04', '2018-11-06');


--山本氏を「日帰り」で登録(相関サブクエリの結果から内田氏が消える)
DELETE FROM Reservations;
INSERT INTO Reservations VALUES('木村', '2018-10-26', '2018-10-27');
INSERT INTO Reservations VALUES('荒木', '2018-10-28', '2018-10-31');
INSERT INTO Reservations VALUES('堀',   '2018-10-31', '2018-11-01');
INSERT INTO Reservations VALUES('山本', '2018-11-04', '2018-11-04');
INSERT INTO Reservations VALUES('内田', '2018-11-03', '2018-11-05');
INSERT INTO Reservations VALUES('水谷', '2018-11-06', '2018-11-06');


--演習問題：1-6
CREATE TABLE Accounts
(prc_date DATE NOT NULL ,
 prc_amt  INTEGER NOT NULL ,
 PRIMARY KEY (prc_date)) ;

DELETE FROM Accounts;
INSERT INTO Accounts VALUES ('2018-10-26',  12000 );
INSERT INTO Accounts VALUES ('2018-10-28',   2500 );
INSERT INTO Accounts VALUES ('2018-10-31', -15000 );
INSERT INTO Accounts VALUES ('2018-11-03',  34000 );
INSERT INTO Accounts VALUES ('2018-11-04',  -5000 );
INSERT INTO Accounts VALUES ('2018-11-06',   7200 );
INSERT INTO Accounts VALUES ('2018-11-11',  11000 );

