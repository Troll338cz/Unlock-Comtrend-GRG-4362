# Run as root:
# More usefull info may be found at https://github.com/Anime4000/RTL960x/blob/main/Docs/Modify_Firmware.md
# Tar updates not yet tested 
mksquashfs rootfs_extracted/ rootfs_new.img -comp xz -b 131072 -always-use-fragments -no-recovery -noappend