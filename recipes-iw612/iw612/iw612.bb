SUMMARY = "NXP IW612 stuffs for Matter"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://gpl-2.0.txt;md5=ab04ac0f249af12befccb94447c08b77"

SRC_URI = "file://gpl-2.0.txt file://bin_sdw61x file://scripts file://systemd_units file://FwImage"

S = "${WORKDIR}"

do_install () {
    install -d ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -d ${D}${datadir}/nxp_iw612/bin_sdw61x/config
    install -d ${D}${datadir}/nxp_iw612/scripts
    install -d ${D}${datadir}/nxp_iw612/scripts/config
    install -d ${D}/lib/systemd/system
    install -d ${D}/etc/systemd/system/multi-user.target.wants
    install -d ${D}/lib/firmware/nxp

    install -m 644 bin_sdw61x/version ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 644 bin_sdw61x/mlan.ko ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 644 bin_sdw61x/sdw61x.ko ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 755 bin_sdw61x/fw_loader_imx_lnx ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 755 bin_sdw61x/mlanutl ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 755 bin_sdw61x/uaputl.exe ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 644 bin_sdw61x/README ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 644 bin_sdw61x/README_MLAN ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 644 bin_sdw61x/README_UAP ${D}${datadir}/nxp_iw612/bin_sdw61x
    install -m 644 bin_sdw61x/config/* ${D}${datadir}/nxp_iw612/bin_sdw61x/config
    install -m 755 scripts/*.sh ${D}${datadir}/nxp_iw612/scripts
    install -m 644 scripts/config/* ${D}${datadir}/nxp_iw612/scripts/config
    install -m 644 systemd_units/* ${D}/lib/systemd/system
    ln -s -r ${D}/lib/systemd/system/iw612-driver.service ${D}/etc/systemd/system/multi-user.target.wants/iw612-driver.service
    ln -s -r ${D}/lib/systemd/system/iw612-client.service ${D}/etc/systemd/system/multi-user.target.wants/iw612-client.service
    ln -s -r ${D}/lib/systemd/system/iw612-otbr.service ${D}/etc/systemd/system/multi-user.target.wants/iw612-otbr.service
    ln -s -r ${D}/lib/systemd/system/radvd.service ${D}/etc/systemd/system/multi-user.target.wants/radvd.service
    install -m 444 FwImage/* ${D}/lib/firmware/nxp
    ln -s -r ${D}/lib/firmware/nxp/sduart_nw61x_v1.bin.se ${D}/lib/firmware/nxp/sduart_nw61x_v1.bin
    ln -s -r ${D}/lib/firmware/nxp/sd_w61x_v1.bin.se ${D}/lib/firmware/nxp/sd_w61x_v1.bin
    ln -s -r ${D}/lib/firmware/nxp/uartspi_n61x_v1.bin.se ${D}/lib/firmware/nxp/uartspi_n61x_v1.bin
    ln -s -r ${D}${datadir}/nxp_iw612/bin_sdw61x/config/WlanCalData_ext_RD-IW61x-QFN-IPA-2A_V2_without_diversity.conf ${D}/lib/firmware/nxp/WlanCalData_ext_IW612.conf
}

INHIBIT_PACKAGE_STRIP = "1"

FILES:${PN} = "${datadir}/nxp_iw612/bin_sdw61x ${datadir}/nxp_iw612/scripts /etc/systemd/system /lib/firmware/nxp /lib/systemd/system"

RDEPENDS:${PN} = "bash"

RRECOMMENDS:${PN} = "wireless-tools"
