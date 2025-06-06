# -*- coding:utf-8; mode:python; mode:auto-complete  -*-
""" Last Change: 2025-06-06 16:40.
Create:  2025-06-06 (15:36:06)
file  :  uniq_count_csv.py


スクリプトの解説
設定項目:
csv_file_path: 処理したいCSVファイルのパスを指定します。
column_a_name: 結合対象の1つ目のカラム名を指定します（例: "PATIENTNO"）。
column_b_name: 結合対象の2つ目のカラム名を指定します（例: "DEPARTMENTCODE"）。
output_file_name: 結果を保存するCSVファイルの名前を指定します。

get_encoding(file_path) 関数:
	chardet ライブラリ（pip install chardet でインストール）を使って、ファイルの先頭部分を読み込み、
	最も可能性の高いエンコーディングを推定します。これは、CSVファイルのエンコーディングが事前に不明な場合に役立ちます。

calculate_combined_unique_counts() 関数:
	エンコーディングの判別と読み込み:
	まず chardet で検出されたエンコーディングでCSVファイルを読み込みます。
	UnicodeDecodeError
	が発生した場合（エンコーディングの判別ミスなど）、フォールバックとしてCP932、次にUTF-8の順で読み込みを試みます。
	これにより、CP932またはUTF-8のどちらかであれば、適切に読み込める可能性が高まります。
カラムの存在チェック: 指定されたカラム名がデータフレームに存在するかを確認します。
カラムの結合:
	df[col1_name].astype(str) + "_" + df[col2_name].astype(str):
	指定された2つのカラムの値を文字列として結合し、間にアンダースコア _
	を挟みます。これにより、例えば PATIENTNO が 123、DEPARTMENTCODE が 内科 ならば
	"123_内科" のような新しい文字列が生成されます。
	.astype(str) は、数値や日付型のカラムが文字列型に変換されることを保証し、結合時のエラーを防ぎます。また、None
	や NaN のような欠損値が None_値 や nan_値 となることを防ぐために、必要に応じて
	fillna('') などで欠損値を空文字列に置き換える前処理を検討しても良いでしょう。
ユニークカウントの計算:
	df['combined_column'].value_counts():
	結合された新しいカラムの各ユニークな値の出現回数を計算します。結果はシリーズ（Series）として返されます。
	.reset_index():
	シリーズをデータフレームに変換します。ユニークな値がインデックスになり、カウントがカラムになります。
	.columns = ['Combined_Value', 'Unique_Count']: カラム名を分かりやすく変更します。
元のカラムへの分割:
	unique_counts_df['Combined_Value'].apply(lambda x: x.split('_')[0]):
	結合された値から、元の Col-A の部分を再度抽出し、新しいカラム Original_Col_A
	に格納します。 unique_counts_df['Combined_Value'].apply(lambda x:
'_'.join(x.split('_')[1:])): 同様に、元の Col-B
	の部分を抽出します。これは、Col-B の内容自体に _
	が含まれる可能性がある場合に、split('_') で分割した残りを結合し直すためです。
	最終的に Original_Col_A、Original_Col_B、Unique_Count
	のカラムを持つ整形されたデータフレームを返します。
メイン処理:
	calculate_combined_unique_counts 関数を呼び出し、結果を result_df に格納します。
	結果のデータフレームをコンソールに表示し、指定されたファイル名でCSVとして保存します。保存時のエンコーディングは
	utf-8 を推奨します。
"""

import pandas as pd
import chardet # エンコーディング自動判別用 (必要に応じてインストール)

# --- 設定項目 ---
csv_file_path = "your_data.csv"  # ★あなたのCSVファイルパスを指定してください
column_a_name = "Col-A"          # ★ユニークカウントを結合する1つ目のカラム名
column_b_name = "Col-B"          # ★ユニークカウントを結合する2つ目のカラム名
output_file_name = "combined_unique_counts.csv" # 出力するCSVファイル名
# -----------------

