#!/usr/bin/perl
use strict;
use warnings;
use utf8;

# 入出力のエンコーディングをUTF-8に設定
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# ファイル全体を一つの文字列として読み込む
my $content = do { local $/; <> };

# コメントを削除 (% から行末まで)
$content =~ s/%.*//g;

# \begin{...} と \end{...} を削除
$content =~ s/\\(begin|end)\{[^}]+\}//g;

# \command[options]{argument} のようなコマンドを argument に置換
# 注意: ネストした波括弧には対応していません
$content =~ s/\\[a-zA-Z]+(?:\[[^\]]*\])?\{([^{}]*)\}/$1/g;

# \command のような引数なしのコマンドを削除
$content =~ s/\\[a-zA-Z]+//g;

# 残った波括弧を削除
$content =~ s/[{}]//g;

# 複数の空行を1行にまとめる
$content =~ s/\n\s*\n/\n/g;

# 処理後の内容を出力
print $content;
