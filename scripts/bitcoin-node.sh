# one liner:
# curl -fsSL https://raw.githubusercontent.com/monxas/proxmox/develop/scripts/bitcoin-node.sh | sudo bash

#!/usr/bin/env bash
# Install & configure a Bitcoin Core full node on Ubuntu Server
# Data directory: /mnt/nfs_bitcoin (NFS mount strongly recommended to be reliable & fast; SSD-local is safer)
set -euo pipefail

# --- CONFIG ---
BITCOIN_USER="bitcoin"
DATA_ROOT="/mnt/nfs_bitcoin"
DATA_DIR="${DATA_ROOT}/bitcoin"
RPC_USER="rpcuser"
RPC_PASS="$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 32)"
TXINDEX="1"          # set "0" if you don't need txindex
PRUNE="0"            # set >0 (e.g. 550) to prune in GiB; keep 0 for full node
MAXCONN="64"
DBCACHE="700"        # tune based on RAM
# ---------------


if [[ $EUID -ne 0 ]]; then echo "Please run as root (sudo)." >&2; exit 1; fi

echo "[1/9] Verifying NFS mount at ${DATA_ROOT}..."
if ! findmnt -rn -S "$(stat -f -c %T "${DATA_ROOT}" 2>/dev/null || echo '')" >/dev/null 2>&1; then true; fi
if ! mountpoint -q "${DATA_ROOT}"; then
  echo "ERROR: ${DATA_ROOT} is not a mountpoint. Mount your NFS share there first." >&2
  exit 1
fi
# Basic sanity: ensure not mounted with 'nolock' (bad for LevelDB)
if findmnt -T "${DATA_ROOT}" | grep -qi "nolock"; then
  echo "ERROR: NFS is mounted with 'nolock'. Re-mount without it." >&2
  exit 1
fi

echo "[2/9] Installing dependencies & Bitcoin Core (from official PPA)..."
apt-get update -y
apt-get install -y software-properties-common gnupg ufw jq
add-apt-repository -y ppa:bitcoin/bitcoin
apt-get update -y
apt-get install -y bitcoind

echo "[3/9] Creating dedicated user and directories..."
id -u "${BITCOIN_USER}" >/dev/null 2>&1 || adduser --system --group --home /var/lib/bitcoind --disabled-login "${BITCOIN_USER}"
mkdir -p "${DATA_DIR}"
chown -R "${BITCOIN_USER}:${BITCOIN_USER}" "${DATA_ROOT}"

echo "[4/9] Writing bitcoin.conf at ${DATA_DIR}/bitcoin.conf ..."
cat > "${DATA_DIR}/bitcoin.conf" <<EOF
server=1
daemon=0
txindex=${TXINDEX}
prune=${PRUNE}
maxconnections=${MAXCONN}
dbcache=${DBCACHE}

# Networking
listen=1
port=8333
bind=0.0.0.0:8333
# If behind NAT, consider: externalip=<your.ip>

# RPC (local only)
rpcuser=${RPC_USER}
rpcpassword=${RPC_PASS}
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
rpcport=8332

# Logging
printtoconsole=1
logtimestamps=1

# ZMQ (optional)
# zmqpubrawblock=tcp://127.0.0.1:28332
# zmqpubrawtx=tcp://127.0.0.1:28333

# Performance / safety
par=0
assumevalid=
EOF
chown "${BITCOIN_USER}:${BITCOIN_USER}" "${DATA_DIR}/bitcoin.conf"
chmod 600 "${DATA_DIR}/bitcoin.conf"

echo "[5/9] Creating systemd service..."
cat > /etc/systemd/system/bitcoind.service <<'EOF'
[Unit]
Description=Bitcoin daemon
After=network-online.target nss-lookup.target
Wants=network-online.target
# Ensure the data mount is present before starting (adjust if different)
RequiresMountsFor=/mnt/nfs_bitcoin

[Service]
User=bitcoin
Group=bitcoin
Type=notify
ExecStart=/usr/bin/bitcoind -datadir=/mnt/nfs_bitcoin/bitcoin
ExecStop=/usr/bin/bitcoin-cli -datadir=/mnt/nfs_bitcoin/bitcoin stop
Restart=on-failure
TimeoutStopSec=600
PrivateTmp=true
NoNewPrivileges=true
ProtectSystem=full
ProtectHome=true
PrivateDevices=true
ReadWritePaths=/mnt/nfs_bitcoin/bitcoin

# Hardening (tune if needed)
CapabilityBoundingSet=
AmbientCapabilities=
LockPersonality=true
MemoryDenyWriteExecute=true

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload

echo "[6/9] Opening P2P port in UFW (8333/tcp) if UFW is active..."
if ufw status | grep -q "Status: active"; then
  ufw allow 8333/tcp || true
fi

echo "[7/9] Pre-flight check..."
echo "  - bitcoind version: $(bitcoind -version | head -n1)"
echo "  - Data dir: ${DATA_DIR}"
echo "  - Free space on ${DATA_ROOT}:"
df -h "${DATA_ROOT}" | tail -n+2

echo "[8/9] Enabling and starting bitcoind..."
systemctl enable bitcoind
systemctl start bitcoind

echo "[9/9] Waiting for initial RPC to become available..."
for i in {1..30}; do
  if sudo -u "${BITCOIN_USER}" bitcoin-cli -datadir="${DATA_DIR}" getblockchaininfo >/dev/null 2>&1; then break; fi
  sleep 2
done

echo "=== DONE ==="
echo "bitcoin.conf written at: ${DATA_DIR}/bitcoin.conf"
echo "Systemd service:        systemctl status bitcoind"
echo "RPC creds:              rpcuser=${RPC_USER} rpcpassword=${RPC_PASS}"
echo "Tip: tail -f /var/log/syslog | grep bitcoind   (or journalctl -u bitcoind -f)"
