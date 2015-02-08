window.onload = ->
  url = location.hash.slice(1)
  if !url then return
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
  blob = new Blob([bom, csv], {type: 'text/csv'})
  url = (window.URL or window.webkitURL).createObjectURL(blob)
  a = document.getElementById(id)
  a.download = 'file.csv'
  a.href = url

bom = new Uint8Array([0xEF, 0xBB, 0xBF])
