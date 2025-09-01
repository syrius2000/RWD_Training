# 重複レコードに対する処理について

## 利用場面USE CASE

フラットファイル（CSVやTSVなど）でデータを得ることが多い。

このとき、フラットファイルに重複レコードが存在する場面がある。重複を除いて正しい
集計を可能にする。

### 重複のパターンに注意する

おおよそ次の4パターンがある。

- A:同一レコードが連続して重複が発生
- B:同一レコードが不連続に発生して重複する

 また、

- C:同一ファイル内での重複
- D:複数ワイルに跨る重複

などにも注意が必要。

## 標準コマンドの利用に注意

 unix TEXT utils の標準である`uniq`コマンドは`sort | uniq` とパイプしなければならな
ならない。

![連続した重複](/IMAGE/ClinicalExamSample.png)

uniq ClinicalExamSampleNotSorted.csv | wc
      8       8     457

sort ClinicalExamSampleNotSorted.csv | uniq | wc
      8       8     457

![重複が複数不連続](/IMAGE/ClinicalExamSampleNotSorted.png)

awkやpythonなど「連想配列」機能がある言語を注意して利用すれば良い。

see DUP.awk, DUP.py



