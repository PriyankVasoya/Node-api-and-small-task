var express = require('express');
var middleware = require('../../../middleware/headerValidator');
var common = require('../../../config/common');
var auth_model = require('./auth_model');
const { checkValidationRules } = require('../../../middleware/headerValidator');
var router = express.Router();

/*
 * Signup api for User
 * 12-04-2022
 */
// router.post("/signup", function (req, res) {

//     // request method decryption
//     console.log(req.body)
//     middleware.decryption(req.body, function (request) {
//         console.log(request)
//         var rules = {
//             name: 'required',
//             username: 'required',
//             email: 'required',
//             password: 'required',
//             device_type: 'required|in:A,I',
//             device_token: 'required',

//         }

//         const messages = {
//             'required': req.language.required,
//             'in': req.language.in,
//         }

//         // checks all validation rules defined above and if error send back response
//         if (middleware.checkValidationRules(request, res, rules, messages, {})) {
//             auth_model.signUpUsers(request, function (responsecode, responsemsg, responsedata) {
//                 middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
//             });
//         }
//     });
// });

router.post("/signup", function (req, res) {

    // request method decryption
    console.log(req.body)
    middleware.decryption(req.body, function (request) {
        console.log(request)
        var rules = {
            name: 'required',
            // username: 'required',
            email: 'required',
            password: '',
            device_type: 'required|in:A,I',
            device_token: 'required',
            latitude: '',
            longitude: '',
            social_id: '',
            login_type: 'required|in:S,F,G',
        }

        const messages = {
            'required': req.language.required,
            'in': req.language.in,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.signUpUsers(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});


/*
 * Login api for User
 * 12-04-2022
 */
// router.post("/login", function (req, res) {

//     middleware.decryption(req.body, function (request) {

//         var request = request
//         var rules = {
//             device_token: 'required',
//             device_type: 'required|in:A,I',
//             email: 'required',
//             password: 'required'
//         }

//         const messages = {
//             'required': req.language.required,
//             'in': req.language.in,
//         }

//         // checks all validation rules defined above and if error send back response
//         if (middleware.checkValidationRules(request, res, rules, messages, {})) {
//             auth_model.checkLogin(request, function (responsecode, responsemsg, responsedata) {
//                 middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
//             });
//         }
//     });
// });

/*
 * Login api for User
 * 29-08-2022
 */
router.post("/login", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var request = request
        var rules = {
            device_token: 'required',
            device_type: 'required|in:A,I',
            email: 'required',
            password: '',
            social_id: '',
            login_type: 'required|in:S,F,G',
        }

        const messages = {
            'required': req.language.required,
            'in': req.language.in,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.checkLogin(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});



router.post("/res_detail", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var rules = {
            // latitude: 'required',   
            // longitude: 'required',  
            search: '',

        }

        const messages = {
            'required': req.language.required
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.resDetail(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }

    });
});


/*
 *All glass_details API 
 
 * 03-09-2022
 */
router.post("/alldetails", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var request = request
        var rules = {

            id: 'required'
        }

        const messages = {
            'required': req.language.required,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.restaurant_details(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});

router.post("/alldetailss", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var request = request
        var rules = {

            id: 'required'
        }

        const messages = {
            'required': req.language.required,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.Restaurant_details(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});


router.post('/cartdetails', function (req, res) {
    middleware.decryption(req.body, function (request) {
        var rules = {
            u_id: 'required',
            dish_id: 'required',
            qty: 'required',
        }
        const message = {
            'required': req.language.required
        }
        if (middleware.checkValidationRules(request, res, rules, message, {})) {
            auth_model.order_details(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata)
            })
        }
    })
});

router.get("/order", function (req, res) {
    middleware.decryption(req.body, function (request) {
        var rules = {
            "res_id":"required",
            "total": "required",
            "service_charge": "required",
            "sub_total":"required",
            "discount_amount":"required",
            "grand_total":"required",
            "promocode":"required",
            "payment_method":"required",
            "status": "required",
            "dish": "required"
        }
        const messages = {
            'required': req.language.required,
        }
        request.user_id = req.user_id;
        
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.order(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});

router.get("/abc",function(req,res){

    middleware.decryption(req.body,function(request){
      var rules ={
        res_id:'required'
      }
      const messages = {
        'required': req.language.required,
      }

      if(middleware.checkValidationRules(request,res,rules,messages,{})){
        auth_model.abc(request,function(responsecode, responsemsg, responsedata){
            middleware.sendresponse(req,res,200,responsecode, responsemsg, responsedata);
        })
      }

    })

})


module.exports = router;