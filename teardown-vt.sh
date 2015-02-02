#! /bin/bash -x

. ~/src/github.com/youtube/vitess/dev.env

# TODO(rushiagr): wait till all the processes are killed
pkill -u $USER -f $VTDATAROOT

rm -rf $VTDATAROOT/*
