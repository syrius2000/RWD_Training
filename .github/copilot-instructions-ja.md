# RWDトレーニングリポジトリ向けAIコーディングエージェント指示

## プロジェクト概要
このリポジトリはReal World Data (RWD)処理のトレーニング教材を提供し、フラットファイルを構造化データベースに変換し、統計分析を実行することに焦点を当てています。コードベースはコマンドラインツール、Python、MySQL、LaTeXドキュメントを使用した実践的なデータエンジニアリングワークフローを実演しています。

## アーキテクチャとデータフロー

### コアコンポーネント
- **コマンドラインプロセッシング** (`lec01_commandline/`): Unixツールを使用したデータ重複除去と品質チェック
- **データベース操作** (`lecDBMS_mysql80/`, `lecDBMS_SQL/`): MySQL 8.0のセットアップとSQL変換
- **Python分析** (`examples/`): 統計分析と変化点検出
- **ドキュメント** (`lec02_AI/`): LaTeXベースの技術文書
- **テキスト処理** (`scripts/`): データクリーニング用のPerlおよびPythonユーティリティ

### データ処理パイプライン
1. **入力**: 重複やエンコーディングの問題があるCSV/TSVフラットファイル
2. **処理**: コマンドライン重複除去 → データベースインポート → SQL変換 → 分析
3. **出力**: クリーンなデータセット、統計レポート、LaTeXドキュメント

## 重要な開発者ワークフロー

### データ重複除去 (必須パターン)
```bash
# このコードベースでは常にsortしてからuniqを実行 - これはオプションではありません
sort file.csv | uniq > deduplicated.csv

````markdown
# AIコーディングエージェント向けメモ — RWD_Training（要約）

短い要約
- 目的: フラットファイルのクリーニング → MySQLインポート → SQL変換 → Python解析 → LaTeXドキュメントの生成、を学ぶための教材リポジトリ。

主要ディレクトリ（素早く見る場所）
- `lec01_commandline/` — Unixツールと重複除去の例（`DUP.awk`, `checkDUP.sh`）
- `lecDBMS_mysql80/`, `lecDBMS_SQL/` — MySQL初期化とインポートSQL（`initDB_Training.sql`）
- `examples/` — Pythonによる解析デモ（`change_point_demo.py`, `requirements.txt`）
- `lec02_AI/` — LaTeXソースと `Makefile`（`make` でビルド）
- `scripts/` — テキスト処理ユーティリティ（`clean_text.pl`, `detex.pl`）

必須ルールと例
- 重複除去: 常に `sort` のあとに `uniq` を使う。例: `sort file.csv | uniq > dedup.csv`。非連続重複は `awk '!seen[$0]++' input.csv > out.csv` を参照（`lec01_commandline/DUP.awk`）。
- エンコーディング: 日本語データはUTF-8に変換する。例: `iconv -f SHIFT_JIS -t UTF-8 input.csv > utf8.csv`。
- MySQL: MySQL 8.0 を想定。`innodb_file_per_table=ON` と `secure_file_priv` を空にする運用が想定される（`lecDBMS_mysql80/README.md` を参照）。
- LaTeX: `lec02_AI/Makefile` を使う（直接 `pdflatex` を呼ばない）。
- Python: スクリプト内で相対パスを使うパターン `HERE = os.path.dirname(__file__)` を踏襲する（`examples/change_point_demo.py`）。

実行ワークフロー（短例）
- ドキュメントPDFを作る: `cd lec02_AI && make`。
- Python依存を入れる: 仮想環境を作成し `pip install -r examples/requirements.txt`。
- 重複除去の検証: `wc -l input.csv output.csv` と `diff <(sort input.csv) <(sort output.csv)`。

プロジェクトの注意点
- SQLファイルは小さく分け、説明的な名前にする（`initDB_Training.sql` など）。
- データ/スクリプトは相対パスで参照する。絶対パスは避ける。
- 日本語文字列は UTF8MB4 を前提にする。

参考ファイル（必ず見るべきもの）
- `lec01_commandline/DUP.awk`, `lec01_commandline/checkDUP.sh`
- `examples/change_point_demo.py`, `examples/requirements.txt`
- `lecDBMS_mysql80/initDB_Training.sql`, `lecDBMS_mysql80/README.md`
- `lec02_AI/Makefile`, `lec02_AI/aboutAI.tex`

エージェント向け指示（運用ルール）
- 小さな変更を推奨: 1ファイルずつ、テストを追加する場合は小さなスモークテストを同梱。
- MySQLのサーバ設定はローカル/運用者に確認する（直接 `/etc/my.cnf` を編集しない）。

不明点があれば教えてください。必要なら CI 用の簡単なチェックや日本語ドキュメントの追記を作成します。
````