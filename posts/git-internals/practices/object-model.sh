#!/bin/zsh

# 创建临时目录
root=$(mktemp -d)
trap "rm -rf $root" EXIT

echo "start git practice in $root"

# 初始化仓库
cd $root && git init

# commit 1
# 包含文件: test.txt("version 1")
echo "version 1" > test.txt && git add test.txt && git commit -m "commit 1"

# commit 2
# 包含文件: test.txt("version2"), new.txt("new file")
echo "version 2" > test.txt
echo "new file" > new.txt
git add test.txt new.txt && git commit -m "commit 2"

# commit 3
# 包含文件: test.txt("version2"), new.txt("new file"), subdir/test.txt("version 1")
echo "version 2" > test.txt
mkdir subdir && echo "version 1" > subdir/test.txt
rm -rf new.txt
git add . && git commit -m "commit 3"

# 使用 gitviz 查看可视化的 object model
if ! [ -x "$(command -v gitviz)" ]; then
    go install github.com/riezebosch/gitviz@master
fi

echo 'open following url:'
gitviz
