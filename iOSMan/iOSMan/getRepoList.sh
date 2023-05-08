#!/bin/sh

#  getRepoList.sh
#  iOSMan
#
#  Created by 임준협 on 2023/05/07.
#  
gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /users/"$1"/repos
