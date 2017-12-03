IPFS transport for apt

# Requirements

    sudo apt install python3 pip
    sudo pip3 install ipfsapi

# Install

Copy the ipfs file from this repo to the directory for apt transport methods:

    sudo wget --output-file /usr/lib/apt/methods/ipfs https://raw.githubusercontent.com/JaquerEspeis/apt-transport-ipfs/master/ipfs

# Configure

Add to your apt sources.list file an IPFS mirror. TODO set up a mirror.
