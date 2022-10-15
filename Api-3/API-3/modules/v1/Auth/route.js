var express = require('express');
var middleware = require('../../../middleware/headerValidator');
var common = require('../../../config/common');
var auth_model = require('./auth_model');
const { sendSMS } = require('../../../config/common');
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
            social_id: '',
            // mobile_no:'required',
            login_type: '',
        }

        const messages = {
            'required': req.language.required,
            'in': req.language.in,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.signUpUsers(request, function (responsecode, responsemsg, responsedata) {
                res.send(responsedata)
                // middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
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
                userProfile.pin_list = pinDetails;
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
 * glass_categories API 
 * 03-09-2022
 */
router.post("/glass_categories", function (req, res) {
    console.log(req.body)
    middleware.decryption(req.body, function (request) {
        console.log(request)

        var request = request
        var rules = {
            id: 'required'
        }

        const messages = {
            'required': req.language.required,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.glass_categories(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});


/*
 * glass_details API 
 * 03-09-2022
 */
router.post("/glass_details", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var request = request
        var rules = {

            type_id: 'required'
        }

        const messages = {
            'required': req.language.required,
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.glass_details(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});

router.get("/alldetail", function (req, res) {

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
            auth_model.allDetail(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }
    });
});



/*
 * Send Otp api for User
 * 02-09-2022
 */
router.post("/send_otp", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var rules = {
            code: 'required',
            mobile: 'required',
        }

        const messages = {
            'required': req.language.required
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.send_otp(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }

    });
});

/*
 * verify Otp api for User
 * 02-09-2022
 */
router.post("/verify_otp", function (req, res) {

    middleware.decryption(req.body, function (request) {

        var rules = {
            code: 'required',
            mobile: 'required',
            otp: 'required',
        }

        const messages = {
            'required': req.language.required
        }

        // checks all validation rules defined above and if error send back response
        if (middleware.checkValidationRules(request, res, rules, messages, {})) {
            auth_model.verify_otp(request, function (responsecode, responsemsg, responsedata) {
                middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
            });
        }

    });
});

router.get("/order", function (req, res) {
    middleware.decryption(req.body, function (request) {
        var rules = {
            product_id: "required",
            total: "required",
            service_charge: "required",
            sub_total: "required",
            grand_total: "required",
            payment_method: "required",
            items: "required"
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

router.get("/cart", function (req, res) {
    middleware.decryption(req.body, function (request) {
     
        request.user_id = req.user_id;

        auth_model.Cart(request, function (responsecode, responsemsg, responsedata) {
            middleware.sendresponse(req, res, 200, responsecode, responsemsg, responsedata);
        });
  
    });
});


module.exports = router;