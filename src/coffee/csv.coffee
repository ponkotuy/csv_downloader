
LF = '\r\n'

@toCSV = (xss) ->
  entire = xss.map (xs) ->
    line = xs.map (x) ->
      quote = x.contains('"') or x.contains(',') or x.contains('\r') or x.contains('\n')
      x = x.replace('"', '""')
      if quote then '"' + x + '"' else x
    line.join(',')
  entire.join(LF) + LF
