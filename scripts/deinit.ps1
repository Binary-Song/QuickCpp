[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ProjectName = "Uninitialized"
)
function Rename-Tree {
    param (
        [Parameter()] 
        [Object]
        $Directory
    )
    Write-Output  "Renaming ${Directory.Name}"
    # Rename all files in this folder (files in subfolders are not included)
    Get-ChildItem $Directory -Exclude *.ps1, *.json, *.md | ForEach-Object { `
            $new_name = $_.Name.Replace("Initialized", "$ProjectName")
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

# replace the content of files
Get-ChildItem . -Exclude *.ps1, *.json, *.md -Recurse -File | ForEach-Object { `
    Write-Output  "Updating ${_.Name}" 
    (Get-Content $_).replace("Initialized", "$ProjectName") | Set-Content $_
}

# Set tasks.json runOn from 'default' to 'folderOpen'
$file = Get-Item .\.vscode\tasks.json
Write-Output  "Updating ${file.Name}" 
$content =  Get-Content $file 
Set-Content $file $content.Replace('"runOn": "default"','"runOn": "folderOpen"')

Write-Output "Done!"
