# Powershell---File-Archival-Process
-----------------------------------------------------
Powershell script will check the retention period as the required business's data archiving strategy and will then archive the older files which are not required. The script will to achive better utilization of storage and related costs. 


Background:
-----------
Data archiving is the process of moving data that is no longer actively used to a separate storage device for long-term retention. 
The script is designed and develop to archive older log files and provide following functionality:

1. Check the current Utilization of disk space remotely on different Windows Server
2. Archive log files which are older then 30 days
3. Delete archived log files which are older than 60 days


Version: Powershell 2.0
-----------------------------

Source Code
----------------

Attached 3 Powershell Scripts Files:

1. Disk Capacity Script.ps1 

This script will check the current utilization on each disk-drive for the given windows Server

2. logarchivescript.ps1

This script will archive files which are older than 30 days

3. deletearchivelogfile.ps1

This script will delete older archived files which are older then 60 days

Dependency:
-------------

Winrar -- > rar.exe file

Rar.exe executable file is part of Winrar bundle and is used to compress the logs. Download Winrar compression agent tool 

Configuraiton File:
------------------

Config.txt 

Config.txt file is the property config file which is used to set following parameters:

Server Names
log path
Retention period
archival log path
hidden path

batch File - it will be created at runtime
