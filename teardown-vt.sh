#! /bin/bash -x
cd ~/src/github.com/youtube/vitess/
. dev.env
#. ~/src/github.com/youtube/vitess/dev.env

# TODO(rushiagr): wait till all the processes are killed
pkill -u $USER -f $VTDATAROOT

sleep 2

rm -rf $VTDATAROOT/*
