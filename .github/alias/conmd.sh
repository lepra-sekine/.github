#!/bin/bash
# git configをMarkDown形式で出力する。
# Output git config with MarkDown.
#   @author lepra-sekine
#
# Parameters:
#   SCOPE               local, global, system, list (デフォルトはlocal)
#   SEARCH_PATTERN      検索パターン (デフォルトは空文字列)

# 使用する関数群を読み込み
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "${SCRIPT_DIR}/inc/text.inc.sh"
source "${SCRIPT_DIR}/inc/ansi.inc.sh"
source "${SCRIPT_DIR}/inc/i18n.inc.sh"

SCOPE=${1:-local}
SEARCH_PATTERN=${2:-""}

if echo "$SCOPE" | egrep -q "^(local|global|system|list)$"; then
    printf "${ANSI_MD_TIT}# Git config ($SCOPE)${ANSI_RES}\n\n"
    printf "${ANSI_HD_ROW}| ${ANSI_TBL_CO1}config${ANSI_RES}${ANSI_HD_ROW} | ${ANSI_TBL_CO2}value${ANSI_RES}${ANSI_HD_ROW} |${ANSI_RES}\n"
    printf "${ANSI_TBL_SEP}|:--|:--|${ANSI_RES}\n"

    if [ -n "$SEARCH_PATTERN" ]; then
        git config -l --"$SCOPE" | egrep "$SEARCH_PATTERN" | awk '
            {
                pos = index($0, "=")
                if (pos > 0) {
                    key = substr($0, 1, pos - 1)
                    value = substr($0, pos + 1)
                    print "| " key " | " value " |"
                }
            }'
    else
        # awk はシングルクォート内でシェル変数を展開しないため、ANSIコードを変数として渡す。
        # printf '%b' を使って \e を実際の ESC コードへ変換することで、見出しやセルの色が反映される。
        color1="$(printf '%b' "$ANSI_TBL_CO1")"
        color2="$(printf '%b' "$ANSI_TBL_CO2")"
        reset="$(printf '%b' "$ANSI_RES")"

        git config -l --"$SCOPE" | awk \
            -v color1="$color1" \
            -v color2="$color2" \
            -v reset="$reset" \
            '
            {
                pos = index($0, "=")
                if (pos > 0) {
                    key = substr($0, 1, pos - 1)
                    value = substr($0, pos + 1)
                    printf "%s| %s %s| %s%s %s|\n", color1, key, reset, color2, value, reset
                }
            }'
    fi
else
    ERR_MSG=`i18n invalid_scope`
    printf "${ANSI_ERR}${ERR_MSG} local, global, system, list.${ANSI_RES}\n"
    exit 1
fi

