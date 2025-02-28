$progressPreference = 'silentlyContinue'
# --- Install WinGet Module and Bootstrap ---
Write-Host "Installing WinGet PowerShell module from PSGallery..."
Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
Repair-WinGetPackageManager
Write-Host "Done." 

# --- Install .NET Runtimes and SDKs ---
Write-Host "Installing .NET components via winget..."
winget install -e --id Microsoft.DotNet.Runtime.7 --source winget
winget install -e --id Microsoft.DotNet.Runtime.6 --source winget
winget install -e --id Microsoft.DotNet.Runtime.5 --source winget
winget install -e --id Microsoft.DotNet.Runtime.Preview --source winget
winget install -e --id Microsoft.DotNet.AspNetCore.Preview --source winget
winget install -e --id Microsoft.DotNet.AspNetCore.7 --source winget
winget install -e --id Microsoft.DotNet.AspNetCore.6 --source winget
winget install -e --id Microsoft.DotNet.AspNetCore.5 --source winget --source winget

# --- Install Redistributables via winget ---
Write-Host "Installing redistributable packages via winget..."
winget install -e --id abbodi1406.vcredist --source winget
winget install -e --id Microsoft.DirectX --source winget
winget install -e --id Microsoft.XNARedist --source winget
winget install -e --id Nvidia.PhysXLegacy --source winget
winget install -e --id Nvidia.PhysX --source winget
winget install -e --id Oracle.JavaRuntimeEnvironment --source winget

# --- Manually Download & Execute Additional Setups ---

# Visual J# Redistributable
Write-Host "Downloading and installing Visual J# Redistributable..."
$vjUrl  = "https://download.microsoft.com/download/9/a/0/9a01eb1e-fe80-41af-a3f8-ea41220918f7/vjredist.exe"
$vjPath = "$env:TEMP\vjredist.exe"
Invoke-WebRequest -Uri $vjUrl -OutFile $vjPath
Start-Process -FilePath $vjPath -Wait

# SQL Server Compact Edition (SSCE) Runtime
Write-Host "Downloading and installing SSCE Runtime..."
$ssceUrl  = "https://download.microsoft.com/download/f/f/d/ffdf76e3-9e55-41da-a750-1798b971936c/ENU/SSCERuntime_x64-ENU.exe"
$sscePath = "$env:TEMP\SSCERuntime_x64-ENU.exe"
Invoke-WebRequest -Uri $ssceUrl -OutFile $sscePath
Start-Process -FilePath $sscePath -Wait

# OpenAL Installer
Write-Host "Downloading and installing OpenAL..."
$oalUrl    = "https://www.openal.org/downloads/oalinst.zip"
$oalZip    = "$env:TEMP\oalinst.zip"
$oalFolder = "$env:TEMP\oalinst"
Invoke-WebRequest -Uri $oalUrl -OutFile $oalZip
Expand-Archive -Path $oalZip -DestinationPath $oalFolder -Force
$oalExe = Join-Path $oalFolder "oalinst.exe"
Start-Process -FilePath $oalExe -Wait

Write-Host "All installations complete."
