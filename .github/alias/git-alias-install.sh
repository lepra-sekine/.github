#!/bin/bash
# ----------------------------------------------------------
# このリポジトリで実装した git alias を全件インストールする。
# ----------------------------------------------------------
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
FROM_RC=${BASH_SOURCE[1]:-0}

# 使用する関数群を読み込み
source "${SCRIPT_DIR}/inc/text.inc.sh"
source "${SCRIPT_DIR}/inc/ansi.inc.sh"
source "${SCRIPT_DIR}/inc/i18n.inc.sh"


# インストールチェック
GAI_PATH=~/.lepra-sekine.git/caches/.git-alias-installed
if [ ! -f $GAI_PATH ]
then
    # mkdir都度エラーになるので、エラー出力は捨てる
    mkdir -p "$(dirname "$GAI_PATH")" 2> /dev/null
    touch $GAI_PATH
    printf "export GIT_ALIAS_INSTALLED=\"true\"" > $GAI_PATH
else
    source $GAI_PATH
fi

# エイリアス未登録の場合のみ、実行。
INSTALLED="${GIT_ALIAS_INSTALLED:-"false"}"

if [[ "$INSTALLED" == "false" ]]
then
    # インストール開始
    process_msg="$(center_text "エイリアスインストール開始！" "48")"
    printf "${ANSI_INFO}$process_msg${ANSI_RES}\n"

    # エイリアスを登録
    git config --global alias.conmd "!.github/alias/conmd.sh"

    printf "\nexport GIT_ALIAS_INSTALLED=\"true\"" >> ~/.bash_profile

    # インストール完了
    process_msg="$(center_text "エイリアスインストール完了！" "48")"
    printf "${ANSI_INFO}$process_msg${ANSI_RES}\n"
fi