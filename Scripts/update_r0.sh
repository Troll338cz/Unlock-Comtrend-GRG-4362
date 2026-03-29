# Run from U-Boot shell
# Networking does not work :(
# loady is preffered over loadz due to setting ${filesize} to allow easy replacement of tftp commands
# Depends on "lrzsz" package

loady ${tftp_base} 115200

# Using screen - Ctrl-A + :  exec !! sz --ymodem CTN-1.0.8b16_r0.img
# Using minicom - CTRL-A, and s, select ymodem and your file
# Wait about 20 minutes

# Taken from printenv, can be used to update other ubifs partitions or mtds
setenv current_vol ubi_r0
run check_vol
ubi write ${tftp_base} ubi_r0 ${filesize}
reset