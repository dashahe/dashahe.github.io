#!/bin/zsh

# 创建临时目录
root=$(mktemp -d)
# trap "rm -rf $root" EXIT

echo "start git practice in $root"

# 初始化仓库
cd $root && git init

# base commit
echo "commit1" > testfile
git add . && git commit -m "commit1"

# commit 2, 3, 4 in dev branch
git checkout -b dev

echo "commit2" > testfile
git add . && git commit -m "commit2"

echo "commit3" > testfile
git add . && git commit -m "commit3"

echo "commit4" > testfile
git add . && git commit -m "commit4"

# commit 5 in master branch
git checkout master
echo "commit5" > testfile
git add . && git commit -m "commit5"

# checkout to dev and rebase master
# 等价于在 master 上，将 commit 2, 3, 4 都 cherry-pick 过去
git checkout dev
git log --graph

git rebase master

# 然后，你可以使用 terminal 进入该 $root 目录，随后便可以感受到需要处理 3 次冲突，才能够 rebase 成功
# 因为此时在 dev 分支 rebase master，等价于分别 cherry-pick commit 2, 3, 4