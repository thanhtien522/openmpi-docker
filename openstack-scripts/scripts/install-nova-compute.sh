#!/bin/bash

yum install -y openstack-nova-compute sysfsutils

MY_IP=$(sh ../tools/getIPAddress.sh)

sed -i "/\[DEFAULT\]/a rpc_backend = rabbit\n\
auth_strategy = keystone\n\
my_ip = ${MY_IP}\n\
vnc_enabled = True\n\
vncserver_listen = 0.0.0.0\n\
vncserver_proxyclient_address = ${MY_IP}\n\
novncproxy_base_url = http://controller:6080/vnc_auto.html" /etc/nova/nova.conf

sed -i "/^\[oslo_messaging_rabbit\]$/a rabbit_host = controller\n\
rabbit_userid = openstack\n\
rabbit_password = ${RABBIT_PASS}" /etc/nova/nova.conf

sed -i "/\[keystone_authtoken\]/a auth_uri = http://controller:5000\n\
auth_url = http://controller:35357\n\
auth_plugin = password\n\
project_domain_id = default\n\
user_domain_id = default\n\
project_name = service\n\
username = nova\n\
password = ${NOVA_PASS}" /etc/nova/nova.conf

sed -i "/^\[glance\]/a host = controller" /etc/nova/nova.conf

sed -i "/^\[oslo_concurrency\]$/a lock_path = /var/lib/nova/tmp" /etc/nova/nova.conf

KVM_SUPPORT=$(sh ../tools/kvmSupport.sh)
if [ ${KVM_SUPPORT} -eq 0 ] 
	sed -i "/^\[libvirt\]$/a virt_type = qemu" /etc/nova/nova.conf
fi

systemctl enable libvirtd.service openstack-nova-compute.service
systemctl start libvirtd.service openstack-nova-compute.service




