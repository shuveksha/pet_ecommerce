const express = require('express');
const authcontroller = require('../controllers/auth');
const userprofilerouter = express.Router();
const mysql= require('mysql'); 

const db = mysql.createConnection(
    {
      host: process.env.DATABASE_HOST,
      user: process.env.DATABASE_USER,
      password: process.env.DATABASE_PASSWORD,
      database: process.env.DATABASE
    }
  )

  db.connect((error) => {

    if (error) {
      console.log('error in connecting database');
    }
    else {
      console.log('database connected succesfully')
    }
  })

userprofilerouter.route('/').get(authcontroller.isLoggedIn,function(req, res){


  if (!req.user.user_id) {
      res.redirect('/login');
  }


  // let sql = "select * from user inner join user_order on user.user_id=user_order.user_id where user.user_id=?";

  let userOrderSql = "select * from user_order  where user_id=?";
  db.query(userOrderSql, [req.user.user_id],function (err, result) {
    let length=result.length;
   
    
      if (err) {
          res.send("Server error while fetching userOrder");
          return;
      }
    
      
       res.render('userprofile', {
        orders: result,
        length:length
      });



  });


});



module.exports = userprofilerouter;