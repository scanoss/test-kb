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
    ├── url
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
scanoss v1.5.0.tar.gz | jq
{
  "v1.5.0.tar.gz": [
    {
      "id": "file",
      "status": "pending",
      "lines": "all",
      "oss_lines": "all",
      "matched": "100%",
      "purl": [
        "pkg:github/phpspec/prophecy"
      ],
      "vendor": "phpspec",
      "component": "prophecy",
      "version": "1.5.0",
      "latest": "1.5.0",
      "url": "https://github.com/phpspec/prophecy",
      "release_date": "2015-08-13",
      "file": "v1.5.0.tar.gz",
      "url_hash": "0092c636449ac512feba8345a196478c",
      "file_hash": "0092c636449ac512feba8345a196478c",
      "source_hash": "0092c636449ac512feba8345a196478c",
      "file_url": "https://github.com/phpspec/prophecy/archive/v1.5.0.tar.gz",
      "server": {
        "version": "4.5.0",
        "kb_version": {
          "monthly": "22.01",
          "daily": "22.01.01"
        }
      }
    }
  ]
}
```

## File scan

Expand the component and pick a file to scan:

```
tar -zxf v1.5.0.tar.gz 
scanoss prophecy-1.5.0/src/Prophecy/Util/ExportUtil.php | jq
{
  "prophecy-1.5.0/src/Prophecy/Util/ExportUtil.php": [
    {
      "id": "file",
      "status": "pending",
      "lines": "all",
      "oss_lines": "all",
      "matched": "100%",
      "purl": [
        "pkg:github/phpspec/prophecy"
      ],
      "vendor": "phpspec",
      "component": "prophecy",
      "version": "1.5.0",
      "latest": "1.5.0",
      "url": "https://github.com/phpspec/prophecy",
      "release_date": "2015-08-13",
      "file": "src/Prophecy/Util/ExportUtil.php",
      "url_hash": "0092c636449ac512feba8345a196478c",
      "file_hash": "e490bd70fde393e9d87770da3d631358",
      "source_hash": "e490bd70fde393e9d87770da3d631358",
      "file_url": "https://osskb.org/api/file_contents/e490bd70fde393e9d87770da3d631358",
      "server": {
        "version": "4.5.0",
        "kb_version": {
          "monthly": "22.01",
          "daily": "22.01.01"
        }
      }
    }
  ]
}
```

## Snippet scan

Just appending a LF to a file will produce a no match on the entire file, which would trigger a snippet analysis and match:

```
echo -e \n >> prophecy-1.5.0/src/Prophecy/Util/StringUtil.php
scanoss prophecy-1.5.0/src/Prophecy/Util/StringUtil.php | jq
{
  "prophecy-1.5.0/src/Prophecy/Util/StringUtil.php": [
    {
      "id": "snippet",
      "status": "pending",
      "lines": "1-85",
      "oss_lines": "1-85",
      "matched": "98%",
      "purl": [
        "pkg:github/phpspec/prophecy"
      ],
      "vendor": "phpspec",
      "component": "prophecy",
      "version": "1.10.0",
      "latest": "1.10.0",
      "url": "https://github.com/phpspec/prophecy",
      "release_date": "2019-12-17",
      "file": "src/Prophecy/Util/StringUtil.php",
      "url_hash": "5bb10a12d3755d82edbcea4308c37d54",
      "file_hash": "201cdcb4700db4d4c7880b14880d6a41",
      "source_hash": "9e75d7ef2e91fe71664f1b1d027b150e",
      "file_url": "https://osskb.org/api/file_contents/201cdcb4700db4d4c7880b14880d6a41",
      "server": {
        "version": "4.5.0",
        "kb_version": {
          "monthly": "22.01",
          "daily": "22.01.01"
        }
      }
    }
  ]
}
```

# Scanning from a remote location

Follow instructions on installing the [**SCANOSS API**](https://github.com/scanoss/API) and the [**scanner.py**](https://github.com/scanoss/scanner.py) command-line interface to expose the remote scanning service.

# License

The Scanoss Platform is entirely released under the GPL 2.0 license. Please check the LICENSE file for more information.

Copyright (C) 2018-2020 SCANOSS.COM
