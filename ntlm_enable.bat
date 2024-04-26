@echo off
setlocal enabledelayedexpansion

rem Enable NTLM
reg add "HKLM\System\CurrentControlSet\Control\Lsa" /v "LMCompatibilityLevel" /t REG_DWORD /d 0 /f

rem Restart the machine for changes to take effect
shutdown /r /t 0