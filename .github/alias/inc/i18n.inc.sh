#!/bin/bash
# i18n
#   @author lepra-sekine

# 翻訳メッセージを出力する
#   i18n [msgkey]
#       msgkey          メッセージキー
function i18n() {
    # langは今の所ja, enのみ想定
    local msgkey="${1:-}"
    local lang="${LC_ALL:-${LC_MESSAGES:-${LANG:-ja}}}"

    # ja_JP.UTF-8 などのロケール値を ja に正規化する
    lang="${lang%%.*}"
    lang="${lang%%_*}"
    lang="${lang,,}"

    # msgkey|lang|message
    local msglist='
invalid_scope|ja|無効なスコープです。次のいずれかを指定してください。:
invalid_scope|en|Invalid scope. Please use:
no_data|ja|データが見つかりません。
no_data|en|No data found.'

    local result
    result=$(printf '%s\n' "$msglist" | grep -F "${msgkey}|${lang}|" | head -n 1 | cut -d'|' -f3)

    if [ -n "$result" ]; then
        printf '%s\n' "$result"
        return 0
    else
        printf '%s\n' "${ANSI_ERR}No message found for key: ${msgkey} and language: ${lang}${ANSI_RES}"
        return 1
    fi

    return 1
}

