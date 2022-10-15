let express = require("express");
const app = express();
const port = 8082
const path = require("path");
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
    con.query("SELECT * FROM tbl_form1 ORDER BY id desc", function(err, result, fields){
        if(err) throw err;
        console.log(result);
        
        res.render(path.join(__dirname+'/table.ejs'),{ data:result})
    });
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
  
  var upload = multer({ storage: storage })

app.post('/send_post', upload.single('img'), function(req, res){
    var params = {
       id: req.params.id,
       fname: req.body.fname,
       lname: req.body.lname,
       email: req.body.email,
       phone: req.body.phone,
      image: req.file.filename,

    }
        con.query(`INSERT INTO tbl_form1 (fname, lname, email, phone, image, is_active) SET ?`,params,
        function(err,result,fields){
            if(err) throw err;
            console.log(result);
            res.redirect("/");
        });
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});