window.onload = ->
  url = location.hash.slice(1)
  xhr = new XMLHttpRequest()
  xhr.open('GET', url, true)
  xhr.onload = ->
    if xhr.readyState == 4
      if xhr.status == 200
        json = JSON.parse(xhr.responseText)
        ary = jsonToArray(json)
        createCSVURL(ary, 'main')
  xhr.onerror = -> console.error(xhr.statusText)
  xhr.send(null)

createCSVURL = (ary, id) ->
  csv = toCSV(ary)
  blob = new Blob([csv], {type: 'text/csv'})
  url = (window.URL or window.webkitURL).createObjectURL(blob)
  console.log(url)
  a = document.getElementById(id)
  a.download = 'file.csv'
  a.href = url

createCORSRequest = (method, url) ->
