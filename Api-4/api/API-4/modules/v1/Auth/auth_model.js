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

        con.query("SELECT u.*,concat('" + process.env.S3_BUCKET_ROOT + process.env.USER_IMAGE + "','',u.profile_image) as profile_image,IFNULL(ut.device_token,'') as device_token,IFNULL(ut.device_type,'') as device_type,IFNULL(ut.token,'') as token FROM tbl_user u LEFT JOIN tbl_user_device as ut ON u.id = ut.user_id WHERE u.id = '" + user_id + "' AND u.is_deleted='0' GROUP BY u.id", function (err, result, fields) {
            // console.log("Error of Users", err);
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
            console.log()
            if (isUnique) {

                var userlist = {
                    social_id: (request.social_id != undefined && request.social_id != '') ? request.social_id : '',
                    username: request.username,
                    name: request.name,
                    email: (request.email != undefined && request.email != "") ? request.email : '',
                    is_active: '1',
                    is_online: '1',
                    profile_image: 'default.png',
                    password: (request.password != undefined && request.password != '') ? cryptoLib.encrypt(request.password, shaKey, process.env.IV) : '',
                    login_type: request.login_type,
                };

                con.query('INSERT INTO tbl_user SET ?', userlist, function (err, result, fields) {
                    if (!err) {

                        common.checkUpdateDeviceInfo(result.insertId, "userlist", request, function () {

                            Auth.userdetails(result.insertId, function (userprofile, err) {

                                common.generateSessionCode(result.insertId, "userlist", function (Token) {

                                    userprofile.token = Token;
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
            console.log('a')
            var whereCondition = "social_id = '" + request.social_id + "' AND login_type = '" + request.login_type + "'";

        } else {
            console.log('b')
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


    // resDetail : function (request, callback) {

    //         con.query(`select * from tbl_resta_detail WHERE name like '%${request.search}%'`, function (err, result) {
    //             console.log(request.search)
    //             if (!err) {
    //                 callback('1', {
    //                     keyword: 'restuarent is here',
    //                     components: {}
    //                 }, result);
    //             } else {
    //                 callback('0', {
    //                     keyword: 'something went wrong',
    //                     components: {}
    //                 }, null);
    //             }


    // })

    // },



    resDetail: function (request, callback) {
        console.log(request)
        if (request.search != undefined && request.search != '') {
            var where = `AND (p.location LIKE '%` + request.search + `%')`;
        }
        else {
            var where = '';
        }
        // con.query(`SELECT * FROM tbl_resta_detail WHERE location LIKE '%?%'`, request.search
        con.query(`SELECT p.*,(3959 * 2 * ASIN(SQRT(POWER(SIN(('` + request.latitude + `' - p.latitude) * pi()/180 /2),(2) ) + COS('` + request.latitude + `' * pi() / 180) *  COS(p.latitude * pi()/180) * POWER(SIN(('` + request.longitude + `' - p.longitude) * pi()/180 /2), (2))))) as distance FROM tbl_resta_detail as p WHERE p.is_active='1'` + where + ` HAVING distance <=40000`
            , function (err, result, fields) {
                // console.log('111')
                console.log(result);
                if (!err) {
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
            });
    },


    /*
  productList ()
  */
    restaurant_details: function (request, callback) {
        var Distance = "(3959 * 2 * ASIN(SQRT(POWER(SIN(('` + request.latitude + `' - latitude) * pi()/180 /2),(2) ) + COS('` + request.latitude + `' * pi() / 180) *  COS(latitude * pi()/180) * POWER(SIN(('` + request.longitude + `' - longitude) * pi()/180 /2), (2))))) as distance"

        con.query("SELECT id, image, name, about,latitude, longitude, avg_rating, total_review, " + Distance + " FROM tbl_resta_detail where id='" + request.id + "' AND is_active='1'", function (err, result) {
            console.log(err)
            if (!err) {

                Auth.OCtime(request.id, function (code, message, RestaurantTime) {
                    result[0].Res_Time = RestaurantTime
                })
                Auth.cuisine(request.id, function (code, message, cui_name) {
                    // console.log(request.id)
                    result[0].cui_name = cui_name
                    // console.log(cui_name)

                    callback("1", {
                        keyword: "cuisine is here",
                        components: {},
                    }, result);

                })
            }
            else {
                callback("0", {
                    keyword: "cuisine get failed",
                    components: {},
                }, null);
            }
        })
    },


    // Opning and closing Time and day
    OCtime: function (id, callback) {
        con.query("SELECT res_id, open_time, close_time from tbl_time where res_id='" + id + "' and is_active='1'", function (err, result) {
            // console.log(result)
            if (!err && result.length > 0) {
                callback('1', {
                    keyword: 'time is here',
                    components: {}
                }, result);
            }
            else {
                callback("0", {
                    keyword: "time get failed",
                    components: {},
                }, null);
            }
        })
    },


    /*
    Product category ()
    */
    cuisine: function (request, callback) {

        con.query("SELECT * FROM tbl_cuisine WHERE id = '" + request + "'", function (err, result) {
            // console.log("1", result)

            if (!err && result.length > 0) {

                asyncLoop(result, function (item, next) {

                    Auth.dish(item.id, function (code, message, data) {

                        item.product = data;
                        next();
                    })
                }, function () {
                    callback("1", {
                        keyword: "succsess",
                        components: {},
                    }, result);
                })


            } else {
                callback("0", {
                    keyword: "failed",
                    components: {},
                }, null);
            }
        });
    },


    dish: function (request, callback) {
        // console.log(request)
        con.query("select * from tbl_dish where res_id =" + request + " AND is_active = '1'", function (err, result) {
            //console.log(result)
            if (!err) {
                callback("1", {
                    keyword: "succsess",
                    components: {},
                }, result);
            }
            else {
                callback("0", {
                    keyword: "failed",
                    components: {},
                }, null);
            }
        })
    },

    order_details: function (request, callback) {
        var rules = {
            u_id: (request.u_id != undefined && request.u_id != "") ? request.u_id : '',
            dish_id: (request.dish_id != undefined && request.dish_id != "") ? request.dish_id : '',
            qty: (request.qty != undefined && request.qty != "") ? request.qty : '',

        }
        con.query(`INSERT INTO tbl_cart SET ?`, rules, function (err, result) {


            console.log(err);
            if (!err) {
                callback('1', {
                    keyword: 'rest_keyword_order_details_created',
                    components: {}
                }, result);
            } else {
                callback('0', {
                    keyword: 'rest_keyword_order_details_failed',
                    components: {}
                }, null);
            }
        })
    },

        order: function (request, callback) {
            createorder(request, function (order_id) {
                if(order_id != null){
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
                }else{
                    callback('0', {
                        keyword: 'Order not Created...',
                        components: {}
                    }, null);        
                    }
            })

            function createorder(request, callback) {
                order = {
                    "user_id": request.user_id,
                    "res_id": request.res_id,
                    "total": request.total,
                    "service_charge": request.service_charge,
                    "sub_total": request.sub_total,
                    "discount_amount": request.discount_amount,
                    "grand_total": request.grand_total,
                    "promocode": request.promocode,
                    "payment_method": request.payment_method,
                    "status": request.status
                }
                con.query('INSERT INTO tbl_order SET ?', order, (err, result) => {
                    console.log(err)
                    if (!err) {
                        asyncLoop(request.dish, function (item, next) {
                            item.user_id = request.user_id
                            item.order_id = result.insertId
                            console.log(item)
                            item.sub_total = item.quantity * item.price
                            console.log(item)
                            con.query('INSERT INTO tbl_order_detail SET ?', item, (err, result) => {
                                console.log(err)
                                if(!err){
                                    next();
                                }else{
                                    callback(null);
                                }
                            })
                        }, function (err) {
                            callback(result.insertId)
                            
                        });
                    } else {
                        callback(null);                }
                    
                });
            }
        },


    abc: function (request, callback) {
        con.query("select * from tbl_dish where res_id= " + request.res_id + " and is_active= 1", function (err, result) {

            if (!err) {
                callback('1', {
                    keyword: 'dish is here...',
                    components: {},
                }, result);
            } else {
                callback('0', {
                    keyword: 'dish get failed...',
                    components: {},
                }, null);
            }
        })

    },


    Restaurant_details: function (request, callback) {
        
        restaurant_info(request, (restaurant_data) => {
            openclose(request, (a) => {
                category_data(request, (b) => {
                    object = {
                        restaurant: restaurant_data
                    }
                    restaurant_data.openclose = a
                    restaurant_data.abc = b
                    console.log(object)
                    callback('1', {
                        keyword: 'Details Found...',
                        components: {}
                    }, object);
                })
            })
        })
        
        function restaurant_info(request, callback){
            con.query(`SELECT name, image, about, location, avg_rating, total_review FROM tbl_resta_detail WHERE id = ${request.id} AND is_active = 1`, (err, result) => {
                if(!err){
                    callback(result[0]);
                }else{
                    callback(err);
                }
            })
        }

        function openclose(request, callback){
            con.query(`SELECT  open_time, close_time FROM tbl_time WHERE res_id = ${request.id} AND is_active = 1`, (err, result) => {
                if(!err){
                    callback(result);
                }else{
                    callback(err);
                }
            })
        }

        function category_data(request, callback){
            con.query(`SELECT c.id, c.cui_name FROM tbl_dish d JOIN tbl_cuisine c on c.id = d.cui_id WHERE d.res_id = ${request.id} GROUP BY cui_id;`, (err, result) => {

                asyncLoop(result, function (obj, next) {    
                    console.log(err)
                    con.query(`SELECT id, name, image, about, price FROM tbl_dish WHERE cui_id = ${obj.id} AND is_active = 1`, (err, result) => {
                        if(!err){
                            obj.dish = result;
                        }
                        next();
                    })
                }, function () {
                    callback(result);
                });
            }) 
            
        }


    }



}

module.exports = Auth;

