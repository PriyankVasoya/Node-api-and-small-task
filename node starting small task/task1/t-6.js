var http = require('http');
var moment = require('moment');


http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end(('\n 1. ')+ moment().format('MMMM Do YYYY, h:mm:ss a') + 
  ('\n 2. ') + (moment().format('dddd'))+
  ('\n 3. ') + (moment().format("MMM Do YY"))+
  ('\n 4. ') + (moment().add(3, 'days').format("MMM Do YY") )+
  ('\n 5. ') + (moment().subtract(3, 'days').format("MMM Do YY") ));
}).listen(8080);