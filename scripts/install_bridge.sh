export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt-get install -y git obfs4proxy
sudo apt-get install -y tor
sudo setcap cap_net_bind_service=+ep /usr/bin/obfs4proxy
sudo cp ~/torrc_bridge /etc/tor/torrc
sudo systemctl stop tor
sleep 5
nohup tor &
sleep 5
