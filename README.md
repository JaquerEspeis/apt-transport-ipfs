IPFS transport for apt

# Requirements

    sudo apt install python3 pip
    sudo pip3 install ipfsapi
    sudo snap install ipfs
    ipfs init
    ipfs daemon &

# Install

Copy the ipfs file from this repo to the directory for apt transport methods:

    sudo wget --output-document /usr/lib/apt/methods/ipfs https://raw.githubusercontent.com/JaquerEspeis/apt-transport-ipfs/master/ipfs
    sudo chmod +x /usr/lib/apt/methods/ipfs

# Configure

Add an IPFS mirror to your apt sources.list file. TODO set up a mirror.

# Hacky local test

While we set up a proper IPFS mirror, this can be tested by adding a bunch
of files:

    cd ~
    mkdir --parents test-archive/dists/xenial/
    cd test-archive/dists/xenial
    wget http://archive.ubuntu.com/ubuntu/dists/xenial/InRelease
    wget http://archive.ubuntu.com/ubuntu/dists/xenial/Release
    ipfs add --recursive ~/test-archive

The last line that this command returns will be something like:

    added {hash} test-archive

Now, add that hash to /etc/apt/source.list with the following form:

    deb ipfs://{hash} xenial main
