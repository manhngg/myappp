$( document ).on('turbolinks:load', function() {
  var swiper = new Swiper('.swiper-container',
    {
      slidesPerView: 4,
      autoplay: {
        delay: 2500,
        disableOnInteraction: false,
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
});
