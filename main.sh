#!/bin/bash

# 定义函数：创建新文章
function create_new_post() {
    local title=""
    read -p "请输入新文章的标题，按回车键使用默认标题：[杂记：$(date +%Y年%m月%d日)] " title
    if [ -z "$title" ]; then
        title="杂记：$(date +%Y年%m月%d日)"
    fi
    local post_title="$title"
    echo -e "\033[32m新笔记 - [$post_title]\033[0m"
    read -p "请输入标签，多个标签用空格隔开: " tags
    hexo new post "$post_title" --tags="$tags"
    read -p "是否打开文件？(y/n)" open_file
    if [ "$open_file" == "y" ]; then
        if command -v open &> /dev/null; then
            if [ -d "/Applications/Typora.app" ]; then
                open -a "/Applications/Typora.app" "source/_posts/${post_title// /-}.md"
            elif [ -d "/Applications/Visual Studio Code.app" ]; then
                open -a "/Applications/Visual Studio Code.app" "source/_posts/${post_title// /-}.md"
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

# 定义函数：管理source/_posts下的所有.md文件
function manage_posts() {
    local action=""
    while true; do
        echo "请选择要执行的操作："
        echo "1. 展示所有.md文件"
        echo "2. 重命名文件"
        echo "3. 删除文件"
        echo "4. 打开文件"
        echo "5. 复制目录"
        echo "99. 返回上一级"
        read -p "请输入操作编号：" action
        case "$action" in
            1)
                # 垂直展示所有.md文件的详细信息
                ls -l source/_posts/*.md
                ;;

            2)
                read -p "请输入要重命名的文件名：" old_name
                read -p "请输入新的文件名：" new_name
                mv "source/_posts/$old_name" "source/_posts/$new_name"
                echo -e "\033[32m文件已重命名。\033[0m"
                ;;
            3)
                read -p "请输入要删除的文件名：" file_name
                rm "source/_posts/$file_name"
                echo -e "\033[32m文件已删除。\033[0m"
                ;;
            4)
                read -p "请输入要打开的文件名：" file_name
                if command -v open &> /dev/null; then
                    if [ -d "/Applications/Typora.app" ]; then
                        open -a "/Applications/Typora.app" "source/_posts/$file_name"
                    elif [ -d "/Applications/Visual Studio Code.app" ]; then
                        open -a "/Applications/Visual Studio Code.app" "source/_posts/$file_name"
                    else
                        echo "请安装支持Markdown的编辑器。"
                    fi
                else
                    echo "您的系统不支持打开文件。"
                fi
                ;;
            5)
                read -p "请输入要复制的目录名：" dir_name
                cp -r "source/_posts" "$dir_name"
                echo -e "\033[32m目录已复制。\033[0m"
                ;;
            99)
                break
                ;;
            *)
                echo "无效的操作。"
                ;;
        esac
    done
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
        echo "2. 清理、提交并部署"
        echo "3. 文章管理"
        echo "99. 退出"
        read -p "请输入数字：" choice
        case "$choice" in
            1)
                create_new_post
                ;;
            2)
                run_hexo_command "hexo clean"
                commit_changes
                run_hexo_command "hexo clean && hexo g && hexo d"
                ;;
            3)
                manage_posts
                ;;
            99)
                exit 0
                ;;
            *)
                echo "无效的选项。"
                ;;
        esac
    done
}

main

