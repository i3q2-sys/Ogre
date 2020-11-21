export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt-get install -y git build-essential automake libevent-dev libssl-dev zlib1g-dev python3.8 pkg-config liblzma-dev libzstd-dev
git clone https://gitlab.com/torproject/tor.git
cp config/auths_dir.inc tor/src/app/config/auth_dirs.inc
cd /home/ubuntu/PTN/docker/tor && ./autogen.sh
cd /home/ubuntu/PTN/docker/tor && ./configure --disable-asciidoc && make
cd /home/ubuntu/PTN/docker/tor && sudo make install
cd /home/ubuntu/PTN/docker && sudo cp config/torrc_middle /usr/local/etc/tor/torrc
mkdir /home/ubuntu/log
mkdir /home/ubuntu/.tor
mkdir /home/ubuntu/.tor/keys
cd /home/ubuntu/.tor/keys && cat test | tor-gencert -v --create-identity-key --passphrase-fd test

