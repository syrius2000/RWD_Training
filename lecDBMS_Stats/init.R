# Rスクリプトの場所をワーキングディレクトリに設定する

try_set_wd_to_script_location <- function() {# {{{
  # この関数は、スクリプトの場所を特定し、
  # そこをワーキングディレクトリに設定しようとします。

  # 方法1: RStudio API を使用 (RStudio で "Source" ボタン等で実行された場合)
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    script_path <- tryCatch(rstudioapi::getSourceEditorContext()$path, error = function(e) NULL)
    if (!is.null(script_path) && nzchar(script_path) && file.exists(script_path)) {
      setwd(dirname(script_path))
      message("ワーキングディレクトリがRStudio API経由で設定されました: ", getwd())
      return(invisible(TRUE))
    }
  }

  # 方法2: source() で実行された場合 (sys.frame(1)$ofile)
  # sys.frame(1)$ofile は source() されたファイルのパスを返す可能性があります。
  # より堅牢にするには sys.frames() を辿る必要がありますが、ここでは最も一般的なケースを扱います。
  tryCatch({
    # sys.frame() は呼び出し元の環境を取得します。
    # source() でスクリプトが実行された場合、sys.frame(1)$ofile にパスが含まれることがあります。
    # ただし、すべての状況で信頼できるわけではありません。
    frames <- sys.frames()
    for (i in rev(seq_along(frames))) { # 呼び出しスタックを遡る
      script_path_candidate <- tryCatch(frames[[i]]$ofile, error = function(e) NULL)
      if (!is.null(script_path_candidate) && nzchar(script_path_candidate) && file.exists(script_path_candidate)) {
        # 実行可能なファイルであるか、より確実なチェックが必要な場合がある
        # ここでは単純に存在するファイルパスとして扱う
        setwd(dirname(script_path_candidate))
        message("ワーキングディレクトリが source() 経由で設定されました: ", getwd())
        return(invisible(TRUE))
      }
    }
  }, error = function(e) {
    # エラーが発生した場合は何もしない
  })


  # 方法3: Rscript で実行された場合 (commandArgs)
  args <- commandArgs(trailingOnly = FALSE)
  file_arg_pattern <- "^--file="
  script_path_arg <- grep(file_arg_pattern, args, value = TRUE)

  if (length(script_path_arg) == 1) {
    # '--file=' の部分を除去し、パスを正規化
    script_path_full <- normalizePath(sub(file_arg_pattern, "", script_path_arg))
    if (file.exists(script_path_full)) {
      setwd(dirname(script_path_full))
      message("ワーキングディレクトリが Rscript (commandArgs) 経由で設定されました: ", getwd())
      return(invisible(TRUE))
    }
  }

  message("警告: スクリプトの場所を自動的に特定してワーキングディレクトリを設定できませんでした。")
  message("現在のワーキングディレクトリ: ", getwd())
  return(invisible(FALSE))
}# }}}

# --- スクリプトの実行開始 ---
# スクリプトの最初にこの関数を呼び出してワーキングディレクトリを設定
try_set_wd_to_script_location()

# これ以降のコードは、ワーキングディレクトリがスクリプトの場所になっていることを期待できます
# (上記の関数が成功した場合)

# 例: 現在のワーキングディレクトリを表示
print(paste("現在のワーキングディレクトリ:", getwd()))

# 例: スクリプトと同じディレクトリにあるはずのファイルを読み込む試み
# (実際に "my_data.csv" というファイルがスクリプトと同じ場所にあれば読み込めます)
# tryCatch({
#   data <- read.csv("my_data.csv")
#   print("my_data.csv の読み込みに成功しました。")
# }, error = function(e) {
#   print("my_data.csv の読み込みに失敗しました。スクリプトと同じディレクトリにありますか？")
#   print(e$message)
# })

# スクリプトの他の処理をここに記述
# ...

