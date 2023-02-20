hexo clean
sleep 1
input=$1
title=""
if [ -n "$input" ];then
title=":memo: $input"
fi
if [ -z "$input" ];then
title=":memo: 无题"
fi
echo "新笔记 - [$title]"
hexo new post "$title"
