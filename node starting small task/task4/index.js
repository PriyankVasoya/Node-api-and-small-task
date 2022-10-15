let express = require("express");
const app = express();
const port = 8081
const path = require("path");
const con = require("./database.js");
const Validator = require('Validator');
require('dotenv').config()
app.use(express.static('public'));
const multer = require('multer');
app.use(express.urlencoded({ extended : true }));
const cryptLib = require("cryptlib");
const key=cryptLib.getHashSha256(process.env.ENC_KEY, 32);

// encrypt decrypt
encryptedText= cryptLib.encrypt('Hello, where are you from ?',key, process.env.ENC_IV);
console.log(encryptedText)

orignalText= cryptLib.decrypt(encryptedText,key, process.env.ENC_IV)
console.log(orignalText)

console.log(process.env.PORT);

// for form
app.get('/form', function (req, res) {
  res.render(path.join(__dirname+'/form.ejs'))

})


// show data as table
app.get('/', function (req, res) {
  con.query("SELECT * FROM tbl_form1 WHERE is_active = 1 ORDER BY id DESC", function(err, result){
      if(err) throw err;
      console.log(result);
      res.render(path.join(__dirname+'/table.ejs'),{ data:result})
  });
})

// soft delete
app.get('/delete/:id', function(req, res){
  con.query(`UPDATE tbl_form1 SET is_active = '0' WHERE tbl_form1.id = ${req.params.id}`)
  res.redirect("/")
})

// update = edit data
app.get('/update/:id', (req, res) =>{
  var id = req.params.id;
  con.query("SELECT * FROM tbl_form1 WHERE id = ?", [id], (err, result) =>{

      if(!err){
          console.log(result)
          res.render(path.join(__dirname+'/edit.ejs'), {data: result})
      }
  })
})


// image
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, './public/uploads')
    },
    filename: function (req, file, cb) {
        console.log(file.filename)
        console.log( Date.now())
      cb(null, Date.now() + path.extname(file.originalname))
    }
  })
  
  // var upload = multer({ storage: storage })
const maxSize = 1 * 1024 * 1024; // for 1MB
 
var upload = multer({
  storage: storage,
  fileFilter: (req, file, cb) => {
    if (file.mimetype == "image/png" || file.mimetype == "image/jpg" ||file.mimetype == "image/jpeg" ) {
      cb(null, true);
    } else {
      cb(null, false);
      return cb(new Error("Only .png, .jpg and .jpeg format allowed!"));
    }
  },
  limits: { fileSize: maxSize },
  
})

// in form image upload
app.post('/send_post', upload.single('img'), function(req, res){
  
  console.log(req.body)
  
  const rules={
    fname:'required',
    lname:'required',
    email:'email',
    phone:'integer'
   
  };
  
    const messages = {
      // custom message for based rules
      required: 'You forgot the :attr field',
      email: ':attr is not valid',
      // custom message for specific rule of attribute
      // 'receiver.email': 'The receiver email address is not valid'
  };
const v = Validator.make(req.body, rules, messages,{ email: 'Email Address' } );

if(v.fails()){
    const errors = v.getErrors();
    console.log(errors);
    con.query("SELECT * FROM tbl_form1 ORDER BY id desc", function(err, result){
        if(err) throw err;
        console.log(result);
        res.render(path.join(__dirname+'/form.ejs'),{ data:result,errors:errors })
    });
}else
{

  var params = {
    id: req.params.id,
    fname: req.body.fname,
    lname: req.body.lname,
    email: req.body.email,
    phone: req.body.phone,
    image: req.file.filename,
  }
  con.query(`INSERT INTO tbl_form1 SET ?`, params,
    function (err, result, fields) {
      if (err) throw err;
      console.log(result);
      res.redirect("/");
    });
  }
})
//image when update
app.post('/update_value/:id', upload.single('editimage'), (req, res, cb) => {

  console.log(req.body)
  
  const rules={
    fname:'required',
    lname:'required',
    email:'email',
    phone:'integer'
   
  };
  
    const messages = {
      // custom message for based rules
      required: 'You forgot the :attr field',
      email: ':attr is not valid',
      // custom message for specific rule of attribute
      // 'receiver.email': 'The receiver email address is not valid'
  };
const v = Validator.make(req.body, rules, messages,{ email: 'Email Address' } );

if(v.fails()){
    const errors = v.getErrors();
    console.log(errors);
    con.query("SELECT * FROM tbl_form1 ORDER BY id desc", function(err, result){
        if(err) throw err;
        console.log(result);
        res.render(path.join(__dirname+'/edit.ejs'),{ data:result,errors:errors })
    });
}else
{

  var id = req.params.id;
  var fname = req.body.fname;
  var lname = req.body.lname;
  var email = req.body.email;
  var phone = req.body.phone;
  var newimage = req.file.filename;

  con.query("UPDATE tbl_form1 SET fname= ?, lname= ?, email= ?, phone= ?, image= ? WHERE id = ?", [fname, lname, email, phone, newimage, id])
  res.redirect("/");
}
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});