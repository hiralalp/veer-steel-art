# Fix handles and nameplates pages

# Get actual image files
$handleImages = Get-ChildItem -Path "img\ramdev\RSI-SH" -File | Sort-Object Name | Select-Object -First 87
$nameplateImages = Get-ChildItem -Path "img\ramdev\n-series" -File | Sort-Object Name | Select-Object -First 39

Write-Host "Found $($handleImages.Count) handle images"
Write-Host "Found $($nameplateImages.Count) nameplate images"

# Template for product pages
$template = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
   <title>{{TITLE}} - Ramdev Steel Industries</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="{{KEYWORD}}" name="keywords">
    <meta content="Premium {{TITLE}} for modern homes and offices" name="description">
    <link href="img/Ramdev Steel Industries logo.png" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600&family=Playfair+Display:wght@500;600;700&display=swap" rel="stylesheet"> 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <nav class="navbar navbar-expand-lg bg-white navbar-light fixed-top shadow py-lg-0 px-4 px-lg-5 wow fadeIn" data-wow-delay="0.1s">
        <a href="index.html" class="navbar-brand d-block d-lg-none">
            <h1 class="text-primary">Ramdev Steel Industries</h1>
        </a>
        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between py-4 py-lg-0" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-0">
                <a href="index.html" class="nav-item nav-link">Home</a>
                <a href="about.html" class="nav-item nav-link">About</a>
                <a href="service.html" class="nav-item nav-link">Services</a>
            </div>
            <a href="index.html" class="navbar-brand bg-primary py-2 px-4 mx-3 d-none d-lg-block" style="width: 280px;">
               <img src="./img/Ramdev Steel Industries logo.png" class="img-fluid"  alt="" style=" height: 58px; margin-left: 81px;">
            </a>
            <div class="navbar-nav me-auto py-0">
                <a href="quality.html" class="nav-item nav-link">Quality</a>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Products</a>
                    <div class="dropdown-menu rounded-0 shadow-sm border-0 m-0">
                        <a href="ramdev-grills.html" class="dropdown-item">Stainless Steel Grills</a>
                        <a href="ramdev-handles.html" class="dropdown-item">Stainless Steel Handles</a>
                        <a href="ramdev-railings.html" class="dropdown-item">Stainless Steel Railings</a>
                        <a href="ramdev-gates.html" class="dropdown-item">Stainless Steel Gates</a>
                        <a href="ramdev-doors.html" class="dropdown-item">Stainless Steel Doors</a>
                        <a href="ramdev-tables.html" class="dropdown-item">Steel Tables</a>
                        <a href="ramdev-chairs.html" class="dropdown-item">Steel Chairs & Stools</a>
                        <a href="ramdev-kitchen.html" class="dropdown-item">Kitchen Items</a>
                        <a href="ramdev-pvd-coating.html" class="dropdown-item">PVD Coating</a>
                        <a href="ramdev-laser-cutting.html" class="dropdown-item">Laser Cutting</a>
                        <a href="ramdev-accessories.html" class="dropdown-item">Steel Accessories</a>
                        <a href="ramdev-nameplates.html" class="dropdown-item">Name Plates</a>
                    </div>
                </div>
                <a href="contact.html" class="nav-item nav-link">Contact Us</a>
            </div>
        </div>
    </nav>
    <div class="container-fluid hero-header py-5 mb-5" style="background-image: url('./img/banner-2.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
        <div class="container py-5">
            <div class="row g-5 align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 mb-3 animated slideInDown" style="color:#EE2B47;">{{TITLE}}</h1>
                    <nav aria-label="breadcrumb animated slideInDown">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                            <li class="breadcrumb-item"><a href="#">Products</a></li>
                            <li class="breadcrumb-item active" aria-current="page">{{TITLE}}</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
     <div class="container-xxl py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
            <p class="text-primary text-uppercase mb-2">Our Collection</p>
            <h1 class="display-6 mb-0">{{TITLE}}</h1>
        </div>
        <div class="row g-3">
{{IMAGES}}
        </div>
    </div>
</div>
<style>
    .project-title {
        display: none;
    }
    .project-item {
        overflow: hidden;
        position: relative;
        border-radius: 8px;
    }
    .project-item img {
        transition: transform 0.3s ease;
        width: 100%;
        height: 300px;
        object-fit: cover;
    }
    .project-item:hover img {
        transform: scale(1.05);
    }
