var express = require('express');
var app = express();
var parsedJson
app.set('port', (process.env.PORT || 5000));

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
      console.log('Response: ' + chunk);
      parsedJson = JSON.parse(chunk, null);

    });
    res.on('error', function(e) {
      console.log('Error Response: ' + chunk);
      return 'Error Response: ' + chunk
    });

  });



  // post the data
  post_req.write(post_data);

  post_req.end();
  return JSON.stringify(parsedJson)
}


app.get('/', function(req, res) {
  res.send(PostCode(JSON.stringify(userData)))
})

app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});
