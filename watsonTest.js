var NaturalLanguageUnderstandingV1 = require('watson-developer-cloud/natural-language-understanding/v1.js');
var natural_language_understanding = new NaturalLanguageUnderstandingV1({
  'username': 'de9b6371-a828-44aa-986e-79b6c3addd5d',
  'password': 'vkrpbiRUCA41',
  'version_date': '2017-02-27'
});

var parameters = {
  'url': 'hackyourtommorow.herokuapp.com/historystr',
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
};

natural_language_understanding.analyze(parameters, function(err, response) {
  if (err)
    console.log('error:', err);
  else
    console.log(JSON.stringify(response, null, 2));
});
