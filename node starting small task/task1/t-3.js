
var http = require('http');
var fs = require('fs');
http.createServer(function (req, res) {
  fs.unlink('test.txt', function(err, data) {

    if (err) throw err;
    console.log('File deleted!');
    return res.end();
  });
}).listen(8080);