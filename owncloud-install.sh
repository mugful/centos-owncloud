#!/bin/bash

set -euxo pipefail

OWNCLOUD_VERSION=$(cat /usr/local/share/owncloud/owncloud_major_version | tr -d '\n')

yum -y install wget

rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm

wget -O "/etc/yum.repos.d/isv:ownCloud:community:$OWNCLOUD_VERSION.0.repo" "http://download.opensuse.org/repositories/isv:/ownCloud:/community:/$OWNCLOUD_VERSION.0/CentOS_CentOS-7/isv:ownCloud:community:$OWNCLOUD_VERSION.0.repo"

# check that version is correct
AVAILABLE_VERSION=$(yum info available owncloud | grep ^Version | awk '{ print $3 }' | awk -F. '{ print $1; }')
if [ "$OWNCLOUD_VERSION" != "$AVAILABLE_VERSION" ]; then
    echo "ERROR: Wanted ownCloud version $OWNCLOUD_VERSION, got version $AVAILABLE_VERSION"
    exit 1
fi

yum -y install httpd mod_ssl mariadb-galera-server owncloud supervisor

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common

# not present in centos image, mysql wants it to exist
touch /etc/sysconfig/network

# clean cache to keep the image small
yum clean all
