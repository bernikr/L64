drawAccuracy = (lat, lon, length) ->
  dlon = 180/(Math.pow(8,length))
  dlat = 90/(Math.pow(8,length))

  bounds = {
    north: lat+dlat
    south: lat-dlat
    east:  lon+dlon
    west:  lon-dlon
  }

  box.setOptions({
    strokeColor: '#FF0000'
    strokeOpacity: 0.8
    strokeWeight: 2
    fillColor: '#FF0000'
    fillOpacity: 0.35
    map: mapContext.map
    bounds: bounds
  })

setLocation = (l64) ->
  location = base64ToLocation(l64)
  map.locationpicker "location", location
  zoomlevel = if l64.length<6 then l64.length*3 else 17
  mapContext.map.setZoom(zoomlevel)
  drawAccuracy(location.latitude, location.longitude, l64.length)
  window.location.hash = l64
