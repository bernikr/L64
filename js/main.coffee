---
---

map = {}
mapContext = {}
box = {}

{% include_relative convert.coffee %}
{% include_relative functions.coffee %}

onNewPosition = (location) ->
  l64 = locationToBase64(location.latitude, location.longitude, 8)
  drawAccuracy(l64)
  $('#addressField').val l64
  window.location.hash = l64

onInput = (e) ->
  input = e.target.value
  setLocation(input) if input != ''

$ ->
  map = $('#map').locationpicker
    radius: 0
    onchanged: onNewPosition
  $('#addressField').change onInput
  mapContext = map.locationpicker 'map'
  box = new google.maps.Rectangle()

  if window.location.hash
    l64 = window.location.hash.substr(1)
    setLocation(l64)
    $('#addressField').val l64
