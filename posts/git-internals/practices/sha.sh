#!/bin/zsh

# 创建临时目录
root=$(mktemp -d)
trap "rm -rf $root" EXIT

echo "start git practice in $root"

# 初始化仓库
cd $root && git init

# 添加文件
echo "abcde" > testfile && git add testfile && git commit -m "add testfile"
echo

# 查看 objects
echo 'git blob object:'
git hash-object testfile
echo

# 自己计算 SHA1 值
echo 'sha1sum:'
sha1sum testfile
echo

# 添加前缀
echo 'sha1sum with prefix:'
content=$(cat testfile) && print "blob $(wc -c testfile | awk '{print $1}')\0$content" | sha1sum