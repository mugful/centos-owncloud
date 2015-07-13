#!/bin/bash

set -euxo pipefail

OWNCLOUD_VERSION=$(cat /usr/local/share/owncloud/owncloud_version | tr -d '\n')

yum -y install wget epel-release

wget -O "/etc/yum.repos.d/isv:ownCloud:community:$OWNCLOUD_VERSION.repo" "http://download.opensuse.org/repositories/isv:/ownCloud:/community:/$OWNCLOUD_VERSION/CentOS_7/isv:ownCloud:community:$OWNCLOUD_VERSION.repo"

# check that version is correct
AVAILABLE_VERSION=$(yum info available owncloud | grep ^Version | awk '{ print $3 }' | awk -F. '{ print $1"."$2; }')
if [ "$OWNCLOUD_VERSION" != "$AVAILABLE_VERSION" ]; then
    echo "ERROR: Wanted ownCloud version $OWNCLOUD_VERSION, got version $AVAILABLE_VERSION"
    exit 1
fi

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common

yum -y install httpd mod_ssl postgresql-server php-gd php-pgsql owncloud screen supervisor tmux

# not present in centos image, mysql wants it to exist
touch /etc/sysconfig/network

# clean cache to keep the image small
yum clean all

# rm postgres data dir or postgres will fail to initialize
rmdir /var/lib/pgsql/data
