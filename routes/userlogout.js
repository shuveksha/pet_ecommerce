const express= require('express');
const authcontroller = require('../controllers/auth')
const mysql= require('mysql');
const userlogoutrouter= express.Router();
userlogoutrouter.route('/').get(authcontroller.logout);


module.exports= userlogoutrouter;
