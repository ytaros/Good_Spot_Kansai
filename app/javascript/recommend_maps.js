window.loadGoogleMapsAPI = function (apiKey) {
  return new Promise((resolve, reject) => {
    if (window.google && window.google.maps) {
      resolve();
      return;
    }

    window.initMapCallback = () => resolve();
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&libraries=geometry&callback=initMapCallback`;
    script.async = true;
    document.head.appendChild(script);
  });
};

window.setupRecommendMap = function (apiKey) {
  loadGoogleMapsAPI(apiKey).then(() => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const map = initMap(
            position.coords.latitude,
            position.coords.longitude
          );
          setupMapListeners(map);
        },
        () => {
          const map = initMap(34.702485, 135.495951);
          setupMapListeners(map);
        }
      );
    } else {
      const map = initMap(34.702485, 135.495951);
      setupMapListeners(map);
    }
  });
};

let debounceTimer;
let lastCenter = null;
const minDistanceToUpdate = 5000;

function setupMapListeners(map) {
  map.addListener("center_changed", () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => fetchAndDisplayArticles(map), 5000);
  });
  map.addListener("zoom_changed", () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => fetchAndDisplayArticles(map), 5000);
  });
}

function shouldFetchArticles(newCenter) {
  if (!lastCenter) return true;
  const distanceMoved = google.maps.geometry.spherical.computeDistanceBetween(
    newCenter,
    lastCenter
  );
  return distanceMoved > minDistanceToUpdate;
}

function fetchAndDisplayArticles(map) {
  const currentLocation = map.getCenter();
  if (!shouldFetchArticles(currentLocation)) return;

  lastCenter = currentLocation;

  const radius = 10000;

  fetch(
    `/articles/recommend?latitude=${currentLocation.lat()}&longitude=${currentLocation.lng()}&radius=${radius}`,
    {
      headers: { Accept: "application/json" },
    }
  )
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((articles) => {
      const filteredArticles = articles.filter((article) => {
        const articleLocation = new google.maps.LatLng(
          article.latitude,
          article.longitude
        );
        return (
          google.maps.geometry.spherical.computeDistanceBetween(
            articleLocation,
            currentLocation
          ) <= radius
        );
      });

      placeMarkers(map, filteredArticles);
      displayArticlesBelowMap(filteredArticles);
    })
    .catch((error) => console.error("Error:", error));
}

function displayArticlesBelowMap(articles) {
  const articlesContainer = document.getElementById("articles-container");
  articlesContainer.innerHTML = "";

  articles.forEach((article) => {
    const articleElement = document.createElement("div");
    articleElement.className =
      "flex flex-col items-center overflow-hidden rounded-lg border md:flex-row";

    const imageElement = document.createElement("div");
    imageElement.className =
      "group relative block h-48 w-full shrink-0 self-start overflow-hidden bg-gray-100 md:h-full md:w-32 lg:w-48";

    if (article.photos && article.photos.length > 0) {
      const articleLink = document.createElement("a");
      articleLink.href = `/articles/${article.id}`;

      const img = document.createElement("img");
      img.src = article.photos[0];
      img.className =
        "absolute inset-0 h-full w-full object-cover object-center transition duration-200 group-hover:scale-110";
      img.alt = `Photo from ${article.title}`;

      articleLink.appendChild(img);
      imageElement.appendChild(articleLink);
    }

    articleElement.appendChild(imageElement);

    const detailsElement = document.createElement("div");
    detailsElement.className = "flex flex-col gap-2 p-4 lg:p-6";
    detailsElement.innerHTML = `
      <span class="block text-sm text-gray-400">${new Date(
        article.created_at
      ).toLocaleDateString()}</span>
      <h2 class="text-md font-bold text-gray-800">${article.title}</h2>
      <p class="text-gray-500">${
        article.tag ? article.tag.name : "タグ未設定"
      }</p>
      <p class="text-gray-500">${
        article.city ? article.city.name : "都市未設定"
      }</p>
    `;

    articleElement.appendChild(detailsElement);

    articlesContainer.appendChild(articleElement);
  });
}

window.initMap = function (latitude, longitude, mapElementId = "map") {
  const mapElement = document.getElementById(mapElementId);
  if (!mapElement) {
    console.error("Map element not found");
    return;
  }
  const kinkiRegionBounds = {
    north: 35.5,
    south: 34.0,
    west: 134.0,
    east: 136.0,
  };

  if (
    latitude > kinkiRegionBounds.south &&
    latitude < kinkiRegionBounds.north &&
    longitude > kinkiRegionBounds.west &&
    longitude < kinkiRegionBounds.east
  ) {
    var location = { lat: latitude, lng: longitude };
  } else {
    var location = { lat: 34.702485, lng: 135.495951 };
  }

  const mapOptions = {
    zoom: 12,
    center: location,
    mapTypeControl: false,
    streetViewControl: false,
  };

  const map = new google.maps.Map(mapElement, mapOptions);

  new google.maps.Marker({
    position: location,
    map: map,
    title: "現在地",
    icon: { url: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png" },
  });

  map.addListener("center_changed", () => {
    fetchAndDisplayArticles(map);
  });

  fetchAndDisplayArticles(map);
};

function placeMarkers(map, articles) {
  const infowindow = new google.maps.InfoWindow();
  articles.forEach((article) => {
    const lat = article.latitude;
    const lng = article.longitude;

    if (!lat || !lng) {
      console.error("Invalid article location data:", article);
      return;
    }

    const markerLocation = new google.maps.LatLng(lat, lng);

    if (
      google.maps.geometry.spherical.computeDistanceBetween(
        markerLocation,
        map.getCenter()
      ) <= 10000
    ) {
      const marker = new google.maps.Marker({
        position: markerLocation,
        map: map,
      });

      marker.addListener("click", () => {
        const contentString = `
          <div>
            <h3>${article.title}</h3>
            <p>住所: ${article.address}</p>
            <p>カテゴリー: ${
              article.category ? article.category.name : "未設定"
            }</p>
            <p>タグ: ${article.tag ? article.tag.name : "未設定"}</p>
          </div>
        `;
        infowindow.setContent(contentString);
        infowindow.open(map, marker);
      });
    }
  });
}
