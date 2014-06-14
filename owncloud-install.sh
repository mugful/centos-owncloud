#!/bin/bash

set -euxo pipefail

yum -y install wget

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

wget -O /etc/yum.repos.d/isv:ownCloud:community.repo http://download.opensuse.org/repositories/isv:/ownCloud:/community/CentOS_CentOS-6/isv:ownCloud:community.repo

yum -y install httpd mod_ssl mysql-server owncloud supervisor

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common

# not present in centos image, mysql wants it to exist
touch /etc/sysconfig/network

# clean cache to keep the image small
yum clean all
