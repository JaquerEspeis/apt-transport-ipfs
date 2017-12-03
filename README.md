IPFS transport for apt

# Requirements

    sudo apt install python3 pip
    sudo pip3 install ipfsapi
    sudo snap install ipfs
    ipfs init
    ipfs daemon &

# Install

Copy the ipfs file from this repo to the directory for apt transport methods:

    sudo wget --output-file /usr/lib/apt/methods/ipfs https://raw.githubusercontent.com/JaquerEspeis/apt-transport-ipfs/master/ipfs
    sudo chmod +x /usr/lib/apt/methods/ipfs

# Configure

Add an IPFS mirror to your apt sources.list file. TODO set up a mirror.
