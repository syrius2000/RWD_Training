#!/Users/manabu/.pyenv/shims/python3
# vim: set fileencoding=utf-8, setl expandtab

"""
# File name  : DUP.py
# __version__ = "$Revision: 0.1 $"
# __date__ = "$Date :  $"
# Last Change: 2025/04/17 00:23$
# __author__ = "Manabu Yamaguchi"

"""

import sys

def find_duplicates_from_files(file_paths):
    """複数のファイルから重複要素を抽出する関数"""
    seen = set()
    duplicates = set()
    for file_path in file_paths:
        try:
            with open(file_path, "r") as f:
                for line in f:
                    item = line.strip()
                    if item in seen:
                        duplicates.add(item)
                    else:
                        seen.add(item)
        except FileNotFoundError:
            print(f"ファイルが見つかりません: {file_path}")
    return list(duplicates)

# 例
file_paths = sys.argv[1:] # コマンドライン引数でファイルパスを受け取る。
duplicates = find_duplicates_from_files(file_paths)
print(duplicates)



