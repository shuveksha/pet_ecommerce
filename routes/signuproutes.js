const express= require('express');
const signuprouter = express.Router();
 const authcontroller = require('../controllers/auth');

 signuprouter.route('/').get((req,res)=>{
    res.render('signup');
  });
// signuprouter.post( '/',authcontroller.signup);
signuprouter.route('/').post(authcontroller.signup); //post ma mero data haru  form ko chaiyeko ho get mah chai page lai display garako

module.exports= signuprouter;

