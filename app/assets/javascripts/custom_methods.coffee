Array.prototype.include = (value) ->
  result = false
  for e in @
    if e is value
      result = true
      break
  result

