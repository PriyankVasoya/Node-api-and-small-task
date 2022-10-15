const mysql = require('mysql')
var express = require('express')
var app = express()
var con = require('./config/database')
var bodyParser = require('body-parser')
require('dotenv').config()
app.use(bodyParser.json())
app.use(express.urlencoded({ extended: true }))

//get 
app.get('/list',function (req, res)  {
 // var id = req.params.id
    con.query("select * from tbl_crud", function (err, data) {
        console.log(err)
        if (err) throw err
        res.send(data)
    })
})

//post
app.post('/add', function (req, res) {
    console.log(req.body)
    // req.body = JSON.parse(req.body)
    var params = {
        id: req.params.id,
        name: req.body.name,
        email: req.body.email,
        password: req.body.password,      
      }
      console.log(params)
    con.query(`insert into tbl_crud SET ?`, params, function (err, data) {
        if (err) throw err
        res.send('Your Data Inserted Successfully')
    })
})

//put
app.put('/update/:id', function (req, res) {
    // var id = req.params.id
    con.query(`update tbl_crud set name='${req.body.name}', email='${req.body.email}', password='${req.body.password}' where id = '${req.params.id}' `, function (err, data) {
        if (err) throw err
        res.send('Your Data Update Success ')
    })
})

//delete
app.delete('/delete/:id', function (req, res) {

    var id = req.params.id
    con.query("delete from tbl_crud where id = ?", id, function (err, data) {
        if (err) throw err
        res.send('Your Data Delete Successfully')
    })
})


try {
	server = app.listen(process.env.PORT);
	console.log("Connected to postman crud port : "+process.env.PORT);
} catch (err) {
	console.log("Failed to connect");
}