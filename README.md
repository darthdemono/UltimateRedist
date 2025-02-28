# UltimateRedist

UltimateRedist is a PowerShell-based solution that automates the installation of essential redistributables and .NET runtimes using Winget. Designed for gaming and casual use, it streamlines the setup of a comprehensive collection of runtimes—so you never have to manually hunt down each component again.

---

## Features

- **Automated Installation:** Uses Winget to install .NET, ASP.NET, VC++ redistributables, DirectX, XNA, NVIDIA PhysX, and more.
- **Comprehensive Coverage:** Supports modern and legacy runtimes including:
  - Visual C++ Redistributables (x86/x64)
  - .NET Runtimes & ASP.NET Core
  - DirectX and XNA
  - NVIDIA PhysX (Legacy & Current)
  - Oracle Java Runtime
  - Visual J# Redistributable
  - SQL Server Compact Edition (SSCE) Runtime
  - OpenAL
- **Universal Compatibility:** Works on both x64 and x86 systems.
- **Winget Integration:** Installs Winget using a workaround to overcome the default installation issues.

---

## Installs:

### Visual C++ Redistributables
Package of Microsoft C and C++ runtime libraries required for applications built with Visual Studio.

- **VC++ Redistributables 2005 (x86/x64)**
- **VC++ Redistributables 2008 (x86/x64)**
- **VC++ Redistributables 2010 (x86/x64)**
- **VC++ Redistributables 2012 (x86/x64)**
- **VC++ Redistributables 2013 (x86/x64)**
- **VC++ Redistributables 2022 (x86/x64)**
- **Visual Studio 2010 Tools for Office Runtime (x86/x64)**
- **Visual C++ 2002:**
- **Visual C++ 2003:**
- **Visual Basic Runtimes**

### .NET and ASP.NET Runtimes/SDKs
Framework and web libraries needed to run .NET and ASP.NET applications.

- **.NET 5**
- **.NET 6**
- **.NET 7**
- **.NET Preview**
- **ASP.NET 5**
- **ASP.NET 6**
- **ASP.NET 7**
- **ASP.NET Preview**

### NVIDIA PhysX
Physics engine libraries that power realistic in-game physics simulations.
- **NVIDIA PhysX**
- **NVIDIA PhysX Legacy**

### Additional Runtimes/Redistributables
#### DirectX
A collection of multimedia APIs designed for handling graphics, video, and game programming.
#### XNA Framework
Legacy game development framework for Windows and Xbox applications.
#### Oracle Java Runtime
Environment required to run applications developed in Java.
#### Visual J# Redistributable
Runtime components for running applications developed with Visual J#, targeting the .NET Framework.
#### SQL Server Compact Edition (SSCE) Runtime
Lightweight, embedded database engine for local data storage in legacy and small-scale applications.
#### OpenAL
Cross-platform audio API for rendering multichannel 3D audio.

---

## Why UltimateRedist?

As a tech enthusiast, reinstalling Windows often means rebuilding your development and gaming environment from scratch. Keeping track of and updating every individual redistributable—from VC++ runtimes and .NET to DirectX, XNA, and beyond—can be a hassle. UltimateRedist simplifies this process by automating the installation of every required component through Winget, so you can focus on what matters.

### Why Install Winget?
Winget is an excellent package manager that streamlines software installation. However, the traditional method of installing Winget is bugged, which is why this project employs a workaround to install Winget dependencies and the package manager itself.

### Why These Rare Runtimes?
This project aims to cover every essential runtime without the need to manually download files from various websites. By automating these installations, you save time and reduce the risk of missing a critical component.

---

## Special Thanks

- **[abbodi1406](https://github.com/abbodi1406/):** Thanks to his [VCredist AIO project](https://github.com/abbodi1406/vcredist), I didn’t have to manually add every Visual C++ redistributable. His work has been instrumental in making UltimateRedist universal for all Windows runtimes.

---

## Usage

### Prerequisites
- **Windows 10/11**
- **PowerShell:** Run as Administrator
- **Execution Policy:** Ensure script execution is allowed

### Instructions

1. **Open Windows Terminal or PowerShell as Administrator:**
   - Right-click on the Start button and select **Windows Terminal (Admin)** or **PowerShell (Admin)**.

2. **Enable Script Execution (if not already enabled):**
   ```powershell
   Set-ExecutionPolicy Unrestricted
   ```

3. **Run the Script:**
   Copy and paste the following command into your elevated terminal:
   ```powershell
   irm "https://raw.githubusercontent.com/darthdemono/UltimateRedist/main/UltimateRedist.ps1" | iex
   ```
   - This command will download and execute the UltimateRedist script directly from GitHub.

---

## Compatibility

UltimateRedist supports both **x64** and **x86** systems and is designed to install all necessary redistributables and runtimes for a comprehensive gaming and casual usage setup.

---
## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
