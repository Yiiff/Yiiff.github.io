#!/bin/bash

function run_hexo_command() {
    local cmd=$1
    echo "执行命令：$cmd"
    eval "$cmd"
    if [ $? -eq 0 ]; then
        echo "命令执行成功。"
    else
        echo "命令执行失败。"
        exit 1
    fi
}

function main() {
    if ! command -v hexo &> /dev/null; then
        echo "hexo 命令未找到，请先安装 hexo。"
        exit 1
    fi

    run_hexo_command "hexo clean"
    sleep 1
    run_hexo_command "hexo deploy"
    sleep 1
    run_hexo_command "hexo clean"
}

main
