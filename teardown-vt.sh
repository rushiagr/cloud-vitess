#! /bin/bash -x

. ~/src/github.com/youtube/vitess/dev.env

pkill -u $USER -f $VTDATAROOT

rm -rf $VTDATAROOT/*
