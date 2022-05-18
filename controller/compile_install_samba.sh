yum install -y dnf-plugins-core
yum install -y epel-release
yum config-manager --set-enabled powertools -y
yum install -y \
    --setopt=install_weak_deps=False \
    "@Development Tools" \
    acl \
    attr \
    autoconf \
    avahi-devel \
    bind-utils \
    binutils \
    bison \
    ccache \
    chrpath \
    cups-devel \
    curl \
    dbus-devel \
    docbook-dtds \
    docbook-style-xsl \
    flex \
    gawk \
    gcc \
    gdb \
    git \
    glib2-devel \
    glibc-common \
    glibc-langpack-en \
    glusterfs-api-devel \
    glusterfs-devel \
    gnutls-devel \
    gpgme-devel \
    gzip \
    hostname \
    htop \
    jansson-devel \
    keyutils-libs-devel \
    krb5-devel \
    krb5-server \
    libacl-devel \
    libarchive-devel \
    libattr-devel \
    libblkid-devel \
    libbsd-devel \
    libcap-devel \
    libcephfs-devel \
    libicu-devel \
    libnsl2-devel \
    libpcap-devel \
    libtasn1-devel \
    libtasn1-tools \
    libtirpc-devel \
    libunwind-devel \
    libuuid-devel \
    libxslt \
    lmdb \
    lmdb-devel \
    make \
    mingw64-gcc \
    ncurses-devel \
    openldap-devel \
    pam-devel \
    patch \
    perl \
    perl-Archive-Tar \
    perl-ExtUtils-MakeMaker \
    perl-JSON \
    perl-Parse-Yapp \
    perl-Test-Simple \
    perl-generators \
    perl-interpreter \
    pkgconfig \
    popt-devel \
    procps-ng \
    psmisc \
    python3 \
    python3-cryptography \
    python3-devel \
    python3-dns \
    python3-gpg \
    python3-iso8601 \
    python3-libsemanage \
    python3-markdown \
    python3-policycoreutils \
    python3-pyasn1 \
    python3-setproctitle \
    quota-devel \
    readline-devel \
    redhat-lsb \
    rng-tools \
    rpcgen \
    rpcsvc-proto-devel \
    rsync \
    sed \
    sudo \
    systemd-devel \
    tar \
    tree \
    wget \
    which \
    xfsprogs-devel \
    yum-utils \
    zlib-devel

yum clean all
cd ~
wget https://download.samba.org/pub/samba/stable/samba-4.16.0.tar.gz
tar xzvf samba-4.16.0.tar.gz
cd samba-4.16.0
./configure --prefix=/opt/samba
make
make install

echo '[Unit]
Description=Samba PDC
After=syslog.target network.target 

[Service]
Type=forking
PIDFile=/opt/samba/var/run/samba.pid
ExecStart=/opt/samba/sbin/samba -D
ExecReload=/usr/bin/kill -HUP $MAINPID
ExecStop=/usr/bin/kill $MAINPID

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/samba.service

rm -f /etc/krb5.conf

echo 'PATH=/opt/samba/bin:/opt/samba/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin' >> /etc/environment