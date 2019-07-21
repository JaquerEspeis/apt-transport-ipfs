#!/bin/bash

mkdir --parents test-archive/dists/bionic/main/binary-amd64/by-hash/SHA256/
mkdir --parents test-archive/dists/bionic/main/i18n/
mkdir --parents test-archive/pool/main/h/hello/

wget --directory-prefix=test-archive/dists/bionic/ http://archive.ubuntu.com/ubuntu/dists/bionic/InRelease
wget --directory-prefix=test-archive/dists/bionic/ http://archive.ubuntu.com/ubuntu/dists/bionic/Release
wget --directory-prefix=test-archive/dists/bionic/main/binary-amd64/by-hash/SHA256/ http://archive.ubuntu.com/ubuntu/dists/bionic/main/binary-amd64/by-hash/SHA256/76858a337b1665561a256cea6f7ef32515517754e3c5e54c1895cf29e1b41884
wget --directory-prefix=test-archive/dists/bionic/main/binary-amd64/ http://archive.ubuntu.com/ubuntu/dists/bionic/main/binary-amd64/Packages.xz
wget --directory-prefix=test-archive/dists/bionic/main/i18n/ http://archive.ubuntu.com/ubuntu/dists/bionic/main/i18n/Translation-en.xz
wget --directory-prefix=test-archive/pool/main/h/hello/ http://archive.ubuntu.com/ubuntu/pool/main/h/hello/hello_2.10-1_amd64.deb

hash="$(ipfs add --quiet --recursive test-archive | tail -n1)"
ipfs name publish "$hash"
