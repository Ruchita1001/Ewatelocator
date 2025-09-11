<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>E-Waste Facility Locator</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  <script src="https://unpkg.com/leaflet-routing-machine/dist/leaflet-routing-machine.js"></script>
  <script src="https://code.responsivevoice.org/responsivevoice.js"></script>
  <style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
    #map { height: 500px; }
    #searchContainer { margin: 10px; text-align: center; }
    #searchResults { list-style: none; padding: 0; }
    #searchResults li { padding: 5px; cursor: pointer; border-bottom: 1px solid #ddd; }
    #searchResults li:hover { background: #f0f0f0; }
    header { background: #333; color: white; padding: 10px; text-align: right; }
    header a { color: white; margin: 0 10px; text-decoration: none; }
    #startNav { display: none; margin: 10px; padding: 10px; background: blue; color: white; cursor: pointer; border: none; }
  </style>
</head>
<body>
  <header>
    <a href="scanreward.html">Scan QR Code</a> 
    <a href="viewreward.jsp">View Rewards</a> 
    <a href="UserProfileShow.jsp">User Profile</a>
    <a href="feedback.jsp">Feedback</a>
    <a href="UserLogout.jsp">Logout</a>
  </header>

  <div id="searchContainer">
    <input type="text" id="search" placeholder="Search E-Waste Center...">
    <ul id="searchResults"></ul>
  </div>

  <button id="startNav">Start Navigation</button>

  <div id="map"></div>

  <script>
    let map = L.map('map').setView([22.7196, 75.8577], 13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

    let userMarker = null;
    let userLat = 22.7196; // fallback default
    let userLon = 75.8577;

    let routeControl = null;

    let eWasteCenters = [
      { name: "E Waste Samadhan", lat: 22.69815, lon: 75.78995 },
      { name: "Moonstar Enterprises", lat: 22.76791, lon: 75.85119 },
      { name: "Unique Eco Recycle", lat: 22.68758, lon: 75.90094 }
    ];

    let markers = {};
    eWasteCenters.forEach(center => {
      let marker = L.marker([center.lat, center.lon], {
        icon: L.icon({
          iconUrl: 'https://maps.google.com/mapfiles/ms/icons/red-dot.png',
          iconSize: [30, 30]
        })
      }).addTo(map).bindPopup(center.name);
      markers[center.name] = marker;
    });

    function trackUser() {
      if (navigator.geolocation) {
        navigator.geolocation.watchPosition(position => {
          userLat = position.coords.latitude;
          userLon = position.coords.longitude;

          if (userMarker) {
            userMarker.setLatLng([userLat, userLon]);
          } else {
            userMarker = L.marker([userLat, userLon], { icon: L.icon({
              iconUrl: 'https://maps.google.com/mapfiles/ms/icons/blue-dot.png',
              iconSize: [30, 30]
            }) }).addTo(map).bindPopup("Your Location");
          }
        }, error => {
          console.error("Location access denied or error:", error);
        });
      } else {
        alert("Geolocation is not supported by this browser.");
      }
    }

    let searchInput = document.getElementById("search");
    let searchResults = document.getElementById("searchResults");
    let startNavBtn = document.getElementById("startNav");

    searchInput.addEventListener("input", function () {
      let query = searchInput.value.toLowerCase();
      searchResults.innerHTML = "";

      if (query.length > 0) {
        eWasteCenters.forEach(center => {
          if (center.name.toLowerCase().includes(query)) {
            let li = document.createElement("li");
            li.textContent = center.name;
            li.addEventListener("click", function () {
              searchInput.value = "";
              searchResults.innerHTML = "";
              let latLng = L.latLng(center.lat, center.lon);
              markers[center.name].openPopup();

              if (routeControl) {
                map.removeControl(routeControl);
              }

              let from = L.latLng(userLat, userLon); // now uses updated GPS location
              routeControl = L.Routing.control({
                waypoints: [from, latLng],
                routeWhileDragging: false
              }).addTo(map);

              startNavBtn.style.display = "block";
              startNavBtn.onclick = function () {
                startVoiceNavigation([from, latLng]);
              };
            });
            searchResults.appendChild(li);
          }
        });
      }
    });

    function startVoiceNavigation(waypoints) {
      let i = 0;
      function announceStep() {
        if (i < waypoints.length) {
          let step = waypoints[i];
          map.setView(step, 15);
          responsiveVoice.speak("Proceed to the next point");
          i++;
          setTimeout(announceStep, 5000);
        } else {
          responsiveVoice.speak("You have arrived at your destination");
        }
      }
      announceStep();
    }

    trackUser(); // start tracking as soon as page loads
  </script>
</body>
</html>
