(function() {
  var LF, bom, createCSVURL, isObject, object, toArray, toElems, toString;

  LF = '\r\n';

  this.toCSV = function(xss) {
    var entire;
    entire = xss.map(function(xs) {
      var line;
      line = xs.map(function(x) {
        var quote;
        quote = x.contains('"') || x.contains(',') || x.contains('\r') || x.contains('\n');
        x = x.replace('"', '""');
        if (quote) {
          return '"' + x + '"';
        } else {
          return x;
        }
      });
      return line.join(',');
    });
    return entire.join(LF) + LF;
  };

  this.jsonToArray = function(json) {
    var columns, result;
    columns = [];
    result = json.map(function(line) {
      return toArray(columns, line);
    });
    result.unshift(columns);
    return result;
  };

  toArray = function(columns, x) {
    var idx, k, result, v, _ref;
    result = [];
    if (isObject(x)) {
      _ref = toElems(x);
      for (k in _ref) {
        v = _ref[k];
        idx = columns.indexOf(k);
        if (idx === -1) {
          columns.push(k);
          idx = columns.length - 1;
        }
        result[idx] = v;
      }
    }
    return result;
  };

  toElems = function(x) {
    var k, obj, result, v, xk, xv;
    result = {};
    for (xk in x) {
      xv = x[xk];
      if (isObject(xv)) {
        obj = toElems(xv);
        for (k in obj) {
          v = obj[k];
          result["" + xk + "_" + k] = v;
        }
      } else {
        result[xk] = xv.toString();
      }
    }
    return result;
  };

  isObject = function(x) {
    return toString.call(x) === object;
  };

  toString = Object.prototype.toString;

  object = toString.call({});

  window.onload = function() {
    var url, xhr;
    url = location.hash.slice(1);
    if (!url) {
      return;
    }
    xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onload = function() {
      var ary, json;
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          json = JSON.parse(xhr.responseText);
          ary = jsonToArray(json);
          return createCSVURL(ary, 'main');
        }
      }
    };
    xhr.onerror = function() {
      return console.error(xhr.statusText);
    };
    return xhr.send(null);
  };

  createCSVURL = function(ary, id) {
    var a, blob, csv, url;
    csv = toCSV(ary);
    blob = new Blob([bom, csv], {
      type: 'text/csv'
    });
    url = (window.URL || window.webkitURL).createObjectURL(blob);
    a = document.getElementById(id);
    a.download = 'file.csv';
    a.href = url;
    a.removeAttribute("disabled");
    return location.href = url;
  };

  bom = new Uint8Array([0xEF, 0xBB, 0xBF]);

}).call(this);

//# sourceMappingURL=csv_down.js.map
