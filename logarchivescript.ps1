




$AppProps = convertfrom-stringdata (get-content d:\suresh\config.txt | Out-String)
$SName = $AppProps.'cpaserver.name'
$SIP = $AppProps.'server.IP'
$SType = $AppProps.'server.Type'
$rarpath = $AppProps.'rar.path'
$archivalLimit = $AppProps.'archival.limit'
$logPath = $AppProps.'log.path'
$batchfilepath = $AppProps.'batch.filepath'
$archivalpath=$AppProps.'archival.path'


$limit = (Get-Date).AddDays(-([int]$archivalLimit))



write-output ("The archival limit of logs files is " + $limit + " Days")

foreach ($ServerName in $SName.split(",")){

    write-output ("Checking the File Last Modificates Date's on Server :        " + $ServerName)
    write-output ("---------------------------------------------------------------------------------")


        $logFilePath = "\\" + $ServerName + "\" + $logPath

        $filelist = gci $logFilePath *.* -rec | where-object { !$_PSIsContainer -and $_LastWriteTime -lt $limit }
        $fileName =""
        foreach ( $file in $filelist){

            if( $file.LastWriteTime -lt $limit ) {
            
                
                $fileName = $logFilePath + $file.Name + " "  + $fileName 
                 write-output ($file.Name  + "   File is Older than $archivalLimit Days :")
                }
        }

    #$fileName
    if ( $fileName -ne "") {
    $fileName
    $date = Get-Date -Format "dd_MMM_yyyy"
    $time = Get-Date -Format "HHmmssfffffff"
    $currentDateTimeZipFileName =   "\\"+ $ServerName  +"\"+  $archivalpath +  $date + "_" + $time + ".rar"
    $rarcommand = "\\"+ $ServerName  +"\"+ $rarpath + "  a -r " + $currentDateTimeZipFileName + " " + $fileName

    $batchFile = "\\" + $ServerName  + "\" + $batchfilepath 
    
    
    set-content $batchFile  $rarcommand
    start-process $batchFile
   write-output ("File Archived At Location : "+ $currentDateTimeZipFileName )
    $fileName=""
    }
    else{
    write-output ("No File available to archive")
    }
    
    
        write-output ("                                                    ")
}




