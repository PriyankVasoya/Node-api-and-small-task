var mysql = require("mysql");

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database:"db_node_form"
});
con.connect(function(err,result) {
    if (err) throw err;
    console.log("Connected!");
  });
  
module.exports = con;