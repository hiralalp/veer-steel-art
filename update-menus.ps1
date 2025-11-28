# PowerShell script to update the simplified Products dropdown in every HTML page

$htmlFiles = Get-ChildItem -Path "*.html" -File

$count = 0
foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.Name)..."

    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    # if ($content -match 'dropdown-hover') {
    #     Write-Host "  Already using the new menu, skipping." -ForegroundColor Yellow
    #     continue
    # }

    $startPos = $content.IndexOf('<div class="nav-item dropdown')
    if ($startPos -lt 0) {
        Write-Host "  No dropdown block found, skipping." -ForegroundColor Yellow
        continue
    }

    $afterStart = $content.Substring($startPos)
    $depth = 0
    $endPos = -1

    for ($i = 0; $i -lt $afterStart.Length; $i++) {
        if ($afterStart.Substring($i).StartsWith('<div')) {
            $depth++
        }
        elseif ($afterStart.Substring($i).StartsWith('</div>')) {
            $depth--
            if ($depth -eq 0) {
                $endPos = $i + 6
                break
            }
        }
    }

    if ($endPos -le 0) {
        Write-Host "  Unable to determine dropdown block, skipping." -ForegroundColor Red
        continue
    }

    $oldMenu = $afterStart.Substring(0, $endPos)
    $activeSuffix = if ($oldMenu -match 'dropdown-toggle\s+active') { ' active' } else { '' }

    $newMenuTemplate = @'
                <div class="nav-item dropdown dropdown-hover" id="productsDropdown">
                    <a href="#" class="nav-link dropdown-toggle{0}" data-bs-toggle="dropdown" data-bs-auto-close="outside">Products</a>
                    <div class="dropdown-menu simple-products-menu shadow-sm border-0 m-0">
                        <a href="ramdev-railings.html" class="dropdown-item">Stainless Steel Railings</a>
                        <a href="ramdev-grills.html" class="dropdown-item">Stainless Steel Grills</a>
                        <a href="ramdev-pvd-coating.html" class="dropdown-item">PVD Coating Services</a>
                        <a href="ramdev-doors.html" class="dropdown-item">Stainless Steel Doors</a>
                        <a href="ramdev-gates.html" class="dropdown-item">Stainless Steel Gates</a>
                        <a href="ramdev-kitchen.html" class="dropdown-item">Kitchen Items</a>
                        <a href="ramdev-chairs.html" class="dropdown-item">Steel Chairs &amp; Stools</a>
                        <a href="ramdev-tables.html" class="dropdown-item">Steel Tables</a>
                        <a href="ramdev-handles.html" class="dropdown-item">Stainless Steel Handles</a>
                        <a href="ramdev-accessories.html" class="dropdown-item">Steel Accessories</a>
                        <a href="ramdev-decorative-items.html" class="dropdown-item">Decorative Items</a>
                        <a href="ramdev-laser-cutting.html" class="dropdown-item">Laser Cutting Portfolio</a>
                        <a href="ramdev-nameplates.html" class="dropdown-item">Name Plates</a>
                        <div class="dropdown-divider"></div>
                        <a href="other-products.html" class="dropdown-item highlight">Other Products</a>
                    </div>
                </div>
'@

    $newMenu = [string]::Format($newMenuTemplate, $activeSuffix)

    $before = $content.Substring(0, $startPos)
    $after = $afterStart.Substring($endPos)
    $newContent = $before + $newMenu + $after

    [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host "  Updated $($file.Name)" -ForegroundColor Green
    $count++
}

Write-Host "`nUpdated $count files with the shared Products dropdown." -ForegroundColor Cyan
