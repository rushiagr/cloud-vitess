#! /bin/bash -x

go version 2>&1 >/dev/null
if [ $? != 0 ]; then
    echo "Go is not installed or is not on \$PATH"
    exit 1
fi

git clone https://github.com/youtube/vitess.git ~/src/github.com/youtube/vitess
cd ~/src/github.com/youtube/vitess
export MYSQL_FLAVOR=MariaDB
./bootstrap.sh
. ./dev.env
make build
