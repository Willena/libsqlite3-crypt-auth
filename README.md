LibSQLite3-crypt-auth
======

This repository is an extract of the wxsqlite repository (https://github.com/utelle/wxsqlite3.git).
This repository only contain the code for building sqlite3 with encryption and userauth and some other things.

The easy way of using it is to clone this repository, then start the "updateAll.sh" script that will update the content of src/ with the latest code from the wxsqlite3. It also edit some files to make them compatible with the main project of this repository : build the jdbc sqlite connector with encryption inlcuded. The modified version of the jdbc connector, recompiled can be found here : https://github.com/Willena/sqlite-jdbc.

Use of the Encryption API
=========================

PRAGMA usage
------------

From the shell or when using it in a project you can use PRAGMA to encrypt or decrypt the database. 
##### PRAGMA key
   - example usage: ```PRAGMA key='passphrase';```

##### PRAGMA rekey
   - example usage: ```PRAGMA rekey='passphrase';```
   - example of decrypting: ```PRAGMA rekey='';```

Instruction order to work with encrypted databases
--------------------------------------------------

##### Encrypting a new db

1. open         
2. key          
3. use as usual

##### Opening an encrypted DB

1. open          
2. key           
3. use as usual  

##### Changing the key

1. open          
2. key           
3. rekey        
4. use as usual  

##### Decrypting

1. open             
2. key              
3. rekey with null   
4. use as usual

Checking if key was correct
---------------------------

The only way to know if the entered key is the right one is to try some operation on the database. Try for example to select something in the "master" table:
```sqlite 
SELECT count(*) FROM sqlite_master;
```
if it throw an error like "Not a database, the file is encrypted or not a databse" then it means that the key is wrong. If the key is good you should get the number of row in the table "sqlite_master"

