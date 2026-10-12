#!/bin/bash
#!/bin/bash
# よく使うANSI装飾まとめ
#   @author lepra-sekine

## 共通・リセット
ANSI_SUCCESS='\e[1;4;37;42m'
ANSI_ERR='\e[1;37;41m'
ANSI_INFO='\e[1;48;5;82;38;5;227m'
ANSI_WARN='\e[1;48;5;220;1;38;5;9m'
ANSI_RES='\e[0m'

## Markdown系
ANSI_MD_TIT='\e[1;37;42m'
ANSI_HD_ROW='\e[1;30;46m'
ANSI_TBL_SEP='\e[0;37;47m'
ANSI_TBL_CO1='\e[32m'
ANSI_TBL_CO2='\e[36m'

## 前の行削除
ANSI_DLT_PREV="\033[1A\033[2K"

# 引数の文字列を虹色背景で太字 ＆ ブリンク表示する
# Usage:
#   gaming_title [text] [color offset]
#       text            テキスト
#       color offset    背景色開始値（省略で赤（196番）からスタート）
function gaming_title() {
    local text="${1:-}"
    if [[ -z "${text}" ]]; then
        return 0
    fi

    # カラーコードの配列（開始色の都合で７色を２周させている）
    local colors_mst=(196 202 208 214 220 154 46 39 21 201 196 202 208 214 220 154 46 39 21 201)
    local colors=(196 202 208 214 220 154 46 39 21 201)
    local color_count=${#colors[@]}

    # 色の開始箇所
    local color_offset=$(( ${2:-0} % color_count ))
    if (( color_offset >= color_count )); then
        color_offset=0
    fi

    # 色の開始箇所から色数分を選択
    colors=("${colors_mst[@]:$color_offset:$color_count}")

    # 文字数とチャンクサイズを計算
    local text_len=${#text}
    local chunk_size=$(( text_len / color_count ))
    local remainder=$(( text_len % color_count ))
    local offset=0
    local idx=0

    # 文字数がカラーコードの数より少ない場合、チャンクサイズを1にして余りを0にする
    if (( text_len < color_count )); then
        chunk_size=1
        remainder=0
    fi

    # 文字列をチャンクに分割して色を適用
    while (( idx < color_count && offset < text_len )); do
        local size=$chunk_size
        if (( idx < remainder )); then
            ((size++))
        fi

        local part="${text:offset:size}"
        printf '%b' "\e[1;5;48;5;${colors[idx]}m${part}${ANSI_RES}"

        ((offset += size))
        ((idx++))
    done
    return 0
}

# とても煩わしいウェルカムメッセージを表示する。
# ~/.bashrcで呼びだして使ってください。
# Usage:
#   welcom_msg
function welcom_msg()
{
    # 一日一回のみ実行。
    WELCOM_CHK_PATH=~/.lepra-sekine.git/caches/.welcom_msg_date
    if [ ! -d "$(dirname "$WELCOM_CHK_PATH")" ]
    then
        mkdir -p "$(dirname "$WELCOM_CHK_PATH")"
    fi

    if [ ! -f $WELCOM_CHK_PATH ]
    then
        touch $WELCOM_CHK_PATH
    else
        source $WELCOM_CHK_PATH
    fi

    local exec_date="${WELCOM_MSG_DATE:-0}"
    local today_date=`date "+%Y%m%d"`
    if (( "$today_date" == "$exec_date" ))
    then
        return 0
    fi
    printf "export WELCOM_MSG_DATE=\"${today_date}\"" > $WELCOM_CHK_PATH

    local place="${PLACE_NAME:-"THE TOKYO D***** SEA"}"

    # 文言
    local msg1="  Hello!! ${HOSTNAME}!!!! Welcom to ${place}!!!!  "
    local msg2="$(center_text "YEAH!!!! LET'S GO!!!!" "${#msg1}")"
    local bar="$(center_text "" "${#msg1}")"

    # 派手な演出
    local n=0
    while (( ${n} < 100 ))
    do
        clear
        # printf "\033[2J\033[H"
        local color_offset=$(( n % 10 ))
        gaming_title "${bar}\n" $(( color_offset + 2 ))
        gaming_title "${msg1}\n" $(( color_offset + 4 ))
        gaming_title "${msg2}\n" $(( color_offset + 6 ))
        gaming_title "${bar}\n" $(( color_offset + 8 ))
        sleep 0.01
        (( n++ ))
    done

    return 0
}

# ANSIコードの例を一覧表示する。
#   Usage:
#      ansi_example
function ansi_example() {
    local TXT_PRE=3
    local BG_PRE=4
    local COLORS="0 Black
1 Red
2 Green
3 Yellow
4 Blue
5 Magenta
6 Cyan
7 White"
    local ATTR="0 Normal
1 Bold
2 Transparent
3 Italic
4 Underline
5 Blink
7 Inverse
8 Hidden
9 Cancel"
    local DEFINED_VALUES="ANSI_SUCCESS:Success
ANSI_ERR:Error
ANSI_INFO:Information
ANSI_WARN:Warning
ANSI_RES:Reset ansi code
ANSI_MD_TIT:Markdown title
ANSI_HD_ROW:Header row
ANSI_TBL_SEP:Table separator
ANSI_TBL_CO1:Table column 1
ANSI_TBL_CO2:Table column 2"

    local indent="    "

    # テキストカラーの例
    printf "${ANSI_MD_TIT}[  Text colors  ]${ANSI_RES}\n"
    while read -r code name; do
        printf '%b' "${indent}\e[${TXT_PRE}${code}m ${name} = (\\\\e[${TXT_PRE}${code}m) ${ANSI_RES}\n"
    done <<< "$COLORS"
    printf "\n"

    # 背景色の例
    printf "${ANSI_MD_TIT}[  Background colors  ]${ANSI_RES}\n"
    while read -r code name; do
        printf '%b' "${indent}\e[${BG_PRE}${code}m ${name} = (\\\\e[${BG_PRE}${code}m) ${ANSI_RES}\n"
    done <<< "$COLORS"
    printf "\n"

    # 属性の例
    printf "${ANSI_MD_TIT}[  Attributes  ]${ANSI_RES}\n"
    while read -r code name; do
        printf '%b' "${indent}\e[${code}m ${name} = (\\\\e[${code}m) ${ANSI_RES} \n"
    done <<< "$ATTR"
    printf "\n"

    # 定義済み変数の例
    printf "${ANSI_MD_TIT}[  Defined values  ]${ANSI_RES}\n"
    while read -r code name; do
        printf '%b' "${indent}${!code} ${name} = (\$${code}) ${ANSI_RES} \n"
    done < <(printf '%s\n' "$DEFINED_VALUES" | awk -F":" '{print $1" "$2}')
    printf "\n"

    # 関数の例
    printf "${ANSI_MD_TIT}[  Functions  ]${ANSI_RES}\n"
    printf "${indent}gaming_title [string] [color offset]\n"
    local smb1943="   SUPER MAGIC BARMHERZIGKEIT 1943 / THE REVENGE OF THE SHELL   "
    local bar="$(center_text "" ${#smb1943})"
    gaming_title "${bar}" && printf "\n"
    gaming_title "${smb1943}" 4 && printf "\n"
    gaming_title "${bar}" 6  && printf "\n"
    printf "\n"

    return 0
}

# ANSIコードの拡張色（0x00～0xffの256色）を一覧表示する
#   ansi_hexcolor_example [target]
#       target          表示対象（text=拡張文字色のみ表示 bg=拡張背景色のみ表示 省略=両方表示）
function ansi_hexcolor_example() {
    local switch=${1:-""}
    local tgt_titles=""

    # 第一引数によって表示対象を変更
    if [ "${switch}" -eq "text" ]
    then
        tgt_titles="38 拡張文字色"
    elif [ "${switch}" -eq "bg" ]
    then
        tgt_titles="48 拡張背景色"
    else
        tgt_titles="38 拡張文字色
48 拡張背景色"
    fi

    # 表示対象毎に、16x16のコードの色を表示する
    while read -r tgt title; do
        printf "${ANSI_MD_TIT} [ ${title} ] ${ANSI_RES}\n"

        for hex_row in {0..15}
        do
            for hex_col in {0..15}
            do
                local hex_no=$(( hex_row * 16 + $hex_col ))
                local ANSI_HEXCOLOR="\e[1;${tgt};5;${hex_no}m"
                local escaped="\\\\e[1;${tgt};5;${hex_no}m"
                printf '%b' "${ANSI_HEXCOLOR} (${escaped}) ${ANSI_RES}"
            done
            printf "\n"

        done

        printf "\n\n"

    done <<< "$tgt_titles"

    return 0
}