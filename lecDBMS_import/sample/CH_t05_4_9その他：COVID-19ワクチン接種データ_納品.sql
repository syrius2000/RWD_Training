USE VACCINE;

DROP TABLE IF EXISTS COVID19ワクチン接種;
CREATE TABLE COVID19ワクチン接種(
    PATIENTNO VARCHAR(20) NOT NULL,
    DEPARTMENTCODE VARCHAR(10),
    DEPTNAME VARCHAR(50),
    EVENTDATE DATE NULL,                           -- イベント日
    更新日時 DATETIME NULL,                       -- 更新日時（時刻情報も必要なのでDATETIME）
    問診1_過去2週間の曝露歴 VARCHAR(10),
    問診2_濃厚接触者 VARCHAR(10),
    問診3_症状の有無 VARCHAR(10),
    問診4_家族_同僚症状の有無 VARCHAR(10),
    問診5_接種歴 VARCHAR(20),
    接種日1回目 DATE NULL,                         -- 接種日1回目
    日付不明1回目 VARCHAR(10),                     -- 「日付不明」文字列をそのまま保持
    年1回目 VARCHAR(40),                            -- 年を文字列として保持
    月1回目 VARCHAR(20),                            -- 月を文字列として保持
    接種日2回目 DATE NULL,                         -- 接種日2回目
    日付不明2回目 VARCHAR(10),
    年2回目 VARCHAR(40),
    月2回目 VARCHAR(20),
    接種日3回目 DATE NULL,
    日付不明3回目 VARCHAR(10),
    年3回目 VARCHAR(40),
    月3回目 VARCHAR(20),
    接種日4回目 DATE NULL,
    日付不明4回目 VARCHAR(40),
    年4回目 VARCHAR(40),
    月4回目 VARCHAR(20),
    問診6_新型コロナ感染症の罹患歴 VARCHAR(10),
    診断日 DATE NULL,                              -- 診断日
    診断日日付不明 VARCHAR(10),
    診断日年1 VARCHAR(40),
    診断日月1 VARCHAR(20),
    問診7_過去6か月以内の海外渡航歴 VARCHAR(10)
    -- PRIMARY KEY (PATIENTNO, EVENTDATE)             -- 患者番号とイベント日の組み合わせを主キーに設定
);

-- SHOW TABLES;
DESCRIBE COVID19ワクチン接種;

-- LOAD DATA INFILE '/Users/myamaguchi/Data/Vaccin/CH_t05_4_9その他：COVID-19ワクチン接種データ_納品.txt'
LOAD DATA INFILE '/tmp/CH_t05_4_9その他：COVID-19ワクチン接種データ_納品.txt'
INTO TABLE COVID19ワクチン接種
CHARACTER SET CP932
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    PATIENTNO,
    DEPARTMENTCODE,
    DEPTNAME,
    @EVENTDATE_STR,     -- 一時変数に読み込む
    @更新日時_STR,     -- 一時変数に読み込む
    問診1_過去2週間の曝露歴,
    問診2_濃厚接触者,
    問診3_症状の有無,
    問診4_家族_同僚症状の有無,
    問診5_接種歴,
    @接種日1回目_STR,
    日付不明1回目,
    年1回目,
    月1回目,
    @接種日2回目_STR,
    日付不明2回目,
    年2回目,
    月2回目,
    @接種日3回目_STR,
    日付不明3回目,
    年3回目,
    月3回目,
    @接種日4回目_STR,
    日付不明4回目,
    年4回目,
    月4回目,
    問診6_新型コロナ感染症の罹患歴,
    @診断日_STR,
    診断日日付不明,
    診断日年1,
    診断日月1,
    問診7_過去6か月以内の海外渡航歴
)
SET
    -- 日付型カラムの処理: 空文字列または「日付不明」の場合はNULLにする
    EVENTDATE = CASE
                    WHEN @EVENTDATE_STR = '' OR @EVENTDATE_STR = '日付不明' THEN NULL
                    ELSE STR_TO_DATE(@EVENTDATE_STR, '%Y/%m/%d %H:%i:%s')
                END,
    更新日時 = CASE
                   WHEN @更新日時_STR = '' THEN NULL
                   ELSE STR_TO_DATE(@更新日時_STR, '%Y/%m/%d %H:%i:%s')
               END,
    接種日1回目 = CASE
                      WHEN @接種日1回目_STR = '' OR @接種日1回目_STR = '日付不明' THEN NULL
                      ELSE STR_TO_DATE(@接種日1回目_STR, '%Y/%m/%d %H:%i:%s')
                  END,
    接種日2回目 = CASE
                      WHEN @接種日2回目_STR = '' OR @接種日2回目_STR = '日付不明' THEN NULL
                      ELSE STR_TO_DATE(@接種日2回目_STR, '%Y/%m/%d %H:%i:%s')
                  END,
    接種日3回目 = CASE
                      WHEN @接種日3回目_STR = '' OR @接種日3回目_STR = '日付不明' THEN NULL
                      ELSE STR_TO_DATE(@接種日3回目_STR, '%Y/%m/%d %H:%i:%s')
                  END,
    接種日4回目 = CASE
                      WHEN @接種日4回目_STR = '' OR @接種日4回目_STR = '日付不明' THEN NULL
                      ELSE STR_TO_DATE(@接種日4回目_STR, '%Y/%m/%d %H:%i:%s')
                  END,
    診断日 = CASE
                 WHEN @診断日_STR = '' OR @診断日_STR = '日付不明' THEN NULL
                 ELSE STR_TO_DATE(@診断日_STR, '%Y/%m/%d %H:%i:%s')
             END;

SELECT * FROM COVID19ワクチン接種 LIMIT 10;


