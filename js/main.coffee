---
---

map =
  map: {}
  box: {}
  marker: {}

{% include_relative convert.coffee %}
{% include_relative functions.coffee %}

$ ->
  map.box = new google.maps.Rectangle()

  initMap()

  if window.location.hash
    l64 = window.location.hash.substr(1)
    setLocation(l64)
    $('#addressField').val l64

  google.maps.event.addListener(map.marker, 'dragend', onNewPosition)
  $('#addressField').change onInput
