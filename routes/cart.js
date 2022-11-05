const express= require('express');
const cartrouter = express.Router();

const mysql = require('mysql');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');  //password encryption
 const cookieParser= require('cookie-parser');
const authcontroller = require('../controllers/auth')
//  const { promisify } = require('util');

const dotenv= require('dotenv');
dotenv.config({path:'./.env'});

let cart_message;

const con = mysql.createConnection({
  
    host:process.env.DATABASE_HOST,
    user:process.env.DATABASE_USER,
    password:process.env.DATABASE_PASSWORD,
    database:process.env.DATABASE
  

})



cartrouter.route('/').get(authcontroller.isLoggedIn, (req, res) => {

   
    if(req.user){
    
    let sql = "select product.pname, product.pprice,cart.quantity,cart.pid,cart.quantity*product.pprice as sub_total from cart inner join product on cart.pid=product.pid where cart.user_id=?";
   
    con.query(sql, [req.user.user_id], function (err, result) {
    
        if (err) {
            res.send("Error fetching user cart");
            return;
        }
        if(result.length<=0)
    
        {
            cart_message="your cart is empty";
        
        }


        if (result.length >=0) {
            total_item = result.length;
            cart_message =` You have  ${total_item} item in your cart;`

            let total_quantity = 0;
            let total_price = 0

            result.forEach(item => {
                total_quantity += item.quantity;
                total_price += item.sub_total;
            });

            res.render('cart', {
                cart_message: cart_message,
                items: result,
                total_quantity: total_quantity,
                total_price: total_price
            });
        }  

    })




}
else{
    res.redirect('/')
}
})


cartrouter.route('/').post((req,res)=>{

 let cart_id= req.body.cart_id;
    if(cart_id){
         con.query("DELETE FROM cart WHERE pid=?",[cart_id]);
    }
    res.redirect('/cart');

})


// getting the product id from db
// ++++++++++++


// cartrouter.route('/:id').get((req,res)=>{

   
//   const id = req.params.id;
//   console.log(id); //db kai pid ako cha
//   const con = mysql.createConnection({
  
//       host:process.env.DATABASE_HOST,
//       user:process.env.DATABASE_USER,
//       password:process.env.DATABASE_PASSWORD,
//       database:process.env.DATABASE
    

// })
// con.query("SELECT * from product where pid=?",[id],(err,result)=>{
//     res.render('cart',{
//         result:result
//     });

// })
// });


// });


module.exports= cartrouter;




  




// *******
