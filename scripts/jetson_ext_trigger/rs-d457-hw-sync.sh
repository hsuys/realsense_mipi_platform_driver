# MAX9295A
# CSI Port A:	2 lanes

# MAX9296A
# CSI Port A:	2 lanes, 1500Mbps/lane

# Default Power Up States
# MAX9295A
# CFG0 : I2C adr 0x80
# CFG1 : GMSL2, 6Gbps, Coax

# MAX9296A
# CFG0 : I2C adr 0x90
# CFG1 : GMSL2, 6Gbps, Coax

# I2C Addresses (8-bit)
# MAX9295A : 0x80
# MAX9296A : 0x90

# Script format
# [Number of bytes],[Slave adr],[Reg adr MSB],[Reg adr LSB],[Data],
# OR
# 0x00,[delay in ms],

#!/bin/bash

set -e

# Configure 1x Deser and 2x Ser 
apply_serdes_trigger_setting() {
    ### HW-SYNC  ###
    # SerDes Depth Trigger Path MFP7 > MFP0
    sudo i2cset -f -y 2 0x48 0x02 0x82c5 w #MFP7
    sudo i2cset -f -y 2 0x48 0x02 0x1fc6 w
    sudo i2cset -f -y 2 0x42 0x02 0x84be w #MFP0
    sudo i2cset -f -y 2 0x42 0x02 0x20bf w #OUT_TYPE bit to 1 (Push-pull)
    sudo i2cset -f -y 2 0x42 0x02 0x1fc0 w
    sudo i2cset -f -y 2 0x60 0x02 0x84be w #MFP0
    sudo i2cset -f -y 2 0x60 0x02 0x20bf w #OUT_TYPE bit to 1 (Push-pull)
    sudo i2cset -f -y 2 0x60 0x02 0x1fc0 w
    
#    echo -n "> Depth 0x48: "
#    sudo i2ctransfer -y -f 2 w2@0x48 0x02 0xc5 r2
#    echo -n "> Depth 0x42: "
#    sudo i2ctransfer -y -f 2 w2@0x42 0x02 0xc1 r3
#    echo -n "> Depth 0x60: "
#    sudo i2ctransfer -y -f 2 w2@0x60 0x02 0xc1 r3

    # SerDes RGB Trigger Path MFP9 > MFP1
    sudo i2cset -f -y 2 0x48 0x02 0x82cb w #MFP9
    sudo i2cset -f -y 2 0x48 0x02 0x1bcc w
    sudo i2cset -f -y 2 0x42 0x02 0x84c1 w #MFP1
    sudo i2cset -f -y 2 0x42 0x02 0x20c2 w #OUT_TYPE bit to 1 (Push-pull)
    sudo i2cset -f -y 2 0x42 0x02 0x1bc3 w
    sudo i2cset -f -y 2 0x60 0x02 0x84c1 w #MFP1
    sudo i2cset -f -y 2 0x60 0x02 0x20c2 w #OUT_TYPE bit to 1 (Push-pull)
    sudo i2cset -f -y 2 0x60 0x02 0x1bc3 w

#    echo -n "> RGB 0x48: "
#    sudo i2ctransfer -y -f 2 w2@0x48 0x02 0xcb r2
#    echo -n "> RGB 0x42: "
#    sudo i2ctransfer -y -f 2 w2@0x42 0x02 0xbe r3
#    echo -n "> RGB 0x60:"
#    sudo i2ctransfer -y -f 2 w2@0x60 0x02 0xbe r3
}

if [[ $# < 1 ]]; then
    echo "rs-d457-hw-sync.sh [fps]"
    echo "e.g., rs-d457-hw-sync.sh 30.0089"
    exit 1
else
    FPS=$1
    python3 rs-trigger-generator.py $FPS
fi
