:: Name:     vm-windows-dev.bat
:: Purpose:
:: Author:   Thada Wangthammang <mildronize@gmail.com>
:: Revision: 2016/06/22 Initial version

:: Ref: http://steve-jansen.github.io/guides/windows-batch-scripting/part-10-advanced-tricks.html
::      http://schier.co/blog/2013/03/13/start-virtualbox-vm-in-headless-mode.html


@ECHO OFF

SET VirtualBoxPath=C:\Program Files\Oracle\VirtualBox
SET DefaultVmName=md9-dev
SET Host=localhost
SET Port=22
SET User=mildronize
SET PuttyPrivateKeyPath=C:\Users\Mildronize\hanuman\hanuman.ppk
SET PuttySession="mildronize-template"

:: Sync
SET HostKey="*"
SET FileMaskInclude=""
SET FileMaskExclude=*.git/; .git/;Thumbs.db
SET HostPath="C:\Users\Mildronize\hanuman\files"
SET RemotePath="/home/mildronize/windows/"


:: Main
IF "%1"=="" CALL :QUICK_START
IF "%1"=="help" CALL :HELP
IF "%1"=="start" CALL :START
IF "%1"=="stop" CALL :STOP
IF "%1"=="ls"  CALL :LIST
IF "%1"=="list"  CALL :LIST
IF "%1"=="attach"  CALL :ATTACH
IF "%1"=="sync" CALL :SYNC

EXIT /B 0

:: End Main

:QUICK_START
CALL :START
CALL :SYNC

:HELP
ECHO # Quick start ( start vm + sync )
ECHO vm-windows-dev
ECHO ---
ECHO # Start and stop with default VM name
ECHO vm-windows-dev start
ECHO vm-windows-dev stop
ECHO ---
ECHO vm-windows-dev attach
ECHO vm-windows-dev sync
ECHO ---
ECHO vm-windows-dev help
ECHO vm-windows-dev ls   # List virtual machines
ECHO vm-windows-dev list # List virtual machines
EXIT /B 0

:START
IF "%2"=="" (
	SET VmName=%DefaultVmName%
) ELSE (
	SET VmName=%2
)
ECHO Starting... %VmName%
"%VirtualBoxPath%\VBoxManage.exe" startvm %VmName% --type headless
EXIT /B 0


:STOP
IF "%2"=="" (
	SET VmName=%DefaultVmName%
) ELSE (
	SET VmName=%2
)
ECHO Stopping... %VmName%
"%VirtualBoxPath%\VBoxManage.exe" controlvm %VmName% poweroff
EXIT /B 0


:LIST
"%VirtualBoxPath%\VBoxManage.exe" list vms
EXIT /B 0


:ATTACH
putty -load %PuttySession% -ssh %Host% -l %User% -i %PuttyPrivateKeyPath%
EXIT /B 0


:SYNC
winscp.com /command ^
    "option batch abort" ^
    "option confirm off" ^
    "open sftp://%User%@%Host%:%Port% -privatekey=%PuttyPrivateKeyPath% -hostkey=%hostkey%" ^
    "synchronize remote C:\Users\Mildronize\hanuman\files /home/mildronize/windows/ -filemask='%FileMaskInclude% | %FileMaskExclude%'" ^
    "keepuptodate C:\Users\Mildronize\hanuman\files /home/mildronize/windows/ -filemask='%FileMaskInclude% | %FileMaskExclude%'" ^
    "exit"
EXIT /B 0
