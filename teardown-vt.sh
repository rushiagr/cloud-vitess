#! /bin/bash -x
cd ~/src/github.com/youtube/vitess/
. dev.env
#. ~/src/github.com/youtube/vitess/dev.env

# TODO(rushiagr): wait till all the processes are killed
pkill -u $USER -f $VTDATAROOT

sleep 2

rm -rf $VTDATAROOT/*

sleep 2

sudo kill -9 $(ps aux | grep vttablet | awk '{print $2}')
