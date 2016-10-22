onNewPosition = (e) ->
  lat = e.latLng.lat()
  lon = e.latLng.lng()
  l64 = locationToL64(lat, lon, 8)
  drawAccuracy(l64)
  $('#addressField').val l64
  window.location.hash = l64

onInput = (e) ->
  input = e.target.value
  setLocation(input) if input != ''

drawAccuracy = (l64) ->
  loc = l64ToLocation(l64)

  dlon = 180/(Math.pow(8,l64.length))
  dlat = 90/(Math.pow(8,l64.length))

  bounds = {
    north: loc.lat+dlat
    south: loc.lat-dlat
    east:  loc.lon+dlon
    west:  loc.lon-dlon
  }

  map.box.setOptions({
    strokeColor: '#FF0000'
    strokeOpacity: 0.8
    strokeWeight: 2
    fillColor: '#FF0000'
    fillOpacity: 0.35
    map: map.map
    bounds: bounds
  })

setLocation = (l64) ->
  loc = l64ToLocation(l64)
  map.marker.setOptions({position: {lat: loc.lat, lng: loc.lon}})
  map.map.setOptions({center: {lat: loc.lat, lng: loc.lon}})
  zoomlevel = if l64.length<6 then l64.length*3 else 17
  map.map.setZoom(zoomlevel)
  drawAccuracy(l64)
  window.location.hash = l64

initMap = ->
  map.map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 0, lng: 0}
    zoom: 2
  })
  map.marker = new google.maps.Marker({
    position: {lat: 0, lng: 0}
    map: map.map
    draggable: true
  })
