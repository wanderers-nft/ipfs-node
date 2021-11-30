IPFS_PATH=/opt/ipfs

# Check if volume exists
if [ ! -d "$IPFS_PATH" ]; then
  echo "Expected volume in $IPFS_PATH, but it could not be found. Attempting to create path now."
  mkdir -p /opt/ipfs
fi

if [ ! -d "$IPFS_PATH" ]; then
  echo "Path creation failed, exiting."
  exit 1
fi 

# Download IPFS
echo "Downloading IPFS"
wget https://dist.ipfs.io/ipfs-update/v1.7.1/ipfs-update_v1.7.1_linux-amd64.tar.gz
tar -xvzf ipfs-update_v1.7.1_linux-amd64.tar.gz -C /opt/ipfs/

sudo bash /opt/ipfs/ipfs-update/install.sh
ipfs-update --version
ipfs-update install latest
ipfs --version

# Set up IPFS
echo "Setting up IPFS daemon"
export IPFS_PATH="$IPFS_PATH"
ipfs init --profile server

# Start IPFS daemon
echo "Starting IPFS daemon"
systemctl enable ipfs
systemctl start ipfs

echo "Sleeping for a few seconds..."
sleep 5

# Pin files
# Wanderers Metadata
echo "Pinning metadata files, this will take about 60 seconds"
ipfs pin add QmNnWrwfAbsnWvyTgGpaYLdh1oAkBR5B74MjwZh8stTL97 --progress
# Wanderers Videos
echo "Pinning MP4 files, this is likely to take 4+ hours - make sure your terminal window doesn't time out!"
ipfs pin add QmWeXmth66wkCT5RYeBG9p1mnHgzAkTxoAtBdPy3CzE6o8 --progress
