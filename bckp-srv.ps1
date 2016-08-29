#######################Variables#######################################
# путь каталога источника
$sourcedir = 'C:\powershell\1\sourcedir'
# название сервиса
$servicename = 'TestService'
# путь самого сервиса
$servicedir = 'C:\Powershell\1\servicedir'
# путь хранения бэкапов
$backupdir = 'C:\Powershell\1\backupdir'
#set 7zip.exe directory
$zipexe = 'C:\powershell\7z.exe'
#########################################################################
# проверка наличия каталогов
if ((Test-Path $sourcedir -PathType Container) -eq $true ) {Write-Host "SourceDIR FOLDER EXIST"}
else {Write-Host "No SOURCEDIR FOLDER in location"}
 
if ((Test-Path $servicedir -PathType Container) -eq $true ) {Write-Host "ServiceDIR FOLDER EXIST"}
else {Write-Host "No ServiceDIR FOLDER in location"}
 
if ((Test-Path $backupdir -PathType Container) -eq $true ) {Write-Host "BackupDIR FOLDER EXIST"}
else {Write-Host "No BackupDIR FOLDER in location"}
 
# получаем инф-ию о сервисе
$checkserviceoff = Get-Service $servicename
if ($checkserviceoff.Status -eq "Running") {write-host "Stopping service..."; Stop-Service $servicename; write-host "Service stopped"}
else {Write-Host "Service is already stopped"}
 
# 7zip
$datestring = Get-Date -Format ddMMyy_HHmmss
$zipfile = "$servicedir\bckp_$datestring.zip"
&$zipexe a -mx=9 $zipfile $servicedir
Move-Item "$servicedir\bckp_*.zip" -Destination $backupdir
 
# del files in sourcedir
Remove-Item $servicedir\*.* -Recurse
 
# copy files from sourcedir to servicedir
Copy-Item $sourcedir\*.* -Destination $servicedir
 
# start service
$checkserviceon = Get-Service $servicename
if ($checkserviceon.Status -ne "Running") {write-host "Starting service...";
                         Start-Service $servicename;
                         Start-Sleep -s 10;
                         }
else {Write-Host "Some error"}
 
# running service check
$checkservicetest = Get-Service $servicename
if ($checkservicetest.Status -eq "Running") {write-host "Service successfully running"}
else {Write-Host "Service is not started"}
