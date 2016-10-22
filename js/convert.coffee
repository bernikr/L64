toQuadKey = (lat, lon, level) ->
  mapSize = 1 << level

  x = (lon + 180) / 360 * mapSize
  y = (lat + 90 ) / 180 * mapSize

  quadKey = ""
  for i in [level..1]
    digit = 0
    mask = 1 << (i-1)
    digit += 1 if (x & mask) != 0
    digit += 2 if (y & mask) != 0
    quadKey += digit
  quadKey

splitQuadKey = (qk) -> (qk.substr(x*5, 5) for x in [0..qk.length/5-1])

base4toInt = (num) -> parseInt(num, 4)
