App.filter 'tease', ->
  (input, maxLength=50)->
    return "" if !input?
    return input if input.length <= maxLength
    "#{input[0..(maxLength-1)]}..."
