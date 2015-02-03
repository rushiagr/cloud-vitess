# Create a vttablet by passing a number between 100 and 999
# NOTE: doesnt work now.

vttablet() {
    if [ -z $2 ]; then
        echo "Usage: vttablet master 100"
        exit 1
    fi

    /home/vagrant/bin/vttablet \
        -log_dir /home/vagrant/vtdataroot/tmp \
        -port 15$2 \
        -db-config-app-uname vt_app \
        -db-config-app-dbname vt_test_keyspace \
        -db-config-app-charset utf8 \
        -db-config-dba-uname vt_dba \
        -db-config-dba-charset utf8 \
        -db-config-repl-uname vt_repl \
        -db-config-repl-dbname vt_test_keyspace \
        -db-config-repl-charset utf8 \
        -db-config-filtered-uname vt_filtered \
        -db-config-filtered-dbname vt_test_keyspace \
        -db-config-filtered-charset utf8 \
        -tablet-path test-0000000$2 \
        -init_keyspace test_keyspace \
        -init_shard 0
        -target_tablet_type $1 \
        -enable-rowcache \
        -rowcache-bin /usr/bin/memcached \
        -rowcache-socket /home/vagrant/vtdataroot/vt_0000000$2/memcache.sock \
        > /home/vagrant/vtdataroot/vt_0000000$2/vttablet.out 2>&1 &

    disown -a
}

vdb() {
    # Usage: vdb 101
    # This will connect to vt_0000000101 tablet
    /usr/bin/mysql -u vt_dba -S /home/vagrant/vtdataroot/vt_0000000$1/mysql.sock
}

alias vc='vtctlclient -server localhost:15000'
