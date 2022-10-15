var con = require('../../../config/database');
// var GLOBALS = require('../../../config/constants');
require("dotenv").config();
var common = require('../../../config/common');
var cryptoLib = require('cryptlib');
var asyncLoop = require('node-async-loop');
var moment = require('moment');
var shaKey = cryptoLib.getHashSha256(process.env.KEY, 32);
var emailTemplate = require('../../../config/template');

var Auth = {

    /**
     * Function to get details of any users
     * 12-04-2022
     * @param {Login User ID} user_id 
     * @param {Function} callback
     */
    userdetails: function (user_id, callback) {

        con.query("SELECT u.*,IFNULL(ut.device_token,'') as device_token,IFNULL(ut.device_type,'') as device_type,IFNULL(ut.token,'') as token FROM tbl_user u LEFT JOIN tbl_user_device as ut ON u.id = ut.user_id WHERE u.id = '" + user_id + "' AND u.is_deleted='0' GROUP BY u.id", function (err, result, fields) {
            console.log("Error of Users", err);
            if (!err && result.length > 0) {
                callback(result[0]);
            } else {
                callback(null);
            }
        });
    },

    //Get_pins function
    get_pins: function (user_id, callback) {

        con.query(` SELECT * FROM tbl_place WHERE user_id = '` + user_id + `'`, function (err, result, fields) {
            console.log("Error of Users", err);
            if (!err && result.length > 0) {
                console.log(result)
                callback(result);
            } else {
                callback(null);
            }
        });
    },

    /**
     * Function for check unique email and phone numbers for users
     * 12-04-2022
     * @param {Login User ID} user_id 
     * @param {Request Data} request 
     * @param {Function} callback 
     */
    checkUniqueFields: function (user_id, request, callback) {

        // Check in database for this email register
        Auth.checkUniqueEmail(user_id, request, function (emailcode, emailmsg, emailUnique) {
            if (emailUnique) {
                Auth.checkUniqueUsername(user_id, request, function (phonecode, phonemsg, phoneUnique) {
                    if (phoneUnique) {
                        callback(phonecode, phonemsg, phoneUnique);
                    } else {
                        callback(phonecode, phonemsg, phoneUnique);
                    }
                });
            } else {
                callback(emailcode, emailmsg, emailUnique);
            }
        });
    },

    /**
     * Function to check email uniqueness
     * 12-04-2022
     * @param {Login User ID} user_id 
     * @param {Request} request 
     * @param {Function} callback 
     */
    checkUniqueEmail: function (user_id, request, callback) {

        if (request.email != undefined && request.email != '') {

            if (user_id != undefined && user_id != '') {
                var uniqueEmail = "SELECT * FROM tbl_user WHERE email = '" + request.email + "' AND is_deleted='0' AND id != '" + user_id + "' ";
            } else {
                var uniqueEmail = "SELECT * FROM tbl_user WHERE email = '" + request.email + "' AND is_deleted='0' ";
            }
            con.query(uniqueEmail, function (error, result, fields) {
                if (!error && result[0] != undefined) {
                    callback('0', {
                        keyword: 'rest_keywords_duplicate_email',   // email already exits
                        components: {}
                    }, false);
                } else {
                    callback('1', "Success", true);
                }
            });

        } else {
            callback('1', "Success", true);
        }
    },

    /**
     * Function to check email uniqueness
     * 12-04-2022
     * @param {Login User ID} user_id 
     * @param {Request} request 
     * @param {Function} callback 
     */
    checkUniqueUsername: function (user_id, request, callback) {

        if (request.username != undefined && request.username != '') {

            if (user_id != undefined && user_id != '') {
                var uniqueUsername = "SELECT * FROM tbl_user WHERE username = '" + request.username + "' AND is_deleted='0' AND id != '" + user_id + "' ";
            } else {
                var uniqueUsername = "SELECT * FROM tbl_user WHERE username = '" + request.username + "' AND is_deleted='0' ";
            }
            con.query(uniqueUsername, function (error, result, fields) {
                if (!error && result[0] != undefined) {
                    callback('0', {
                        keyword: 'rest_keywords_duplicate_username',
                        components: {}
                    }, false);
                } else {
                    callback('1', "Success", true);
                }
            });

        } else {
            callback('1', "Success", true);
        }
    },

    /**
     * Function to update users details
     * 12-04-2022
     * @param {Login User ID} user_id 
     * @param {Update Parameters} upd_params 
     * @param {Function} callback 
     */
    updateuserlist: function (user_id, upd_params, callback) {
        con.query("UPDATE tbl_user SET ? WHERE id = ? ", [upd_params, user_id], function (err, result, fields) {
            if (!err) {
                Auth.userdetails(user_id, function (response, err) {
                    callback(response);
                });
            } else {
                callback(null, err);
            }
        });
    },

    /**
     * Function to signup for users
     * @param {request} request 
     * @param {Function} callback 
     */

    signUpUsers: function (request, callback) {
        Auth.checkUniqueFields('', request, function (uniquecode, uniquemsg, isUnique) {
            if (isUnique) {

                var userlist = {
                    social_id: (request.social_id != undefined && request.social_id != '') ? request.social_id : '',
                    username: request.username,
                    name: request.name,
                    email: (request.email != undefined && request.email != "") ? request.email : '',
                    is_active: '1',
                    is_online: '1',
                    // mobile_no: (request.mobile_no != undefined && request.mobile_no != "") ? request.mobile_no : '',
                    password: (request.password != undefined && request.password != '') ? cryptoLib.encrypt(request.password, shaKey, process.env.KEY) : '',
                    login_type: (request.login_type != undefined && request.login_type != "") ? request.login_type : '',

                };

                con.query('INSERT INTO tbl_user SET ?', userlist, function (err, result, fields) {
                    if (!err) {

                        common.checkUpdateDeviceInfo(result.insertId, "userlist", request, function () {

                            Auth.userdetails(result.insertId, function (userprofile, err) {
                                // console.log("test",userprofile)
                                common.generateSessionCode(result.insertId, "userlist", function (token) {
                                    console.log(token)
                                    userprofile.token = token;
                                    callback('1', {
                                        keyword: 'rest_keywords_user_signup_success',
                                        components: {}
                                    }, userprofile);
                                });
                            });
                        });
                    } else {
                        // console.log(err)
                        callback('0', {
                            keyword: 'rest_keywords_user_signup_failed',
                            components: {}
                        }, null);
                    }
                });

            } else {
                callback(uniquecode, uniquemsg, null);
            }
        });
    },


    /**
     * Function to check login details of users
     * @param {request} request 
     * @param {Function} callback 
     */


    checkLogin: function (request, callback) {

        //chek user details via Email    
        if (request.social_id != undefined && request.login_type != 'S') {
            // console.log('a')    
            var whereCondition = "social_id = '" + request.social_id + "' AND login_type = '" + request.login_type + "'";

        } else {
            // console.log('b')
            var whereCondition = " email='" + request.email + "' ";
        }
        con.query("SELECT * FROM tbl_user where " + whereCondition + " AND is_deleted='0' ", function (err, result, fields) {

            if (!err) {

                if (result[0] != undefined) {

                    // console.log(result)

                    Auth.userdetails(result[0].id, function (userprofile) {

                        if (request.social_id != undefined && request.login_type != 'S') {
                            var flag = 1;
                        }//end if 
                        else {
                            var password = cryptoLib.decrypt(result[0].password, shaKey, process.env.IV);
                            if (password === request.password) {
                                var flag = 1;
                            } else {
                                var flag = 0;
                            }
                        }
                        if (flag == 1) {
                            var updparams = {
                                is_online: "1",
                                last_login: require('node-datetime').create().format('Y-m-d H:M:S'),

                            }
                            // update device information of user
                            common.checkUpdateDeviceInfo(result[0].id, "userlist", request, function () {
                                Auth.updateuserlist(result[0].id, updparams, function (userprofile, error) {
                                    common.generateSessionCode(result[0].id, "userlist", function (token) {
                                        userprofile.token = token;
                                        callback('1', {
                                            keyword: 'rest_keywords_user_login_success', //when succes
                                            components: {}
                                        }, userprofile);
                                    });
                                });
                            });
                        } else {
                            callback('0', {
                                keyword: 'rest_keywords_user_old_password_incorrect', //simple login password incorrect
                                components: {}
                            }, null);

                        }
                    });
                } else {
                    //social id
                    if (request.social_id != undefined && request.login_type != 'S') {
                        //chek email exitsts or not 
                        callback('11', {
                            keyword: 'text_user_login_new',
                            components: {}
                        }, null);

                    } else {
                        callback('0', {
                            // login_type wrong 
                            keyword: 'text_user_login_fail',
                            components: {}
                        }, null);
                    }

                }
            } else {
                callback('0', {
                    keyword: 'rest_keywords_invalid_email',
                    components: {}
                }, null);
            }
        });
    },
    /**
     * Function to send forgot password links
     * @param {request} request 
     * @param {Function} callback 
     */
    forgotPassword: function (request, callback) {

        con.query("SELECT * FROM tbl_user where email='" + request.email + "' AND is_deleted='0' ", function (err, result, fields) {
            if (!err & result[0] != undefined) {

                var updparams = {
                    forgotpassword_token: process.env.APP_NAME + result[0].id,
                    forgotpassword_date: require('node-datetime').create().format('Y-m-d H:M:S')
                }
                Auth.updateuserlist(result[0].id, updparams, function (isupdated) {

                    result[0].encoded_user_id = Buffer.from(result[0].id.toString()).toString('base64');
                    emailTemplate.forgot_password(result[0], function (forgotTemplate) {
                        common.send_email("Forgot Password", request.email, forgotTemplate, function (isSend) {
                            if (isSend) {
                                callback('1', {
                                    keyword: 'rest_keywords_user_forgot_password_success',
                                    components: {}
                                }, result[0]);
                            } else {
                                callback('0', {
                                    keyword: 'rest_keywords_user_forgot_password_failed',
                                    components: {}
                                }, result[0]);
                            }
                        });
                    });
                });
            } else {
                callback('0', {
                    keyword: 'rest_keywords_user_doesnot_exist',
                    components: {}
                }, null);
            }
        });
    },

    /**
     * Function to change the password of users
     * @param {user id} user_id 
     * @param {request} request 
     * @param {Function} callback 
     */
    changePassword: function (user_id, request, callback) {
        Auth.userdetails(user_id, function (userprofile) {
            if (userprofile != null) {
                var currentpassword = cryptoLib.decrypt(userprofile.password, shaKey, process.env.IV);
                if (currentpassword != request.old_password) {
                    callback('0', {
                        keyword: 'rest_keywords_user_old_password_incorrect',
                        components: {}
                    }, null);
                } else if (currentpassword == request.new_password) {
                    callback('0', {
                        keyword: 'rest_keywords_user_newold_password_similar',
                        components: {}
                    }, null);
                } else {
                    var password = cryptoLib.encrypt(request.new_password, shaKey, process.env.IV);
                    var updparams = {
                        password: password
                    };
                    Auth.updateuserlist(user_id, updparams, function (userprofile) {
                        if (userprofile == null) {
                            callback('0', {
                                keyword: 'rest_keywords_something_went_wrong',
                                components: {}
                            }, null);
                        } else {
                            callback('1', {
                                keyword: 'rest_keywords_user_change_password_success',
                                components: {}
                            }, userprofile);
                        }
                    });
                }
            } else {
                callback('0', {
                    keyword: 'rest_keywords_userdetailsnot_found',
                    components: {}
                }, null);
            }
        });
    },



    glass_categories: function (request, callback) {

        var p = "select * from tbl_type t where t.gen_id = " + request.id + " AND is_active = '1'";
        con.query(p, function (err, result) {
            // console.log(result)
            if (!err & result.length > 0) {

                callback("1", { keyword: "rest_keywords_get_store_details_category_success", components: {}, }, result);
            }
            else {

                callback("0", { keyword: "rest_keywords_get_store_details_category_FAIL", components: {}, }, null);
            }

        })
    },

    glass_details: function (request, callback) {

        var p = "select * from tbl_product p where p.type_id = " + request.type_id + " AND is_active = '1'";
        con.query(p, function (err, result) {
            // console.log(result)
            if (!err) {

                callback("1", { keyword: "rest_keywords_get_store_details_category_success", components: {}, }, result);
            }
            else {

                callback("0", { keyword: "rest_keywords_get_store_details_category_FAIL", components: {}, }, null);
            }

        })
    },


    colorList: function (request, callback) {

        var p = "select color from tbl_color where p_id =" + request.id + " AND is_active = '1'";
        con.query(p, function (err, result) {
            if (!err) {
                callback("1", { keyword: "rest_keywords_get_store_details_category_success", components: {}, }, result);
            }
            else {
                callback("0", { keyword: "rest_keywords_get_store_details_category_FAIL", components: {}, }, null);
            }

        })
    },

    framesize: function (request, callback) {

        var p = "select size from tbl_frame_size where p_id =" + request.id + " AND is_active = '1'";
        con.query(p, function (err, result) {
            if (!err) {
                callback("1", { keyword: "rest_keywords_get_store_details_category_success", components: {}, }, result);
            }
            else {
                callback("0", { keyword: "rest_keywords_get_store_details_category_FAIL", components: {}, }, null);
            }

        })
    },

    framewidth: function (request, callback) {

        var p = "select width from tbl_frame_width where p_id =" + request.id + " AND is_active = '1'";
        con.query(p, function (err, result) {
            if (!err) {
                callback("1", { keyword: "rest_keywords_get_store_details_category_success", components: {}, }, result);
            }
            else {
                callback("0", { keyword: "rest_keywords_get_store_details_category_FAIL", components: {}, }, null);
            }

        })
    },

    image: function (request, callback) {

        var p = "select imagee from tbl_pro_image where p_id =" + request.id + " AND is_active = '1'";
        con.query(p, function (err, result) {
            if (!err) {
                callback("1", { keyword: "rest_keywords_get_store_details_category_success", components: {}, }, result);
            }
            else {
                callback("0", { keyword: "rest_keywords_get_store_details_category_FAIL", components: {}, }, null);
            }

        })
    },


    allDetail: function (request, callback) {

        var p = "select * from tbl_product p where p.id = " + request.id + " AND is_active = '1'";
        // var p = "select * from tbl_product";

        con.query(p, function (err, result) {

            if (!err) {
                // console.log(result)
                // console.log(result[0].id)
                request.id = result[0].id
                console.log(result[0].id)
                Auth.colorList(request, function (code, message, color) {
                    // console.log(color)
                    result[0].color = color;

                    Auth.framesize(request, function (code, message, size) {
                        // console.log(size)
                        result[0].size = size;


                        Auth.framewidth(request, function (code, message, width) {
                            // console.log(width)
                            result[0].width = width;

                            Auth.image(request, function (code, message, imagee) {
                                // console.log(imagee)
                                result[0].imagee = imagee;

                                callback("1", { keyword: "rest_keywords_get_store_details_category_success", components: {}, }, result);
                            })
                        })
                    })
                })

            }
            else {

                callback("0", { keyword: "rest_keywords_get_store_details_category_FAIL", components: {}, }, null);
            }

        })
    },

    /**
     * Function to send_otp for users
     * @param {request} request 
     * @param {Function} callback 
     */
    send_otp: function (request, callback) {

        var OTP = Math.floor(1000 + Math.random() * 9000);
        // var OTP = '1234';

        con.query("SELECT * FROM tbl_user_otp_details where mobile = '" + request.mobile + "' ", function (err, result, fields) {

            if (!err && result[0] != undefined) {

                con.query('UPDATE tbl_user_otp_details SET ? WHERE id = "' + result[0].id + '" ', { otp: OTP }, function (err, result, fields) {

                    request.OTP = OTP;
                    callback('1', {
                        keyword: 'otp resend successfull',
                        components: {}
                    }, request);
                })
            }
            else {

                var params = {
                    code: request.code,
                    mobile: request.mobile,
                    otp: OTP
                }
                con.query('INSERT tbl_user_otp_details SET ? ', params, function (err, result, fields) {
                    console.log(this.sql)
                    request.OTP = OTP;
                    callback('1', {
                        keyword: 'otp send successfull',
                        components: {}
                    }, request);
                })
            }
        });

    },

    /**
     * Function to verify_otp for users
     * @param {request} request 
     * @param {Function} callback 
     */
    verify_otp: function (request, callback) {

        con.query(`SELECT * FROM tbl_user_otp_details where mobile = '" + request.mobile + "' AND otp = '" + request.otp + "' `, function (err, result, fields) {
            console.log(result[0])
            if (!err && result[0] != undefined) {

                con.query(`UPDATE tbl_user_otp_details SET otp='' WHERE id = ${result[0].id}`, function (err, result, fields) {
                    callback('1', {
                        keyword: 'otp verification successfull',
                        components: {}
                    }, null);
                })
            }
            else {
                callback('0', {
                    keyword: 'otp verification is fail',
                    components: {}
                }, null);
            }
        });

    },

    order: function (request, callback) {
        createorder(request, function (order_id) {
            if (order_id != null) {
                con.query(`SELECT * FROM tbl_order WHERE id = ${order_id}`, (err, result) => {

                    console.log(err)
                    if (!err) {
                        callback('1', {
                            keyword: 'Order Created...',
                            components: {}
                        }, result);
                    } else {
                        callback('0', {
                            keyword: 'Order not Created...',
                            components: {}
                        }, null);
                    }

                });
            } else {
                callback('0', {
                    keyword: 'Order not Created...',
                    components: {}
                }, null);
            }
        })

        function createorder(request, callback) {
            order = {
                user_id: request.user_id,
                product_id: request.product_id,
                total: request.total,
                service_charge: request.service_charge,
                sub_total: request.sub_total,
                grand_total: request.grand_total,
                payment_method: request.payment_method,
               
            }
            con.query('INSERT INTO tbl_order SET ?', order, (err, result) => {
                console.log(err)
                if (!err) {
                    asyncLoop(request.items, function (item, next) {
                        item.user_id = request.user_id
                        item.order_id = result.insertId
                        // console.log(item)
                        item.sub_total = item.quantity * item.price
                        // console.log(item)
                        con.query('INSERT INTO tbl_order_detail SET ?', item, (err, result) => {
                            console.log(err)
                            if (!err) {
                                next();
                            } else {
                                callback(null);
                            }
                        })
                    }, function (err) {
                        callback(result.insertId)

                    });
                } else {
                    callback(null);
                }

            });
        }
    },

    Cart: function (request, callback){
       con.query(`SELECT c.glass_id,p.name,p.image,p.about,p.price,c.qty,c.sub_total from tbl_cart as c join tbl_product as p on c.glass_id=p.id WHERE c.user_id = ${request.user_id}`, (err, result) => {
            if(!err && result!= undefined){
                Auth.total_count(result, (total) => {
                    object = {
                        grand_total: total,
                        cart: result
                    }
                    callback('1', {
                        keyword: 'cart details found...',
                        components: {}
                    }, object);
                })
            }else{
                callback('0', {
                    keyword: 'cart details not found...',
                    components: {}
                }, null);
            }
       })
    },

    total_count: function(result, callback){
        let total = 0;
        asyncLoop(result, function (item, next) {
                   
            total = parseInt(total) + parseInt(item.sub_total);
            
            next()
        }, function (err) {
            callback(total);
        });
    }



}

module.exports = Auth;


