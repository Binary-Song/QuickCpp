[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ProjectName = "Initialized"
)

Get-ChildItem . -Exclude *.ps1, *.json -Recurse | ForEach-Object { `
        $new_name = $_.Name.Replace("Initialized", "Uninitialized")
    if ($new_name -ne $_.Name) {
        Rename-Item $_ $_.Name.Replace("Initialized", "Uninitialized")
    }
} 

Get-ChildItem . -Exclude *.ps1, *.json -Recurse -File | ForEach-Object { `
    (Get-Content $_).replace("Initialized", "Uninitialized") | Set-Content $_
}
