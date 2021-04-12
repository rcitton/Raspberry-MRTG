# Raspberry-MRTG
Raspberry PI 4 monitoring with complete graphs.
---------------------------------
![alt tag](https://github.com/rcitton/Raspberry-MRTG/blob/master/Printscreen.png)

Setup:
------
First, update your package list:
```
sudo apt-get update
```
Then download and install MRTG:
-------------------------------
```
sudo apt-get install mrtg
sudo apt-get install bc
sudo apt-get install lynx
sudo apt-get install ntpdate
sudo apt-get install jq
sudo apt-get install tcpdump
```
Change directory:
-----------------
```
cd /tmp
```
Clone all file's:
-----------------
```
git clone https://github.com/rcitton/Raspberry-MRTG
```

```
cd Raspberry-MRTG
sudo mkdir -p /etc/mrtg
sudo cp -r . /etc/mrtg/.
cd /etc/mrtg
```

Adding SNMP support for CPU temperature monitoring
---------------------------
```
sudo cp snmp-cpu-temp /usr/local/bin
```
edit the SNMP daemon configuration to tell it how to handle this OID.  Edit the file: 'snmpd.conf' and just below the sample ""Pass-through" MIB extension command"  lines, insert a new active "pass" command:
```
pass .1.3.6.1.2.1.25.1.8 /bin/sh /usr/local/bin/snmp-cpu-temp
```
Restart snmpd:
```
sudo service snmpd restart
```
and you can then test that it's all working with the command:
```
$ snmpget -v 2c localhost -c public .1.3.6.1.2.1.25.1.8
```
You should get something like:
```
iso.3.6.1.2.1.25.1.8 = Gauge32: 41868
```

Run the following commands:
---------------------------
```
sudo mkdir /var/www/html/mrtg
sudo indexmaker --output=/var/www/html/mrtg/index.html /etc/mrtg/mrtg.cfg
```
Open '/etc/lighttpd' and append/add mod_alias to list of server modules:
-----------------------------------------------------------------------------------------------------------------
```
server.modules += ( "mod_alias" )
```
add mrgt alias:
```
alias.url += ("/mrtg" => "/var/www/html/mrtg/" )
```
Set MRTG as service, issuing the following commands:
---------------------------
```
sudo cp mrtg.service /lib/systemd/system/mrtg.service
sudo systemctl enable mrtg
sudo systemctl start mrtg
```
Resart lighttpd:
---------------------------
```
service lighttpd restart
```
