Batman.Filters.dateFormat = (date, format) ->
  moment(date).format(format)

Batman.Filters.times = (x, y) ->
  x * y
