#!/bin/bash

function commit_changes() {
    local commit_msg=$1
    if [ -z "$commit_msg" ]; then
        commit_msg=":pencil: update content"
    fi
    git add -A
    git commit -m "$commit_msg"
    git push origin hexo
    if [ $? -eq 0 ]; then
        echo "博客内容已更新。"
    else
        echo "博客内容更新失败。"
    fi
}

function main() {
    if ! command -v git &> /dev/null; then
        echo "git 命令未找到，请先安装 git。"
        exit 1
    fi

    local commit_msg=$1
    commit_changes "$commit_msg"
}

main "$@"
