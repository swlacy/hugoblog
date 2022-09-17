#/usr/bin/env bash

if [ $# -gt 0 ]; then
    msg="'$*'"
else
    read -p "Message: " msg
fi

if [ -z "$msg" ]; then
    msg="Generic file update(s); no commit message provided"
fi

rm -rf public/ && hugo && firebase deploy

git add .
git commit -m "$msg"
git push -u origin main
