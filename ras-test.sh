
dmesg | grep -i ras 2>&1 | tee ras-enabled-check.log

echo "=============RAS query test (P1)============="  2>&1 | tee ras-query.log
sudo amdgpuras -d $1 -b 0 2>&1 | tee -a ras-query.log
sudo amdgpuras -d $1 -b 2 2>&1 | tee -a ras-query.log
sudo amdgpuras -d $1 -b 3 2>&1 | tee -a ras-query.log
sudo amdgpuras -d $1 -b 5 2>&1 | tee -a ras-query.log
dmesg  2>&1 | tee ras-query.log

sleep 30
echo "=============Inject GFX SINGLE_CORRECTABLE error (P3)============="  2>&1 | tee gfx-single.log
sudo dmesg -C
sudo amdgpuras -d $1 -b 2 2>&1 | tee -a gfx-single.log
sudo amdgpuras -d $1 -b 2 -s 0 -t 2 2>&1 | tee -a gfx-single.log
sudo amdgpuras -d $1 -b 2 2>&1 | tee -a gfx-single.log

sleep 30
dmesg  2>&1 | tee dmesg-gfx-single.log
/opt/rocm/bin/rocminfo 

echo "=============Inject GFX MULTI_UNCORRECTABLE error (P1)============="  2>&1 | tee gfx-multi.log
sudo dmesg -C
sudo amdgpuras -d $1 -b 2 2>&1 | tee -a gfx-multi.log
sudo amdgpuras -d $1 -b 2 -s 0 -t 4 -S 20 2>&1 | tee -a gfx-multi.log
sudo amdgpuras -d $1 -b 2 2>&1 | tee -a gfx-multi.log

sleep 30
dmesg  2>&1 | tee dmesg-gfx-multi.log
/opt/rocm/bin/rocminfo

echo "=============Inject MMHUB SINGLE_CORRECTABLE error (P3)============="  2>&1 | tee mmhub-single.log
sudo dmesg -C
sudo amdgpuras -d $1 -b 3 2>&1 | tee -a mmhub-single.log
sudo amdgpuras -d $1 -b 3 -s 0 -t 2 2>&1 | tee -a mmhub-single.log
sudo amdgpuras -d $1 -b 3 2>&1 | tee -a mmhub-single.log

sleep 30
dmesg  2>&1 | tee dmesg-mmhub-single.log
/opt/rocm/bin/rocminfo


echo "=============Inject MMHUB MULTI_UNCORRECTABLE error (P1)============="  2>&1 | tee mmhub-multi.log
sudo dmesg -C
sudo amdgpuras -d $1 -b 3 2>&1 | tee -a mmhub-multi.log
sudo amdgpuras -d $1 -b 3 -s 0 -t 4 -S 20 2>&1 | tee -a mmhub-multi.log
sudo amdgpuras -d $1 -b 3 2>&1 | tee -a mmhub-multi.log

sleep 30
dmesg  2>&1 | tee dmesg-mmhub-multi.log
/opt/rocm/bin/rocminfo



echo "=============Inject PCIE BIF SINGLE_CORRECTABLE error (P3)============="  2>&1 | tee pci-bif-single.log
sudo dmesg -C
sudo amdgpuras -d $1 -b 5 2>&1 | tee -a pci-bif-single.log
sudo amdgpuras -d $1 -b 5 -s 0 -t 2 2>&1 | tee -a pci-bif-single.log
sudo amdgpuras -d $1 -b 5 2>&1 | tee -a pci-bif-single.log

sleep 30
dmesg  2>&1 | tee dmesg-bif-single.log
/opt/rocm/bin/rocminfo


echo "=============Inject PCIe BIF MULTI_UNCORRECTABLE error (P1)============="  2>&1 | tee pci-bif-multi.log
sudo dmesg -C
sudo amdgpuras -d $1 -b 5 2>&1 | tee -a pci-bif-multi.log
sudo amdgpuras -d $1 -b 5 -s 0 -t 4 -S 20 2>&1 | tee -a pci-bif-multi.log
sudo amdgpuras -d $1 -b 5 2>&1 | tee -a pci-bif-multi.log

sleep 30
dmesg  2>&1 | tee dmesg-bif-multi.log
/opt/rocm/bin/rocminfo



echo "=============Inject XGMI_WAFL MULTI_UNCORRECTABLE error (P1)============="  2>&1 | tee xgmi-wafl-multi.log
sudo dmesg -C
sudo amdgpuras -d $1 -b 7 2>&1 | tee -a xgmi-wafl-multi.log
sudo amdgpuras -d $1 -b 7 -s 0 -t 4 -m 6 -S 20 2>&1 | tee -a xgmi-wafl-multi.log
sudo amdgpuras -d $1 -b 7 2>&1 | tee -a xgmi-wafl-multi.log

sleep 30
dmesg  2>&1 | tee dmesg-wafl-multi.log
/opt/rocm/bin/rocminfo

echo "=============Inject UMC MULTI_UNCORRECTABLE error (P1)============="  2>&1 | tee umc-multi.log
sudo dmesg -C
#echo 1 > /sys/kernel/debug/dri/x/ras/ras_eeprom_reset ; do this mandatory after running this parituclar test. "x" value will come from amdvbflash output
sudo amdgpuras -d $1 -b 0 2>&1 | tee -a umc-multi.log
sudo amdgpuras -d $1 -b 0 -s 0 -t 4 -S 20 2>&1 | tee -a umc-multi.log
sudo amdgpuras -d $1 -b 0 2>&1 | tee -a umc-multi.log
cat /sys/class/drm/card7/device/ras/gpu_vram_bad_pages 2>&1 | tee -a umc-multi.log


sleep 30
dmesg  2>&1 | tee dmesg-umc-multi.log
/opt/rocm/bin/rocminfo

echo "=============Inject UMC SINGLE_CORRECTABLE error (P3)============="  2>&1 | tee umc-single.log
sudo dmesg -C
#echo 1 > /sys/kernel/debug/dri/x/ras/ras_eeprom_reset ; do this mandatory after running this parituclar test.
sudo amdgpuras -d $1 -b 0 2>&1 | tee -a umc-single.log
sudo amdgpuras -d $1 -b 0 -s 0 -t 2 2>&1 | tee -a umc-single.log
sudo amdgpuras -d $1 -b 0 2>&1 | tee -a umc-single.log

sleep 30
dmesg  2>&1 | tee dmesg-umc-single.log
/opt/rocm/bin/rocminfo

