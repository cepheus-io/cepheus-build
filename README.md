## Cepheus-Build

Option to build Cepheus on existing hardware or VMs. The primary `cepheus` project contains all of the code needed to build out Cepheus from nothing. However, on existing hardware or VMs you need a way to `bootstrap` the initial build and `Cepheus-Build` is that bootstrap.

To launch do the following:

>Login to the node that will be your `bootstrap` node with `sudo` rights


**Step 1 (install git):** (if your node already has git installed then skip to Step 2)

>**Redhat/CentOS:**
>
>sudo yum install -y git
>>
>**Ubuntu:**
>
>sudo apt install -y git
>
>Setup git credentials (optional for public repos):
>
>git config --global user.email "you@example.com"
>
>git config --global user.name "Your Name"

**Step 2 (install this repo):**

>git clone https://github.com/cepheus-io/cepheus-build
>
> **OR** (combine Step 2 and Step 3)
>
>git clone https://github.com/cepheus-io/cepheus-build && ./cepheus-build/cepheus-build.sh

**Step 3 (start build):**
This step will install the needed dependencies, git clone `cepheus` to /tmp/cepheus and then launch `./CEPH_UP -u 0` which will start the build process.

>./cepheus-build/cepheus-build.sh