</style>
    <div class="container-fluid footer position-relative bg-dark text-white-50 mt-5 py-5 px-4 px-lg-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="row g-5 py-5">
            <div class="col-lg-6 pe-lg-5">
                <a href="index.html" class="navbar-brand">
                    <h1 class="display-5 text-primary">Ramdev Steel Industries</h1>
                </a>
                <p>Ramdev Steel Industries manufactures all kinds of S.S. Handles, Railings, Safety Door Grill, Interior Fabrication, and provides all kinds of PVD & PU coatings for metal surfaces.  </p>
                <p><i class="fa fa-map-marker-alt me-2"></i>Shop No. 180, Sefi House, T.P. Street, 6th Kumhharwada, Mumbai 400004 </p>
                <p><i class="fa fa-phone-alt me-2"></i>Harishbhai Dewasi - 90295 85033</p>
                <p><i class="fa fa-phone-alt me-2"></i>Harishbhai Dewasi - 98928 62579</p>
                <p><i class="fa fa-phone-alt me-2"></i>Navin Dewasi - 88787 28590</p>
                <p><i class="fa fa-phone-alt me-2"></i>Tel-022-67521222</p>
                <p><i class="fa fa-envelope me-2"></i>info@ramdevsteelindustries.com</p>
                <p><i class="fa fa-envelope me-2"></i>ramdevsteel.harish@gmail.com</p>
                <div class="d-flex justify-content-start mt-4">
                    <a class="btn btn-square btn-outline-primary rounded-circle me-2" href="https://x.com/"><i class="fab fa-x-twitter"></i></a>
                    <a class="btn btn-square btn-outline-primary rounded-circle me-2" href="https://www.facebook.com/"><i class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-square btn-outline-primary rounded-circle me-2" href="https://in.linkedin.com/"><i class="fab fa-linkedin-in"></i></a>
                    <a class="btn btn-square btn-outline-primary rounded-circle me-2" href="https://www.instagram.com/"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="col-lg-6 ps-lg-5">
                <div class="row g-5">
                    <div class="col-sm-6">
                        <h4 class="text-light mb-4">Quick Links</h4>
                        <a class="btn btn-link" href="about.html">About Us</a>
                        <a class="btn btn-link" href="service.html">Our Services</a>
                        <a class="btn btn-link" href="quality.html">Quality</a>
                        <a class="btn btn-link" href="contact.html">Contact Us</a>
                    </div>
                    <div class="col-sm-6">
                        <h4 class="text-light mb-4">Products</h4>
                        <a class="btn btn-link" href="ramdev-grills.html">Stainless Steel Grills</a>
                        <a class="btn btn-link" href="ramdev-handles.html">Stainless Steel Handles</a>
                        <a class="btn btn-link" href="ramdev-railings.html">Stainless Steel Railings</a>
                        <a class="btn btn-link" href="ramdev-gates.html">Stainless Steel Gates</a>
                        <a class="btn btn-link" href="ramdev-doors.html">Stainless Steel Doors</a>
                    </div>
                     <form action="https://api.web3forms.com/submit" method="POST">
                        <input type="hidden" name="access_key" value="f0b1004f-2bd5-4924-b688-ff222c0cffb2">
                        <input type="hidden" name="subject" value="New Quote Request Subscription">
                        <div class="w-100">
                            <div class="input-group">
                                <input type="email" name="email" class="form-control border-0 bg-secondary" 
                                    style="padding: 20px 30px; color: white;" 
                                    placeholder="Your Email Address" required>
                                <button type="submit" class="btn btn-primary px-4">Subscribe</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
   <div class="container-fluid bg-dark text-white border-top border-secondary px-0">
        <div class="d-flex flex-column flex-md-row justify-content-between">
            <div class="py-4 px-5 text-center text-md-start">
                <p class="mb-0">&copy; <a class="text-primary" href="#">2025</a> All right reserved Ramdev Steel Industries</p>
            </div>
            <div class="py-4 px-5 bg-secondary footer-shape position-relative text-center text-md-end">
                <p class="mb-0">Designed by <a class="text-primary fw-bold" href="https://htmlcodex.com">Akroas technologies</a></p>
            </div>
        </div>
    </div>
<a href="javascript:void(0);"
   onclick="window.open('https://wa.me/919029585033', '_blank')"
   class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"
   style="color: white; background: green; border: 2px solid green;"
   title="Chat on WhatsApp">
   <i class="bi bi-whatsapp"></i>
</a>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
'@

# Fix Handles Page
Write-Host "`nGenerating ramdev-handles.html..." -ForegroundColor Cyan
$imageHtml = ""
$delay = 0.1
foreach ($img in $handleImages) {
    $imageHtml += @"
            <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
                <div class="project-item">
                    <img class="img-fluid" src="img/ramdev/RSI-SH/$($img.Name)" alt="Stainless Steel Handles">
                    <a class="project-title h5 mb-0" href="img/ramdev/RSI-SH/$($img.Name)" data-lightbox="gallery"></a>
                </div>
            </div>

"@
    $delay += 0.1
    if ($delay > 1.2) { $delay = 0.1 }
}

$html = $template -replace '{{TITLE}}', 'Stainless Steel Handles'
$html = $html -replace '{{KEYWORD}}', 'Stainless Steel Handles, Door Handles, Cabinet Handles'
$html = $html -replace '{{IMAGES}}', $imageHtml
$html | Out-File -FilePath "ramdev-handles.html" -Encoding UTF8
Write-Host "Created ramdev-handles.html with $($handleImages.Count) images" -ForegroundColor Green

# Fix Nameplates Page
Write-Host "`nGenerating ramdev-nameplates.html..." -ForegroundColor Cyan
$imageHtml = ""
$delay = 0.1
foreach ($img in $nameplateImages) {
    $imageHtml += @"
            <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
                <div class="project-item">
                    <img class="img-fluid" src="img/ramdev/n-series/$($img.Name)" alt="Name Plates">
                    <a class="project-title h5 mb-0" href="img/ramdev/n-series/$($img.Name)" data-lightbox="gallery"></a>
                </div>
            </div>

"@
    $delay += 0.1
    if ($delay > 1.2) { $delay = 0.1 }
}

$html = $template -replace '{{TITLE}}', 'Name Plates'
$html = $html -replace '{{KEYWORD}}', 'Name Plates, Door Name Plates, Office Name Plates'
$html = $html -replace '{{IMAGES}}', $imageHtml
$html | Out-File -FilePath "ramdev-nameplates.html" -Encoding UTF8
Write-Host "Created ramdev-nameplates.html with $($nameplateImages.Count) images" -ForegroundColor Green

Write-Host ""
Write-Host "Both pages fixed successfully!" -ForegroundColor Green

