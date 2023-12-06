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

// 地図の中心やズームが変わるたびに記事を更新
function setupMapListeners(map) {
  map.addListener("center_changed", () => fetchAndDisplayArticles(map));
  map.addListener("zoom_changed", () => fetchAndDisplayArticles(map));
}

// 記事をフェッチして表示する関数（改良版）
function fetchAndDisplayArticles(map) {
  const currentLocation = map.getCenter();
  const radius = 20000; // 30km

  fetch(
    `/articles/recommend?latitude=${currentLocation.lat()}&longitude=${currentLocation.lng()}&radius=${radius}`,
    {
      headers: { Accept: "application/json" },
    }
  )
    .then((response) => response.json())
    .then((articles) => {
      // 現在地から30km以内の記事のみを表示
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
  articlesContainer.innerHTML = ""; // コンテナをクリア

  articles.forEach((article) => {
    // 記事のHTML要素を生成
    const articleElement = document.createElement("div");
    articleElement.className =
      "flex flex-col items-center overflow-hidden rounded-lg border md:flex-row";

    // 記事の画像コンテナ（存在する場合）
    const imageElement = document.createElement("div");
    imageElement.className =
      "group relative block h-48 w-full shrink-0 self-start overflow-hidden bg-gray-100 md:h-full md:w-32 lg:w-48";

    // 記事の画像（存在する場合）
    if (article.photos && article.photos.length > 0) {
      // リンク要素を作成し、画像をラップ
      const articleLink = document.createElement("a");
      articleLink.href = `/articles/${article.id}`; // Railsのarticle_pathに相当するURL

      const img = document.createElement("img");
      img.src = article.photos[0]; // 最初の写真のURL
      img.className =
        "absolute inset-0 h-full w-full object-cover object-center transition duration-200 group-hover:scale-110";
      img.alt = `Photo from ${article.title}`;

      // 画像をリンク要素に追加
      articleLink.appendChild(img);
      // リンク要素を画像コンテナに追加
      imageElement.appendChild(articleLink);
    }

    // 画像コンテナを記事要素に追加
    articleElement.appendChild(imageElement);

    // 記事の詳細要素
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

    // 詳細要素を記事要素に追加
    articleElement.appendChild(detailsElement);

    // 完成した記事要素をarticlesContainerに追加
    articlesContainer.appendChild(articleElement);
  });
}

window.initMap = function (latitude, longitude, mapElementId = "map") {
  const kinkiRegionBounds = {
    north: 35.5,
    south: 34.0,
    west: 134.0,
    east: 136.0,
  };

  // ユーザーの位置が近畿地方内かどうかを判断
  if (
    latitude > kinkiRegionBounds.south &&
    latitude < kinkiRegionBounds.north &&
    longitude > kinkiRegionBounds.west &&
    longitude < kinkiRegionBounds.east
  ) {
    // 近畿地方内の場合、ユーザーの位置を使用
    var location = { lat: latitude, lng: longitude };
  } else {
    // 近畿地方外の場合、大阪駅の位置を使用
    var location = { lat: 34.702485, lng: 135.495951 };
  }

  // 地図オプションの設定と地図の生成
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
