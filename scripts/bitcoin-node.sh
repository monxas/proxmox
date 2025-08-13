#!/usr/bin/env bash
set -euo pipefail

# --- Config ---
BITCOIN_VERSION="29.0" # Change to latest
DATA_DIR="/mnt/nfs_bitcoin/bitcoin"

# --- Install deps ---
sudo apt-get update
sudo apt-get install -y wget tar gnupg

# --- Download & verify Bitcoin Core ---
wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz
wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS
wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc
sha256sum --check --ignore-missing SHA256SUMS

# Optional: Verify signature (requires Bitcoin Core PGP key)
# gpg --keyserver keyserver.ubuntu.com --recv-keys 01EA5486DE18A882D4C2684590C8019E36C2E964
# gpg --verify SHA256SUMS.asc SHA256SUMS

# --- Install Bitcoin Core ---
tar -xzf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz
sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-${BITCOIN_VERSION}/bin/*

# --- Create data dir ---
sudo mkdir -p "$DATA_DIR"
sudo chown -R "$USER":"$USER" "$DATA_DIR"

# --- Create bitcoin.conf ---
cat > "$DATA_DIR/bitcoin.conf" <<EOF
server=1
daemon=1
txindex=1
prune=0
maxconnections=64
rpcuser=rpcuser
rpcpassword=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 32)
EOF

# --- Run Bitcoin Core ---
bitcoind -datadir="$DATA_DIR"

echo "Bitcoin Core started. Data directory: $DATA_DIR"
