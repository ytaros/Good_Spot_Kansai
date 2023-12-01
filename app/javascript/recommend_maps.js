// 地図の初期化
window.initMap = function (latitude, longitude, mapElementId = "map") {
  const location = { lat: latitude, lng: longitude };
  const mapOptions = {
    zoom: 12, // ズームレベル
    center: location,
  };
  const map = new google.maps.Map(
    document.getElementById(mapElementId),
    mapOptions
  );

  const userLocationMarker = new google.maps.Marker({
    position: location,
    map: map,
    title: "現在地",
    icon: {
      url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png", // ここで色を指定
    },
  });
  fetchAndDisplayArticles(map);
};

// 記事をフェッチしてマーカーを表示
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
      displayArticles(articles); // 追加する関数
    })
    .catch((error) => console.error("Error:", error));
}

function displayArticles(articles) {
  const articlesContainer = document.getElementById("articles-container");
  articlesContainer.innerHTML = ""; // コンテナをクリア

  articles.forEach((article) => {
    // ここで各記事のHTMLを生成し、articlesContainerに追加
    const articleDiv = document.createElement("div");
    articleDiv.className = "article"; // 適切なクラスを設定
    articleDiv.innerHTML = `
      <div class="flex flex-col items-center overflow-hidden rounded-lg border md:flex-row">
        <a href="${
          article.url
        }" class="group relative block h-48 w-full shrink-0 self-start overflow-hidden bg-gray-100 md:h-full md:w-32 lg:w-48">
          <img src="${article.photo.first}" alt="${
      article.title
    }" class="absolute inset-0 h-full w-full object-cover object-center transition duration-200 group-hover:scale-110"/>
        </a>
        <div class="flex flex-col gap-2 p-4 lg:p-6">
          <span class="block text-sm text-gray-400">${new Date(
            article.created_at
          ).toLocaleDateString()}</span>
          <h2 class="text-md font-bold text-gray-800">
            <a href="${
              article.url
            }" class="transition duration-100 hover:text-indigo-500 active:text-indigo-600">${
      article.title
    }</a>
          </h2>
          <p class="text-gray-500">${article.category.name}</p>
          <div>
            <span class="text-sm text-gray-400">${article.city.name}</span>
          </div>
        </div>
      </div>
    `;
    articlesContainer.appendChild(articleDiv);
  });
}

// マーカーの配置
function placeMarkers(map, articles) {
  const infowindow = new google.maps.InfoWindow();

  articles.forEach((article) => {
    const markerLocation = new google.maps.LatLng(
      article.latitude,
      article.longitude
    );
    const marker = new google.maps.Marker({
      position: markerLocation,
      map: map,
    });

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
  });
}

// Google Maps APIのロード
window.loadGoogleMapsAPI = function (apiKey) {
  return new Promise((resolve, reject) => {
    window.initMapCallback = () => resolve();
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMapCallback`;
    script.async = true;
    document.head.appendChild(script);
  });
};

// マップのセットアップ
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

  window.fetchAndDisplayArticles = function (map) {
    const currentLocation = map.getCenter();
    fetch(
      `/articles/recommend?latitude=${currentLocation.lat()}&longitude=${currentLocation.lng()}`,
      {
        headers: {
          Accept: "application/json",
        },
      }
    )
      .then((response) => response.json())
      .then((articles) => {
        // フェッチした記事データでマーカーを配置
        articles.forEach((article) => {
          const markerLocation = new google.maps.LatLng(
            article.latitude,
            article.longitude
          );
          new google.maps.Marker({
            position: markerLocation,
            map: map,
          });
        });
      })
      .catch((error) => console.error("Error fetching articles:", error));
  };

  function placeMarkers(map, articles) {
    const infowindow = new google.maps.InfoWindow();

    articles.forEach((article) => {
      const markerLocation = new google.maps.LatLng(
        article.latitude,
        article.longitude
      );
      const marker = new google.maps.Marker({
        position: markerLocation,
        map: map,
      });

      // マーカーをクリックした時のイベント
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
    });
  }
};
