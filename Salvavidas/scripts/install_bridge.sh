export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt-get install -y git obfs4proxy
sudo apt-get install tor
sudo setcap cap_net_bind_service=+ep /user/bin/obfs4proxy
cd ../config && sudo cp torrc_bridge /usr/local/etc/tor/torrc

