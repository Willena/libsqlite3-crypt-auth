#!/bin/sh

if [ "$TRAVIS_EVENT_TYPE" = "cron" ]
then
        exit 0
fi


echo -n "Collecting current version"
SQLITE_VERSION_LINE=$(./src/sqliteshell -version)
set $SQLITE_VERSION_LINE
SQLITE_VERSION=$1
echo " : $SQLITE_VERSION"
echo -n "Creating new tag"
git tag $SQLITE_VERSION
git push origin --tags
