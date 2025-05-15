#!/Users/manabu/.pyenv/shims/python3
# vim: set fileencoding=utf-8, setl expandtab

"""
# File name  :  複数のファイルからユニークな行を抽出 (元の順序を保持、ただしファイルごとの順序).py
# version = "$Revision: 0.1 $"
# Last Change: 2025/05/15 12:46$
# author = "Manabu Yamaguchi"

"""

import sys
import pprint

def get_unique_lines_from_files_ordered(file_paths):
    """複数のファイルからユニークな行を抽出し、ファイルごとの元の順序を保持する関数"""
    seen_lines = set()
    unique_records = []
    for file_path in file_paths:
        try:
            with open(file_path, 'r') as f:
                for line in f:
                    stripped_line = line.strip()
                    if stripped_line not in seen_lines:
                        seen_lines.add(stripped_line)
                        unique_records.append(stripped_line)
        except FileNotFoundError:
            print(f"ファイルが見つかりません: {file_path}")
    return unique_records

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("使用方法: python unique_records_multi_ordered.py <ファイル1> <ファイル2> ...")
        sys.exit(1)

    file_paths = sys.argv[1:]
    unique_records = get_unique_lines_from_files_ordered(file_paths)

    if unique_records:
        # print("\nユニークなレコード (ファイルごとの元の順序):")
        for record in unique_records:
            pprint.pprint(record)


