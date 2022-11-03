$(document).ready(function(){

    $('.owl-carousel').owlCarousel({
        loop:true,
         nav:true,
        // margin:30,
        responsiveClass:true,
        center:true,
        responsive:{
            0:{
                items:1,
               
            },
            600:{
                items:3,
               
            },
            1000:{
                items:4,
            }
        }
    })
})
