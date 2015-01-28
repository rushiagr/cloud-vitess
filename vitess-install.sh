#! /bin/bash -ux

if [ -z "$(ls | grep go1.4.1.linux-amd64.tar.gz)" ]; then
    wget https://storage.googleapis.com/golang/go1.4.1.linux-amd64.tar.gz
fi
sudo tar -C /usr/local/ -xzf go1.4.1.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" | sudo tee -a /etc/profile

sudo -E apt-get install -y software-properties-common
sudo -E apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo -E add-apt-repository 'deb http://mariadb.bytenet.in//repo/10.0/ubuntu trusty main'

sudo -E apt-get update
sudo -E apt-get install -y mariadb-server

sudo -E apt-get install -y libmariadbclient-dev

sudo -E apt-get install -y openjdk-7-jre

sudo -E apt-get install -y make automake libtool memcached python-dev python-mysqldb libssl-dev g++ mercurial git pkg-config bison curl
