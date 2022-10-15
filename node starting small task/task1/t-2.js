
var http = require('http');
var fs = require('fs');
http.createServer(function (req, res) {
  fs.readFile('test.txt', function(err, data) {
    res.write(data);
    return res.end();
  });
}).listen(8080);