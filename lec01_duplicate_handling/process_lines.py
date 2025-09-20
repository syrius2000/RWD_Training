#!/usr/bin/env python3
# vim: set fileencoding=utf-8:expandtab:ts=2:sw=2:softtabstop=2

"""
ファイル名: process_lines.py

説明:
複数のファイルから、ユニークな行を抽出するか、または重複している行のみを抽出するスクリプトです。
コマンドライン引数で動作を制御します。

使用方法:
  1. ユニークな行を抽出 (デフォルト、順序保持):
     python process_lines.py <ファイル1> <ファイル2> ...

  2. ユニークな行を抽出 (順序保持なし、高速):
     python process_lines.py --no-order <ファイル1> <ファイル2> ...

  3. 重複している行のみを抽出:
     python process_lines.py --duplicates-only <ファイル1> <ファイル2> ...

  4. ヘルプを表示:
     python process_lines.py --help
"""

import sys
import argparse

def process_lines(file_paths, duplicates_only=False, keep_order=True):
    """
    複数のファイルから行を処理し、ユニークな行または重複行を抽出する関数。

    Args:
        file_paths (list): 処理対象のファイルパスのリスト。
        duplicates_only (bool): Trueの場合、重複している行のみを返す。
                                Falseの場合、ユニークな行を返す。
        keep_order (bool): Trueの場合、行の出現順序を保持する（duplicates_only=Falseの場合のみ有効）。

    Returns:
        list: 処理結果の行のリスト。
    """
    if duplicates_only:
        # 重複行のみを抽出するロジック (DUP.pyの機能)
        seen = set()
        duplicates = set()
        for file_path in file_paths:
            try:
                with open(file_path, "r", encoding='utf-8') as f:
                    for line in f:
                        stripped_line = line.strip()
                        if stripped_line in seen:
                            duplicates.add(stripped_line)
                        else:
                            seen.add(stripped_line)
            except FileNotFoundError:
                print(f"エラー: ファイルが見つかりません: {file_path}", file=sys.stderr)
            except Exception as e:
                print(f"エラー: {file_path} 処理中にエラーが発生しました: {e}", file=sys.stderr)
        return list(duplicates)
    else:
        # ユニークな行を抽出するロジック (ExtractUniqueLines_from_MultipleFiles.pyの機能)
        if keep_order:
            seen_lines = set()
            unique_records = []
            for file_path in file_paths:
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        for line in f:
                            stripped_line = line.strip()
                            if stripped_line not in seen_lines:
                                seen_lines.add(stripped_line)
                                unique_records.append(stripped_line)
                except FileNotFoundError:
                    print(f"エラー: ファイルが見つかりません: {file_path}", file=sys.stderr)
                except Exception as e:
                    print(f"エラー: {file_path} 処理中にエラーが発生しました: {e}", file=sys.stderr)
            return unique_records
        else:
            unique_lines = set()
            for file_path in file_paths:
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        for line in f:
                            unique_lines.add(line.strip())
                except FileNotFoundError:
                    print(f"エラー: ファイルが見つかりません: {file_path}", file=sys.stderr)
                except Exception as e:
                    print(f"エラー: {file_path} 処理中にエラーが発生しました: {e}", file=sys.stderr)
            return list(unique_lines)

def main():
    """コマンドライン引数を処理し、メインの処理を実行する。"""
    parser = argparse.ArgumentParser(
        description="複数のファイルからユニークな行または重複行を抽出します。",
        epilog="デフォルトではユニークな行を抽出し、順序を保持します。"
    )
    parser.add_argument(
        "file_paths",
        metavar="FILE",
        nargs='+',
        help="処理対象のファイルパス。複数指定可能。"
    )
    parser.add_argument(
        "--duplicates-only",
        "-d",
        action="store_true",
        help="重複している行のみを出力します。"
    )
    parser.add_argument(
        "--no-order",
        action="store_false",
        dest="keep_order",
        help="ユニーク行抽出時に行の順序を保持しません（処理が高速になる場合があります）。"
    )
    parser.set_defaults(keep_order=True) # デフォルトは順序保持

    args = parser.parse_args()

    # --duplicates-only が指定された場合、--no-order は無視されるべき
    if args.duplicates_only:
        # 重複行の抽出では順序保持は意味がないため、常にFalseとして渡す
        # ただし、duplicates_onlyモードではkeep_orderの引数は内部的に使用されない
        processed_records = process_lines(args.file_paths, duplicates_only=True)
    else:
        processed_records = process_lines(args.file_paths, duplicates_only=False, keep_order=args.keep_order)

    if processed_records:
        for record in processed_records:
            print(record)

if __name__ == "__main__":
    main()
