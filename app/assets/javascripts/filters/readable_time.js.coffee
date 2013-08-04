App.filter 'readableTime', ->
  (input)->
    d = new Date(input)
    sample = new Date()
    if (d.getTime() - sample.getTime()) < 86400
      moment(d).fromNow()
    else if d.getFullYear()  == sample.getFullYear()
      moment(d).format("D MMM, h:mma")
    else
      moment(d).format("D MMM-YYYY h:mma")
