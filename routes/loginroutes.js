const express= require('express');
const loginrouter = express.Router();
const authcontroller= require('../controllers/auth');

loginrouter.route('/').get((req,res)=>{
  res.render('login');
});

loginrouter.post( '/',authcontroller.login);
// loginrouter.route('/').post(authcontroller.login);

module.exports= loginrouter;




