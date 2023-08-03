$tempDIR = $env:TEMP
$user = "chk"

$wslDistroName = "debian"
$installFolder = "$env:USERPROFILE\WSL\$wslDistroName"

wsl -d $wslDistroName --user root ./initialize-root.sh $user $user "`"$env:USERPROFILE`""

Write-Output "Done with distro install"
Write-Output $user
Write-Output "`"$env:USERPROFILE`""

Write-Output "Done with init.sh, shutting down wsl"
wsl --shutdown

Write-Output "Done!"