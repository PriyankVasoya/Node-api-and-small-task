let express = require("express");
const app = express();
const port = 8086
const path = require("path");
const Validator = require('Validator');
const con = require("./database.js");
require('dotenv').config()
const cryptLib = require("cryptlib");
const key=cryptLib.getHashSha256(process.env.ENC_KEY, 32);

encryptedText= cryptLib.encrypt('Hello, where are you from ?',key, process.env.ENC_IV);
console.log(encryptedText)

orignalText= cryptLib.decrypt(encryptedText,key, process.env.ENC_IV)
console.log(orignalText)

console.log(process.env.PORT);

app.use(express.static('public'));
const multer = require('multer');
app.use(express.urlencoded({ extended : true }));



app.get('/', function (req, res) {
  con.query("SELECT * FROM tbl_practice WHERE is_active = 1 ORDER BY id DESC", function(err, result){
      if(err) throw err;
      console.log(result);
      res.render(path.join(__dirname+'/table.ejs'),{ data:result})
  });
})

app.get('/delete/:id', function(req, res){
  con.query(`UPDATE tbl_practice SET is_active = '0' WHERE tbl_practice.id = ${req.params.id}`)
  res.redirect("/")
})

app.get('/update/:id', (req, res) =>{
  var id = req.params.id;
  con.query("SELECT * FROM tbl_practice WHERE id = ?", [id], (err, result) =>{
      if(!err){
          console.log(result)
          res.render(path.join(__dirname+'/edit.ejs'), {data: result})
      }
  })
})


app.get('/form', function (req, res) {
        res.render(path.join(__dirname+'/form.ejs'))
   
})

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
  
//   var upload = multer({ storage: storage })
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
    con.query("SELECT * FROM tbl_form ORDER BY id desc", function(err, result){
        if(err) throw err;
        console.log(result);
        res.render(path.join(__dirname+'/form.ejs'),{ data:result,errors:errors })
    });
}else
{
//     con.query("INSERT INTO tbl_form SET ?",req.body ,function(err,result){
//         if(err) throw err;
//         console.log(result);
//         res.redirect("/get_data")
//     });
// 
    
        con.query(`INSERT INTO tbl_practice (fname, lname, email, phone, image, is_active) VALUES ('${req.body.fname}', '${req.body.lname}', '${req.body.email}', '${req.body.phone}', '${req.file.filename}', '1')` ,function(err,result,fields){
            if(err) throw err;
            console.log(result);
            res.redirect("/");
        });
      }
})


app.post('/update_value/:id', upload.single('editimage'), (req, res, cb) => {
  var id = req.params.id;
  var fname = req.body.fname;
  var lname = req.body.lname;
  var email = req.body.email;
  var phone = req.body.phone;
  var newimage = req.file.filename;

  con.query("UPDATE tbl_practice SET fname= ?, lname= ?, email= ?, phone= ?, image= ? WHERE id = ?", [fname, lname, email, phone, newimage, id])
  res.redirect("/");
})


app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});