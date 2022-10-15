var express = require('express');
var middleware = require('../../../middleware/headerValidator');
var common = require('../../../config/common');
var auth_model = require('./auth_model');
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
            username: 'required',
            email: 'required',
            password: '',
            device_type: 'required|in:A,I',
            device_token: 'required',
            latitude: '',
            longitude: '',
            social_id:'',
            login_type:'required|in:S,F,G',
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
            social_id:'',
            login_type:'required|in:S,F,G',
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

/* 
 * API to get users details
 * 12-04-2022
 */

router.get("/userdetails", function (req, res) {
    // checks all validation rules defined above and if error send back response
    
        auth_model.userdetails(req.user_id, function (userProfile) {
            if (userProfile != null) {    
                        
         auth_model.get_pins(req.user_id, function (pinDetails) {
            console.log()
           userProfile.pin_list=pinDetails;
                   middleware.sendresponse(req, res, 200, '1', {
                        keyword: 'rest_keywords_user_data_successfound',
                        components: {}
                    }, userProfile);
                })                 
            } else {
                middleware.sendresponse(req, res, 200, '0', {
                    keyword: 'rest_keywords_userdetailsnot_found',
                    components: {}
                }, null);
            }
        });
});


/*
 * Forgot password API for users
 * 12-04-2022
 */
router.post("/forgotpassword", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var request = request
        var rules = {
            email: 'required|email'
        }

        const messages = {
            'required': req.language.required,
            'email': req.language.email,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.forgotPassword(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});

/*
 * Change password API for users
 * 12-04-2022
 */
router.post("/changepassword", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var request = request
        var rules = {
            old_password: 'required',
            new_password: 'required',
        }

        const messages = {
            'required': req.language.required
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.changePassword(req.user_id, request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});



/**
 * Api for logout user
 * 12-04-2022
 */
router.post("/logout", function (req, res) {

    var updusers = {
        is_online: "0"
    };
    auth_model.updateuserlist(req.user_id, updusers, function (userprofile, error) {
        if (userprofile != null) {
            var deviceparam = {
                token: "",
                device_token: ""
            };
            common.updateDeviceInfo(req.user_id, 'User', deviceparam, function (respond) {
                middleware.sendresponse(req, res, 200, '1', {
                    keyword: 'rest_keywords_userlogout_success',
                    components: {}
                }, null);
            });
        } else {
            middleware.sendresponse(req, res, 200, '0', {
                keyword: 'rest_keywords_something_went_wrong',
                components: {}
            }, null);
        }
    });
});


/*
 * API for edit profile for userlists
 * 14-12-2021
 */
router.post("/editprofile", function (req, res) {

    middleware.decryption(req.body, function (request) {
        var rules = {
            name: 'required',
            email: 'required',
            username: 'required',
            
        }
        const messages = {
            'required': req.language.required
        }
        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.editProfile(req.user_id, request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});

/*
 * add place api for User
 * 12-04-2022
 */
router.post("/addplace", function (req, res) {

    // request method decryption
    console.log(req.body)
    middleware.decryption(req.body, function (request) {
        // console.log(request)
        var rules = {
            // user_id: 'required',
            location: 'required',
            about: 'required',
            latitude: 'required',
            longitude: 'required',
            // avg_rating: '0.0 ',
            // total_review: ' ',
        }
        
        const messages = {
            'required': req.language.required,
            'in': req.language.in,
        }
        request.lang = req.lang;
        request.user_id = req.user_id;
        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.addplace(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});

//Add Review Api
router.post('/addreview', function(req, res){
    middleware.decryption(req.body, function(request){

        var review = {
            place_id: 'required',
            review: 'required',
            rating :'required',
            
        }

        const message = {
            'required' : req.language.required,
            'in': req.language.required,
        }
        request.user_id = req.user_id;
        if(middleware.checkValidationRules(request, res, review, message, {})) {
            auth_model.add_review(request, function(responsecode, responsemsg, responsedata){
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata)
            })
        }
    })
});

router.post("/placedetails", function (req, res) {
    middleware.decryption(req.body, function (request) {
        var rules = {
            place_id : 'required'
        }
        
        const messages = {
            'required': req.language.required,
            'in': req.language.in,
        }
        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.placeDetails(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});

router.post("/placereview", function(req, res){
    middleware.decryption(req.body, function (request) {
        var rules = {
            place_id: 'required',   
        }

        const messages = {
            'required': req.language.required,
        }

        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.getplace_review(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
  
});

router.post("/findplace", function(req, res){
    middleware.decryption(req.body, function (request) {
        var rules = {
            latitude: 'required',   
            longitude: 'required',  
            search: '',  
        }

        const messages = {
            'required': req.language.required,
        }

        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.findPlace(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
  
});





module.exports = router;