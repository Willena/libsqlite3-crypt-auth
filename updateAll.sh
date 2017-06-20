#!/bin/sh

if [ "$TRAVIS_EVENT_TYPE" != "cron" ]
then
	exit 0
fi

chmod +x build.sh
cd ${0%/*}
pwd
rm -rf wxsqlite3/
rm -rf src/
git clone https://github.com/utelle/wxsqlite3.git
cp -R wxsqlite3/sqlite3/secure/* .
sed -i "s|typedef sqlite3_uint64 u64;.*|//typedef sqlite3_uint64 u64;|g" src/shathree.c
rm -rf wxsqlite3/

git add .
CHANGED=$(git diff --name-only HEAD |wc -l)
if [ "$CHANGED" != "0" ]
then
#	echo "Ok not 0"
	git config --global user.name "Villena Guillaume"
	git config --global user.email  guiguivil@gmail.com
	git commit -a -m "Upgrade to the lastest SQLite version"
	git push
fi

