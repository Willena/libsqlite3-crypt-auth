#!/bin/sh
cd ${0%/*}
pwd
git submodule foreach git pull origin master

cp -R wxsqlite3/sqlite3/secure/* .