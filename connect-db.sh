#!/bin/bash

connection_db() {
    password='cuongdm250701'
    port=5432
    host='localhost'
    user='postgres'
    database_name='kasumi'

    # Setting password
    export PGPASSWORD=${password}

    # Excute connection
    query=$(psql -h ${host} -U ${user} -p ${port} -d ${database_name} -c "select 1;" 2>/dev/null)

    # Check connection
    if [ $? -eq 0 ]; then
        echo "Connect ok"
    else
        echo "Connect fail"
    fi
}

