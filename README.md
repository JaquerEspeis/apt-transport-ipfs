IPFS transport for apt

# Requirements

    sudo apt install python3-pip git
    sudo pip3 install ipfsapi
    sudo snap install ipfs
    ipfs init
    ipfs daemon &

# Install

Copy the ipfs file from this repo to the directory for apt transport methods:

    git clone https://github.com/JaquerEspeis/apt-transport-ipfs
    sudo mv ipfs /usr/lib/apt/methods/ipfs

# Configure

Add an IPFS mirror to your apt sources.list file. TODO set up a mirror.

# Hacky test

While we set up a proper IPFS mirror, this can be tested by using a hardcoded
IPFS hash that was manually set up to serve the hello deb.

Backup your /etc/apt/sources.list, remove all the lines that it has and leave it
just with:

    deb ipfs://QmTNL3t9h23ZUUSsRj1h4CaZ6SLQF6xFoLcve2gAMcLdWA xenial main

To test it, run:

    sudo apt update
    sudo apt install hello

This IPFS node is not permanent and will disappear. To set it up again, use the
script in `scripts/add_test_mirror.sh`.
