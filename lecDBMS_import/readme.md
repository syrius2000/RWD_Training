# RDBMSへのインポートTips

ELTが整備されている場合以外の多くはCSVフラットテーブルを入手し、DBMSに適切にインポートする必要がある。


## 標準的なインポートSQL

``` SQL
    CREATE TABLE 患者基本情報_身長体重 (
         PATIENTNO VARCHAR(20) NOT NULL,           -- 患者番号
         SEX VARCHAR(1) NULL,                      -- 性別
         HEIGHTWEIGHTSTATUS VARCHAR(2) NULL,       -- 身長体重ステータス
         HEIGHTWEIGHT DECIMAL(5,2) NULL,           -- 身長または体重（例: 156.7）
         HEIGHTWEIGHTDATE DATE NULL                -- 身長体重測定日
         );
-- csv import
    LOAD DATA LOCAL
        INFILE 'fugafuga'  -- CSVファイルのフルパスを指定
    INTO TABLE 患者基本情報_身長体重              -- データを挿入するテーブル名
...
```

このSQLの作成にはDDLレベル条件が明確である必要がある。

1. カラムの文字列のサイズ長
2. NULL ケースの存在
3. フラットテーブルのEncoding
4. フラットテーブルのレコードセパレータ
5. 重複レコードがある場合はPrimaryが設定できない
6. いわゆる外字とEncodingの問題
7. 構造の不正（カラム数がレコードで一定か？）
8. 複数のフラットファイルにまたがる場合


## カラムの文字列のサイズ長


## NULL ケースの存在

NULLと””の区別・利用方法が一般に知られていないので注意する。
各カラムはNULL含む前提で望む。

```sql
      SEX VARCHAR(1) NULL,                          -- 性別にもNULLの記録があり得る
```



## フラットテーブルのEncoding

標準的なシェルスクリプトで一括調査する。

```shell
for I in *.txt;do echo $I; nkf --guess $I;done
```

得られた情報をSQLに加える。


```sql
CHARACTER SET sjis
```


## フラットテーブルのレコードセパレータ

vimでファイルを開いて確認する（無論入手時のRFPにて定義することが望ましいが、結構忘れられる）


## 重複レコードがある場合はPrimaryが設定できない

CSVフラットファイルに重複レコードが存在する場合が十分考えられる。
1. SQLにインポートしてから重複削除
2. CSVの段階で重複削除
などが考えられるが、ケースバイケースで対応する。 「重複があること前提での処理」が必要との認識が重要。


## いわゆる外字とEncodingの問題

フラットテーブルを調査しないと現実には把握困難。トライ＆エラーで望む。

## 構造の不正（カラム数がレコードで一定か？）

awkなどでフラットファイルの調査が必要

1. カラム数は全レコードで同一か？
2. カラムの最大文字数はいくつか？
3. 0/1データは文字か？数字か？Semanticは？
4. 外字が含まれているか？

結論的にトライ＆エラーで対応する。

## 複数のフラットファイルにまたがる場合

```sql
LOAD DATA INFILE '検査_2020txt'
INTO TABLE 一般検査
...
...
LOAD DATA INFILE '検査_2021.txt'
INTO TABLE 一般検査
```

などのSQLステートメントで対応する
