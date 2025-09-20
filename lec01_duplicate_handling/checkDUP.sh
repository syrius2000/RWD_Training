#!/bin/bash

# 処理対象のファイルリスト
files=(
    "検査結果2022UTF8.csv"
    "検査結果2021UTF8.csv"
    "検査結果2020UTF8.csv"
    "検査結果2019UTF8.csv"
    "検査結果2018UTF8.csv"
    "手術リストUTF8.csv"
    "入院患者一覧DPC病名UTF8.csv"
    "外来患者リストUTF8.csv"
    "処方オーダリストUTF8.csv"
    "看護実施ファイルUTF8.csv"
    "保険病名患者リストUTF8.csv"
    "注射オーダリストUTF8.csv"
)

echo "--- 各ファイルのユニーク行数と重複行数の確認 ---"
echo "ファイル名: (sort | uniq | wc), (awkでユニーク行 | wc)"
echo "--------------------------------------------------"

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo -n "$file: "
        # sort | uniq | wc
        sort_uniq_wc=$(sort "$file" | uniq | wc -l)
        # gawkでユニーク行を抽出 | wc
        gawk_uniq_wc=$(gawk -F, '!a[$0]++' "$file" | wc -l)
        
        echo "$sort_uniq_wc, $gawk_uniq_wc"
    else
        echo "警告: ファイルが見つかりません - $file"
    fi
done

echo "--------------------------------------------------"
echo "補足: 'sort | uniq | wc' と 'gawk -F, '!a[$0]++' | wc' は、"
echo "ソートされたデータに対しては同じユニーク行数を返します。"
echo "'uniq | uniq | wc' は、ファイルがソートされていない場合、正確なユニーク行数を返しません。"