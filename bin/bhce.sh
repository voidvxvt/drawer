#!/bin/sh

#sudo useradd bhce --no-create-home -s /usr/bin/nologin
uid=$(id -u)

sudo mkdir -p /opt/bhce
sudo chown -R $uid:$uid /opt/bhce
chmod 750 /opt/bhce
cd /opt/bhce

curl -sL 'https://ghst.ly/getbhce' > /opt/bhce/docker-compose.yml

echo 'BLOODHOUND_PORT=8181' > /opt/bhce/.env
echo 'BLOODHOUND_HOST=127.0.0.1' >> /opt/bhce/.env

docker compose pull

echo "[Unit]
Description=BloodHound CE Service
Requires=network.target docker.service
After=network.target docker.service
StartLimitIntervalSec=0

[Service]
Type=oneshot
RemainAfterExit=yes
User=$(whoami)
WorkingDirectory=/opt/bhce
ExecStart=/usr/bin/docker-compose up -d --remove-orphans
ExecStop=/usr/bin/docker-compose down

[Install]
WantedBy=multi-user.target" \
| sudo tee '/lib/systemd/system/bhce.service' > /dev/null

sudo systemctl daemon-reload
sudo systemctl start bhce

init_pass=''
while ! init_pass=$(docker compose logs | grep -oP '# Initial Password Set To:\ +\K[a-zA-Z0-9_]+'); do
    sleep 2
done

echo "http://127.0.0.1:8181/ui/login -> admin:$init_pass"
