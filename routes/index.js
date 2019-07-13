var express = require('express');
var router = express.Router();
var books = require('google-books-search');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.send('Use form: /books/search/{nome-do-livro}')
});

/* GET search books. */
router.get('/books/search/:name', function(req, res, next) {
  let name = req.params.name
  books.search(name, function(error, results) {
    if (!error) {
      res.json(results);
    } else {
      res.json({ result: false })
    }
  });
});

module.exports = router;
