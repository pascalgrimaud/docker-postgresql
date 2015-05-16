#!/bin/bash

echo "Starting container : PostgreSQL Server ${PG_VERSION}"

PG_HOME="/var/lib/postgresql"
PG_CONFDIR="/etc/postgresql/${PG_VERSION}/main"
PG_BINDIR="/usr/lib/postgresql/${PG_VERSION}/bin"
PG_DATADIR="${PG_HOME}/${PG_VERSION}/main"

sudo chown -R postgres:postgres /var/lib/postgresql/

# initialize PostgreSQL data directory
if [ ! -d ${PG_DATADIR} ]; then
	echo "Initializing database..."
	sudo -u postgres -H "${PG_BINDIR}/initdb" \
		--pgdata="${PG_DATADIR}" \
		--username=postgres \
		--encoding=unicode \
		--lc-collate='en_US.UTF-8' \
		--lc-ctype='en_US.UTF-8' \
		--auth=trust >/dev/null
	echo "Initializing database : done!"
fi

# change the password
if [ ! -f ${PG_HOME}/${PG_VERSION}/.postgres_set_password ]; then
	echo "Initializing the 'postgres' user password..."

	# start service
	service postgresql start >/dev/null 2>&1
	# generate password
	PASS=${POSTGRES_PASS:-$(date +%s | sha256sum | base64 | head -c 16 ; echo)}
	# change password
	sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password '$PASS';" >/dev/null 2>&1
	touch ${PG_HOME}/${PG_VERSION}/.postgres_set_password
	# stop service
	service postgresql stop >/dev/null 2>&1

	echo "Initializing the 'postgres' user password : done!"
fi

# display info
echo ""
echo "######################################################################"
echo "You can now connect to this PostgreSQL Server using :"
echo ""
echo "    psql -h <host> -p <port> -U postgres"
if [ ! -d ${PASS} ]; then
	echo "    and enter the password '$PASS' when prompted"
	echo ""
	echo "Please remember to change the above password as soon as possible!"
else
	echo "    and enter the password when prompted"
fi
echo ""
echo "######################################################################"
echo ""

# start PostgreSQL 
sudo -u postgres ${PG_BINDIR}/postgres -D ${PG_DATADIR} -c config_file=${PG_CONFDIR}/postgresql.conf
