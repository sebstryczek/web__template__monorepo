$PACKAGES_DIR = "../../packages"
$PACKAGES_PREFIX = "xterra-"

Get-ChildItem -Path $PACKAGES_DIR -Filter "$PACKAGES_PREFIX-*" -Directory | ForEach-Object {
    $PACKAGE_DIR = $_
    if (Test-Path "$($PACKAGE_DIR.FullName)/package.json") {
        while ($true) {
            $indexFiles = Get-ChildItem -Path "$($PACKAGE_DIR.FullName)/dist" -Filter "index.*.js"
            if ($indexFiles -and $indexFiles.Count -gt 0) {
                Write-Host "$($PACKAGE_DIR.FullName) is ready!"
                break
            } else {
                Write-Host "Waiting for $($PACKAGE_DIR.FullName)..."
                Start-Sleep -Seconds 1
            }
        }
    } else {
        Write-Host "$($PACKAGE_DIR.FullName) is not a package."
    }
}

Write-Host "All packages are ready!"
