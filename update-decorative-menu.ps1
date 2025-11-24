# Update all HTML files to add Decorative Items to product menu

$htmlFiles = Get-ChildItem -Path "*.html" -File | Where-Object { $_.Name -ne "ramdev-decorative-items.html" }

$count = 0
foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Check if file has the Ramdev products menu structure
    if ($content -match '<a href="ramdev-nameplates\.html" class="dropdown-item">Name Plates</a>') {
        
        # Add Decorative Items link after Name Plates
        $oldMenu = '<a href="ramdev-nameplates.html" class="dropdown-item">Name Plates</a>'
        $newMenu = '<a href="ramdev-nameplates.html" class="dropdown-item">Name Plates</a>' + "`r`n" + '                        <a href="ramdev-decorative-items.html" class="dropdown-item">Decorative Items</a>'
        
        $newContent = $content -replace [regex]::Escape($oldMenu), $newMenu
        
        if ($content -ne $newContent) {
            $newContent | Out-File -FilePath $file.FullName -Encoding UTF8 -NoNewline
            Write-Host "Updated $($file.Name)" -ForegroundColor Green
            $count++
        }
    }
}

Write-Host ""
Write-Host "Updated $count files with Decorative Items link!" -ForegroundColor Cyan
