#!/bin/bash
#
# Copyright (C) 2018, 2019 JaquerEspeis
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Make a full sync of an Ubuntu mirror.
# This currently requires more than 1TB of storage space and takes a long time.
# Arguments:
#   storage-dir: The directory where the mirror files will be stored.

set -e

if [ "$#" -ne 1 ]; then
	echo "Usage: "$0" <storage-dir>"
	exit 1
fi

IPFS="/snap/bin/ipfs"
export IPFS_PATH="/media/data/.ipfs"
export IPFS_FD_MAX="4096"

dir="$1"

# Two stage sync of the main Ubuntu mirror.
# More info and options in https://wiki.ubuntu.com/Mirrors/Scripts.
echo "Synchronizing with the main Ubuntu mirror, stage 1."
rsync --recursive --times --links --safe-links --hard-links --stats --exclude "Packages*" --exclude "Sources*" --exclude "Release*" --exclude "InRelease"   rsync://archive.ubuntu.com/ubuntu "${dir}"
echo "Synchronizing with the main Ubuntu mirror, stage 2."
rsync --recursive --times --links --safe-links --hard-links   --stats --delete --delete-after rsync://archive.ubuntu.com/ubuntu "${dir}"

# Publish the files on IPFS.
# This uses the experimental filestore:
# https://github.com/ipfs/go-ipfs/issues/3397#issuecomment-284337564
$IPFS config --json Experimental.FilestoreEnabled true

# Tips for adding large datasets from:
# https://github.com/ipfs/notes/issues/212
$IPFS config --json Datastore.NoSync true
$IPFS config Reprovider.Interval "0"
$IPFS config --json Experimental.ShardingEnabled true

echo "Adding the mirror files to IPFS."
hash="$($IPFS add --progress --offline --nocopy --fscache --quieter --recursive "${dir}" | tail -n1)"
echo "Published IPFS hash ${hash}."
echo "Updating IPNS."
ipns="$($IPFS name publish "${hash}" | cut -d ' ' -f 3 | tr -d ':')"
echo "IPFS Mirror synchronized."
echo "Add the address 'ipfs:/ipns/${ipns}' to your '/etc/apt/sources.list'."
echo "For example, add 'deb ipfs:/ipns/${ipns} xenial main' if you are in Ubuntu 16.04, and you want to use IPFS to get updates from the main archive."
