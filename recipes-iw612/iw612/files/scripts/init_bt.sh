#!/bin/bash -x
# =============================================
# Parameters
#

function init_bt()
{
    if [ $direct3M == 0 ]; then
        hciattach ${bt_devif} any -s 115200 115200 flow dtron
        hciconfig hci0 up
        hcitool -i hci0 cmd 0x3f 0x0009 0xc0 0xc6 0x2d 0x00
        killall hciattach
    fi
    hciattach /dev/${bt_devif} any -s 3000000 3000000 flow dtron
    sleep 1
    hciconfig hci0 up
}

cwd=$PWD

while [ ! -d /proc/mwlan/adapter0 ]
do
    sleep 1
done
sleep 1

machine=$(uname -n)
release=$(uname -r)
if [[ ${machine} =~ "imx8mm" ]]; then
    echo "Machine Version: ${machine}"
    bt_devif=ttymxc2
fi
if [[ ${machine} =~ "imx93" ]]; then
    echo "Machine Version: ${machine}"
    bt_devif=ttyLP4
fi

cd /usr/share/nxp_iw612/scripts
source config/init_bt.ini
init_bt

cd $cwd
