var express = require('express');
var app = express();
const Validator = require('Validator');
const port = 8083
const path = require("path");

app.use(express.urlencoded({ extended : true }));

//database connection
const con = require('./config/database'); 

//get respond from url
app.get('/', function(req, res){
    res.render(path.join(__dirname+'/index.ejs'))
})

// for print data
app.get('/process_get', function(req, res){
    console.log(req.query)
    console.log(req.query.fname)
    console.log(req.query.lname)
        res.send('Hello '+req.query.fname+ ' ' + req.query.lname);
})

//get respond from url
app.get('/form', function (req, res) {
    res.render(__dirname + "/" + "form.ejs")

});

// for validation and print data
app.post('/process_post', function(req, res){
    console.log(req.body)
    
    const rules={
        fname:'required',
        lname:'required',
        email:'required|email',
        phone:'required|integer'
    };
    
    const v = Validator.make(req.body, rules);

    if(v.fails()){
        const errors = v.getErrors();
        console.log(errors);
        con.query("SELECT * FROM tbl_form ORDER BY id desc", function(err, result){
            if(err) throw err;
            console.log(result);
            res.render(path.join(__dirname+'/form.ejs'),{ data:result,errors:errors })
        });
    }else
    {
        con.query("INSERT INTO tbl_form SET ?",req.body ,function(err,result){
            if(err) throw err;
            console.log(result);
            res.redirect("/get_data")
        });
    }
})

app.get('/get_data', function (req, res) {
    console.log(req)
    con.query("select * from tbl_form where is_active=1 ORDER BY id desc", function (err, result, fields) {
        if (err) throw err;
        console.log(result);
        res.render(path.join(__dirname + '/table.ejs'), { data: result })
    });
})

 //delete data
app.get('/delete/:id', function (req, res) {
    con.query("update tbl_form set is_active = 0 where id = ?", [req.params.id])
    res.redirect('/get_data')
});

    
// UPDATE Data 
app.get('/update/:id', (req, res) =>{
    var id = req.params.id;
    con.query("SELECT * FROM tbl_form WHERE id = ?", [id], (err, result) =>{
      
            res.render(path.join(__dirname+'/edit.ejs'), {data: result})
      
    })
})

// UPDATE It
app.post('/update_value/:id', (req,res) =>{
    var id = req.params.id;
    var fname = req.body.fname;
    var lname = req.body.lname;
    var email = req.body.email;
    var phone = req.body.phone;

    console.log(id)

    con.query("UPDATE tbl_form SET fname= ?, lname= ?, email= ?, phone= ?  WHERE id = ?", [fname, lname, email, phone, id], (err, result) =>{
        if (err) throw err; {
            con.query("select * from tbl_form ORDER BY id desc", function () {
          
                res.redirect('/get_data')
            });
        }
    })
})

app.use((req,res,next) => {
    res.render(path.join(__dirname+ '/error.ejs'))
    var err = new Error('NOT FOUND');
    err.status = 404 ;
    next();
})


app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});