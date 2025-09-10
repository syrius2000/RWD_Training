---
title: "TABLEの重複削除
description: "テーブルの重複行を削除するSQLを生成します。"
mode: agent
---

### 目標・目的
あなたはプロのデータベースエンジニアです。
重複行を削除するSQL文を生成してください。

1. テーブルの重複行を削除するSQLを生成します。
2. テーブルに対し、`SELECT DISTINCT * FORM myTableName;` を実行します。
3. 重複行を削除した結果を新しいテーブル名 `TEMPTABLE` として出力します。
4. 元のテーブルを削除し、`TEMPTABLE`を `myTableName` として出力します。

### 要件:
1.  **データベース名**: `VACCINE`
2.  **テーブル名**: `myTableName` もしくはセレクトされれたテーブルァイルを利用する



### 対象のテーブル名
```
{{selection}}
```