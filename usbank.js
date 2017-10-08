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
  var post_data = JSON.stringify(mydata);

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
      var parsedJson = JSON.parse(chunk, null);
    });
    res.on('error', function(e) {
      console.log('Error Response: ' + chunk);
    });
  });



  // post the data
  post_req.write(post_data);

  post_req.end();
}

PostCode(JSON.stringify(mydata));
