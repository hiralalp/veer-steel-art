(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner();
    
    
    // Initiate the wowjs
    new WOW().init();


    // Nested dropdown handling with longer delay
    var submenuTimer;
    var currentSubmenu = null;
    
    $('.dropdown-submenu').on('mouseenter', function() {
        var $this = $(this);
        var $submenu = $this.find('> .dropdown-menu');
        
        clearTimeout(submenuTimer);
        
        // Hide other submenus
        if(currentSubmenu && currentSubmenu[0] !== $submenu[0]) {
            currentSubmenu.hide();
        }
        
        $submenu.show();
        currentSubmenu = $submenu;
    });
    
    $('.dropdown-submenu').on('mouseleave', function() {
        var $submenu = $(this).find('> .dropdown-menu');
        submenuTimer = setTimeout(function() {
            $submenu.hide();
        }, 500); // 500ms delay before hiding
    });
    
    // Keep submenu open when hovering over it
    $('.dropdown-submenu > .dropdown-menu').on('mouseenter', function() {
        clearTimeout(submenuTimer);
        $(this).show();
    });
    
    $('.dropdown-submenu > .dropdown-menu').on('mouseleave', function() {
        var $submenu = $(this);
        submenuTimer = setTimeout(function() {
            $submenu.hide();
        }, 500);
    });
    
    // Mobile click handling
    $('.dropdown-menu .dropdown-item.dropdown-toggle').on('click', function(e) {
        if($(window).width() < 992) {
            e.preventDefault();
            var $subMenu = $(this).next(".dropdown-menu");
            $subMenu.slideToggle(200);
            return false;
        }
    });


    // Navbar on scrolling
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.navbar').fadeIn('slow').css('display', 'flex');
        } else {
            $('.navbar').fadeOut('slow').css('display', 'none');
        }
    });


    // Modal Video
    var $videoSrc;
    $('.btn-play').click(function () {
        $videoSrc = $(this).data("src");
    });
    console.log($videoSrc);
    $('#videoModal').on('shown.bs.modal', function (e) {
        $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
    })
    $('#videoModal').on('hide.bs.modal', function (e) {
        $("#video").attr('src', $videoSrc);
    })
    
    
    // Back to top button
    // $(window).scroll(function () {
    //     if ($(this).scrollTop() > 300) {
    //         $('.back-to-top').fadeIn('slow');
    //     } else {
    //         $('.back-to-top').fadeOut('slow');
    //     }
    // });
    // $('.back-to-top').click(function () {
    //     $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
    //     return false;
    // });

    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });

    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });
    // Facts counter
    $('[data-toggle="counter-up"]').counterUp({
        delay: 10,
        time: 2000
    });


    // Testimonials carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: false,
        smartSpeed: 1000,
        margin: 25,
        loop: true,
        center: true,
        dots: false,
        nav: true,
        navText : [
            '<i class="bi bi-chevron-left"></i>',
            '<i class="bi bi-chevron-right"></i>'
        ],
        responsive: {
            0:{
                items:1
            },
            768:{
                items:2
            },
            992:{
                items:3
            }
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        const hoverMedia = window.matchMedia('(min-width: 992px)');
        const hoverDropdowns = document.querySelectorAll('.dropdown-hover');

        hoverDropdowns.forEach(function (dropdown) {
            const toggle = dropdown.querySelector('[data-bs-toggle="dropdown"]');
            if (!toggle) {
                return;
            }

            let showTimer;
            let hideTimer;

            dropdown.addEventListener('mouseenter', function () {
                if (!hoverMedia.matches) {
                    return;
                }
                clearTimeout(hideTimer);
                showTimer = setTimeout(function () {
                    bootstrap.Dropdown.getOrCreateInstance(toggle).show();
                }, 120);
            });

            dropdown.addEventListener('mouseleave', function () {
                if (!hoverMedia.matches) {
                    return;
                }
                clearTimeout(showTimer);
                hideTimer = setTimeout(function () {
                    bootstrap.Dropdown.getOrCreateInstance(toggle).hide();
                }, 140);
            });
        });

        const resetDropdowns = function () {
            if (hoverMedia.matches) {
                return;
            }
            hoverDropdowns.forEach(function (dropdown) {
                const toggle = dropdown.querySelector('[data-bs-toggle="dropdown"]');
                if (!toggle) {
                    return;
                }
                const instance = bootstrap.Dropdown.getInstance(toggle);
                if (instance) {
                    instance.hide();
                }
            });
        };

        if (typeof hoverMedia.addEventListener === 'function') {
            hoverMedia.addEventListener('change', resetDropdowns);
        } else if (typeof hoverMedia.addListener === 'function') {
            hoverMedia.addListener(resetDropdowns);
        }
    });
    
    
})(jQuery);

