# RWD Training

作業はgithubリポジトリの資料を利用する。

```git clone https://github.com/syrius2000/RWD_Training```

このリポジトリは必要な知識を記録し、「フラットデータをデータベース化し、解析テーブルを得る」 目標を支援します。

- Linux（MAC OSX）またはWindows WSLなどを使い、フラットデータを点検する。
  - 形状把握
    - エンコーディングやカラム名の把握
    - 重複抽出
  - **利用ツール:** `Gnu text utils`, `awk`, `python`,`mysql8.0` 
- **SQLで実施する処置**
  - 重複抽出 → UniqなDataのテーブル作成
  - SQL2002の集計関数で処理する（CTE やwindow関数の利用）
- **SQL手順:**
  1. フラットデータをimportする。
  2. SQLでデータを操作する。
  3. 複数テーブルを組みして析テーブルを作成する。

これらの手順を実施する作業**Manual Instractions** として [従来手法を元にした作業手順](./lecDBMS_import/readme.md)を完成させた。

----
## AIエージェントの利用による効率化・基礎技術不足を補う

2025-09現在、RWD用に開発したAIエージェントができるようになった。
エージェントを利用するプロンプトを開発した。

- **AIエージェント実施方法の概要**: [Copilot Instructions](./.github/copilot-instructions-ja.md)
- **データインポート用AIエージェント**: [Copilot Instructions](./.github/prompts/SQLimport.prompt.md)
- **重複排除とインポート用AIエージェント**: [Copilot Instructions](.github/prompts/SQLImportAndDedupe.prompt.md)

以後、SQLでの解析テーブ作成エージェント、Rによる分析スクリプト作成エージェントを公開予定。(2025/09/15)
