# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ドットファイルディレクトリ
ZSH_DIR="${HOME}/.zsh"
# pyenv.zshを含む全ての.zshファイルのカウント
FILES=("${ZSH_DIR}"/*.zsh)
TOTAL_FILES=${#FILES[@]}

# プログレスバーの初期化
PROGRESS=0
# プログレスバーの全体長
PROGRESS_BAR_LENGTH=30

# プログレスバーの初期化
UPDATE_PROGRESS_BAR () {
    # 進捗率をパーセントで計算
    PROGRESS_PERCENT=$((PROGRESS * 100 / TOTAL_FILES))
    BAR_COUNT=$(( (PROGRESS_PERCENT * PROGRESS_BAR_LENGTH + 99) / 100 ))  # バーの長さを固定する

    # ドットの文字列を生成
    BAR=$(printf "#"%.0s $(seq 1 $BAR_COUNT))
    SPACES=$((PROGRESS_BAR_LENGTH - BAR_COUNT))  # バー以外の空白の数

    # プログレスバーの表示
    printf "\r[%s%*s] %3d%%" "$BAR" $SPACES "" "$PROGRESS_PERCENT"
}

# .zshファイルを読み込む
if [ -d "$ZSH_DIR" ] && [ -r "$ZSH_DIR" ] && [ -x "$ZSH_DIR" ]; then
    for file in "${FILES[@]}"; do
        source "$file"
        PROGRESS=$((PROGRESS+1))
        UPDATE_PROGRESS_BAR
        sleep 0.01  # バーの更新をわかりやすくするための遅延
    done
fi
printf "\n"
