# Installation of prerequisites for Sitecore 8.* on prem instance 
## inspired by  [Sitecore.HabitatHome.Utilities](https://github.com/Sitecore/Sitecore.HabitatHome.Utilities)
## SQL Server is not provisioned
## requires Powershell 5

- Open PowerShell session as Administrator

```
.\Install-All.ps1
```

### Steps Performed by Install-All

#### Install Chocolatey
Chocolatey builds on technologies you know - unattended installation and PowerShell. Chocolatey works with all existing software installation technologies like MSI, NSIS, InnoSetup, etc
#### Install IIS Features
Uses Windows' native `Enable-WindowsOptionalFeature` to install relevant Windows **IIS Features **as well as **Url Rewrite** and **Web Deploy**

#### Install Choco Packages
an arbitrary set of tools for the dev env

#### Install mongo db as a service (ver. 3.6.2)

