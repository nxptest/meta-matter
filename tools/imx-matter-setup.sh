if [ ! -n "$MACHINE" ]; then
    MACHINE=imx8mmevk
fi
if [ ! -n "$OT_RCP_BUS" ]; then
    OT_RCP_BUS=UART
fi
echo "MACHINE = $MACHINE"
echo "OT_RCP_BUS = $OT_RCP_BUS"

echo "========= Will setup Matter build dependency ========"
python3 -m venv matter_venv
source matter_venv/bin/activate
wget -O /tmp/constraints.txt https://raw.githubusercontent.com/project-chip/connectedhomeip/v1.1.0.1/scripts/setup/constraints.txt
pip install -r /tmp/constraints.txt
CURRENT_DIR=$(pwd)
MATTER_PYTHON_PATH="$CURRENT_DIR/matter_venv/bin/python3"

EULA=$EULA DISTRO=$DISTRO MACHINE=$MACHINE . ./imx-setup-release.sh -b $@

if [ "$OT_RCP_BUS" = "SPI" ]; then
    echo "OT_RCP_BUS = \"SPI\"" >> conf/local.conf
fi
if [ "$OT_RCP_BUS" = "UART" ]; then
    echo "OT_RCP_BUS = \"UART\"" >> conf/local.conf
fi
 
echo "# layers for i.MX IoT for MATTER & OpenThread Border Router" >> conf/bblayers.conf
echo "BBLAYERS += \"\${BSPDIR}/sources/meta-matter\"" >> conf/bblayers.conf
echo "IMAGE_INSTALL:append = \" boost boost-dev boost-staticdev \"" >> conf/local.conf
echo "PACKAGECONFIG:append:pn-iptables = \" libnftnl\"" >> conf/local.conf
echo "MATTER_PY_PATH=\"${MATTER_PYTHON_PATH}\"" >> conf/local.conf

echo ""
echo "Now you can use below command to generate your image:"
echo "    $ bitbake imx-image-core"
echo "             or "
echo "    $ bitbake imx-image-multimedia"
echo "======================================================="
echo "If you want to generate SDK, please use:"
echo "    $ bitbake imx-image-core -c populate_sdk"
echo "To exit Matter build environment, please:"
echo "    $ deactivate"
echo ""
