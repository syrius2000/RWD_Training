# Command line nobenkyou

# 対象ファイル

/Users/myamaguchi/Data/COVID/外来患者リストUTF8.csv

% cat 外来患者リストUTF8.csv | wc
 2542428 4675774 123366696

% gawk '!colnames[$0]++'  外来患者リストUTF8.csv | wc
 2541961 4675005 123344053

2542428- 2541961 = 467

wc, grep , uniq, sort, |, awk
