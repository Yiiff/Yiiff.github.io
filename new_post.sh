#!/bin/bash

function create_new_post() {
    local title="$1"
    local post_title="${title:-无题}"
    echo "新笔记 - [$post_title]"
    hexo new post "$post_title" && open "$(hexo config | grep "post_asset_folder" | cut -d ":" -f 2 | sed 's/ //g')/$post_title/index.md"
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
        create_new_post "$@"
    fi

    if [ $? -eq 0 ]; then
        echo "博客文章创建成功！"
    else
        echo "博客文章创建失败！"
    fi
}

main "$@"
