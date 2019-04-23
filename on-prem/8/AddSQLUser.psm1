
function SQL-Get-Server-Instance
{
    param (
        [parameter(Mandatory = $true)][string] $DatabaseServer,
        [parameter(Mandatory = $true)][string] $InstanceName
    )

    if (!$InstanceName -or $InstanceName -eq "" -or $InstanceName -eq "MSSQLSERVER")
        { return $DatabaseServer }
    else
        { return "$DatabaseServer\$InstanceName" }
}


function Create-SQL-Login
{
    param (
        [parameter(Mandatory = $true)][string] $loginName,
        [parameter(Mandatory = $true)][string] $DatabaseServer,
        [parameter(Mandatory = $true)][string] $SaUser = "sa",
        [parameter(Mandatory = $true)][string] $SaPwd,
        [parameter(Mandatory = $false)][string] $InstanceName = "MSSQLSERVER"
    )

    $sqlConnection = $null

    try
    {
        $Error.Clear()

        $ServerInstance = SQL-Get-Server-Instance $DatabaseServer $InstanceName
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection
        $sqlConnection.ConnectionString = "Password=$SaPwd;User ID=$SaUser;Server=$ServerInstance"

        $Command = New-Object System.Data.SqlClient.SqlCommand
        $Command.CommandType = 1
        $Command.Connection = $sqlConnection
        $Command.CommandText = "create login [$loginName] from windows with default_database=[master], default_language=[us_english]"
        $sqlConnection.Open()
        $Command.ExecuteNonQuery() | Out-Null
        $Command.CommandText = "exec master..sp_addsrvrolemember @loginame = N'$loginName', @rolename = N'sysadmin'"
        $Command.ExecuteNonQuery() | Out-Null
    }

    catch
    {
        $str = (([string] $Error).Split(':'))[1]
        <# Write-Error ($str.Replace('"', '')) #>
    }

    finally
    {
        if ($sqlConnection)
            { $sqlConnection.Close() }
    }
}