#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
#
# util/kb-mine.c
#
# Test Knowledgebase generator
# 
# This program generates a test knowledgebase to be use with the SCANOSS platform.
#
# An important step in the script counts on the bsort command line being installed
# bsort is avalable here: https://github.com/pelotoncycle/bsort
#
# Copyright (C) 2018-2020 SCANOSS.COM
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Download a few OSS components:

# A few of versions of the Linux Kernel (C)
minr -d torvalds,kernel,4.4.231  -u https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.4.231.tar.xz
minr -d torvalds,kernel,3.0.1    -u https://mirrors.edge.kernel.org/pub/linux/kernel/v3.0/linux-3.0.1.tar.gz
minr -d torvalds,kernel,2.0.1    -u https://mirrors.edge.kernel.org/pub/linux/kernel/v2.0/linux-2.0.1.tar.bz2
minr -d torvalds,kernel,1.0      -u https://mirrors.edge.kernel.org/pub/linux/kernel/v1.0/linux-1.0.tar.gz

# A few versions of OpenCV (C++)
minr -d opencv,opencv,4.0.0 -u https://github.com/opencv/opencv/archive/4.0.0.tar.gz
minr -d opencv,opencv,3.0.0 -u https://github.com/opencv/opencv/archive/3.0.0.tar.gz
minr -d opencv,opencv,2.2   -u https://github.com/opencv/opencv/archive/2.2.tar.gz

# A few versions of Action Runner (C#)
minr -d actions,runner,2.267.1 -u https://github.com/actions/runner/archive/v2.267.1.tar.gz
minr -d actions,runner,2.169.1 -u https://github.com/actions/runner/archive/v2.169.1.tar.gz
minr -d actions,runner,2.160.0 -u https://github.com/actions/runner/archive/v2.160.0.tar.gz

# A few versions of Retrofit (Java)
minr -d square,retrofit,2.9.0 -u https://github.com/square/retrofit/archive/2.9.0.tar.gz
minr -d square,retrofit,2.0.0 -u https://github.com/square/retrofit/archive/parent-2.0.0.tar.gz
minr -d square,retrofit,1.0.0 -u https://github.com/square/retrofit/archive/parent-1.0.0.tar.gz

# A few versions of JQuery (Javascript)
minr -d jquery,jquery,3.5.1  -u https://code.jquery.com/jquery-3.5.1.js
minr -d jquery,jquery,3.5.1  -u https://code.jquery.com/jquery-3.5.1.min.js
minr -d jquery,jquery,2.2.4  -u https://code.jquery.com/jquery-2.2.4.js
minr -d jquery,jquery,2.2.4  -u https://code.jquery.com/jquery-2.2.4.min.js
minr -d jquery,jquery,1.12.4 -u https://code.jquery.com/jquery-1.12.4.js
minr -d jquery,jquery,1.12.4 -u https://code.jquery.com/jquery-1.12.4.min.js

# A few versions of Jekyll (Ruby)
minr -d jekyll,jekyll,4.0.0 -u https://github.com/jekyll/jekyll/archive/v4.0.0.tar.gz
minr -d jekyll,jekyll,3.0.0 -u https://github.com/jekyll/jekyll/archive/v3.0.0.tar.gz
minr -d jekyll,jekyll,2.0.0 -u https://github.com/jekyll/jekyll/archive/v2.0.0.tar.gz
minr -d jekyll,jekyll,1.0.0 -u https://github.com/jekyll/jekyll/archive/v1.0.0.tar.gz

# A few versions of Prophecy (PHP)
minr -d phpspec,prophecy,1.10.0 -u https://github.com/phpspec/prophecy/archive/1.10.0.tar.gz
minr -d phpspec,prophecy,1.5.0  -u https://github.com/phpspec/prophecy/archive/v1.5.0.tar.gz
minr -d phpspec,prophecy,1.0.0  -u https://github.com/phpspec/prophecy/archive/v1.0.0.tar.gz

# A few versions of Poetry (Python)
minr -d python-poetry,poetry,1.0.0  -u https://github.com/python-poetry/poetry/archive/1.0.0.tar.gz
minr -d python-poetry,poetry,0.12.0 -u https://github.com/python-poetry/poetry/archive/0.12.0.tar.gz
minr -d python-poetry,poetry,0.5.0  -u https://github.com/python-poetry/poetry/archive/0.5.0.tar.gz

# Extract snippet (WFP IDs)
minr -z mined

# Sort .csv files (components and files)
find mined -name '*.csv' -exec sort -o {} {} \;

# Sort .bin files (WFP IDs)
find mined -name '*.bin' -exec bsort -r21 -k21 {} \;

# Import into LDB
minr -i mined
