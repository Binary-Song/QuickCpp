[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ProjectName = "Initialized"
)

Write-Output "Initializing repository..."

function Rename-Tree {
    param (
        [Parameter()] 
        [Object]
        $Directory
    )
    Write-Output $Directory.Name
    # Rename all files in this folder (files in subfolders are not included)
    Get-ChildItem $Directory -Exclude *.ps1, *.json, *.md | ForEach-Object { `
            $new_name = $_.Name.Replace("Uninitialized", "$ProjectName")
        if ($new_name -ne $_.Name) {
            Rename-Item $_ $new_name
        }
    }
    # Call Rename-Tree on all subfolders recursively
    Get-ChildItem $Directory -Exclude *.ps1, *.json, *.md -Directory | ForEach-Object { `
            Rename-Tree -Directory $_
    }
}

Rename-Tree -Directory .

# Replace the content of files
Get-ChildItem . -Exclude *.ps1, *.json, *.md -Recurse -File | ForEach-Object { `
    (Get-Content $_).replace("Uninitialized", "$ProjectName") | Set-Content $_
}

# Set tasks.json runOn from 'folderOpen' to 'default'
$file = Get-Item .\.vscode\tasks.json
$content =  Get-Content $file 
Set-Content $file $content.Replace('"runOn": "folderOpen"','"runOn": "default"')

Write-Output "Done!"