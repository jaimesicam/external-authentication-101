#!/bin/bash

rm -fvr /var/lib/googleusers/*
mkdir -p /var/lib/googleusers/postgres/dbauser01
mkdir -p /var/lib/googleusers/mongod/dbauser01
mkdir -p /var/lib/googleusers/mysql/dbauser01

chmod 0600 /root/.google_authenticator
cp -p /root/.google_authenticator /var/lib/googleusers/postgres/dbauser01
cp -p /root/.google_authenticator /var/lib/googleusers/mongod/dbauser01
cp -p /root/.google_authenticator /var/lib/googleusers/mysql/dbauser01
chown -R postgres:postrgres /var/lib/googleusers/postgres
chown -R mongod:mongod /var/lib/googleusers/mongod
chown -R mysql:mysql /var/lib/googleusers/mysql
