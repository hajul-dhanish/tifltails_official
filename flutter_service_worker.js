'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/assets/fonts/roboto_regular.ttf": "11eabca2251325cfc5589c9c6fb57b46",
"assets/assets/fonts/product_sans_regular.ttf": "eae9c18cee82a8a1a52e654911f8fe83",
"assets/assets/fonts/roboto_italic.ttf": "a720f17aa773e493a7ebf8b08459e66c",
"assets/assets/fonts/product_sans_italic.ttf": "e88ec18827526928e71407a24937825a",
"assets/assets/fonts/product_sans_bold.ttf": "dba0c688b8d5ee09a1e214aebd5d25e4",
"assets/assets/fonts/roboto_bold.ttf": "e07df86cef2e721115583d61d1fb68a6",
"assets/assets/images/logo.png": "c0f25dbd0bad28abecb312d220edbb0b",
"assets/assets/images/hero/testimonial.jpg": "006d05754d21088d510831c6365db5af",
"assets/assets/images/hero/dogs_playing.jpg": "61e67518e1af61ad6a9d8d417a953787",
"assets/assets/images/hero/cat.jpg": "085e0cf2a3c615e6a641fb7865bc7f58",
"assets/assets/images/hero/foster_dog.jpg": "319eb7d71f059b19dcd8fb4d2109215b",
"assets/assets/images/hero/pet_rocky.jpg": "d532a20c6aeee3609cbd2f73f2837a8b",
"assets/assets/images/hero/pet_max.jpg": "69ffbe419a03fea0aeec17606dfbfc6e",
"assets/assets/images/hero/parent_pet.jpg": "fd9264d213d3a3debd4541963f4b67c8",
"assets/assets/docs/priivacy_policy.md": "eaaf2ddafbc5ac7c88ba17b817f18480",
"assets/assets/docs/PRIVACY_POLICY.md": "eaaf2ddafbc5ac7c88ba17b817f18480",
"assets/NOTICES": "a03ad02e1024dcf1f35ab898fe133875",
"assets/fonts/MaterialIcons-Regular.otf": "f0b70b6d6f49e4db3f5cb1ba2b8b4895",
"assets/AssetManifest.json": "c5fbeb475826bc1af5b22fb47f81876a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "277df259a6b4de0c68481e262c8a9b95",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "94a60abc8281d69eb696ec3e9caa1c93",
"assets/AssetManifest.bin": "2193df92c10620687cd816bd8c94f181",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"icons/Icon-maskable-192.png": "468a6d66edc1e5a26e44fce180fe9f7e",
"icons/Icon-512.png": "793c01cacf76aacaf8ebd044e29b3ebe",
"icons/Icon-192.png": "468a6d66edc1e5a26e44fce180fe9f7e",
"icons/Icon-maskable-512.png": "793c01cacf76aacaf8ebd044e29b3ebe",
"favicon.png": "59eefc59a8eb97c4bbc6794df2953a19",
"manifest.json": "6d6abc8e03b3c84a7064b14b61141355",
"main.dart.js": "b93c0bd78778e20ceccac5e2d69d22b2",
"index.html": "40e5ff06bb61842777d92d6b185d4759",
"/": "40e5ff06bb61842777d92d6b185d4759",
"version.json": "44d260bcc5f00c55fd8e9f2a6f69d199",
"landing.html": "891765c4275f4f87cb272a138d0a7f3e",
"flutter_bootstrap.js": "c5635f97a0a3bbeb786f5eb790648389",
"404.html": "d6539691bbc633ed1d1482e1b35b46a6"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
