# Check if volume exists
if [ ! -d "$1" ]; then
  echo "Expected volume in /mnt/$1, but it could not be found. Exiting"
  exit 1
fi

# Download IPFS
echo "Downloading IPFS"
wget https://dist.ipfs.io/ipfs-update/v1.7.1/ipfs-update_v1.7.1_linux-amd64.tar.gz
tar -xvzf ipfs-update_v1.7.1_linux-amd64.tar.gz
cd ipfs-update || exit
sudo bash install.sh
ipfs-update --version
ipfs-update install latest
ipfs --version

# Set up IPFS
echo "Setting up IPFS daemon"
export IPFS_PATH="$1"
ipfs init --profile server
echo "[Unit]
Description=IPFS Daemon

[Service]
ExecStart=/usr/local/bin/ipfs daemon
daemonUser=rootRestart=alwaysLimitNOFILE=10240
Environment=\"IPFS_PATH=$1\"

[Install]
WantedBy=multi-user.target" >>/etc/systemd/system/ipfs.service
sudo systemctl daemon-reload
sudo systemctl enable ipfs
sudo systemctl start ipfs

# Pin files
echo "Pinning files"
# Wanderers Metadata
ipfs pin add QmNnWrwfAbsnWvyTgGpaYLdh1oAkBR5B74MjwZh8stTL97 --progress
# Wanderers Videos
ipfs pin add QmWeXmth66wkCT5RYeBG9p1mnHgzAkTxoAtBdPy3CzE6o8 --progress
