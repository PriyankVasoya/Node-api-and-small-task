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
                    mobile_no: (request.mobile_no != undefined && request.mobile_no != "") ? request.mobile_no : '',
                    password: (request.password != undefined && request.password != '') ? cryptoLib.encrypt(request.password, shaKey, process.env.KEY) : '',
                    login_type: (request.login_type != undefined && request.login_type != "") ? request.login_type : '',

                };

                con.query('INSERT INTO tbl_user SET ?', userlist, function (err, result, fields) {
                    if (!err) {

                        common.checkUpdateDeviceInfo(result.insertId, "userlist", request, function () {

                            Auth.userdetails(result.insertId, function (userprofile, err) {
                                console.log("test", userprofile)
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
                        console.log(err)
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

                    console.log(result)

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


    Category: function (request, callback) {

        var where = ''
        if (request.id != undefined && request.id != '') {

            where = `where id = ` + request.id + ``;
        } else {
            where = ``;
        }

        con.query(`select * from tbl_category ` + where + ``, function (err, result) {
            if (!err) {
                callback('1', {
                    keyword: 'rest_keyword_category_add_success',
                    components: {}
                }, result);
            } else {
                callback('0', {
                    keyword: 'rest_keyword_category_add_failed',
                    components: {}
                }, null);
            }
        })
    },

    storeDetails: function (request, callback) {

        var where = '';
        if (request.category_id != undefined && request.category_id != '') {

            where = `where s.category_id LIKE '%` + request.category_id + `%'`;
        } else {
            where = ``;
        }
        console.log(request.latitude);
        console.log(request.longitude);
        //6371 for kilometer & 3959 for miles measure distance
        con.query(`SELECT s.*, c.*, (6371 * 2 * ASIN(SQRT(POWER(SIN(('` + request.latitude + `' - s.latitude) * pi()/180 / 2), (2))+
    COS('`+ request.latitude + `' * pi()/180) * COS(s.latitude * pi()/180) * POWER(SIN(('` + request.longitude + `' - s.longitude) * pi()/180 / 2),
    (2))))) as distance
     FROM tbl_store as s
      LEFT JOIN tbl_category as c
      ON s.category_id = c.id  `+ where + ``, function (err, result) {
            console.log("aaaaaaaa");
            console.log(result);
            if (!err && result) {
                callback('1', {
                    keyword: 'rest_keywords_get_location_success',
                    components: {}
                }, result);
            }
            else {
                callback('0', {
                    keyword: 'rest_keywords_get_location_failed',
                    components: {}
                }, null);
            }
        })
    },

    Product: function (request, callback) {

        var where = '';
        if (request.id != undefined && request.id != '') {

            where = `where id LIKE '%` + request.id + `%'`;
        } else {
            where = ``;
        }

        con.query(`SELECT * FROM tbl_store ` + where + ``, function (err, result, feilds) {
            if (!err && result[0] != undefined) {
                var data = result[0]

                con.query(`SELECT sc.name, p.image, p.name, p.about, p.price 
            FROM tbl_product as p
            LEFT JOIN tbl_subcategory as sc 
            ON p.sub_category_id = sc.id
            where store_id = '`+ result[0].id + `'`, function (err, result, feilds) {
                    console.log(result)
                    if (!err && result != undefined) {
                        data.product = result;
                        callback('1', {
                            keyword: 'successfully get details',
                            components: {}
                        }, data);
                    } else {
                        callback('0', {
                            keyword: 'failed to get details',
                            components: {}
                        }, null);
                    }
                })
            } else {
                callback('0', {
                    keyword: 'failed to get details',
                    components: {}
                }, null);
            }
        })
    },

    Fav: function (request, callback) {

        var where = '';
        if (request.id != undefined && request.id != '') {

            where = `where p.user_id LIKE '%` + request.id + `%'`;
        } else {
            where = ``;
        }

        con.query(`SELECT p.user_id, pr.image, pr.name, pr.price
     FROM tbl_pro_fav as p
    LEFT JOIN tbl_product as pr
     ON p.pro_id = pr.id `+ where + ``, function (err, result) {
            if (!err && result.length > 0) {
                callback('1', {
                    keyword: 'rest_keyword_get_place_distance',
                    components: {}
                }, result);
            } else {
                callback('0', {
                    keyword: 'rest_keyword_get_place_distance_failed',
                    components: {}
                }, err);
            }
        })
    },


    // Show Category
    shopprod: function (request, callback) {
        var response = {};
        con.query(`SELECT c.*, (3959 * 2 * ASIN(SQRT(POWER(SIN(('` + request.latitude + `' - c.latitude) * pi()/180 / 2), (2))+
        COS('`+ request.latitude + `' * pi()/180) * COS(c.latitude * pi()/180) * POWER(SIN(('` + request.longitude + `' - c.longitude) * pi()/180 / 2),(2))))) as miles_away from tbl_store c where c.id= '` + request.id + `'`, function (err, result) {
            console.log(result)
            if (!err && result.length > 0) {

                response.store_details = result[0];
                Auth.prod_category(request, function (code, message, responsedata) {
                    console.log("2")
                    console.log(responsedata)

                    response.product_details = responsedata;
                    callback('1', {
                        keyword: 'rest_keywords_get_product_success',
                        components: {}
                    }, response)
                });
            } else {
                callback('0', {
                    keyword: 'rest_keywords_get_product_failed',
                    components: {}
                }, null);
            }
        })
    },

    prod_category: function (request, callback) {
        console.log(request.id)
        con.query(`SELECT pc.id, pc.name FROM tbl_product p LEFT JOIN tbl_subcategory pc ON p.sub_category_id = pc.id WHERE p.store_id = '` + request.id + `' GROUP BY pc.name`, function (err, result) {
            console.log(result)

            if (!err) {

                asyncLoop(result, function (item, next) {
                    Auth.get_comp_prod(item.id, function (code, message, data) {
                        item.product = data;
                        console.log(data)

                        next();
                    })
                }, function () {
                    callback('1', {
                        keyword: 'rest_keywords_get_product_success',
                        components: {}
                    }, result);
                });
            } else {
                callback('0', {
                    keyword: 'rest_keywords_get_product_failed',
                    components: {}
                }, null);
            }
        })
    },

    get_comp_prod: function (id, callback) {
        con.query(`SELECT * FROM tbl_product WHERE sub_category_id = '` + id + `'`, function (err, result) {
            console.log('111')

            if (!err) {
                callback('1', {
                    keyword: 'rest_keywords_get_product_success',
                    components: {}
                }, result);
            } else {
                callback('0', {
                    keyword: 'rest_keywords_get_product_failed',
                    components: {}
                }, null);
            }
        })
    },

}

module.exports = Auth;


