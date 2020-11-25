export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt-get install -y git obfs4proxy
sudo apt-get install -y tor
sudo setcap cap_net_bind_service=+ep /usr/bin/obfs4proxy
cd ../config && sudo cp torrc_bridge /etc/tor/torrc

