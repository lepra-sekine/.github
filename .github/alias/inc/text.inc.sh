#!/bin/bash
# テキスト系処理まとめ
#   @author lepra-sekine

# 幅（文字数）を基準にしてセンタリングする
# 文字コードのバイト数の仕様上、日本語や絵文字は、複数行を跨いでセンタリングすると幅が一致しないことがあります。
#   center_text [text] [width]
#       text        出力テキスト
#       width       幅（最大文字数）　省略すると出力テキストの文字数を参照する
function center_text() {
    local text="$1"
    local width="${2:-${#text}}"
    local len=${#text}
    local left=$(( (width - ${#text}) / 2 ))
    local right=$(( width - ${#text} - left ))
    printf '%*s%s%*s' "$left" "" "$text" "$right" ""
}