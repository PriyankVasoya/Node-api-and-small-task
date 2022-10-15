
var http = require('http');
var fs = require('fs');
http.createServer(function (req, res) {
fs.writeFile('test.txt', 'My Name is Priyank Vasoya', function (err) {
  if (err) throw err;
  console.log('Replaced!');
});
}).listen(8080);