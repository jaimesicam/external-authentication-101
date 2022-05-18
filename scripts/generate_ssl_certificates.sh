#!/bin/bash

echo "Placing common entries in variables"
dn_prefix="/C=US/ST=NC/L=Durham/O=Percona"
domain="percona.local"
dn_ad_domain="/DC=Local/DC=Percona/CN=users"
dn_ldap_domain="/DC=Local/DC=Percona/OU=users"
server_hosts=( "samba:192.168.56.51" "ldap:192.168.56.52" "mysql1:192.168.56.53" "mysql2:192.168.56.54" "mysql3:192.168.56.55" "mongodb1:192.168.56.56" "mongodb2:192.168.56.57" "mongodb3:192.168.56.58" "postgres1:192.168.56.59" "postgres2:192.168.56.60" "postgres3:192.168.56.61" "pmm1:192.168.56.62" )
dn_mongodb_users=( "client1" "client2" "dbauser01" "dbauser02" "dbauser03" "devuser01" "devuser02" "devuser03" "search" )
expiry=3650
key_size=4096

echo -e "Remove existing keys, csr and certs\n"
rm -fvr ssl/pem
rm -fvr ssl/csr
rm -fvr ssl/mongodb
rm -fvr ssl/config

echo -e "Create SSL directories if they do not exist\n"
mkdir -p ssl/pem
mkdir -p ssl/csr
mkdir -p ssl/mongodb
mkdir -p ssl/config

echo -e "Create root-ca\n"
openssl genrsa -out ssl/pem/root-ca-key.pem $key_size
openssl req -new -x509 -days $expiry -key ssl/pem/root-ca-key.pem -out ssl/pem/root-ca-cert.pem  -config ssl/openssl.cnf -subj "$dn_prefix/CN=ROOTCA"


echo -e "Create signing-ca\n"
openssl genrsa -out ssl/pem/signing-ca-key.pem $key_size
openssl req -new -key ssl/pem/signing-ca-key.pem -out ssl/csr/signing-ca.csr -config ssl/openssl.cnf -subj "$dn_prefix/CN=CA-SIGNER"
openssl x509 -req -days $expiry -in ssl/csr/signing-ca.csr -CA ssl/pem/root-ca-cert.pem -CAkey ssl/pem/root-ca-key.pem -set_serial 01 -out ssl/pem/signing-ca-cert.pem -extfile ssl/openssl.cnf -extensions v3_ca

echo -e "Generating PEM files for CA bundle in pem directory\n"
cat ssl/pem/root-ca-cert.pem > ssl/pem/ca-bundle.pem
cat ssl/pem/signing-ca-cert.pem >> ssl/pem/ca-bundle.pem

echo -e "Generating certificates for servers\n"
for host_ip in "${server_hosts[@]}"; do
  host=`echo $host_ip|cut -d ':' -f1`
  ip=`echo $host_ip|cut -d ':' -f2`
  echo "Generating key/cert for $host $ip"
  cp ssl/server.cnf ssl/config/$host.cnf
  echo "DNS.1 = ${host}.${domain}" >> ssl/config/$host.cnf
  echo "IP.1 = ${ip}" >> ssl/config/$host.cnf
  openssl genrsa -out ssl/pem/${host}-key.pem $key_size
  openssl req -new -key ssl/pem/${host}-key.pem -out ssl/csr/${host}.csr -config ssl/config/$host.cnf -reqexts v3_req -subj "${dn_prefix}/CN=${host}.${domain}"
  openssl x509 -req -days $expiry -in ssl/csr/${host}.csr -CA ssl/pem/signing-ca-cert.pem -CAkey ssl/pem/signing-ca-key.pem -CAcreateserial -out ssl/pem/${host}-cert.pem -extfile ssl/config/$host.cnf -extensions v3_req 
done

echo -e "Generating certificates for clients\n"

for host in "${dn_mongodb_users[@]}"; do
  echo -e "Generating MongoDB AD key/cert for $host\n"
  openssl genrsa -out ssl/pem/${host}-ad-key.pem $key_size
  openssl req -new -key ssl/pem/${host}-ad-key.pem -out ssl/csr/${host}.ad.csr -config ssl/client.cnf -subj "${dn_ad_domain}/CN=${host}"
  openssl x509 -req -days $expiry -in ssl/csr/${host}.ad.csr -CA ssl/pem/signing-ca-cert.pem -CAkey ssl/pem/signing-ca-key.pem -CAcreateserial -out ssl/pem/${host}-ad-cert.pem -extfile ssl/client.cnf -extensions v3_req
  cat ssl/pem/${host}-ad-cert.pem > ssl/mongodb/${host}-ad.pem
  cat ssl/pem/${host}-ad-key.pem >> ssl/mongodb/${host}-ad.pem
done

for host in "${dn_mongodb_users[@]}"; do
  echo -e "Generating OpenLDAP key/cert for $host\n"
  openssl genrsa -out ssl/pem/${host}-ldap-key.pem $key_size
  openssl req -new -key ssl/pem/${host}-ldap-key.pem -out ssl/csr/${host}.ldap.csr -config ssl/client.cnf -subj "${dn_ldap_domain}/CN=${host}"
  openssl x509 -req -days $expiry -in ssl/csr/${host}.ldap.csr -CA ssl/pem/signing-ca-cert.pem -CAkey ssl/pem/signing-ca-key.pem -CAcreateserial -out ssl/pem/${host}-ldap-cert.pem -extfile ssl/client.cnf -extensions v3_req
  cat ssl/pem/${host}-ldap-cert.pem > ssl/mongodb/${host}-ldap.pem
  cat ssl/pem/${host}-ldap-key.pem >> ssl/mongodb/${host}-ldap.pem
done

echo -e "Generate PMM dhparam"
openssl dhparam -out ssl/pem/pmm-dhparam.pem 1024


