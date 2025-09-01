# チェンジポイント検出デモ (合成データ)

概要
- 年次平均BMIの合成データ（1980-2020）に対してチェンジポイント（平均の変化）を検出するサンプルです。

使い方（macOS, zsh）

1. 仮想環境推奨（任意）

2. 依存パッケージのインストール

```bash
python3 -m pip install -r examples/requirements.txt
```

3. スクリプトを実行

```bash
python3 examples/change_point_demo.py
```

出力
- 実行コンソールに検出されたチェンジポイントの年が表示されます。
- `examples/change_point_result.png` に結果プロットが出力されます。

次のステップ
- 実データ（NHANESや国民健康・栄養調査）に合わせて読み込み部を変更してください。
- 複数検出点、トレンド変化（傾き）の検出には別手法（`segmented`やBai-Perron等）を検討してください。