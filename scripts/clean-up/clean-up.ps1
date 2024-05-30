Get-ChildItem -Path . -Recurse |
Where-Object {
    $_.Name -eq 'node_modules' -or
    $_.FullName -match 'package-lock.json$' -or
    $_.Name -eq 'dist' -or
    $_.Name -eq 'declarations'
} |
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
