#!/bin/bash -x
# =============================================
# Parameters
#

cwd=$PWD

systemctl stop radvd
cd /usr/share/nxp_iw612/bin_sdw61x
machine=$(uname -n)
release=$(uname -r)
if [[ ${machine} =~ "imx8mm" ]]; then
    echo "Machine Version: ${machine}"
    ./fw_loader_imx_lnx /dev/ttymxc2 115200 0 /lib/firmware/nxp/uartspi_n61x_v1.bin.mrk 3000000
fi
if [[ ${machine} =~ "imx93" ]]; then
    echo "Machine Version: ${machine}"
    ./fw_loader_imx_lnx /dev/ttyLP4 115200 0 /lib/firmware/nxp/uartspi_n61x_v1.bin.mrk 3000000
fi
insmod mlan.ko
insmod sdw61x.ko mod_para=/usr/share/nxp_iw612/bin_sdw61x/config/wifi_mod_para.conf

cd $cwd
