#!/bin/bash -x
# =============================================
# Parameters
#
machine=$(uname -n)
release=$(uname -r)
if [[ ${machine} =~ "imx8mm" ]]; then
    echo -n 30b50000.mmc > /sys/bus/platform/drivers/sdhci-esdhc-imx/unbind
    sleep 1
    echo -n 30b50000.mmc > /sys/bus/platform/drivers/sdhci-esdhc-imx/bind
fi


