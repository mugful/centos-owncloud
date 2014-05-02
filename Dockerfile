#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

FROM centos:6.4
MAINTAINER Jiri Stransky <jistr@jistr.com>

RUN yum -y update; yum clean all

ADD owncloud-install.sh /owncloud-install.sh
RUN /owncloud-install.sh
RUN rm /owncloud-install.sh

ADD etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf
ADD etc/supervisord.conf /etc/supervisord.conf
ADD usr/local/bin/mysqld_supervisor /usr/local/bin/mysqld_supervisor
ADD usr/local/bin/volume_permissions /usr/local/bin/volume_permissions

VOLUME ["/var/www/html/owncloud/apps", "/var/www/html/owncloud/config", "/var/www/html/owncloud/data", "/var/lib/mysql"]

EXPOSE 80
EXPOSE 443

CMD ["/usr/bin/supervisord"]
