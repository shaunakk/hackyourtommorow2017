var request = require('request')
var transactionData
var allData = ""
var NaturalLanguageUnderstandingV1 = require('watson-developer-cloud/natural-language-understanding/v1.js');
var natural_language_understanding = new NaturalLanguageUnderstandingV1({
  'username': 'de9b6371-a828-44aa-986e-79b6c3addd5d',
  'password': 'vkrpbiRUCA41',
  'version_date': '2017-02-27'
});



request('http://hackyourtommorow.herokuapp.com/history', function(error, response, body) {
  console.log('error:', error); // Print the error if one occurred
  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
  console.log('body:', body); // Print the HTML for the Google homepage.
  transactionData = JSON.parse(body)
  for (i = 0; i < transactionData.MonetaryTransactionResponseList.length; i++) {
    console.log(transactionData.MonetaryTransactionResponseList[i].Description1 + "\n")
    allData = allData + transactionData.MonetaryTransactionResponseList[i].Description1 + "\n"

  }
  console.log("good dat")
  natural_language_understanding.analyze({
    'text': allData,
    'features': {
      'categories': {}
    },
    function(err, response) {
      if (err) console.log('error:', err);
      console.log(JSON.stringify(response, null, 2));

    }
  });

});
