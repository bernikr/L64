base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"

locationToBase64 = (lat, lon) ->
  quadKey = toQuadKey(lat, lon, 30)
  splitQK = (quadKey.substr(x*3, 3) for x in [0..quadKey.length/3-1])
  numericKey = (parseInt(qk, 4) for qk in splitQK)
  base64key = (base64.charAt(x) for x in numericKey).join('')

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
