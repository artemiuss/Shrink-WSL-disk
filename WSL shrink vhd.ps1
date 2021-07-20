wsl --shutdown

$packageName = Get-AppxPackage -Name "*Ubuntu*" | Select -ExpandProperty PackageFamilyName | Out-String
$vhdPath = $env:userprofile + "\AppData\Local\Packages\" + $packageName
$vhdPath = $vhdPath -replace "`t|`n|`r",""
$vhdPath = $vhdPath + "\LocalState\ext4.vhdx"

Write-Host "WSL2 disk size before shrinking:" ((Get-Item $vhdPath).length/1GB) "GB"
Write-Host "Shrinking WSL2 disk..."
optimize-vhd -Path $vhdPath -Mode full
Write-Host "WSL2 disk size before shrinking:" ((Get-Item $vhdPath).length/1GB) "GB"

wsl --startup
