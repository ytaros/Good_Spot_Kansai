// Google Maps APIをロードするための関数
window.loadGoogleMapsAPI = function (apiKey) {
  return new Promise((resolve, reject) => {
    window.initMapCallback = () => resolve();
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&libraries=geometry&callback=initMapCallback`;
    script.async = true;
    document.head.appendChild(script);
  });
};

// マップをセットアップする関数
window.setupRecommendMap = function (apiKey) {
  loadGoogleMapsAPI(apiKey).then(() => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) =>
          initMap(position.coords.latitude, position.coords.longitude),
        () => initMap(34.702485, 135.495951) // デフォルトの位置（大阪駅）
      );
    } else {
      initMap(34.702485, 135.495951); // デフォルトの位置（大阪駅）
    }
  });
};

// 地図を初期化する関数
window.initMap = function (latitude, longitude, mapElementId = "map") {
  const location = { lat: latitude, lng: longitude };
  const mapOptions = {
    zoom: 12,
    center: location,
    mapTypeControl: false,
    streetViewControl: false,
  };
  const map = new google.maps.Map(
    document.getElementById(mapElementId),
    mapOptions
  );

  // 現在地のマーカーを設定
  new google.maps.Marker({
    position: location,
    map: map,
    title: "現在地",
    icon: { url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" },
  });

  // 地図の中心が変わるたびに記事を更新
  map.addListener("center_changed", () => {
    fetchAndDisplayArticles(map);
  });

  // 初期記事のフェッチ
  fetchAndDisplayArticles(map);
};

// マーカーを設置し、記事の情報を表示する関数
function placeMarkers(map, articles) {
  const infowindow = new google.maps.InfoWindow();
  articles.forEach((article) => {
    // latitude と longitude の値を取得
    const lat = article.latitude;
    const lng = article.longitude;

    if (!lat || !lng) {
      console.error("Invalid article location data:", article);
      return; // 緯度または経度が無効な場合はスキップ
    }

    const markerLocation = new google.maps.LatLng(lat, lng);

    // 現在地から30km以内の記事のみにマーカーを設置
    if (
      google.maps.geometry.spherical.computeDistanceBetween(
        markerLocation,
        map.getCenter()
      ) <= 30000
    ) {
      const marker = new google.maps.Marker({
        position: markerLocation,
        map: map,
      });

      // マーカーのクリックイベントを設定
      marker.addListener("click", () => {
        const contentString = `
          <div>
            <h3>${article.title}</h3>
            <p>住所: ${article.address}</p>
          </div>
        `;
        infowindow.setContent(contentString);
        infowindow.open(map, marker);
      });
    }
  });
}

// 記事をフェッチして表示する関数
function fetchAndDisplayArticles(map) {
  const currentLocation = map.getCenter();
  fetch(
    `/articles/recommend?latitude=${currentLocation.lat()}&longitude=${currentLocation.lng()}`,
    {
      headers: { Accept: "application/json" },
    }
  )
    .then((response) => response.json())
    .then((articles) => {
      placeMarkers(map, articles);
    })
    .catch((error) => console.error("Error:", error));
}
