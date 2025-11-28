$files = Get-ChildItem -Path . -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    if ($content -notmatch "Cache-Control") {
        # Insert meta tags after <head>
        $newContent = $content -replace "<head>", "<head>`r`n    <meta http-equiv=""Cache-Control"" content=""no-cache, no-store, must-revalidate"">`r`n    <meta http-equiv=""Pragma"" content=""no-cache"">`r`n    <meta http-equiv=""Expires"" content=""0"">"
        
        if ($newContent -ne $content) {
            Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
            Write-Host "Updated $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "Could not find <head> tag in $($file.Name)" -ForegroundColor Red
        }
    } else {
        Write-Host "Skipping $($file.Name) (already has Cache-Control)" -ForegroundColor Yellow
    }
}
