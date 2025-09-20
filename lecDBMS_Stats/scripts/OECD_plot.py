import pandas as pd
import matplotlib.pyplot as plt

# --- 日本語フォントの設定 ---
# macOSの場合は '''Hiragino Sans''' が利用できることが多いです。
# ご自身の環境に合わせてフォント名を変更してください。
plt.rcParams['font.family'] = 'Hiragino Sans'
plt.rcParams['font.size'] = 12

# --- データの読み込み ---
try:
    df = pd.read_csv('OECD.CSV')
except FileNotFoundError:
    print("エラー: OECD.CSV ファイルが見つかりません。")
    exit()

# --- グラフ描画の準備 ---
# 描画したい指標のリスト
indicators = {
    '名目GDP(10億ドル)': '2025年 名目GDP予測 (10億USドル)',
    '人口(万人)': '2025年 人口予測 (万人)',
    '平均年齢(歳)': '2025年 平均年齢予測 (歳)',
    '国土面積(km²)': '国土面積 (km²)'
}

# 2x2のグラフ領域を作成
fig, axes = plt.subplots(nrows=2, ncols=2, figsize=(18, 14))
axes = axes.flatten() # 2x2のaxesを1次元配列に変換

# --- 各指標のグラフを作成 ---
for i, (indicator, title) in enumerate(indicators.items()):
    ax = axes[i]
    
    # 指標でデータをフィルタリング
    plot_data = df[df['Indicator'] == indicator].copy()
    
    # 2025年の予測値でソート
    # 国土面積は予測値ではないが、同じ列名で処理
    plot_data_sorted = plot_data.sort_values(by='Year_2025_Forecast', ascending=False)
    
    # 棒グラフを作成
    ax.bar(plot_data_sorted['Country'], plot_data_sorted['Year_2025_Forecast'])
    
    # --- グラフの装飾 ---
    ax.set_title(title, fontsize=16)
    ax.set_ylabel(indicator.split('(')[-1].replace(')', ''), fontsize=12)
    ax.tick_params(axis='x', labelrotation=90) # X軸のラベルを90度回転
    ax.grid(axis='y', linestyle='--', alpha=0.7)

# --- 全体のレイアウト調整と表示 ---
fig.suptitle('OECD先進20カ国 2025年予測値の比較', fontsize=20)
plt.tight_layout(rect=[0, 0, 1, 0.96]) # suptitleとの重なりを調整
plt.show()
