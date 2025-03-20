# Ensure the script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script requires administrative privileges. Restarting with admin rights..."
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$progressPreference = 'silentlyContinue'

# --- Installing Winget Dependencies ---
Write-Host "Installing Winget Dependencies..."
$depUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.10.320/DesktopAppInstaller_Dependencies.zip"
$depZip = "$env:TEMP\DesktopAppInstaller_Dependencies.zip"
Invoke-WebRequest -Uri $depUrl -OutFile $depZip
$depFolder = "$env:TEMP\DesktopAppInstaller_Dependencies"
Expand-Archive -Path $depZip -DestinationPath $depFolder -Force

# Determine system architecture and set variables accordingly
if ([Environment]::Is64BitOperatingSystem) {
    $ssceUrl = "https://download.microsoft.com/download/f/f/d/ffdf76e3-9e55-41da-a750-1798b971936c/ENU/SSCERuntime_x64-ENU.exe"
    $uiXaml = Join-Path $depFolder "x64\Microsoft.UI.Xaml.2.8_8.2501.31001.0_x64.appx"
    $vcLibs = Join-Path $depFolder "x64\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64.appx"
}
else {
    $ssceUrl = "https://download.microsoft.com/download/f/f/d/ffdf76e3-9e55-41da-a750-1798b971936c/ENU/SSCERuntime_x32-ENU.exe"
    $uiXaml = Join-Path $depFolder "x86\Microsoft.UI.Xaml.2.8_8.2501.31001.0_x86.appx"
    $vcLibs = Join-Path $depFolder "x86\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x86.appx"
}

try {
    Add-AppxPackage -Path $PackagePath -ErrorAction Stop
}
catch {
    if ($_.Exception.Message -match "0x80073D02") {
        Write-Host "Package '$PackagePath' already installed, skipping."
    }
    else {
        throw $_
    }
}


Write-Host "Installing Microsoft.UI.Xaml dependency..."
Try-AddAppxPackage -PackagePath $uiXaml

Write-Host "Installing Microsoft.VCLibs dependency..."
Try-AddAppxPackage -PackagePath $vcLibs

Write-Host "Installing Winget..."
$msixUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.10.320/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$msixPath = "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -Uri $msixUrl -OutFile $msixPath

try {
    Add-AppxPackage -Path $msixPath -ErrorAction Stop
}
catch {
    if ($_.Exception.Message -match "0x80073D02") {
        Write-Host "Microsoft.DesktopAppInstaller already installed, skipping."
    }
    else {
        throw $_
    }
}

Write-Host "Checking if there is any Winget update..."
winget update winget --silent

# --- Install .NET Runtimes and SDKs ---
Write-Host "Installing .NET components via Winget..."
winget install -e --id Microsoft.DotNet.Runtime.3_1 --source winget --silent
winget install -e --id Microsoft.DotNet.Runtime.5 --source winget --silent
winget install -e --id Microsoft.DotNet.Runtime.6 --source winget --silent
winget install -e --id Microsoft.DotNet.Runtime.7 --source winget --silent
winget install -e --id Microsoft.DotNet.Runtime.Preview --source winget --silent
winget install -e --id Microsoft.DotNet.DesktopRuntime.3_1 --source winget --silent
winget install -e --id Microsoft.DotNet.DesktopRuntime.5 --source winget --silent
winget install -e --id Microsoft.DotNet.DesktopRuntime.6 --source winget --silent
winget install -e --id Microsoft.DotNet.DesktopRuntime.7 --source winget --silent
winget install -e --id Microsoft.DotNet.DesktopRuntime.Preview --source winget --silent
winget install -e --id Microsoft.DotNet.AspNetCore.3_1 --source winget --silent
winget install -e --id Microsoft.DotNet.AspNetCore.5 --source winget --silent
winget install -e --id Microsoft.DotNet.AspNetCore.6 --source winget --silent
winget install -e --id Microsoft.DotNet.AspNetCore.7 --source winget --silent
winget install -e --id Microsoft.DotNet.AspNetCore.Preview --source winget --silent --silent

# --- Install Redistributables via Winget ---
Write-Host "Installing redistributable packages via Winget..."
winget install -e --id abbodi1406.vcredist --source winget --silent
winget install -e --id Microsoft.DirectX --source winget --silent
winget install -e --id Microsoft.XNARedist --source winget --silent
winget install -e --id Nvidia.PhysXLegacy --source winget --silent
winget install -e --id Nvidia.PhysX --source winget --silent
winget install -e --id Oracle.JavaRuntimeEnvironment --source winget --silent
winget install -e --id NewTek.NDI5Runtime --source winget --silent
winget install -e --id Microsoft.EdgeWebView2Runtime --source winget --silent

# --- Manually Download & Execute Additional Setups ---

# Visual J# Redistributable
Write-Host "Downloading and installing Visual J# Redistributable..."
$vjUrl = "https://download.microsoft.com/download/9/a/0/9a01eb1e-fe80-41af-a3f8-ea41220918f7/vjredist.exe"
$vjPath = "$env:TEMP\vjredist.exe"
Invoke-WebRequest -Uri $vjUrl -OutFile $vjPath
Start-Process -FilePath $vjPath -Wait

# SQL Server Compact Edition (SSCE) Runtime
Write-Host "Downloading and installing SSCE Runtime..."
$sscePath = "$env:TEMP\SSCERuntime_x64-ENU.exe"
Invoke-WebRequest -Uri $ssceUrl -OutFile $sscePath
Start-Process -FilePath $sscePath -Wait

# OpenAL Installer
Write-Host "Downloading and installing OpenAL..."
$oalUrl = "https://www.openal.org/downloads/oalinst.zip"
$oalZip = "$env:TEMP\oalinst.zip"
$oalFolder = "$env:TEMP\oalinst"
Invoke-WebRequest -Uri $oalUrl -OutFile $oalZip
Expand-Archive -Path $oalZip -DestinationPath $oalFolder -Force
$oalExe = Join-Path $oalFolder "oalinst.exe"
Start-Process -FilePath $oalExe -Wait

Write-Host "All installations complete."