def get_encoding(file_path):
    """
    ファイルのエンコーディングを推定する関数
    """
    with open(file_path, 'rb') as f:
        raw_data = f.read(100000) # 先頭100KBを読み込んで判定
    result = chardet.detect(raw_data)
    return result['encoding']

def calculate_combined_unique_counts(file_path, col1_name, col2_name):
    """
    CSVファイルから指定された2つのカラムを結合し、ユニークカウントを計算する。
    """
    df = None
    detected_encoding = None

    try:
        # 1. エンコーディングの自動判別を試みる
        detected_encoding = get_encoding(file_path)
        print(f"Detected encoding: {detected_encoding}")

        # 検出されたエンコーディングで読み込みを試みる
        try:
            df = pd.read_csv(file_path, encoding=detected_encoding)
        except UnicodeDecodeError:
            print(f"Attempting to read with detected encoding '{detected_encoding}' failed. Trying common encodings.")
            # 検出が失敗した場合、CP932とUTF-8を明示的に試す
            try:
                df = pd.read_csv(file_path, encoding='cp932')
                detected_encoding = 'cp932'
                print("Successfully read with encoding: cp932")
            except UnicodeDecodeError:
                try:
                    df = pd.read_csv(file_path, encoding='utf-8')
                    detected_encoding = 'utf-8'
                    print("Successfully read with encoding: utf-8")
                except UnicodeDecodeError as e:
                    print(f"Failed to read with both CP932 and UTF-8: {e}")
                    print("Please ensure the file is CP932 or UTF-8 and check the file content.")
                    return None
        except Exception as e:
            print(f"An unexpected error occurred during file reading: {e}")
            return None


        if df is None:
            return None

        # 2. 指定されたカラムが存在するか確認
        if col1_name not in df.columns:
            raise ValueError(f"指定されたカラム '{col1_name}' がCSVファイルに見つかりません。")
        if col2_name not in df.columns:
            raise ValueError(f"指定されたカラム '{col2_name}' がCSVファイルに見つかりません。")

        # 3. 2つのカラムの内容を結合する
        # null値が含まれる場合、文字列 'None' や 'NaN' と結合されるのを避けるため、
        # 事前に文字列型に変換し、欠損値を空文字列に置き換えることを推奨します。
        df['combined_column'] = df[col1_name].astype(str) + "_" + df[col2_name].astype(str)

        # 4. 結合されたカラムのユニークカウントを計算
        unique_counts_df = df['combined_column'].value_counts().reset_index()
        unique_counts_df.columns = ['Combined_Value', 'Unique_Count']

        # 5. 出力用に整形
        # 元のカラムAとカラムBに分割し直す
        # splitメソッドはリストを返すので、str.split().str[0]のようにしてアクセス
        unique_counts_df['Original_Col_A'] = unique_counts_df['Combined_Value'].apply(lambda x: x.split('_')[0])
        unique_counts_df['Original_Col_B'] = unique_counts_df['Combined_Value'].apply(lambda x: '_'.join(x.split('_')[1:]))
        # オリジナルの結合値カラムは不要であれば削除
        unique_counts_df = unique_counts_df[['Original_Col_A', 'Original_Col_B', 'Unique_Count']]

        return unique_counts_df

    except FileNotFoundError:
        print(f"エラー: ファイル '{file_path}' が見つかりません。")
        return None
    except ValueError as ve:
        print(f"エラー: {ve}")
        return None
    except Exception as e:
        print(f"予期せぬエラーが発生しました: {e}")
        return None

# --- メイン処理 ---
if __name__ == "__main__":
    result_df = calculate_combined_unique_counts(csv_file_path, column_a_name, column_b_name)

    if result_df is not None:
        print("\n--- 結合されたユニークカウント結果 ---")
        print(result_df)

        # 結果をCSVファイルに保存
        # エンコーディングはUTF-8で保存するのが一般的です。
        try:
            result_df.to_csv(output_file_name, index=False, encoding='utf-8')
            print(f"\n結果が '{output_file_name}' に保存されました。")
        except Exception as e:
            print(f"結果のCSVファイルへの保存中にエラーが発生しました: {e}")

