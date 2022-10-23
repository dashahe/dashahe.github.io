#!/bin/zsh

# 创建临时目录
root=$(mktemp -d)
trap "rm -rf $root" EXIT

echo "start git practice in $root"

# 初始化仓库
cd $root && git init

# 下载并提交 22K 的大文件
curl https://raw.githubusercontent.com/mojombo/grit/master/lib/grit/repo.rb > repo.rb
git add . && git commit -m "commit 1"

echo "after commit1:"
git count-objects -v -H

# 简单修改 repo.rb 并提交
echo 'xxxxxxx' >> repo.rb
git add . && git commit -m "commit 2"

echo "after commit2: "
git count-objects -v -H

# 可以看到 object count 和 size 都翻倍了
# 使用 git gc 生成 pack
git gc

echo "after git gc: "
git count-objects -v -H


# 使用 git verify-pack -v 查看 pack 文件的信息
# 能够看到，pack 中会存储文件的 delta，避免重复内容的存储
git verify-pack -v .git/objects/pack/pack-*.idx