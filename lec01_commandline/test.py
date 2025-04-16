#!/Users/manabu/.pyenv/shims/python3
# vim: set fileencoding=utf-8, setl expandtab



"""
# File name  : test.py
# __version__ = "$Revision: 0.1 $"
# __date__ = "$Date :  $"
# Last Change: 2025/04/17 00:31$
# __author__ = "Manabu Yamaguchi"

"""

import sys

def get_unique_lines_from_files(file_paths):
    """複数のファイルからユニークな行を抽出する関数 (順序は保証されない)"""
    unique_lines = set()
    for file_path in file_paths:
        try:
            with open(file_path, 'r') as f:
                for line in f:
                    unique_lines.add(line.strip())
        except FileNotFoundError:
            print(f"ファイルが見つかりません: {file_path}")
    return list(unique_lines)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("使用方法: python unique_records_multi.py <ファイル1> <ファイル2> ...")
        sys.exit(1)

    file_paths = sys.argv[1:]
    unique_records = get_unique_lines_from_files(file_paths)

    if unique_records:
        print("\nユニークなレコード:")
        for record in unique_records:
            print(record)


