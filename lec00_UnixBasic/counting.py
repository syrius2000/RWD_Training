#!/bin/env python3
# vim: set fileencoding=utf-8, setl expandtab

"""
# File name  : counting.py
# __version__ = "$Revision: 0.1 $"
# date = 2025/01/20 18:23
# Last Change: 2025/04/03 14:48$
# __author__ = "Manabu Yamaguchi"

ターミナルとのセッションが切れても、tmux , screen を利用すれば問題ないことを示す例として
"""

import time

def main():
  count = 0
  while True:
    print(f"現在のカウント: {count}")
    count += 1
    time.sleep(1)  # 1秒間処理を停止


if __name__ == '__main__':
  main()
