#!/bin/bash

#
# Git履歴を単一のコミットにまとめる（スカッシュする）スクリプト
#
# 実行方法:
# 1. このスクリプトをリポジトリのルートディレクトリに置きます。
# 2. ターミナルで実行権限を付与します: chmod +x squash_git_history.sh
# 3. スクリプトを実行します: ./squash_git_history.sh
#

# --- 警告 ---
# このスクリプトは、リモートリポジトリの履歴を強制的に書き換える
# 非常に強力で破壊的な操作です。
#
# - 他の共同作業者がいる場合、コンフリクトの重大な原因となります。
#   必ず事前に全員の同意を得てから実行してください。
# - 実行前に、リポジトリのバックアップを取ることを強く推奨します。
#
# --- 警告 ---

# 実行確認
read -p "本当にGit履歴を1つのコミットにまとめ、リモートリポジトリを上書きしますか？ (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "操作はキャンセルされました。"
    exit 1
fi

# 1. 現在のブランチ名を取得
CURRENT_BRANCH=$(git branch --show-current)
if [ -z "$CURRENT_BRANCH" ]; then
    echo "エラー: 現在のブランチ名を取得できませんでした。Gitリポジトリのルートで実行していますか？"
    exit 1
fi

echo "現在のブランチ '$CURRENT_BRANCH' の履歴をスカッシュします。"

# 2. 安全のため、現在のブランチのバックアップを作成
BACKUP_BRANCH="backup-${CURRENT_BRANCH}-$(date +%Y%m%d%H%M%S)"
echo "ステップ1: バックアップブランチ '$BACKUP_BRANCH' を作成します..."
git branch "$BACKUP_BRANCH"
if [ $? -ne 0 ]; then
    echo "エラー: バックアップブランチの作成に失敗しました。"
    exit 1
fi

# 3. 履歴のない新しい孤立したブランチを作成
ORPHAN_BRANCH="new-main-temp"
echo "ステップ2: 履歴のない新しいブランチ '$ORPHAN_BRANCH' を作成します..."
git checkout --orphan "$ORPHAN_BRANCH"

# 4. すべてのファイルをステージング
echo "ステップ3: すべてのファイルをステージングします..."
git add -A

# 5. 新しい最初のコミットを作成
COMMIT_MESSAGE="Initial commit"
echo "ステップ4: 新しい最初のコミットを作成します (メッセージ: '$COMMIT_MESSAGE')..."
git commit -m "$COMMIT_MESSAGE"

# 6. 古いブランチを削除
echo "ステップ5: 古いブランチ '$CURRENT_BRANCH' を削除します..."
git branch -D "$CURRENT_BRANCH"

# 7. 新しいブランチの名前を元のブランチ名に変更
echo "ステップ6: 新しいブランチを '$CURRENT_BRANCH' にリネームします..."
git branch -m "$CURRENT_BRANCH"

# 8. リモートリポジトリに強制的にプッシュ
echo "ステップ7: リモートリポジトリ '$CURRENT_BRANCH' に強制プッシュします..."
git push -f origin "$CURRENT_BRANCH"

if [ $? -eq 0 ]; then
    echo "✅ 正常に完了しました。Git履歴は1つのコミットにまとめられました。"
    echo "問題が発生した場合は、'git checkout $BACKUP_BRANCH' を実行して復元できます。"
else
    echo "❌ エラーが発生しました。'git checkout $BACKUP_BRANCH' を実行して元の状態に戻してください。"
fi
