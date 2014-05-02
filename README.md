
Build
-----

    docker build -t 'myname/el6-owncloud:latest' .

Run
---

    docker run -p 8000:80 -v /home/myname/tmp/owncloud/apps:/var/www/html/owncloud/apps  -v /home/myname/tmp/owncloud/config:/var/www/html/owncloud/config  -v /home/myname/tmp/owncloud/data:/var/www/html/owncloud/data -v /home/myname/tmp/owncloud/mysql:/var/lib/mysql myname/el6-owncloud
