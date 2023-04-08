#!/bin/bash

function create_new_post() {
    local title=$1
    local timestamp=$(date +%s)
    local post_title=":memo: ${title:-无题}-$timestamp"
    echo "新笔记 - [$post_title]"
    hexo new post "$post_title"
}

function main() {
    if ! command -v hexo &> /dev/null; then
        echo "hexo 命令未找到，请先安装 hexo。"
        exit 1
    fi
    
    if [ -z "$1" ]; then
        echo "未指定文章标题，使用默认标题。"
        create_new_post ""
    else
        create_new_post "$1"
    fi

    if [ $? -eq 0 ]; then
        echo "博客文章创建成功！"
    else
        echo "博客文章创建失败！"
    fi
}

main "$@"
