var express = require('express');
var app = express();
var https = require('https')
var parsedJson
var mccData
var wats = "NOT LOADED YET TRY AGAIN"
var parsedJsonHist
var running = false
app.set('port', (process.env.PORT || 5000));
var request = require('request');
var jsondata = []
fs = require('fs')
fs.readFile('./mcc.json', 'utf8', function(err, data) {
  if (err) {
    return console.log(err);
  }
  console.log(data);
  mccData = data
  mccData = JSON.parse(mccData)
});
var mccArray

function getData(mcc) {
  return mccData.filter(
    function(data) {
      return mccData.mcc == mcc
    }
  );
}
var NaturalLanguageUnderstandingV1 = require('watson-developer-cloud/natural-language-understanding/v1.js');
var natural_language_understanding = new NaturalLanguageUnderstandingV1({
  'username': 'de9b6371-a828-44aa-986e-79b6c3addd5d',
  'password': 'vkrpbiRUCA41',
  'version_date': '2017-02-27'
});

var parameters = {
  'url': 'hackyourtommorow.herokuapp.com/historydata',
  'features': {
    'categories': {
      'limit': 5
    },
    'entities': {},
    'keywords': {
      'sentiment': false,
      'emotion': false,
      'limit': 1000
    },
    'concepts': {
      'limit': 3
    }
  }
};
setTimeout(function() {
  natural_language_understanding.analyze(parameters, function(err, response) {
    if (err)
      console.log('error:', err);
    else
      console.log(JSON.stringify(response, null, 2));
    wats = JSON.stringify(response)
  });
}, 40000)


request.post(
  'https://api119622live.gateway.akana.com:443/account/transactions', {
    json: {
      "OperatingCompanyIdentifier": "52",
      "ProductCode": "CCD",
      "PrimaryIdentifier": "00000004037670240271147"
    }
  },
  function(error, response, body) {
    if (!error && response.statusCode == 200) {
      console.log(body)
      parsedJsonHist = body
      historystr = ""
      for (i = 0; i < parsedJsonHist.MonetaryTransactionResponseList.length; i++) {
        find = mccData.filter(function(x) {
          return x.mcc == parsedJsonHist.MonetaryTransactionResponseList[i].StandardIndustryCode.toString().slice(-4);
        })
        if (find.length == 1) {
          if (find[0].hasOwnProperty("edited_description")) {
            find = find[0].edited_description
          }
        } else find = "No Description"


        jsondata.push({
          "expense": parsedJsonHist.MonetaryTransactionResponseList[i].TransactionDescription,
          "expenseType": parsedJsonHist.MonetaryTransactionResponseList[i].StandardIndustryCode,
          "date": parsedJsonHist.MonetaryTransactionResponseList[i].EffectiveDate,
          "amount": parsedJsonHist.MonetaryTransactionResponseList[i].PostedAmount,
          "mcc": find

        })

      }
    }
  }
);
var dataReturn

function dataWatson(data) {
  natural_language_understanding.analyze({
      'text': data,
      'features': {
        'categories': {},
        'entities': {},
        'keywords': {
          'sentiment': false,
          'emotion': false,
          'limit': 1000
        },
        'concepts': {
          'limit': 3
        }
      }
    },
    function(err, response) {
      if (err) console.log('error:', err);
      else console.log(JSON.stringify(response, null, 2));
      dataReturn = response
    });
  return dataReturn
}
// function PostCodeHistory(codestring) {
//   var userData = {
//     "OperatingCompanyIdentifier": "815",
//     "ProductCode": "DDA",
//     "PrimaryIdentifier": "00000000000000822943114"
//   };
//   running = true
//   // Build the post string from an object
//   var post_data = JSON.stringify(userData);
//
//   // An object of options to indicate where to post to
//   var post_options = {
//     host: 'api119622live.gateway.akana.com/account/transactions',
//     port: '443',
//     path: '/account/transactions',
//     method: 'POST',
//     headers: {
//       'Content-Type': 'application/json',
//       'Content-Length': Buffer.byteLength(post_data)
//     }
//   };
//
//   // Set up the request
//   var post_req = https.request(post_options, function(res) {
//     console.log("This is statusCode" + res.statusCode);
//     res.setEncoding('utf8');
//     res.on('data', function(chunk) {
//       parsedJsonHist = JSON.parse(chunk, null);
//       console.log(chunk)
//
//     });
//     res.on('error', function(e) {
//       console.log('Error Response: ' + chunk);
//       return 'Error Response: ' + chunk
//     });
//   });
//
//
//
//   // post the data
//   post_req.write(post_data);
//   parsedJsonHist = JSON.stringify(parsedJsonHist)
//
//   post_req.end();
//
//
//
//
// }
app.use(express.static(__dirname + '/build'));

// views is directory for all template files
app.set('views', __dirname + '/build');
app.set('view engine', 'jsx');
var http = require('http');

var userData = {
  "OperatingCompanyIdentifier": "815",
  "ProductCode": "DDA",
  "PrimaryIdentifier": "00000000000000822943114"
};

var querystring = require('querystring');
var http = require('http');
var fs = require('fs');

function PostCode(codestring) {
  running = true
  // Build the post string from an object
  var post_data = JSON.stringify(userData);

  // An object of options to indicate where to post to
  var post_options = {
    host: 'api119521live.gateway.akana.com',
    port: '80',
    path: '/api/v1/account/details',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(post_data)
    }
  };

  // Set up the request
  var post_req = http.request(post_options, function(res) {
    console.log("This is statusCode" + res.statusCode);
    res.setEncoding('utf8');
    res.on('data', function(chunk) {
      parsedJson = JSON.parse(chunk, null);
      console.log(chunk)

    });
    res.on('error', function(e) {
      console.log('Error Response: ' + chunk);
      return 'Error Response: ' + chunk
    });
  });



  // post the data
  post_req.write(post_data);
  parsedJson = JSON.stringify(parsedJson)
  post_req.end();




}

app.get('/person', function(req, res) {
  res.send(parsedJson)


})
app.get('/watson', function(req, res) {

  res.send(wats)


})
app.get('/history', function(req, res) {

  res.send(parsedJsonHist)


})
app.get('/historydata', function(req, res) {

  res.send(jsondata)


})
app.get('/historystr', function(req, res) {

  res.send(historystr.toString())


})
app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});
PostCode(JSON.stringify(userData))
// PostCodeHistory(JSON.stringify(userData))
