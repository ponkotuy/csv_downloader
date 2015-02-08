
LF = '\r\n'

@toCSV = (xss) ->
  entire = xss.map (xs) ->
    line = xs.map (x) ->
      quote = contains(x, '"') or contains(x, ',') or contains(x, '\r') or contains(x, '\n')
      x = x.replace('"', '""')
      if quote then '"' + x + '"' else x
    line.join(',')
  entire.join(LF) + LF

contains = (str, elem) ->
  str.indexOf(elem) != -1
