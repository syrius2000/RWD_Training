#!/usr/bin/perl
use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

while (<>) {
    # ヘッダー/フッターと思われる行をスキップ
    next if /ֶޱࢁ/;
    next if /^\d{4}-\d{2}-\d{2}.*?\d{4}-\d{2}-\d{2}/;

    # 制御文字や特定の記号のみの行をスキップ
    next if /^[ֱ\s]+$/;

    # 空行をスキップ
    next if /^\s*$/;

    # 上記の条件に一致しない行を出力
    print;
}
