#!/bin/sh -e
eval $(grep '^ARG ' Dockerfile | cut -f 1 -d ' ' --complement)

NEW_PAPER_BUILD="$1"
NEW_MINECRAFT_VERSION="$2"
NEW_PAPER_URL="https://ci.destroystokyo.com/job/PaperSpigot/${NEW_PAPER_BUILD}/artifact/paperclip-${NEW_PAPER_BUILD}.jar"

curl -I -f "${NEW_PAPER_URL}" || (echo "Version not found." && exit 1)

commitmessage="Update to Paper build $1"
sed -i "s,PAPER_BUILD=.\+\?,PAPER_BUILD=$1,g" Dockerfile*
if [ ! -z "$2" ]; then
  if [ "$MINECRAFT_VERSION" != "$2" ]; then
    commitmessage="$commitmessage and Minecraft $2"
    sed -i "s,MINECRAFT_VERSION=.\+\?,MINECRAFT_VERSION=$2,g" Dockerfile*
  fi
fi
./update-sha512.sh
git add Dockerfile

sed -i 's,`b'"$PAPER_BUILD"'`,`b'"$NEW_PAPER_BUILD"'`,' README.md
git add README.md

git commit -m "$commitmessage."
git tag -s -m "Paper server build $1." "b$1"
