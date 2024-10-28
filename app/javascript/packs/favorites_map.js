// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});


// ライブラリの読み込み
let map;

/* global google */
async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記

  // 地図の中心と倍率は公式から変更しています。
  map = new Map(document.getElementById("map"), {
    center: { lat: 33.8713748, lng: 130.8536961 },
    zoom: 10,
    mapId: "DEMO_MAP_ID", // 追記
    mapTypeControl: false
  });

  // URLのクエリ文字列を取得
  const queryString = window.location.search;

  // URLSearchParamsオブジェクトを作成してクエリ文字列を解析
  const params = new URLSearchParams(queryString);

  // 特定のパラメータの値を取得
  const paramValue = params.get('id');

  // 追記
  /* global fetch */
  try {
    const response = await fetch(`/users/${paramValue}/favorites.json`);

    if (!response.ok) throw new Error('Network response was not ok');

    const { data: { items } } = await response.json();
    if (!Array.isArray(items)) throw new Error("Items is not an array");

    items.forEach( item => {
      const latitude = item.latitude;
      const longitude = item.longitude;
      const shopName = item.shop;
      const reviewID = item.id;
            // 追記
      const postImage = item.image;
      const address = item.address;
      const genre = item.genre;
      const favorites = item.favorites;

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
        title: shopName,
        // 他の任意のオプションもここに追加可能
      });
      // 追記
      const contentString = `
        <div class="information container p-0">
          <div class="d-flex align-items-center">
            <h1 class="h4 font-weight-bold"><a href="/reviews/${reviewID}">${shopName}</a></h1>
          </div>
          <div>
            <p><strong>${genre}</strong></p>
            <img class="thumbnail mb-2 d-block mx-auto" src="${postImage}" loading="lazy">
            <div class="text-muted mb-3">${address}</div>
            <div class="d-flex">
              <div class="text-muted">♥</div>
              <div class="text-muted ml-1">:${favorites}件</div>
            </div>
          </div>
        </div>
      `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: shopName,
      });

      marker.addListener("click", () => {
          infowindow.open({
          anchor: marker,
          map,
        })
      });
    });
  } catch (error) {
    console.error('Error fetching or processing post images:', error);
  }
}

initMap()