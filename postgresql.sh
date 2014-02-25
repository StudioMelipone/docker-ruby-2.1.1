#!/bin/sh
chown postgres:postgres -R /var/lib/postgresql
if find /var/lib/postgresql -maxdepth 0 -empty | read v; then
  pg_dropcluster 9.1 main
  pg_createcluster -e UTF8 9.1 main
fi
/etc/init.d/postgresql start
