# Generalize the Windows VM using Sysprep
Sysprep removes all your personal account information, among other things, and prepares the machine to be used as an image. 
- Connect to the virtual machine.
- Open the Command Prompt window as an administrator. Change the directory to %windir%\system32\sysprep, and then run sysprep.exe.
In the System Preparation Tool dialog box, select Enter System Out-of-Box Experience (OOBE), and make sure that the Generalize check box is selected.
In Shutdown Options, select Shutdown and then click OK.
When Sysprep completes, it shuts down the virtual machine. Do not restart the VM.

# create image with powershell
- Open a admin Powershell console  and type customizing your detail

```
$Credential = Get-Credential
$SubscriptionName = "YOUR-SUBSCRIPTION-HERE"
Connect-AzureRmAccount -Credential $Credential -SubscriptionName $SubscriptionName

$options = @{
    vmname = "sitecore-82we"
    imagename = "sitecore-82-sql"
    location = "West Europe"
    resource_group = "vms"
}
Stop-AzureRmVM -ResourceGroupName $options.resource_group -Name $options.vmname -Force
Set-AzureRmVM -ResourceGroupName $options.resource_group -Name $options.vmname -Generalized
$vm = Get-AzureRmVM -Name $options.vmname -ResourceGroupName $options.resource_group
$image = New-AzureRmImageConfig -Location $options.location -SourceVirtualMachineId $vm.ID
New-AzureRmImage -Image $image -ImageName $imagename -ResourceGroupName $options.resource_group
```
