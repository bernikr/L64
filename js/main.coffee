---
---

wordList = []

{% include_relative convert.coffee %}

onNewPosition = (location) ->
  quadKey = toQuadKey(location.latitude, location.longitude, 30)
  splitQK = splitQuadKey(quadKey)
  numericKey = (parseInt(qk, 4) for qk in splitQK)
  words = (wordList[nk] for nk in numericKey)

  console.log(words)

$ ->
  $('#map').locationpicker
    radius: 0
    onchanged: onNewPosition

  $.get 'words.txt', (data) ->
    wordList = data.split('\n')
