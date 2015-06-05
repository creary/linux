#!/bin/bash

#自动检车重启apache
URL="http://127.0.0.1"
curlit()
{
curl --connect-timeout 15 --max-time 20 --head --silent "$URL" | grep '200'
}

doit()
{
if ! curlit; then
sleep 20
top -n 1 -b >> /var/log/apachemonitor.log
/usr/bin/killall -9 apache2 && /usr/bin/killall -9 php5-cgi && /usr/bin/killall -9 httpd && /usr/bin/killall -9 http && /usr/bin/killall -9 apache && /usr/bin/killall -9 php-cgi > /dev/null
sleep 2
/etc/init.d/apache2 start > /dev/null
#/etc/init.d/httpd restart > /dev/null
echo $(date) "Apache Restart" >> /var/log/apachemonitor.log
sleep 30
if ! curlit; then
echo $(date) "Failed! Now Reboot Computer!" >> /var/log/apachemonitor.log
#reboot
fi
sleep 180

echo $(date) "Apache Restart" >> /var/log/apachemonitor.log
fi
}

sleep 60
while true; do
doit > /dev/null
sleep 10
done
