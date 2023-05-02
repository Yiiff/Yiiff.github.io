#!/bin/bash

# 定义函数：创建新文章
function create_new_post() {
    local title="$1"
    local post_title="${title:-无题}"
    echo -e "\033[32m新笔记 - [$post_title]\033[0m"
    hexo new post "$post_title"
    read -p "是否打开文件？(y/n)" open_file
    if [ "$open_file" == "y" ]; then
        if command -v open &> /dev/null; then
            if [ -d "/Applications/Typora.app" ]; then
                open -a "/Applications/Typora.app" "source/_posts/$post_title.md"
            elif [ -d "/Applications/Visual Studio Code.app" ]; then
                open -a "/Applications/Visual Studio Code.app" "source/_posts/$post_title.md"
            else
                echo "请安装支持Markdown的编辑器。"
            fi
        else
            echo "您的系统不支持打开文件。"
        fi
    fi
}

# 定义函数：执行 hexo 命令
function run_hexo_command() {
    local cmd=$1
    echo -e "\033[32m执行命令：$cmd\033[0m"
    # 执行 hexo 命令，并检查执行结果
    eval "$cmd"
    if [ $? -eq 0 ]; then
        echo -e "\033[32m命令执行成功。\033[0m"
    else
        echo -e "\033[31m命令执行失败。\033[0m"
        exit 1
    fi
}


# 定义函数：提交博客内容更新
function commit_changes() {
    local commit_msg=$1
    if [ -z "$commit_msg" ]; then
        commit_msg=":pencil: update content"
    fi
    # 添加所有更改，并提交更改到远程仓库
    git add -A
    git commit -m "$commit_msg"
    git push origin hexo
    if [ $? -eq 0 ]; then
        echo -e "\033[32m博客内容已更新。\033[0m"
    else
        echo -e "\033[31m博客内容更新失败。\033[0m"
    fi
}

# 定义函数：主函数
function main() {
    # 检查 hexo 和 git 命令是否存在
    if ! command -v hexo &> /dev/null; then
        echo -e "\033[31mhexo 命令未找到，请先安装 hexo。\033[0m"
        exit 1
    fi

    if ! command -v git &> /dev/null; then
        echo -e "\033[31mgit 命令未找到，请先安装 git。\033[0m"
        exit 1
    fi

    while true; do
        # 显示菜单
        # 导入 figlet 命令
        if ! command -v figlet &> /dev/null; then
            echo -e "\033[31mfiglet 命令未找到，请先安装 figlet。\033[0m"
            exit 1
        fi

        # 显示花漾字
        figlet "workbench blog"
        echo "请选择要执行的操作："
        echo "1. 创建新文章"
        echo "2. 清理并部署博客"
        echo "3. 提交博客内容更新"
        echo "99. 退出"
        read -p "请输入数字 [1-3, 99]: " choice

        case $choice in
            1)
                # 创建新文章
                read -p "请输入文章标题: " title
                create_new_post "$title"
                if [ $? -eq 0 ]; then
                    echo -e "\033[32m博客文章创建成功！\033[0m"
                else
                    echo -e "\033[31m博客文章创建失败！\033[0m"
                fi
                ;;
            2)
                # 清理并部署博客
                run_hexo_command "hexo clean"
                sleep 1
                run_hexo_command "hexo deploy"
                sleep 1
                run_hexo_command "hexo clean"
                ;;
            3)
                # 提交博客内容更新
                read -p "请输入提交信息: " commit_msg
                commit_changes "$commit_msg"
                ;;
            99)
                # 退出
                echo "退出。"
                exit 0
                ;;
            *)
                # 无效的选择
                echo -e "\033[31m无效的选择。\033[0m"
                ;;
        esac
    done
}


# 调用主函数
main "$@"

