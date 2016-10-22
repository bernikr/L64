---
---

{% include_relative convert.coffee %}

map = {}

onNewPosition = (location) ->
  base64address = locationToBase64(location.latitude, location.longitude, 8)
  $('#addressField').val base64address

onInput = (e) ->
  location = base64ToLocation(e.target.value)
  map.locationpicker "location", location

$ ->
  map = $('#map').locationpicker
    radius: 0
    onchanged: onNewPosition
    markerInCenter: true
  $('#addressField').change onInput
