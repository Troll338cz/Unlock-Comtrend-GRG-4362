# Boot into bare linux system

Requirement: The active image must be valid (it can even be locked stock because it bypasses authentication).

The version of the Linux kernel on this device is new enough to allow booting with init=/bin/bash without completely breaking.

Although it is currently not possible to obtain a working network from this mode, it can be used to manipulate the configuration and change the inactive image.



Activate:

```sh
TAURUS# setenv basicargs 'earlycon=serial,0xf43291b0 console=ttyS0,115200 init=/bin/bash'
TAURUS# saveenv
```

Deactivate:

```sh
TAURUS# setenv basicargs 'earlycon=serial,0xf43291b0 console=ttyS0,115200'
TAURUS# saveenv
```

Setup enviroment:

```sh
mount -t proc proc /proc 
mount -t sysfs sysfs /sys
mount -o size=64M -t tmpfs tmpfs /var/
mkdir /var/run
mkdir /var/tmp
mkdir /var/config
mount -t ubifs ubi0:ubi_Config /var/config/
```

Recover LAN access:

```sh
flash set SUSER_NAME root
flash set SUSER_PASSWORD root
flash set ACL_IP_TBL.0.any 0
flash set ACL_IP_TBL.0.telnet 1
flash set ACL_IP_TBL.0.web 1
flash set ACL_IP_TBL.0.https 1
flash set ACL_IP_TBL.0.ssh 1
flash set ACL_IP_TBL.0.icmp 1

flash set ACL_IP_TBL.1.ftp 0
flash set ACL_IP_TBL.1.tftp 0
flash set ACL_IP_TBL.1.web 0
flash set ACL_IP_TBL.1.https 0
flash set ACL_IP_TBL.1.ssh 0
flash set ACL_IP_TBL.1.icmp 0

# /config/run_customized_sdk.sh can be used to run commands on OS startup (When TR-142 module loads)
# Delay needed since /var is in too early stage at this point

cat <<EOF > /var/config/run_customized_sdk.sh
#!/bin/sh
echo -en '\x1b[41;33m ===> run_customized_sdk.sh executed! <=== \x1b[0m\n'
sleep 60 && sed -i 's/\/bin\/cli/\/bin\/sh/g' /var/passwd && cat /var/passwd && echo -en '\x1b[42;30m ===> CLI Unlock success! <=== \x1b[0m\n' &
exit 0

EOF
# After boot /etc/passwd will be modified to launch full shell

```
