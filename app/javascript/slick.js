document.addEventListener("turbo:before-cache", function () {
  if ($(".container-mx-auto").hasClass("slick-initialized")) {
    $(".container-mx-auto").slick("unslick");
  }
});

function initializeSlick() {
  $(".container-mx-auto")
    .not(".slick-initialized")
    .slick({
      infinite: true,
      speed: 300,
      slidesToShow: 1,
      centerMode: true,
      variableWidth: true,
      prevArrow: $("#prevArrow"),
      nextArrow: $("#nextArrow"),
    })
    .show();
}

document.removeEventListener("turbo:load", initializeSlick);
document.addEventListener("turbo:load", initializeSlick);
