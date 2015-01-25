#!/bin/sh

#nvram set ss_enable=1
#nvram set ss_server=11.11.11.11
#nvram set ss_server_port=1111
#nvram set ss_password=aaaa
#nvram set ss_method=aes-256-cfb
#nvram commit

SS_ENABLE=`nvram get ss_enable`

if [ "$SS_ENABLE" != "1" ]; then
	rm -f /jffs/configs/dnsmasq.conf.add
	return 0
fi

cp /rom/etc/dnsmasq.conf.add /jffs/configs/dnsmasq.conf.add
cp /rom/etc/nat-start /jffs/scripts/
chmod a+rx /jffs/scripts/nat-start

