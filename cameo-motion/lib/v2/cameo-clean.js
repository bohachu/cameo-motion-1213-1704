// cameo-clean.js
// 將 csv 字串轉 key value js object 形式，最外層再用 javascript array 包起來
// from http://techslides.com/convert-csv-to-json-in-javascript
function csv_to_json(str_csv) {
  var lines = str_csv.split("\n");
  var ary_json = [];
  var headers = lines[0].split(",");
  for (var i = 1; i < lines.length; i++) {
    var dic = {};
    var currentline = lines[i].split(",");
    for (var j = 0; j < headers.length; j++) {
      dic[headers[j]] = currentline[j];
    }
    ary_json.push(dic);
  }
  return ary_json;
}
// 將 csv 轉換為 key value pair 的 javascript object (dictionary)
function csv_to_dic(str_csv) {
  // const ary = Papa.parse(str_csv).data;
  const ary = csv_to_ary(str_csv);
  let dic = {};
  for (let i = 0; i < ary.length; i++) {
    let str_key = ary[i][0];
    let str_value = ary[i][1];
    dic[str_key] = str_value;
  }
  return dic;
}
// 將一個二維矩陣的 row col 順時針轉九十度
function transpose(ary) {
  return ary[0].map((_, col) => ary.map((row) => row[col]));
}

// 取代 Papa parse 把 csv 用逗點隔開之後回傳二維陣列
function csv_to_ary(str_data) {
  let strDelimiter = ",";
  var objPattern = new RegExp(
    "(\\" +
      strDelimiter +
      "|\\r?\\n|\\r|^)" +
      // Quoted fields.
      '(?:"([^"]*(?:""[^"]*)*)"|' +
      // Standard fields.
      '([^"\\' +
      strDelimiter +
      "\\r\\n]*))",
    "gi"
  );
  var arrData = [[]];
  var arrMatches = null;
  while ((arrMatches = objPattern.exec(str_data))) {
    var strMatchedDelimiter = arrMatches[1];
    if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
      arrData.push([]);
    }
    var strMatchedValue;
    if (arrMatches[2]) {
      strMatchedValue = arrMatches[2].replace(new RegExp('""', "g"), '"');
    } else {
      strMatchedValue = arrMatches[3];
    }
    arrData[arrData.length - 1].push(strMatchedValue);
  }
  return arrData;
}

// 將 one column csv, 讀入之後去標頭，並且轉為一維陣列
// intput:
// const str_color_line_csv = `color_line
// #000000
// #EEAC5D
// #F7CB46
// #EAE660
// #8BC9BD
// #4DD6C1
// #31AFA0
// #357993
// #276074
// #3A5697
// #253875`;
//
// output:
// ["#000000", "#EEAC5D", "#F7CB46", "#EAE660", "#8BC9BD", "#4DD6C1", "#31AFA0", "#357993", "#276074", "#3A5697", "#253875"]
function one_col_ary(str_csv) {
  return transpose(csv_to_ary(str_csv))[0].slice(1);
}

async function fetch_text(str_url) {
  let response = await fetch(str_url);
  if (response.ok) {
    return await response.text();
  } else {
    console.log("error, fetch_text(str_url), " + response.status);
  }
}

async function fetch_transpose(str_url) {
  let ary_transpose = transpose(csv_to_ary(await fetch_text(str_url)));
  return ary_transpose;
}

function csv_to_transpose(str_data) {
  return transpose(csv_to_ary(str_data));
}

async function fetch_json(str_url) {
  return csv_to_json(await fetch_text(str_url));
}

async function fetch_dic(str_url) {
  return csv_to_dic(await fetch_text(str_url));
}
export {
  fetch_dic,
  one_col_ary,
  fetch_text,
  csv_to_transpose,
  csv_to_json,
  fetch_json,
  fetch_transpose
};
