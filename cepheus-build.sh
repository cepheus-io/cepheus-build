#!/bin/bash
#
# Author: Chris Jones <chris.jones@lambdastack.io>
# Copyright 2017, LambdaStack
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# NB: PXE_BOOT would normally do all of this.
# NB: The initial bootstrap process: Chef Server and Chef Clients are installed and setup along with everything else.
# NB: Setup sudoers, users, dependencies needed for Chef and Ansible etc...

# IMPORTANT - This process may wipe out any existing Cepheus directories and start over!! Becareful if not sure!

# Colors
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

set -e

# Check to make sure Cepheus is not already setup. If so then bail.
CEPHEUS_CONTINUE=1

for chk in "/ceph-host" "/ceph-files" "$HOME/cepheus"; do
    if [[ -d $chk ]]; then
        CEPHEUS_CONTINUE=0
        break
    fi
done

if [[ $CEPHEUS_CONTINUE -ne 1 ]]; then
    if [[ -d $HOME/cepheus-build ]]; then
        rm -rf $HOME/cepheus-build
    fi
    echo
    echo -e "${RED}====> Cepheus already setup! <====${NC}"
    echo
    exit 1
fi

BOOTSTRAP_ONLY=$1
BOOTSTRAP_ONLY=${BOOTSTRAP_ONLY:-0}

if [[ -f /etc/redhat-release ]]; then
    echo "====> Installing required packages..."
    sudo yum install -y kernel-devel gcc make perl bzip2
    sudo yum install -y epel-release rsync vim git wget curl
    sudo yum install -y python-pip python-jinja2 PyYAML ansible
    sudo yum install -y ipmitool yum-utils createrepo ntp tmux
fi

echo "====> Cloning Cepheus and data files..."
echo

if [[ -d /tmp/cepheus ]]; then
    rm -rf /tmp/cepheus
fi

git clone https://github.com/cepheus-io/cepheus /tmp/cepheus

# IMPORTANT!!!
# clone the "private" layers (if any)
# clone the data layers
# copy over the layers in proper order to /tmp/cepheus
# remove the "private" and data layers

# Go ahead and get rid of the directory so if something fails it can cleanly start over...
if [[ -d $HOME/cepheus-build ]]; then
    rm -rf $HOME/cepheus-build
fi

# Could add a parameter option to allow for install only or build.
# Currently it's build

cd /tmp/cepheus

echo -e "${RED}====> Bootstrap Initial Cepheus...${NC}"
# -b bootstrap build
./CEPH_UP -b

# if [[ $BOOTSTRAP_ONLY -eq 0 ]]; then
    echo -e "${YELLOW}====> Update Cepheus (-cepheus-build-)...${NC}"
    if [[ ! -d $HOME/cepheus ]]; then
        git clone https://github.com/cepheus-io/cepheus $HOME/cepheus
    fi
    cd $HOME/cepheus
    # -x suppress logo, -u 0 update
    ./CEPH_UP -x -u 0
# fi


# Should only have ceph-files.tar.gz in home of primary user so remove it for clean up.
echo -e "${YELLOW}====> Cleaning up <==== ${NC}"
cd $HOME
rm -f *.tar.gz
cd $HOME/cepheus
rm -rf .git
rm .gitignore
rm .kitchen.yml
rm .editorconfig

# This should only be called once!
$HOME/cepheus/bootstrap/common/bootstrap_ceph.sh

echo
echo -e "${RED}=============================================${NC}"
echo -e "${GREEN}====> Cepheus-Build Process - Complete! <====${NC}"
echo -e "${RED}=============================================${NC}"
echo
