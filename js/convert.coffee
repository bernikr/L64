base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"

locationToL64 = (lat, lon, length) ->
  # normalize the coordinates to be in the range 0..1
  x = (lon / 360 + 0.5)
  y = (lat / 180 + 0.5)

  # transform the coordinates to a binary tree per coordinate
  [x,y] = (pad(c.toString(2).substr(2), length*3) for c in [x,y])

  # combine the binary trees into a single one by alternating digits
  binaryTree = ''
  for i in [0...length*3]
    binaryTree += y.charAt(i) + x.charAt(i)

  # split the binary tree in 6 bit chunks and convert them to base64
  splitBT = (binaryTree.substr(x, 6) for x in [0...binaryTree.length] by 6)
  base64Location = (base64.charAt(parseInt(x, 2)) for x in splitBT).join('')

l64ToLocation = (base64Location) ->
  # convert the L64 location into the binary tree by changing the basis
  chars = base64Location.split('')
  numericKey = (base64.indexOf(char) for char in chars)
  binaryTree = (pad(num.toString(2),6, true) for num in numericKey).join('')

  # split the binary tree into the trees for x and y
  [x, y] = ['','']
  for i in [0...binaryTree.length] by 2
    y += binaryTree.charAt(i)
    x += binaryTree.charAt(i+1)

  # convert the binary tree into coordinates between 0 and 1
  [x,y] = ((parseInt(c, 2)+0.5)/Math.pow(2, binaryTree.length/2) for c in [x,y])

  # transform the normalized coordinates back into lat and lon
  location =
    lon: (x - 0.5) * 360
    lat: (y - 0.5) * 180

# function to left or right pad numbers with 0s to a wished length
pad = (str, length, padLeft) ->
  padding = '0'.repeat(length)
  if padLeft
    (padding + str).slice(-length)
  else
    (str + padding).substring(0, length)
