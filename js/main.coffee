---
---

{% include_relative convert.coffee %}

map = {}
mapContext = {}
box = {}

onNewPosition = (location) ->
  base64address = locationToBase64(location.latitude, location.longitude, 8)
  drawAccuracy(location.latitude, location.longitude, 8)
  $('#addressField').val base64address

onInput = (e) ->
  input = e.target.value
  if input != ''
    location = base64ToLocation(input)
    map.locationpicker "location", location
    mapContext.map.setZoom(input.length*3)
    drawAccuracy(location.latitude, location.longitude, input.length)


$ ->
  map = $('#map').locationpicker
    radius: 0
    onchanged: onNewPosition
  $('#addressField').change onInput
  mapContext = map.locationpicker 'map'
  box = new google.maps.Rectangle()

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
