#!/Users/manabu/.pyenv/shims/python3
# vim: set fileencoding=utf-8, setl expandtab

"""
# File name  : counting.py
# __version__ = "$Revision: 0.1 $"
# __date__ = "$Date :  $"
# Last Change: 2025/03/27 14:23$
# __author__ = "Manabu Yamaguchi"

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
