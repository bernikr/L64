---
---

{% include_relative convert.coffee %}

onNewPosition = (location) ->
  console.log(locationToBase64(location.latitude, location.longitude))

$ ->
  $('#map').locationpicker
    radius: 0
    onchanged: onNewPosition
