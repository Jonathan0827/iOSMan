#!/bin/sh

#  update.sh
#  iOSMan
#
#  Created by 임준협 on 2023/05/07.
#  
git add .
git commit -m "$1"
git push
return true
