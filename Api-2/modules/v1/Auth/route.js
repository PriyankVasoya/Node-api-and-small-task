var express = require('express');
var middleware = require('../../../middleware/headerValidator');
var common = require('../../../config/common');
var auth_model = require('./auth_model');
var router = express.Router();


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
            social_id:'',
            mobile_no:'required',
            login_type:'',
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




router.post('/category', function(req, res){
    middleware.decryption(req.body, function (request) { 
        
        var rules = {
            id : ''
        }

        const message = {
            'required' : req.language.required,
        }

        if(middleware.checkValidationRules(request, res, rules, message, {})) {
            auth_model.Category(request, function(responsecode, responsemsg, responsedata){
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            })
        }

     })
});

router.post('/storedetails', function(req, res){
    middleware.decryption(req.body, function(request){

        var rules = {
            latitude: 'required',
            longitude: 'required',
            category_id : '',
        }
        const messages = {
            'required': req.language.required,
        }

        if(middleware.checkValidationRules(request, res, rules, messages, {})){
            auth_model.storeDetails(request, function(responsecode, responsemsg, responsedata){
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            })
        }
    })
});


router.post('/product', function (req, res) {
    middleware.decryption(req.body, function(request){
        var rules = {
            id: 'required',
        }
        const message = {
            'required': req.language.required,
        }

        if(middleware.checkValidationRules(request, res, rules, message, {})){
            auth_model.Product(request, function(responsecode, responsemsg, responsedata){
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            })
        }
    })
});

router.post('/fav', function(req, res){
    middleware.decryption(req.body, function (request) { 
        var rules = {
            id:'',
        }
        const message ={
            'required': req.language.required,
        }

        if(middleware.checkValidationRules(request, res, rules, message,{})){
            auth_model.Fav(request, function(responsecode, responsemsg, responsedata){
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata)
            })
        }
     })
});

router.post('/company_item', function (req, res) {
    middleware.decryption(req.body, function(request){
        var rules = {
            latitude: 'required',
            longitude: 'required',
            id: 'required',
        }
        const message = {
            'required': req.language.required,
        }

        if(middleware.checkValidationRules(request, res, rules, message, {})){
            auth_model.shopprod(request, function(responsecode, responsemsg, responsedata){
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            })
        }
    })
});

module.exports = router;