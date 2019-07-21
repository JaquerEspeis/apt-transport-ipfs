# IPFS transport for APT

## Requirements

```
sudo apt install python3-pip git
sudo pip3 install ipfshttpclient
sudo snap install ipfs
ipfs init
ipfs daemon &
```

You can install IPFS from the snap package, or following the guide at [https://docs.ipfs.io/guides/guides/install/](https://docs.ipfs.io/guides/guides/install/)

You can also install all of the above, except for git, using the requirements file in this repository, with pip3:

`pip3 install -r requirements.txt`

## Install

Copy the ipfs file from this repo to the directory for apt transport methods:

```
git clone https://github.com/JaquerEspeis/apt-transport-ipfs
cd apt-transport-ipfs
sudo cp ipfs /usr/lib/apt/methods/ipfs
```

## Configure

Add an IPFS mirror to your apt sources.list file. TODO set up a mirror.

## Hacky test

While we set up a proper IPFS mirror, this can be tested by using a hardcoded
IPFS hash that was manually set up to serve the hello deb.

Backup your /etc/apt/sources.list, remove all the lines that it has and leave it
just with:

```
deb ipfs:/ipns/QmdyaTjqXayZVQULcEyHQFx6n76TrMBc5aEDCgvp5cUTEi bionic main
```

To test it, run:

```
sudo apt update
sudo apt install hello
```

This IPFS node is not permanent and will disappear. To set it up again, use the
script in `scripts/add_test_mirror.sh`.

Made with :rainbow: by JáquerEspeis

Updated by mibofra to use the latest ipfshttpclient