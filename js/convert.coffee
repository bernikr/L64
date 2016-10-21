toQuadKey = (lat, lon, level) ->
  mapSize = 1 << level

  x = (lon + 180) / 360
  sinLatitude = Math.sin(lat * Math.PI / 180)
  y = 0.5 - Math.log((1 + sinLatitude) / (1 - sinLatitude)) / (4 * Math.PI)

  x2 = x * mapSize
  y2 = y * mapSize

  quadKey = ""
  for i in [level..1]
    digit = 0
    mask = 1 << (i-1)
    digit += 1 if (x2 & mask) != 0
    digit += 2 if (y2 & mask) != 0
    quadKey += digit
  quadKey

splitQuadKey = (qk) -> (qk.substr(x*5, 5) for x in [0..qk.length/5-1])

base4toInt = (num) -> parseInt(num, 4)
