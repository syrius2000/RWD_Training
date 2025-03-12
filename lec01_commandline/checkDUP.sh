
echo "検査結果2022UTF8.csv"
 sort  検査結果2022UTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 検査結果2022UTF8.csv | wc
 uniq  検査結果2022UTF8.csv | uniq | wc

echo "検査結果2021UTF8.csv"
 sort  検査結果2021UTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 検査結果2021UTF8.csv | wc
 uniq  検査結果2021UTF8.csv | uniq | wc

echo "検査結果2020UTF8.csv"
 sort  検査結果2020UTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 検査結果2020UTF8.csv | wc
 uniq  検査結果2020UTF8.csv | uniq | wc

echo "検査結果2019UTF8.csv"
 sort  検査結果2019UTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 検査結果2019UTF8.csv | wc
 uniq  検査結果2019UTF8.csv | uniq | wc

echo "検査結果2018UTF8.csv"
 sort  検査結果2018UTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 検査結果2018UTF8.csv | wc
 uniq  検査結果2018UTF8.csv | uniq | wc

echo "手術リストUTF8.csv"
 sort  手術リストUTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 手術リストUTF8.csv | wc
 uniq  手術リストUTF8.csv | uniq | wc

echo "入院患者一覧DPC病名UTF8.csv"
 sort  入院患者一覧DPC病名UTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 入院患者一覧DPC病名UTF8.csv | wc
 uniq  入院患者一覧DPC病名UTF8.csv | uniq | wc

echo "入院患者一覧DPC病名UTF8.csv"
 sort  入院患者一覧DPC病名UTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 入院患者一覧DPC病名UTF8.csv | wc
 uniq  入院患者一覧DPC病名UTF8.csv | uniq | wc

echo "外来患者リストUTF8.csv"
 sort  外来患者リストUTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 外来患者リストUTF8.csv | wc
 uniq  外来患者リストUTF8.csv | uniq | wc

echo "処方オーダリストUTF8.csv"
 sort  処方オーダリストUTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 処方オーダリストUTF8.csv | wc
 uniq  処方オーダリストUTF8.csv | uniq | wc

echo "看護実施ファイルUTF8.csv"
 sort  看護実施ファイルUTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 看護実施ファイルUTF8.csv | wc
 uniq  看護実施ファイルUTF8.csv | uniq | wc

echo "保険病名患者リストUTF8.csv"
 sort  保険病名患者リストUTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 保険病名患者リストUTF8.csv | wc
 uniq  保険病名患者リストUTF8.csv | uniq | wc

echo "注射オーダリストUTF8.csv"
 sort  注射オーダリストUTF8.csv | uniq | wc
 gawk -F, 'ID[$0]++ == 0{print} ' 注射オーダリストUTF8.csv | wc
 uniq  注射オーダリストUTF8.csv | uniq | wc

#  sort  zzz | uniq | wc
#  gawk -F, 'ID[$0]++ == 0{print} ' zzz | wc
#  uniq  zzz | uniq | wc

# 重複しているものを削除
# gawk -F, '!ID[$0]++ {print} ' 注射オーダリストUTF8.csv | wc#

# 重複しているもののみ出力
# gawk -F, 'ID[$0]++ {print} ' 注射オーダリストUTF8.csv | wc#
#
# 重複行がX個以上あるものだけ出力
# gawk -F, 'ID[$0]++== X {print} ' 注射オーダリストUTF8.csv | wc#
#
# 手術リストUTF8.csv
# 入院患者一覧DPC病名UTF8.csv
# 外来患者リストUTF8.csv
# 処方オーダリストUTF8.csv
# 看護実施ファイルUTF8.csv
# 保険病名患者リストUTF8.csv
# 注射オーダリストUTF8.csv
# 検査結果2018UTF8.csv
# 検査結果2019UTF8.csv
# 検査結果2020UTF8.csv
# 検査結果2021UTF8.csv
# 検査結果2022UTF8.csv
# 患者住所_最新UTF8.csv

