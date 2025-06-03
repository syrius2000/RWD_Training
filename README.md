# RWD Training

## 利用場面Use Case

資料はGITHUBから得ることができる。

```git clone https://github.com/syrius2000/RWD_Training```

この文書によりCUI、Linux（MAC OSX）でフラットテーブルデータを点検したり、Database化して解析テーブルを得るまでの下準備を完了させる事ができるような基礎的な知識の記録を目指す。

cat, awk, mysql8.0,.. などを利用し主体にフラットテーブルデータをDB化しSQLで操作し解析テーブルを作る。

- フラットテーブルに必要な処置や注意点
  - 重複抽出
  - 形状把握
    - エンコーディングやカラム名の把握

- SQLで必要な処置
  - 重複抽出→なしのテーブル作成
  - 要求構造をSQLで集計する（window 関数でpartition機能の紹介）

参考文献を明記し、素晴らしい先達の書を提示し自習（購入要求できる）をできるようにする。

## 参考情報

- **Flat Data Processing** : Includes deduplication and understanding the data structure.
- **SQL Processing** : Involves creating tables without duplicates and achieving required structures using SQL (including SQL2002 partitioning).
- **Self-Study and References** : Emphasizes the importance of citing references and suggests excellent literature for self-study, especially for those accustomed to GUI environments.
