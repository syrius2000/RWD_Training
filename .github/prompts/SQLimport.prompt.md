---
title: "CSVサンプルからCREATE TABLEとLOAD DATA文を生成"
description: "CSVのサンプルからCREATE TABLE文とLOAD DATA INFILE文（日付処理対応）を生成します。"
mode: agent
---

### 使い方
1.  生成されたSQLが新しいエディタに表示されます。
2.  テーブル定義の元にしたいCSVファイルの位置を得ます。もしくはVS Codeで開きます。
3.  **ヘッダー行**と、データ型を推測させるための**データ行を2〜3行**マウスで選択します。またはヘッダを含む数行の情報を得ます。
4.  コマンドパレット (`Cmd+Shift+P` または `Ctrl+Shift+P`) を開きます。
4.  `Copilot: プロンプト` と入力し、一覧から `CSVサンプルからCREATE TABLEとLOAD DATA文を生成` を選択して実行します。

---

あなたはプロのデータベースエンジニアです。
以下のCSVファイルのヘッダ行とデータサンプル（`{{selection}}`）、およびファイルパス（`{{file}}`）を解析し、**`CREATE TABLE`** と **`LOAD DATA INFILE`** の2つのSQL文を生成してください。

### 要件:
1.  **データベース名**: `VACCINE`
2.  **テーブル名**: `myTableName`
3.  **`CREATE TABLE` 文**:
    *   CSVのヘッダ行をカラム名としてください。
    *   データサンプルから各カラムのデータ型（例: `VARCHAR(255)`, `INT`, `DATE`, `DATETIME`, `DOUBLE`など）を的確に推測してください。
    *   主キーやインデックスは不要です。

4.  **`LOAD DATA INFILE` 文**:
    *   インポート対象のファイルパスとして `{{file}}` を使用してください。
    *   CSVの1行目はヘッダーなので、スキップするように `IGNORE 1 LINES` を指定してください。
    *   フィールドの区切り文字がカンマ（`,`）、囲み文字がダブルクォーテーション（`"`）であることを指定してください。
    *   文字セットを指定してください（デフォルトは `CHARACTER SET 'utf8'` です）。
    *   **日付/日時カラムの特別処理**:
        *   `CREATE TABLE`で`DATE`や`DATETIME`型と推測されたカラムは、直接ロードせず、一度ユーザー変数（例: `@column_name_str`）に文字列として読み込んでください。
        *   `SET`句を使い、`STR_TO_DATE(NULLIF(@column_name_str, ''), '%Y/%m/%d')` のようにして、空文字列を`NULL`に変換し、安全に日付型に変換してからカラムに代入してください。

5.  **出力形式**:
    *   生成された`CREATE TABLE`文と`LOAD DATA INFILE`文を、それぞれSQLコードブロックとして出力してください。
    *   各SQL文の最後にはセミコロン `;` を付けてください。

### CSVサンプルデータ:
```csv
{{selection}}
```

### ファイルパス:
`{{file}}`

### 生成するSQL文の例:
```sql
-- CREATE TABLE文
CREATE TABLE VACCINE.myTableName (
    some_id INT,
    event_date DATE,
    value VARCHAR(255)
);
```

```sql
LOAD DATA INFILE '（ここに{{file}}のパスが入る）'
INTO TABLE VACCINE.myTableName
CHARACTER SET 'CP932' /* 必要に応じて UTF-8 などに変更 */
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(
    some_id,
    @event_date_str, -- 日付カラムは変数に読み込む
    value
)
SET
    event_date = STR_TO_DATE(NULLIF(@event_date_str, ''), '%Y/%m/%d'); /* ← 日付書式はデータに合わせる。NULLIF処理必須 */
```

