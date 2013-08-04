App.filter 'tease', ->
  (input, maxLength=50)->
    console.log input.length
    return input if input.length <= maxLength
    "#{input[0..(maxLength-1)]}..."
