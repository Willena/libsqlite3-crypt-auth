#!/bin/sh
chmod +x build.sh
cd ${0%/*}
pwd
rm -rf wxsqlite3/
rm -rf src/
git clone https://github.com/utelle/wxsqlite3.git
cp -R wxsqlite3/sqlite3/secure/* .
sed -i "s|typedef sqlite3_uint64 u64;.*|//typedef sqlite3_uint64 u64;|g" src/shathree.c
rm -rf wxsqlite3/
