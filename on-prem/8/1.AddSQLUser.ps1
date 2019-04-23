Param(
    [Parameter(Mandatory=$True)][string]$SqlAdminUser = "sa",
    [Parameter(Mandatory=$True)][string]$SqlAdminPwd
)


$cpath = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$cpath\AddSQLUser.psm1" -Force
#stupid script to add current user as admin to SQL Server - - vm provisioning reset user
Create-SQL-Login $env:COMPUTERNAME\$env:UserName $env:COMPUTERNAME $SqlAdminUser $SqlAdminPwd