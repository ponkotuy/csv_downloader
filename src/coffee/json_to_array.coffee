
# Required Array
@jsonToArray = (json) ->
  if json.isArray()
    columns = []
    result = json.map = (line) ->
      toArray(columns, line)
    result.unshift(columns)
    result
  else []

toArray = (columns, x) ->
  result = []
  if isObject(x)
    for k, v of toElems(x)
      idx = columns.indexOf(k)
      if idx == -1
        columns.push(k)
        idx = columns.length -1
      result[idx] = v
  result

toElems = (x) ->
  result = {}
  for xk, xv of x
    if isObject(xv)
      obj = toElems(xv)
      for k, v of obj
        result["#{xk}_#{k}"] = v
    else
      result[xk] = xv.toString

isObject = (x) -> toString.call(x) == object
toString = Object.prototype.toString
object = toString({})
