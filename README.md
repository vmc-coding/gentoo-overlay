# gentoo-overlay
Custom Gentoo ebuilds

Usage
-----
Add this overlay to a gentoo linux by creating file `/etc/portage/repos.conf/vmc.conf`:
```
[vmc]
location = /var/db/repos/vmc
sync-type = git
sync-uri = https://github.com/vmc-coding/vmc-gentoo-overlay.git
```

Packages
--------
* tbs6281se-modules: 
Kernel modules for TurboSight TBS 6281SE DVB-T/T2/C (DVB-T/DVB-T2 PCIe card). <br><br>
You'll also need the [firmware](http://www.tbsdtv.com/download/document/linux/tbs-tuner-firmwares_v1.0.tar.bz2) for Silicon Labs Si2168-B40 (dvb-demod-si2168-b40-01.fw) and Silicon Labs Si2147/2148/2157/2158 (dvb-tuner-si2158-a20-01.fw).<br><br>
For more details, see:  
[Wiki from LinuxTV](https://linuxtv.org/wiki/index.php/TBS6281) <br> 
[Wiki from vendor](https://github.com/tbsdtv/linux_media/wiki)
