#! /bin/bash -x

cd ~/src/github.com/youtube/vitess/

. ./dev.env

cd ~/src/github.com/youtube/vitess/examples/local

./zk-up.sh

sleep 5

./vtctld-up.sh

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000

./vttablet-up.sh

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000 RebuildKeyspaceGraph test_keyspace

sleep 5


$VTROOT/bin/vtctlclient -server localhost:15000 ReparentShard -force test_keyspace/0 test-0000000100

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000 ListAllTablets test

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000 ApplySchemaKeyspace -simple -sql "$(cat create_test_table.sql)" test_keyspace
