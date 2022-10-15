
var http = require('http');
var url = require('url');
http.createServer(function (req, res) {
var address = 'http://localhost:8080/index.php?name=Priyank&sername=Vasoya&SN=PV';

//Parse the address:
var q = url.parse(address, true);

//The parse method returns an object containing url properties
console.log(q.host);
console.log(q.pathname);
console.log(q.search);

// The query property returns an object with all the querystring parameters as properties
var qdata = q.query;
console.log(qdata.name); 
console.log(qdata.sername); 
console.log(qdata.SN);

}).listen(8080);
