#!/bin/bash
set -e
./build.sh
git push
gh release create v"$1" "./build/iOSMan.pkg#" -t "$2" -n "$3" --latest
git push
git add .
git commit -m "update"
git push
