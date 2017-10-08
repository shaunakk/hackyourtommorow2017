var express = require('express');
var app = express();
var parsedJson
var running = false
var events = require('events');
app.set('port', (process.env.PORT || 5000));
var eventEmitter = new events.EventEmitter();


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

app.get('/', function(req, res) {

  res.send(parsedJson)


})
setInterval(function() {

}, 1000)
app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});
PostCode(JSON.stringify(userData))
