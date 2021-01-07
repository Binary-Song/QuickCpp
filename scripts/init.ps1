[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ProjectName = "Initialized"
)

Write-Output "Initializing repository..."
 
Get-ChildItem . -Exclude *.ps1, *.json -Recurse | ForEach-Object { `
        $new_name = $_.Name.Replace("Uninitialized", "$ProjectName")
    if ($new_name -ne $_.Name) {
        Rename-Item $_ $_.Name.Replace("Uninitialized", "$ProjectName")
    }
} 

Get-ChildItem . -Exclude *.ps1, *.json -Recurse -File | ForEach-Object { `
    (Get-Content $_).replace("Uninitialized", "$ProjectName") | Set-Content $_
}

Write-Output "Done!"
