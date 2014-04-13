#!/bin/bash

service mysqld start

/usr/sbin/httpd -D FOREGROUND

service mysqld stop
