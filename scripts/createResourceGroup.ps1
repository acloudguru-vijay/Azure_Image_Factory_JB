[CmdletBinding()]
param(
    [Parameter(Mandatory=$True)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory=$True)]
    [string]$ResourceGroupLocation,
    [Parameter(Mandatory=$false)]
    [array]$ResourceGroupTags
)

$ResourceGroupLocation = $ResourceGroupLocation.ToLower().Replace(' ','')

if((az group exists --name $ResourceGroupName) -ne $True){
    if($ResourceGroupTags -ne $null){
        $resourceGroup = az group create --name $ResourceGroupName --location $ResourceGroupLocation --tags $ResourceGroupTags --verbose | ConvertFrom-Json
        Write-Host $resourceGroup
    }
    else {
        $resourceGroup = az group create --name $ResourceGroupName --location $ResourceGroupLocation --verbose | ConvertFrom-Json
        Write-Host $resourceGroup
    }
}
else {
    $resourceGroup = az group show --name $ResourceGroupName | ConvertFrom-Json
    Write-Host "Resource Group $resourceGroupName already exists - taking no action."
    Write-Host $resourceGroup
}