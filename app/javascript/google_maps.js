export function initGoogleMap(latitude, longitude) {
  const location = { lat: latitude, lng: longitude };
  const map = new google.maps.Map(document.getElementById("map2"), {
    zoom: 15,
    center: location,
  });

  const marker = new google.maps.Marker({
    position: location,
    map: map,
    mapTypeControl: false,
    streetViewControl: false,
  });

  const service = new google.maps.places.PlacesService(map);

  marker.addListener("click", function () {
    service.nearbySearch(
      {
        location: location,
        radius: 50,
      },
      function (results, status) {
        if (
          status === google.maps.places.PlacesServiceStatus.OK &&
          results.length > 0
        ) {
          const placeId = results[0].place_id;

          service.getDetails(
            {
              placeId: placeId,
            },
            function (place, status) {
              if (status === google.maps.places.PlacesServiceStatus.OK) {
                const infowindow = new google.maps.InfoWindow({
                  content:
                    "<div><strong>" +
                    place.name +
                    "</strong><br>" +
                    "Rating: " +
                    place.rating +
                    "</div>",
                });
                infowindow.open(map, marker);
              }
            }
          );
        }
      }
    );
  });
}

export function loadGoogleMapsAPI(apiKey) {
  const script = document.createElement("script");
  script.type = "text/javascript";
  script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&libraries=places&callback=initGoogleMap`;
  document.body.appendChild(script);
}
