---
title: "CSVサンプルからCREATE TABLEとLOAD DATA文を生成 (高機能版)"
description: "CSVのサンプルからCREATE TABLE文とLOAD DATA INFILE文を動的に生成します。テーブル名、日付書式、カラム名を自動で調整します。"
mode: agent
---

### 概要
あなたはプロのデータベースエンジニアです。
CSVファイルのヘッダ行とデータサンプル、およびファイルパスを解析し、MySQL用の**`CREATE TABLE`** と **`LOAD DATA INFILE`** の2つのSQL文を生成してください。

### 使い方

1.  テーブル定義の元にしたいCSVファイルをVS Codeで開きます。
2.  **ヘッダー行**と、データ型を推測させるための**データ行を2〜3行**マウスで選択します。
3.  コマンドパレット (`Cmd+Shift+P` または `Ctrl+Shift+P`) を開きます。
4.  `Copilot: プロンプト` と入力し、一覧からこのプロンプト (`CSVサンプルからCREATE TABLEとLOAD DATA文を生成 (高機能版)`) を選択して実行します。
5.  生成されたSQLが新しいエディタに表示されます。

---

### 要件
1.  **データベース名**: `VACCINE`
2.  **テーブル名**: ファイルパス `{{file}}` のファイル名から拡張子を取り除いたものをテーブル名としてください。（例: `t01_patients.csv` -> `t01_patients`）
3.  **`CREATE TABLE` 文**:
    *   CSVのヘッダ行をカラム名としてください。
    *   **カラム名のサニタイズ**: SQLで無効な文字（スペース、括弧、ハイフンなど）がヘッダーに含まれる場合は、自動的にアンダースコア `_` に置き換えてください。
    *   **データ型の推測ルール**:
        *   データサンプルから `DATE` 型または `DATETIME` 型に見えるカラムを推測してください。
        *   上記以外のカラムは、たとえ数値に見えても**全て `VARCHAR(255)`** として定義してください。`INT` や `DECIMAL` は使用しないでください。
    *   主キーやインデックスは不要です。
4.  **`LOAD DATA INFILE` 文**:
    *   インポート対象のファイルパスとして `{{file}}` を使用してください。
    *   CSVの1行目はヘッダーなので、`IGNORE 1 LINES` を指定してください。
    *   フィールドの区切り文字はカンマ（`,`）、囲み文字はダブルクォーテーション（`"`）を想定してください。
    *   文字セットは `cp932` をデフォルトとし、`/* 文字コードはファイルに合わせて utf8mb4 などに変更してください */` というコメントを添えてください。
    *   **日付/日時カラムの特別処理**:
        *   `DATE`や`DATETIME`型のカラムは、一度ユーザー変数（例: `@column_name_str`）に文字列として読み込んでください。
        *   `SET`句を使い、`STR_TO_DATE(NULLIF(@column_name_str, ''), '【ここに推測した日付書式】')` のように変換してください。
        *   **重要**: CSVサンプルの日付書式（例: `%Y/%m/%d`, `%Y-%m-%d %H:%i:%s` など）を**正確に検出し、`STR_TO_DATE`関数に反映**してください。
5.  **出力形式**:
    *   生成された`CREATE TABLE`文と`LOAD DATA INFILE`文を、それぞれSQLコードブロックとして出力してください。
    *   各SQL文の最後にはセミコロン `;` を付けてください。

---

### 入力情報

#### CSVサンプルデータ:
```{{selection}}```

#### ファイルパス:
`{{file}}`

---

### 生成例

**もしCSVサンプルが以下の場合:**
```
"患者 ID", "来院日", "体温(℃)"
"P001", "2023/05/01", "36.8"
"P002", "2023/05/02", "37.1"
```
**かつファイルパスが `/path/to/t01_patients.csv` の場合、以下のようなSQLを生成します。**

```sql
-- テーブル作成
CREATE TABLE VACCINE.t01_patients (
    `患者_ID` VARCHAR(255),
    `来院日` DATE,
    `体温_℃_` VARCHAR(255)
);
```

```sql
-- データロード
LOAD DATA INFILE '/path/to/t01_patients.csv'
INTO TABLE VACCINE.t01_patients
CHARACTER SET 'utf8mb4' -- 文字コードはファイルに合わせて utf8 や cp932 に変更
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(
    `患者_ID`,
    @rainday_str, -- 一時変数に来院日を読み込む
    `体温_℃_`
)
SET
    `来院日` = STR_TO_DATE(NULLIF(@rainday_str, ''), '%Y/%m/%d');
```

この修正案を適用しますか？ また、`SQLImportAndDedupe.prompt.md` にも同様のレイアウト整合性やタイポ修正を適用することも可能です。ご希望でしたらお申し付けください。
