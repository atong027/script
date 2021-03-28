#!/bin/sh
adb kill-server >/dev/null 2>&1
echo "Connecting to your modem ...."
adb connect 192.168.8.1:5555 >/dev/null 2>&1
adb devices -l | grep "192.168.8.1:5555" >/dev/null 2>&1
if [ "$?" -eq 1 ]; then
adb kill-server >/dev/null 2>&1
echo Device NOT Connected !!!
echo Exiting ...
timeout /t 10 /nobreak >/dev/null 2>&1
exit
else
echo Connected !!!
adb shell sleep 2
adb shell echo Installing
adb shell mount -o remount,rw /system
adb shell echo Pakihintay matapos, wag mainip
adb push atong.tgz /tmp/
adb shell rm -rf /online/atong/v2ray
adb shell tar -xzvf /tmp/atong.tgz -C /online
adb shell chmod -R 777 /online/atong/v2ray/
adb shell rm -rf /tmp/atong.tgz
adb shell /online/atong/v2ray/bin/installv2ray.sh
adb shell rm -rf /online/atong/v2ray/bin/installv2ray.sh
fi
