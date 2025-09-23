#!/usr/bin/env python3
# vim: set fileencoding=utf-8:expandtab:ts=2:sw=2:softtabstop=2

"""
process_lines.py

用途:
  - 複数のファイルからユニークな行を抽出する（順序保持 / 高速モード）
  - または重複している行のみを抽出する

改善点:
  - 入力エンコーディングを指定可能にした
  - 標準入力（stdin）からの読み取りに対応
  - 重複抽出時は初回検出順を保持して返す（決定論的）
  - 空行を無視するオプション的な挙動
"""

import sys
import argparse
from collections import OrderedDict
from typing import List


def _read_lines_from_path(path: str, encoding: str):
    with open(path, 'r', encoding=encoding, errors='replace') as f:
        for line in f:
            yield line


def _read_lines_from_stdin(encoding: str):
    for line in sys.stdin:
        yield line


def process_lines(file_paths: List[str], duplicates_only: bool = False, keep_order: bool = True, encoding: str = 'utf-8') -> List[str]:
    """
    Process lines from multiple files or stdin.

    Args:
      file_paths: ファイルパスのリスト。空の場合は標準入力から読み込みます。
      duplicates_only: Trueの場合、複数回出現する行のみを返します（最初の重複の順序は保持されます）
      keep_order: duplicates_onlyがFalseの場合に、ユニークな行の最初に出現した順序を保持するかどうか
      encoding: ファイルを読み込む際のエンコーディング

    Returns:
        処理された行のリスト（前後の空白、末尾の改行は削除されます）
    """
    # choose the iterator for input lines
    def iter_inputs():
        if not file_paths:
            yield from _read_lines_from_stdin(encoding)
        else:
            for p in file_paths:
                try:
                    yield from _read_lines_from_path(p, encoding)
                except FileNotFoundError:
                    print(f"エラー: ファイルが見つかりません: {p}", file=sys.stderr)
                except Exception as e:
                    print(f"エラー: {p} 処理中にエラーが発生しました: {e}", file=sys.stderr)

    if duplicates_only:
        seen = set()
        duplicates = OrderedDict()
        for line in iter_inputs():
            s = line.strip()
            if not s:
                continue
            if s in seen:
                # record first duplicate occurrence ordering and counts
                if s in duplicates:
                    duplicates[s] += 1
                else:
                    duplicates[s] = 2
            else:
                seen.add(s)
        return list(duplicates.keys())
    else:
        if keep_order:
            seen_lines = set()
            unique_records = []
            for line in iter_inputs():
                s = line.strip()
                if not s:
                    continue
                if s not in seen_lines:
                    seen_lines.add(s)
                    unique_records.append(s)
            return unique_records
        else:
            unique_lines = set()
            for line in iter_inputs():
                s = line.strip()
                if not s:
                    continue
                unique_lines.add(s)
            return list(unique_lines)


def main():
    parser = argparse.ArgumentParser(
        description="複数のファイルからユニークな行または重複行を抽出します。",
        epilog="デフォルトではユニークな行を抽出し、順序を保持します。"
    )
    parser.add_argument(
        'file_paths',
        metavar='FILE',
        nargs='*',
        help='処理対象のファイルパス。未指定の場合は標準入力を使用します。'
    )
    parser.add_argument(
        '--duplicates-only', '-d',
        action='store_true',
        help='重複している行のみを出力します。'
    )
    parser.add_argument(
        '--no-order',
        action='store_false',
        dest='keep_order',
        help='ユニーク行抽出時に行の順序を保持しません（処理が高速になる場合があります）。'
    )
    parser.add_argument(
        '--encoding',
        default='utf-8',
        help='入力ファイルのエンコーディング（デフォルト: utf-8）'
    )
    parser.set_defaults(keep_order=True)

    args = parser.parse_args()

    if args.duplicates_only:
        processed_records = process_lines(args.file_paths, duplicates_only=True, encoding=args.encoding)
    else:
        processed_records = process_lines(args.file_paths, duplicates_only=False, keep_order=args.keep_order, encoding=args.encoding)

    if processed_records:
        for record in processed_records:
            print(record)


if __name__ == '__main__':
    main()
