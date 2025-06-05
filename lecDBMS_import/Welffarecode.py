#!/Users/manabu/.pyenv/shims/python3
# vim: set fileencoding=utf-8, setl expandtab

"""
# File name  : columsplitter.py
# __version__ = "$Revision: 0.1 $"
# __date__ = "$Date :  $"
# Last Change: 2025/06/04 13:54$
# __author__ = "Manabu Yamaguchi"

"""

import csv
from collections import Counter

def aggregate_medicine_codes_cp932(input_csv_path, output_csv_path=None): # 関数名も変更しました
    """
    CP932(Shift_JIS拡張)エンコーディングのCSVファイルから "WELFARECODE" と "MEDICINENAME" の
    組み合わせごとの件数を集計します。

    Args:
        input_csv_path (str): 入力するCP932エンコーディングのCSVファイルのパス。
        output_csv_path (str, optional): 結果を出力するCP932エンコーディングのCSVファイルのパス。
                                        指定しない場合はコンソールに出力します。
    """
    try:
        # エンコーディングを 'cp932' に変更
        with open(input_csv_path, 'r', encoding='cp932') as infile:
            reader = csv.reader(infile)
            try:
                header = next(reader)
            except StopIteration:
                print("エラー: CSVファイルが空か、ヘッダー行を読み取れませんでした。")
                return

            try:
                welfare_code_index = header.index("WELFARECODE")
                medicine_name_index = header.index("MEDICINENAME")
            except ValueError:
                print("エラー: CSVファイルに 'WELFARECODE' または 'MEDICINENAME' の列が見つかりません。")
                return

            combinations = Counter()
            line_num = 1 # ヘッダーを読んだ後なのでデータ行は1からカウント (デバッグ用)
            for row in reader:
                line_num += 1
                if len(row) > max(welfare_code_index, medicine_name_index):
                    welfare_code = row[welfare_code_index]
                    medicine_name = row[medicine_name_index]
                    combinations[(welfare_code, medicine_name)] += 1
                else:
                    print(f"警告: {line_num}行目でデータが不足しているためスキップしました: {row}")


            if output_csv_path:
                # エンコーディングを 'cp932' に変更
                # with open(output_csv_path, 'w', encoding='cp932', newline='') as outfile:
                with open(output_csv_path, 'w', encoding='utf-8', newline='') as outfile:
                    writer = csv.writer(outfile)
                    writer.writerow(["WELFARECODE", "MEDICINENAME", "件数"])
                    for (welfare_code, medicine_name), count in combinations.items():
                        writer.writerow([welfare_code, medicine_name, count])
                print(f"結果を {output_csv_path} (utf-8) に出力しました。")
            else:
                print("WELFARECODE,MEDICINENAME,件数")
                for (welfare_code, medicine_name), count in combinations.items():
                    print(f"{welfare_code},{medicine_name},{count}")

    except FileNotFoundError:
        print(f"エラー: 入力ファイル '{input_csv_path}' が見つかりません。")
    except UnicodeDecodeError as e:
        # エラーが再度発生した場合、より詳細な情報を表示
        print(f"エラー: ファイル '{input_csv_path}' のデコードに失敗しました。")
        print(f"  エンコーディング: cp932")
        print(f"  エラー詳細: {e}")
        print(f"  ファイルがCP932以外のエンコーディングであるか、破損している可能性があります。")
    except Exception as e:
        print(f"予期せぬエラーが発生しました: {e}")

# --- 使用例 ---
# input_cp932.csv という名前のCP932エンコードされた入力ファイルがある場合
# aggregate_medicine_codes_cp932('your_input_file.csv') # コンソールに出力
# aggregate_medicine_codes_cp932('your_input_file.csv', 'output_counts_cp932.csv') # 'output_counts_cp932.csv' (CP932) に出力


aggregate_medicine_codes_cp932('/private/tmp/CH_t12_06_処方薬剤_納品.txt', 'walface_counts.csv') # 'output_counts.csv' に出力
