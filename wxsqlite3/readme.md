# wxSQLite3 - a lightweight wrapper for SQLite

**wxSQLite3** is a C++ wrapper around the public domain SQLite 3.x database
and is specifically designed for use in programs based on the wxWidgets
library.

**wxSQLite3** does not try to hide the underlying database, in contrary
almost all special features of the current SQLite3 version are
supported, like for example the creation of user defined scalar or
aggregate functions.

Since SQLite stores strings in UTF-8 encoding, the wxSQLite3 methods
provide automatic conversion between wxStrings and UTF-8 strings. This
works best for the Unicode builds of wxWidgets. In ANSI builds the
current locale conversion object (wxConvCurrent) is used for conversion
to/from UTF-8. Special care has to be taken if external administration
tools are used to modify the database contents, since not all of these
tools operate in Unicode or UTF-8 mode.

- [Version history](#history)
- [Installation](#install)
- [Optional features](#optional)
- [Static SQLite library](#sqlite-static)
- [Acknowledgements](#acknowledge)

## <a name="history"></a>Version history

* 3.5.3 - *March 2017*
  - Upgrade to SQLite version 3.18.0
  - Minor modification to wxsqlite3.pc.in to fix issue with pkgconfig tool
* 3.5.2 - *March 2017*
  - Upgrade to SQLite version 3.17.0
  - Fixed minor issue in SQLite encryption extension related to symbol `SQLITE_DEBUG`
  - Modified build system for GNU make (support monolithic wxWidgets build)
* 3.5.1 - *February 2017*
  - Added version information as Windows resource for DLL builds on Windows
  - Cleaned up premake5 build files for Visual C++ (corrected debug environment settings)
  - Resolved wxWidgets library dependencies for Visual C++ using wxWidgets' special setup.h for MSVC
* 3.5.0 - *January 2017*
  - Upgrade to SQLite version 3.16.2
  - SQLite3 library now integrated part of wxSQLite3
  - Overhaul of build system
* 3.4.1 - *October 2016*
  - Upgrade to SQLite version 3.15.0
* 3.4.0 - *August 2016*
  - Upgrade to SQLite version 3.14.1
  - Added method `wxSQLite3Statement::GetExpandedSQL`
  - Added method `wxSQLite3ResultSet::GetExpandedSQL`
  - Started to modify the build system to compile and statically link the SQLite3 library together with wxSQLite3
  - Added the CSV extension module as part of the SQLite3 library with encryption extension
* 3.3.1 - *April 2016*
  - Upgrade to SQLite version 3.12.1
  - Added method `wxSQLite3Database::GetSystemErrorCode`
* 3.3.0 - *December 2015*
  - Upgrade to SQLite version 3.9.2 (including adjusted SQLite amalgamation source to fix problem with the user authentication module)
  - Transition from SourceForge to GitHub
* 3.2.1 - *March 2015*
  - Upgrade to SQLite version 3.8.8.3
  - Fixed a bug in method GetParamName
* 3.2.0 - *December 2014*
  - Upgrade to SQLite version 3.8.7.4
  - Added support for the SQLite user authentication module
* 3.1.1 - *June 2014*
  - Upgrade to SQLite version 3.8.5
* 3.1.0 - *May 2014*
  - Upgrade to SQLite version 3.8.4.3
  - Added flag `isDeterministic` to method `wxSQLite3Database::CreateFunction`
  - Added new GUI sample
  - Changed implementation of encryption extension (see readme file in sqlite3 subfolder)
* 3.0.6 - *December 2013*
  - Upgrade to SQLite version 3.8.2
* 3.0.5 - *September 2013*
  - Upgrade to SQLite version 3.8.0.2
  - Added support for setting the temporary directory for SQLite on Windows
* 3.0.4 - *August 2013*
  - Upgrade to SQLite version 3.8.0
  - Added support for querying performance characteristics of prepared statements
* 3.0.3 - *March 2013*
  - Upgrade to SQLite version 3.7.16
* 3.0.2 - *Dezember 2012*
  - Upgrade to SQLite version 3.7.15.1
  - Corrected an internal SQLite data structure to avoid compile time warnings
  - Changed method `wxSQLite3Exception::ErrorCodeAsString` to return the error messages provided by SQLite
* 3.0.1 - *November 2012*
  - Upgrade to SQLite version 3.7.14.1
  - Cleaned up and optimized Finalize methods
  - Modified `wxSQLite3Database::Close` to avoid potential memory leaks
  - Added method `wxSQLite3Database::GetWrapperVersion`
  - Added method `wxSQLite3Database::IsReadOnly`
  - Added method `wxSQLite3Statement::BindUnixDateTime`
  - Added method `wxSQLite3ResultSet::GetUnixDateTime`
  - Added method `wxSQLite3ResultSet::GetAutomaticDateTime`
  - Fixed a potential memory leak in method `wxSQLite3Database::ExecuteUpdate`
  - Added a `wxsqlite3.pc` file on request of the Fedora Project developers
  - Replaced assert by `wxASSERT` in `wxSQLite3Transaction` constructor
* 3.0.0 - *January 2012*
  - Upgrade to SQLite version 3.7.10
  - Added method `wxSQLite3Database::Vacuum`
  - Added method `wxSQLite3Database::GetDatabaseFilename`
  - Added method `wxSQLite3Database::ReleaseMemory`
  - Added method `wxSQLite3ResultSet::CursorMoved`
  - Added method `wxSQLite3Statement::IsBusy`
  - Fixed a bug in method `operator=` of `wxSQLite3StringCollection` causing an endless recursion on assignment
  - Dropped the concept of SQLite3 pointer ownership in favor of reference counted pointers allowing much more flexible use of wxSQLite3 classes
  - Modified SQLite3 encryption extension (defining int64 datatype for SHA2 algorithm)
  - Dropped dbadmin sample from build files
  - Added Premake support for SQLite3 library with encryption support and for wxSQLite3 (experimental)
* 2.1.3 - *August 2011*
  - Corrected default behaviour for attached databases in case of an encrypted main database. (Now the attached database uses the same encryption key as the main database if no explicit key is given. Previously the attached database remained unencrypted.)
  - Added an optional progress callback for metheods Backup & Restore
  - Added method `SetBackupRestorePageCount` to set the number of pages to be copied in one cycle of the backup/restore process
* 2.1.2 - *July 2011*
  - Upgrade to SQLite version 3.7.7.1
  - Modified `wxSQLite3Transaction` class to make it exception safe
* 2.1.1 - *April 2011*
  - Upgrade to SQLite version 3.7.6.1
  - Added convenience method `wxSQLite3Statement::ExecuteScalar`
  - Changed write-ahead log checkpoint method to new version (v2)
* 2.1.0 - *March 2011*
  - Upgrade to SQLite version 3.7.5
  - Added wxSQLite+, a database administration application written by Fred Cailleau-Lepetit, as a GUI sample for wxSQLite3. Minor adjustments were applied to make wxSQLite+ compatible with wxWidgets 2.9.x. To compile and link wxSQLite+ successfully using wxWidgets 2.8.x it is required to build the "stc" library (scintilla) in the "contrib" folder of wxWidgets. Please note that wxSQLite+ is under GPL license.
* 2.0.2 - *December 2010*
  - Upgrade to SQLite version 3.7.4
* 2.0.1 - *October 2010*
  - Upgrade to SQLite version 3.7.3
  - Added parameter `transferStatementOwnership` to method `wxSQLite3Statement::ExecuteQuery` to allow using the returned result set beyond the life time of the `wxSQLite3Statement` instance
* 2.0.0.1 - *August 2010*
  - Upgrade to SQLite version 3.7.0.1
  - Added missing function interfaces in `wxsqlite3dyn.h`
  - Adjusted code to eliminate a reference to `sqlite3_mprintf`
* 2.0.0 - *July 2010*
  - Upgrade to SQLite version 3.7.0
  - Fixed a bug in class `wxSQLite3ResultSet`
  - Added support for SQLite's write-ahead log journal mode
  - Added support for named collections (see class `wxSQLite3NamedCollection`)
  - Changed UTF-8 string handling to use methods To/FromUTF8 of the wxString class (requires wxWidgets 2.8.4 or higher)
  - Compatible with wxWidgets 2.9.1
* 1.9.9 - *March 2010*
  - Upgrade to SQLite version 3.6.23
  - Fixed a bug when compiling for dynamic loading of SQLite
  - Added static methods to class `wxSQLite3Database` for accessing the run-time library compilation options diagnostics
  - Added mathod FormatV to class `wxSQLite3StatementBuffer`
* 1.9.8 - *February 2010*
  - Upgrade to SQLite version 3.6.22
  - Fixed a bug when compiling without precompiled header support (by including wx/arrstr.h)
  - Added experimental support for 256 bit AES encryption to the optional key based encryption extension
* 1.9.7 - *November 2009*
  - Upgrade to SQLite version 3.6.20
  - Added methods to query, enable or disable foreign key support
* 1.9.6 - *September 2009*
  - Upgrade to SQLite version 3.6.18
  - Added method to get the SQLite library source id
  - Added `flags` parameter to `wxSQLite3Database::Open` to allow additional control over the database connection (see [http://www.sqlite.org/c3ref/open.html](http://www.sqlite.org/c3ref/open.html) for further information)
  - Fixed a potential memory leak in `wxSQLite3Statement` class
  - Converted encryption extension from C++ to pure C to make it compatible with the SQLite amalgamation.
* 1.9.5 - *February 2009*
  - Upgrade to SQLite version 3.6.11
  - Added user defined function class for REGEXP operator
  - Added support for SQLite backup/restore API, introduced with SQLite 3.6.11
* 1.9.4 - *January 2009*
  - Upgrade to SQLite version 3.6.10
  - Added support for SQLite savepoints, introduced with SQLite 3.6.8
  - Added IsOk methods to several classes
* 1.9.3 - *Dezember 2008*
  - Upgrade to SQLite version 3.6.7
  - Fixed a bug in method `wxSQLite3Table::GetDouble` (conversion from string to double failed in non-US locales)
  - Build system upgraded using Bakefile 0.2.5
* 1.9.2 - *November 2008*
  - Upgrade to SQLite version 3.6.6
  - Added RAII transaction class (see docs for details)
* 1.9.1 - *September 2008*
  - Upgrade to SQLite version 3.6.2
  - Introduced own step counting for aggregate user functions since the `sqlite3_aggregate_count` function is now deprecated.
  - Enhanced `wxSQLite3Database::TableExists` method to query an attached database for existence of a table or to query all open databases.
* 1.9.0 - *July 2008*
  - Upgrade to SQLite version 3.6.0
  - The optional key based encryption support has been adapted to support SQLite version 3.6.0.
  - Added static methods to initialize and shutdown the SQLite library.
  - Changed build system to support static library build against shared wxWidgets build on Linux.
  - Changed behaviour of `Close` method of class `wxSQLite3Database` to finalize all unfinalized prepared statements.
* 1.8.5 - *June 2008*
  - Upgrade to SQLite version 3.5.9
  - Integration of the optional key based encryption support into SQLite has been made easier. Changes to original SQLite source files are no longer necessary.
* 1.8.4 - *April 2008*
  - Upgrade to SQLite version 3.5.8
   - Added support for accessing database limits
   - Changed method `TableExists` to check a table name case insensitive
   - Fixed several minor issues in the build files.
* 1.8.3 - *January 2008*
  - Added support for shared cache mode
  - Added support for access to original SQL statement for prepared statements (requires SQLite 3.5.3 or above)
  - Fixed broken SQLite DLLs
* 1.8.2 - *Dezember 2007*
  - Upgrade to SQLite version 3.5.4
  - Fixed a bug in in `wxSQLite3Database::Begin` (wrong transaction type)
* 1.8.1 - *November 2007*
  - Fixed a bug in in `wxSQLite3Database::Close` (resetting flag `m_isEncrypted`)
  - Eliminated several compile time warnings (regarding unused parameters)
  - Fixed a compile time bug in `wxSQLite3Database::GetBlob` (missing explicit type cast)
* 1.8.0 - *November 2007*
  - Upgrade to SQLite version 3.5.2
  - Support for SQLite incremental BLOBs
  - Changed source code in the SQLite3 encryption extension to eliminate several warnings
  - Changed default wxWidgets version to 2.8.x
  - Adjusted sources for SQLite encryption support are included for all SQLite version from 3.3.1 up to 3.5.2
  - SQLite link libraries for MinGW on Windows are included
  - Added `WXMAKINGLIB_WXSQLITE3` compile time option to support building wxSQLite3 as a static library while using the shared libraries of wxWidgets.
* 1.7.3 - *May 2007*
  - Upgrade to SQLite version 3.3.17
  - Fixed a bug in the SQLite3 encryption extension (MD5 algorithm was not aware of endianess on big-endian platforms, resulting in non-portable database files)
* 1.7.2 - *February 2007*
  - Upgrade to SQLite version 3.3.11
  - Support for loadable extensions is now optional
  - Check for optional wxSQLite3 features at runtime
  - wxSQLite3 API independent of optional features
* 1.7.1 - *January 2007*
  - Fixed a bug in the key based database encryption feature (The call to `sqlite3_rekey` in `wxSQLite3Database::ReKey` could cause a program crash, when used to encrypt a previously unencrypted database.)
* 1.7.0 - *January 2007*
  - Upgrade to SQLite version 3.3.10
  - Added support for BLOBs as wxMemoryBuffer objects
  - Added support for loadable extensions
  - Optional support for key based database encryption
* 1.6.0 - *July 2006*
  - Added support for user-defined collation sequences
* 1.5.3 - *June 2006*
  - Upgrade to SQLite version 3.3.6
  - Added support for optional SQLite meta data methods
* 1.5.2 - *March 2006*
  - Fixed a bug in wxSQLite3Database::Prepare
  - Added `wxSQLite3Database::IsOpen` for convenience
* 1.5.1 - *February 2006*
  - SQLite DLL upgraded to version 3.3.4
* 1.5 - *February 2006*
  - Upgrade to SQLite version 3.3.3
  - Added support for commit, rollback and update callbacks
* 1.4.2 - *November 2005*
  - Optimized code for wxString arguments
* 1.4.1 - *November 2005*
  - Fixed a bug in `TableExists`, eliminated some compiler warnings
  - Changed handling of Unicode string conversion
  - Added support for different transaction types
* 1.4 - *November 2005*
  - Optionally load SQLite library dynamically at run time
* 1.3.1 - *November 2005*
  - Corrected `wxSQLite3ResultSet::GetInt64`,
  - Added `wxSQLite3Table::GetInt64`
* 1.3 - *October 2005*
  - Added wxGTK build support
* 1.2 - *October 2005*
  - Corrected error in `wxSQLite3Table::FindColumnIndex`
* 1.1 - *October 2005*
  - Upgrade to SQLite version 3.2.7
* 1.0 - *July 2005*
  - First public release

## <a name="install"></a>Installation

After the release of **wxSQLite3** version 3.4.1 the build support
has been overhauled. As of version 3.5.0 this process is still in progress.
The build files for Windows platforms is now generated by a (slightly
modified) version of [Premake 5](https://premake.github.io/)
(based on Premake 5.0 alpha 11).  

Ready to use project files are provided for Visual C++ 2010, 2012, 2013,
2015, and 2017. Additionally, GNU Makefiles are provided supporting for
example TDM-GCC MinGW.

For Visual Studio 2010+ solutions it is possible to customize the build
by creating a wx_local.props file in the build directory which is used,
if it exists, by the projects. The settings in that file override the
default values for the properties. The typical way to make the file is
to copy wx_setup.props to wx_local.props and then edit local.

For GNU Makefiles the file config.gcc serves the same purpose as the
file wx_setup.props for Visual C++ projects.

The customization files `wx_setup.props` resp. `config.gcc` allow to
customize certain settings like for example the version number and the
root directory of the wxWidgets library.

### wxMSW

When building on Win32 or Win64, you can use the makefiles or one of the
Microsoft Visual Studio solution files in the BUILD folder.

For Visual C++ the debugging properties are set up in such a way that
debugging the sample applications should work right out of the box. For
release builds you may need to copy the wxSQLite3 DLL or add the
`lib` folder path to the Windows search path (PATH environment variable).

The SQLite3 library is now compiled as an integrated part of wxSQLite3.
The advantage is that SQLite3 and wxSQLite3 are always compiled with
matching configuration options. Additionally, the SQLite3 encryption
extension is automatically enabled, too.

A precompiled SQLite shell program supporting encrypted
databases is provided as a separate download. Use
```
PRAGMA KEY="encryption key";
```
to create or open an encrypted database. Use
```
ATTACH DATABASE x AS y KEY z;
```
to attach an encryted database.

### wxGTK

When building on an autoconf-based system (like Linux/GNU-based
systems), the first setp is to recreate the configure script doing:

```
  autoreconf
```

Thereafter you should create a build directory

```
  mkdir build-gtk [or any other suitable name]
  cd build-gtk
  ../configure [here you should use the same flags you used to configure wxWidgets]
  make
```
 
Type `../configure --help` for more info.

The autoconf-based system also supports a `make install` target which
builds the library and then copies the headers of the component to
`/usr/local/include` and the lib to `/usr/local/lib`.

## <a name="optional"></a>Optional features

### Optional Meta Data support

If you want to use the optional SQLite meta data methods SQLite needs
to be compiled with `SQLITE_ENABLE_COLUMN_METADATA`. Additionally the
preprocessor symbol `WXSQLITE3_HAVE_METADATA` must be defined when
compiling wxSQLite3. As default, meta data support is enabled.

### Optional key based database encryption support

The public release of SQLite contains hooks for key based database
encryption, but the code for implementing this feature is not freely
available. D. Richard Hipp offers a commercial solution
(see [http://www.hwaci.com/sw/sqlite/prosupport.html#crypto](http://www.hwaci.com/sw/sqlite/prosupport.html#crypto)).

If you want to use the optional SQLite key based database encryption
you need to have the implementation of this feature and you have to
compile SQLite with the option `SQLITE_HAS_CODEC`. 

Additionally the preprocessor symbol `WXSQLITE3_HAVE_CODEC` must be
defined when compiling wxSQLite3.

There exist other commercial solutions, among them:

- [http://www.sqlcrypt.com](http://www.sqlcrypt.com)
- [http://www.sqlite-crypt.com](http://www.sqlite-crypt.com)

Both use a slightly different encryption API, which is currently NOT
supported by wxSQLite3.

For Windows based systems there exists an open source solution:
[System.Data.SQLite](http://System.Data.SQLite.org). Encrypted
database files can be shared across Windows platforms only.

The author of wxSQLite3 has created a key based AES database encryption
implementation for SQLite such that sharing encrypted database files
across different platforms is supported. The implementation is based on
knowledge gained from implementing encryption support for the wxCode
component wxPdfDocument and from inspecting the source code of
System.Data.SQLite. The code implementing this feature is available in
directory `sqlite3/secure/src`. You may use this code on your own risk.
The SQLite amalgamation source code is included. Optionally SQLite can be
compiled including the extension function module created by Liam Healy.

Starting with the release of *wxSQLite3 1.9.6* the encryption extension has
been converted from C++ to pure C and is now compatible with the SQLite
amalgamation source distribution. Just compile the file `sqlite3secure.c`
which includes all required source files.

Starting with the release of *wxSQLite3 1.9.8* the encryption extension
includes an implementation of 256 bit AES encryption. The
code comes without any warranty, use it at your own risk.
Currently the decision whether to use 128 bit or 256 bit AES encryption
has to be made at compile time. To enable 256 bit AES encryption define
`CODEC_TYPE=CODEC_TYPE_AES256` (Default: `CODEC_TYPE=CODEC_TYPE_AES128`).

Don't forget to specify the preprocessor symbols from the following list
corresponding to your needs to get a valid SQLite library.

The following 2 symbols enable encryption support:
```
SQLITE_HAS_CODEC
CODEC_TYPE=CODEC_TYPE_AES128
```
In the latter symbol you may specify `CODEC_TYPE_AES256` instead of
`CODEC_TYPE_AES128` to enable the support for AES 256 bit
encryption.

The following 2 symbols are usually always required resp. recommended:
```
SQLITE_CORE
THREADSAFE=1
```
The following 3 symbols are optional to enable specific SQLite features:
```
SQLITE_SECURE_DELETE
SQLITE_SOUNDEX
SQLITE_ENABLE_COLUMN_METADATA
```
The following 6 symbols enable optional extension modules:
```
SQLITE_ENABLE_FTS3
SQLITE_ENABLE_FTS3_PARENTHESIS
SQLITE_ENABLE_FTS4
SQLITE_ENABLE_FTS5
SQLITE_ENABLE_JSON1
SQLITE_ENABLE_RTREE
```
Precompiled binaries of the SQLite3 DLL for Windows are provided as separate downloads.
Support for the optional SQLite meta data methods and the optional key based database
encryption (128 resp. 256 bit AES) is included. The modules FTS5, JSON1, RTREE, and
ExtensionFunctions are included as well.

## <a name="sqlite-static"></a>Using statically linked SQLite library on Windows

Starting with wxSQLite3 version 3.5.0 the SQLite3 library is compiled as an
integrated part of wxSQLite3. A separate SQLite3 DLL is not required any longer.

## <a name="acknowledge"></a>Acknowledgements

The following people have contributed to **wxSQLite3**:

- Francesco Montorsi (enhancement of the build system)
- Neville Dastur (enhancement of the method TableExists)
- Tobias Langner (RAII class for managing transactions)
