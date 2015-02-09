#! /bin/bash -x

cd ~/src/github.com/youtube/vitess/

. ./dev.env

cd ~/src/github.com/youtube/vitess/examples/local

./zk-up.sh

./vtctld-up.sh

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000

./twoshards/vttablet-up.sh

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000 RebuildKeyspaceGraph test_keyspace

sleep 5


$VTROOT/bin/vtctlclient -server localhost:15000 ReparentShard -force test_keyspace/-80 test-0000000100

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000 ReparentShard -force test_keyspace/80- test-0000000200

sleep 5

$VTROOT/bin/vtctlclient -server localhost:15000 ListAllTablets test
$VTROOT/bin/vtctlclient -server localhost:15000 SetKeyspaceShardingInfo -force test_keyspace keyspace_id uint64

sleep 2

$VTROOT/bin/vtctlclient -server localhost:15000 RebuildKeyspaceGraph test_keyspace

#sleep 2

$VTROOT/bin/vtctlclient -server localhost:15000 ApplySchemaKeyspace -simple -sql "$(cat twoshards/new_table.sql)" test_keyspace

sleep 2

./vtgate-up.sh

sleep 10

./twoshards/client.sh --server=localhost:15001
