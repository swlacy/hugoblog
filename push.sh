#/usr/bin/env bash
 
read -p "Message: " msg

if [ -z "$msg" ]; then
    msg="Generic file update(s); no commit message provided"
fi

rm -rf public/ && hugo && firebase deploy

git add .
git commit -m "$msg"
git push -u origin main
