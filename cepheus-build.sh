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

set -e

if [[ -f /etc/redhat-release ]]; then
    echo "====> Installing required packages..."
    sudo yum install -y kernel-devel gcc make perl bzip2
    sudo yum install -y epel-release rsync vim git wget curl
    sudo yum install -y python-pip python-jinja2 PyYAML
    sudo yum install -y ipmitool yum-utils createrepo ntp tmux
fi

echo "====> Cloning Cepheus..."
git clone https://github.com/cepheus-io/cepheus /tmp/cepheus

# Could add a parameter option to allow for install only or build.
# Currently it's build

cd /tmp/cepheus

echo "====> Building Cepheus..."
./CEPH_UP -u 0
