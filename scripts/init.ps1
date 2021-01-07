[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ProjectName = "Initialized"
)

Write-Output "Initializing repository..." 
Write-Output "Project Manifest:"
Write-Output "name: $ProjectName"
Write-Output "use ci: $UseCI"
Write-Output "use test: $UseTest"
 
Get-ChildItem . -Exclude *.ps1, *.json -Recurse | ForEach-Object { `
        $new_name = $_.Name.Replace("Uninitialized", "$ProjectName")
    if ($new_name -ne $_.Name) {
        Rename-Item $_ $_.Name.Replace("Uninitialized", "$ProjectName")
    }
} 

Get-ChildItem . -Exclude *.ps1, *.json -Recurse -File | ForEach-Object { `
    (Get-Content $_).replace("Uninitialized", "$ProjectName") | Set-Content $_
}
