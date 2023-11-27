window.initMap = function (lat, lng) {
  var location = { lat: lat, lng: lng };
  var map = new google.maps.Map(document.getElementById("map"), {
    zoom: 15,
    center: location,
  });
  var marker = new google.maps.Marker({
    position: location,
    map: map,
  });
};
