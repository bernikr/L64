base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"

locationToL64 = (lat, lon, length) ->
  quadKey = locationToQuadKey(lat, lon, length*3)
  splitQK = (quadKey.substr(x*3, 3) for x in [0..quadKey.length/3-1])
  numericKey = (parseInt(qk, 4) for qk in splitQK)
  base64Location = (base64.charAt(x) for x in numericKey).join('')

l64ToLocation = (base64Location) ->
  chars = base64Location.split('')
  numericKey = (base64.indexOf(char) for char in chars)
  quadKey = (("00" + num.toString(4)).slice(-3) for num in numericKey).join('')
  location = quadKeyToLocation(quadKey)

locationToQuadKey = (lat, lon, level) ->
  mapSize = 1 << level

  x = (lon / 360 + 0.5) * mapSize
  y = (lat / 180 + 0.5) * mapSize

  quadKey = ""
  for i in [level..1]
    digit = 0
    mask = 1 << (i-1)
    digit += 1 if (x & mask) != 0
    digit += 2 if (y & mask) != 0
    quadKey += digit
  quadKey

quadKeyToLocation = (qk) ->
  [x, y] = [0, 0]
  offset = 90
  for square in qk.split('')
    switch parseInt(square)
      when 0 then x -= offset; y -= offset
      when 1 then x += offset; y -= offset
      when 2 then x -= offset; y += offset
      when 3 then x += offset; y += offset
    offset *= 0.5
  output =
   lon: x
   lat:  y/2
