#!/bin/sh

#  make_git_repo.sh
#  iOSMan
#
#  Created by 임준협 on 2023/05/07.
#  $1 is github url
if [ git rev-parse --is-inside-work-tree ]
then
    git remote add origin "$1"
    git branch -M main
    git push -u origin main
else
    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin "$1"
    git push -u origin main
