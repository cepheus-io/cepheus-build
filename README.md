## Cepheus-Build

Option to build Cepheus on existing hardware or VMs. The primary `cepheus` project contains all of the code needed to build out Cepheus from nothing. However, on existing hardware or VMs you need a way to `bootstrap` the initial build and `Cepheus-Build` is that bootstrap.

To launch do the following:

>Login to the node that will be your `bootstrap` node with `sudo` rights

**Step 0 (prerequisite - ssh key):**

>Cepheus does not do **key management** (ssh keys). Copy or create your 'operations' like key (pubic and private) to secure area on your drive such as $HOME/.ssh and then put the names of those two files and their path into Cepheus' `environment.yaml` file located in `(repo root)/data/(private | public)/(whatever your datacenter name)/data/environment.yaml` in the `primary_user:` - `public_key:`, `private_key:` and `key_path:` sections.
>
>Example of creating a key: `ssh-keygen -b 2048 -t rsa -f $HOME/.ssh/cepheus -C "Cepheus example"` this will prompt you for a passphrase - you can press ENTER to let it be empty otherwise you will need to enter the passphrase when going between nodes or you will need to use `ssh-agent` etc. Also, the `-C ""` is a comment so put anything you want because it will make it easier to recognize your key in the nodes `authorized_keys` key file.
>
>The example will create two files `cepheus` and `cepheus.pub`. The `.pub` is the public key and the other is the private key. Most enterprises already have their own 'operations' like keys which they manage somehow.

**Step 1 (prerequisite - git):** (if your node already has git installed then skip to Step 2)

>**Redhat/CentOS:**
>
>sudo yum install -y git
>
>
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

>**git clone https://github.com/cepheus-io/cepheus-build**
>
> **OR** (combine Step 2 and Step 3)
>
>**git clone https://github.com/cepheus-io/cepheus-build && ./cepheus-build/cepheus-build.sh**

**Step 3 (start build):**
This step will install the needed dependencies, git clone `cepheus` to /tmp/cepheus and then launch `./CEPH_UP -u 0` which will start the build process.

>**./cepheus-build/cepheus-build.sh**
