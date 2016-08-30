# нужные для работы скрипта штуки - закомментировать если установлено
# Import-Module WebAdministration
# Add-WindowsFeature Web-Scripting-Tools
 
# проверка наличия ИИС
$isiison = get-itemproperty HKLM:\SOFTWARE\Microsoft\InetStp\  | select setupstring
if ($isiison.setupstring -like "IIS *") {write-host "IIS daemon is here"}
else {Write-Host "IIS is not aviable"}
 
# получаем список пулов
$poolslist = Get-ChildItem -Path IIS:\\AppPools
#echo $poolslist
 
# получаем соответствие каждого пула и процесса
$poolproc = gwmi -ComputerName localhost -NS 'root\WebAdministration' -class 'WorkerProcess' | select AppPoolName,ProcessId | ft -AutoSize
#echo $poolproc
 
# cмотрим количество памяти по каждому процессу
$poolprocmem = gwmi -ComputerName localhost -NS 'root\WebAdministration' -class 'WorkerProcess' | select AppPoolName,ProcessId , @{n='PrivateRAM';e={ [math]::round((Get-Process -Id $_.ProcessId).PrivateMemorySize) / 1MB }}| ft -AutoSize
#echo $poolprocmem
 
# сортировка по убыванию и вывод трех лидирующих позиций
$poolmemsort = gwmi -ComputerName localhost -NS 'root\WebAdministration' -class 'WorkerProcess' | select AppPoolName,ProcessId , @{n='PrivateRAM';e={ [math]::round((Get-Process -Id $_.ProcessId).PrivateMemorySize) / 1MB }} | sort PrivateRAM -Descending | Select -First 3 | ft -AutoSize
echo $poolmemsort
