LibSQLite3-crypt-auth
======

This repository is an extract of the wxsqlite repository (https://github.com/utelle/wxsqlite3.git).
This repository only contain the code for building sqlite3 with encryption and userauth and some other things.

The easy way of using it is to clone this repository, then start the "updateAll.sh" script that will update the content of src/ with the latest code from the wxsqlite3. It also edit some files to make them compatible with the main project of this repository : build the jdbc sqlite connector with encryption inlcuded. The modified version of the jdbc connector, recompiled can be found here : https://github.com/Willena/sqlite-jdbc.
