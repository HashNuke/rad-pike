App.filter 'readableTime', ->
  (input)->
    d = new Date(input)
    sample = new Date()
    if ((sample.getTime() - d.getTime())/1000) < 86400
      moment(d).fromNow()
    else if d.getFullYear()  == sample.getFullYear()
      moment(d).format("D MMM")
    else
      moment(d).format("D MMM-YYYY h:mma")
