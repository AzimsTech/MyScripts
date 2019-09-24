@ECHO OFF
ECHO "%~1"
adb push "%~1" /sdcard/
timeout 5