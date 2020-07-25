# SCANOSS Test Knowledgebase

This repository contains a test knowledgebase containing a small selection of components. 

The purpose is to have a working, portable knowledgebase that can be used to test the SCANOSS platform.

The script required for creating the knowledgebase is included in the code tree.

# Components used

A small set of components and versions have been selected from popular components from a small set of programming languages. The list follows: 

# A few of versions of the Linux Kernel (C)

* Linux Kernel (C)
	* versions 4.4.231, 3.0.1, 2.0.1 and 1.0 

* OpenCV (C++)
	* versions 4.0.0, 3.0.0 and 2.2

* Action Runner (C#) 
	* versions 2.267.1, 2.169.1 and 2.160.0

* Retrofit (Java) 
	* versions 2.9.0, 2.0.0 and 1.0.0

* JQuery (Javascript)
	* versions 3.5.1, 2.2.4 and 1.12.4 (in their full and minimized form)

* Jekyll (Ruby)
	* versions 4.0.0, 3.0.0, 2.0.0 and 1.0.0

* Prophecy (PHP)
	* versions 1.10.0, 1.5.0 and 1.0.0

* Poetry (Python)
	* versions 1.0.0, 0.12.0 and 0.5.0

# Disk space

The test KB takes 43Gb of space which mostly accounts for the nearly empty LDB list maps. While database footprint is significant for a small test database, this becomes insignificant in a multi Tb database, which is what the LDB is created for.

LDB maps provide index-less searches, which allows the LDB to respond to queries in just microseconds. For more information on the SCANOSS LDB, please check the [**LDB**](https://github.com/scanoss/ldb) project

# Installation

Simply expand the ldb.tar.xz into /var/lib/ldb and make sure to chown/chmod to grant access to the SCANOSS user.

Note that the tarball is divided in chunks to overcome the 50Mb limitation in Github. You need to stitch it together as follows:

```
cat ldb.tar.xz_a* > ldb.tar.xz
tar -vaxf ldb.tar.xz
sudo mv ldb /var/lib
```

The root LDB directory should be located in /var/lib

```tree -d /var/lib/ldb/
/var/lib/ldb/
└── oss
    ├── component
    ├── file
    └── wfp
```

# Testing

The SCANOSS engine allows direct scanning of files and directories against the SCANOSS Knowledgebase. Please download and install the [**SCANOSS Engine**](https://github.com/scanoss/engine).

Scanning can be done at component, file or snippet level.

## Component scan

Download a component and scan it entirely:

```
wget https://github.com/phpspec/prophecy/archive/v1.5.0.tar.gz
scanoss v1.5.0.tar.gz
{
  "v1.5.0.tar.gz": [
    {
      "id": "component",
      "elapsed": "0.000081s",
      "lines": "all",
      "oss_lines": "all",
      "matched": "100%",
      "vendor": "phpspec",
      "component": "prophecy",
      "version": "1.5.0",
      "latest": "1.5.0",
      "url": "https://github.com/phpspec/prophecy/archive/v1.5.0.tar.gz",
      "file": "all",
      "size": "N/A",
      "dependencies": [],
      "licenses": []
    }
  ]
}
```

## File scan

Expand the component and pick a file to scan:

```
tar -zxf v1.5.0.tar.gz 
scanoss prophecy-1.5.0/src/Prophecy/Util/ExportUtil.php 
{
  "prophecy-1.5.0/src/Prophecy/Util/ExportUtil.php": [
    {
      "id": "file",
      "elapsed": "0.000079s",
      "lines": "all",
      "oss_lines": "all",
      "matched": "100%",
      "vendor": "phpspec",
      "component": "prophecy",
      "version": "1.5.0",
      "latest": "1.5.0",
      "url": "https://github.com/phpspec/prophecy/archive/v1.5.0.tar.gz",
      "file": "prophecy-1.5.0/src/Prophecy/Util/ExportUtil.php",
      "size": "6020",
      "dependencies": [],
      "licenses": []
    }
  ]
}
```

## Snippet scan

Just appending a LF to a file will produce a no match on the entire file, which would trigger a snippet analysis and match:

```
echo -e \n >> prophecy-1.5.0/src/Prophecy/Util/StringUtil.php
scanoss prophecy-1.5.0/src/Prophecy/Util/StringUtil.php
{
  "prophecy-1.5.0/src/Prophecy/Util/StringUtil.php": [
    {
      "id": "snippet",
      "elapsed": "0.001328s",
      "lines": "1-85",
      "oss_lines": "1-85",
      "matched": "98%",
      "vendor": "phpspec",
      "component": "prophecy",
      "version": "1.5.0",
      "latest": "1.5.0",
      "url": "https://github.com/phpspec/prophecy/archive/v1.5.0.tar.gz",
      "file": "prophecy-1.5.0/src/Prophecy/Util/StringUtil.php",
      "size": "2540",
      "dependencies": [],
      "licenses": []
    }
  ]
}
```

# Scanning from a remote location

Follow instructions on installing the [**SCANOSS API**](https://github.com/scanoss/API) and the [**scanner.py**](https://github.com/scanoss/scanner.py) command-line interface to expose the remote scanning service.

# License

The Scanoss Platform is entirely released under the GPL 2.0 license. Please check the LICENSE file for more information.

Copyright (C) 2018-2020 SCANOSS.COM
