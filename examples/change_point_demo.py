import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import ruptures as rpt
import os

# ファイルパス
HERE = os.path.dirname(__file__)
CSV = os.path.join(HERE, "data", "sample_bmi.csv")

# データ読み込み
df = pd.read_csv(CSV)
series = df['mean_bmi'].values
years = df['year'].values

# 描画（元データ）
plt.figure(figsize=(8,4))
plt.plot(years, series, marker='o', label='mean_bmi')
plt.title('Sample mean BMI (1980-2020)')
plt.xlabel('Year')
plt.ylabel('Mean BMI')
plt.grid(alpha=0.3)

# チェンジポイント検出（平均の変化）
# PELTアルゴリズム＋L2コスト（平均の変化に敏感）
model = "l2"
algo = rpt.Pelt(model=model).fit(series)
# ペナルティはデータに応じて調整。ここでは簡単に設定。
result = algo.predict(pen=3)
# result は区間の終了インデックス(1-based)のリスト
# 末尾は長さを含むので除いてチェンジポイントのみ
change_inds = [i for i in result if i < len(series)]

# 結果出力
print("検出されたチェンジポイントのインデックス:", change_inds)
print("対応する年:", [int(years[i]) for i in change_inds])

# プロットに表示
for ci in change_inds:
    year_at = years[ci]
    plt.axvline(year_at, color='red', linestyle='--', alpha=0.8)
    plt.text(year_at, series.max(), f'CP: {int(year_at)}', rotation=90, va='top', ha='right')

plt.legend()
plt.tight_layout()
out_png = os.path.join(HERE, 'change_point_result.png')
plt.savefig(out_png, dpi=150)
print(f"結果プロットを保存しました: {out_png}")
