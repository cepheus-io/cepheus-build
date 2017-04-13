## Cepheus-Build

Option to build Cepheus on existing hardware or VMs. The primary `cepheus` project contains all of the code needed to build out Cepheus from nothing. However, on existing hardware or VMs you need a way to `bootstrap` the initial build and `Cepheus-Build` is that bootstrap.

To launch do the following:

>Login to the node that will be your `bootstrap` node with `sudo` rights


Step 1 (install git): (if your node already has git installed then skip to Step 2)

>Redhat/CentOS:
>
>sudo yum install git
>>
>Ubuntu:
>
>sudo apt install git
>
>Setup git credentials (optional for public repos):
>
>git config --global user.email "you@example.com"
>
>git config --global user.name "Your Name"

Step 2 (install this repo):

>git clone https://github.com/cepheus-io/cepheus-build $HOME

Step 3 (start build):

>sudo $HOME/cepheus-build.sh
