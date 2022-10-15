let express = require("express");
const app = express();
const port = 8080
const path = require("path");
const con = require("./database.js");
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
  con.query("SELECT * FROM tbl_edit WHERE is_active = 1 ORDER BY id DESC", function(err, result){

    for(let i = 0; i < result.length; i++){
            
      result[i].password = cryptLib.decrypt(result[i].password,key, process.env.ENC_IV);
      // result[i].psw = result[i].password;
      console.log(result[i].password)
      // console.log("psw",result[i].password)
      // console.log("final result",result);
  }
      if(err) throw err;
      console.log(result);
      res.render(path.join(__dirname+'/table.ejs'),{ data:result})
  });
})

// soft delete
app.get('/delete/:id', function(req, res){
  con.query(`UPDATE tbl_edit SET is_active = '0' WHERE tbl_edit.id = ${req.params.id}`)
  res.redirect("/")
})

// update = edit data
app.get('/update/:id', (req, res) =>{
  var id = req.params.id;
  con.query("SELECT * FROM tbl_edit WHERE id = ?", [id], (err, result) =>{

    orignalText = cryptLib.decrypt(result[0].password, key, process.env.ENC_IV);
    console.log(orignalText)

    result[0].password = orignalText;
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
  
  var upload = multer({ storage: storage })

// in form image upload
app.post('/send_post', upload.single('img'), function(req, res){

  encryptedText = cryptLib.encrypt(req.body.password, key, process.env.ENC_IV);
  console.log(encryptedText)

  // orignalText = cryptLib.decrypt(encryptedText, key, process.env.ENC_IV)
  // console.log(orignalText)

  var params = {
    id: req.params.id,
    fname: req.body.fname,
    lname: req.body.lname,
    email: req.body.email,
    phone: req.body.phone,
    password: encryptedText,
    image: req.file.filename,
  }
  con.query(`INSERT INTO tbl_edit SET ?`, params,
    function (err, result, fields) {
      if (err) throw err;
      console.log(result);
      res.redirect("/");
    });

})

//image when update
app.post('/update_value/:id', upload.single('editimage'), (req, res, cb) => {

  encryptedText = cryptLib.encrypt(req.body.password, key, process.env.ENC_IV);
  console.log(encryptedText)

  // orignalText = cryptLib.decrypt(encryptedText, key, process.env.ENC_IV)
  // console.log(orignalText)

  var id = req.params.id;
  var fname = req.body.fname;
  var lname = req.body.lname;
  var email = req.body.email;
  var phone = req.body.phone;
  var password = encryptedText;
  var newimage = req.file.filename;

  con.query("UPDATE tbl_edit SET fname= ?, lname= ?, email= ?, phone= ?, password= ?, image= ? WHERE id = ?", [fname, lname, email, phone, password, newimage, id]) 
  res.redirect("/");
})


app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});