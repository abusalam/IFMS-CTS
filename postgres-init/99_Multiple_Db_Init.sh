#!/bin/bash

set -e
set -u

function create_user_and_database() {
	local database=$1
	echo "  Creating user and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE USER $database;
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
EOSQL
}

function create_schema_and_tables() {
	local database=$1
	for sqlFile in /docker-entrypoint-initdb.d/*.sql; do
		echo "  Executing $sqlFile on '$database'"
		psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d $database -f $sqlFile
	done
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
		create_schema_and_tables $db
	done
	echo "Multiple databases created"
fi