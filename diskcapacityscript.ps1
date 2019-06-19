




$AppProps = convertfrom-stringdata (get-content d:\suresh\config.txt | Out-String)
$SName = $AppProps.'cpaserver.name'
$SIP = $AppProps.'server.IP'
$SType = $AppProps.'server.Type'




foreach ($ServerName in $SName.split(",")){

write-output ("Capacity Report for Hostname                " + $ServerName)
write-output ("---------------------------------------------------------------------------------")
$driveList = Get-WMIObject win32_logicaldisk -computername $ServerName  -Filter $deviceID  | Select Name , ProviderName , FileSystem, Size, FreeSpace



write-output ("Drive" + "    Disk Size (GB)    	Used Space (GB)     	Free Space (GB)    	Free Space in (%GB) ")


$limit = (Get-Date).AddDays(-15)
$path = "d:\ecm\"



$src_folder = $path
$destfile = $path + "\docview.zip"
#$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
$includebasedir = $false
#[System.IO.Compression.ZipFile]::CreateFromDirectory($src_folder, $destfile, $compressionLevel, $includebasedir)

foreach ($drive in $driveList){

if ($drive.Name -eq "C:" -OR $drive.Name -eq "D:") {

$freespaceinGB = [Math]::Round($drive.FreeSpace/1GB)
$totalSizeinGB = [Math]::Round($drive.Size/ 1GB)
$usedSpace = $totalSizeinGB -   $freespaceinGB

$freespaceinPercentage = [Math]::Round(($freespaceinGB / $totalSizeinGB ) * 100)

$drive.Name  + "           " + $totalSizeinGB + "                        "    +  $usedSpace +  "                 " +  $freespaceinGB   + "                       " + $freespaceinPercentage + "%" 




}
}

write-output ("                                                                          ")
}

#----------------------------------------------------------------