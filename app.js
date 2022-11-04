const express = require('express');
const chalk = require('chalk');
const debug = require('debug')('petshopstore');
const morgan = require('morgan');
const path = require('path');
const bodyparser = require('body-parser');
const mysql = require('mysql');
const dotenv = require('dotenv');
const cookieParser = require('cookie-parser');
const authcontroller = require('./controllers/auth');
const session = require('express-session')
const passport = require('passport');
const multer = require('multer');
const flash = require('connect-flash');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
const bcrypt = require('bcryptjs');

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

dotenv.config({ path: './.env' });

const app = express(); //object instantiated
app.set('view engine', 'ejs'); //registering ejs (view engine)


//establishing(creating) db connection
const db = mysql.createConnection({
  host: process.env.DATABASE_HOST,
  user: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASSWORD,
  database: process.env.DATABASE
})

db.connect((error) => {

  if (error) {
    debug('error in connecting database');

  }
  else {
    debug('database connected succesfully')
  }
})
const jwt_secret = process.env.JWT_SECRET;
app.use(morgan('tiny')); // middleware
app.use(express.static(path.join(__dirname, '/public')));
app.use('/css', express.static(path.join(__dirname, 'node_modules/bootstrap/dist/css')));
app.use('/js', express.static(path.join(__dirname, 'node_modules/bootstrap/dist/js')));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(cookieParser());//cookies haru use garna
//homepage ko chuttai route banauna baki cha




// required for passport
app.use(session({
  name: 'mycookie',
  secret: 'oursecret',
  resave: true,
  saveUninitialized: false
})); // session secret
app.use(passport.initialize()); //initiliazing passport with app.js
app.use(passport.session()); // persistent login sessions
app.use(flash()); // use connect-flash for flash messages store

// Make available request.user data in all ejs template using locals. 
app.use(function (req, res, next) {
  res.locals.user = req.session.user;
  next();
});



//! Use of Multer
const upload = multer({ dest: 'public/assets/uploads/' });

// configure flash 
// This configuration make flash messages available inside all ejs templates

// To access success and error variables in ejs just use
// <%= flashMessages.success %>
// %= flashMessages.error %>
app.use(function(req, res, next){
  res.locals.flashMessages = req.flash();  
  next();
});






app.get('/', authcontroller.isLoggedIn, (req, res) => {
db.query('SELECT pimage FROM `product` LIMIT 10',(err,result)=>{
  console.log(result);
  res.render('homepage', {
    user: req.user,
    image:result
  });
})
 

});


require('./controllers/passport')(passport); // pass passport for c


require('./routes/admin.js')(app, passport);




//****importing routes***

//adding products from admin 

app.post("/addproducts", upload.single('image'), (req, res) => {





  const pname = req.body.pname;
  const pcategory = req.body.pcategory;
  const pprice = req.body.pprice;
  const pdiscription = req.body.pdiscription;
  const db_image_path = 'assets/uploads/' + req.file.filename;


  if (!req.file.filename || !pname || !pcategory || !pprice || !pdiscription || !req.file.filename) {

    var message = {
      msg: "please enter all  fields",
      type: "alert"
    }

    return res.status(400).render('adminadd_page', {
      message: message
    });

  }



  else if (isNaN(pprice)) {

    var message = {
      msg: "plase enter valid number",
      type: "alert"
    }


    return res.status(400).render('adminadd_page', {
      message: message
    });

  }












  else if (req.file.mimetype !== "image/jpeg" && req.file.mimetype !== "image/png" && req.file.mimetype !== "image/gif" && req.file.mimetype !== "image/jpg") {


    message = {
      msg: "please enter valid file type i.e png jpg or gif",
      type: "alert"
    }
    return res.status(400).render('adminadd_page', {
      message: message
    });



  }

  else {

    message = {
      msg: "product added sucessfuly!!",
      type: "success"
    }


    const insertData = "INSERT INTO product(pimage,pname,pprice,pdiscription,pcategory)VALUES(?,?,?,?,?)"
    db.query(insertData, [db_image_path, pname, pprice, pdiscription, pcategory], (err, result) => {
      if (err) throw err

      return res.status(400).render('adminadd_page', {
        message: message
      });








    });
  }




});




//update products by admin 


app.post("/updateproductpost/:id", upload.single('image'), (req, res) => {

  console.log(req.body);


  const pname = req.body.pname;//get pname from form
  const pcategory = req.body.pcategory;//get category from form 
  const pprice = req.body.pprice;//get price from form
  const pdiscription = req.body.pdiscription;//get description from form

  let rows;
  console.log(req.params.id);
  getData = 'SELECT * FROM product WHERE pid=?';
  db.query(getData, [req.params.id], (err, result) => {

    rows = result;

    if (err) {
      console.log(err);
      return;
    }

    if (!pname || !pcategory || !pprice || !pdiscription) {
      console.log('name' + pname);
      console.log('categoty' + pcategory);
      console.log('price' + pprice);
      console.log('pdiscription' + pdiscription);

      message = {
        msg: "please enter all  fields",
        type: "alert"
      }

      return res.status(400).render('adminupdate_page', {
        result: rows,
        message: message
      });

    } else if (isNaN(pprice)) {

      message = {
        msg: "please enter valid number",
        type: "alert"
      }


      return res.status(400).render('adminupdate_page', {
        message: message,
        result: rows

      });

    } else {
      let sqlUpdateQuery = '';
      let update_query_column = '';
      if (!req.file) {
        sqlUpdateQuery = "UPDATE  product SET pname=?,pprice=?,pdiscription=?,pcategory=? WHERE pid=? ";
        update_query_column = [pname, pprice, pdiscription, pcategory, req.params.id]


      } else {
        const db_image_path = 'assets/uploads/' + req.file.filename;
        sqlUpdateQuery = "UPDATE  product SET pimage=?,pname=?,pprice=?,pdiscription=?,pcategory=? WHERE pid=? ";
        update_query_column = [db_image_path, pname, pprice, pdiscription, pcategory, req.params.id]

      }
     
      db.query(sqlUpdateQuery, update_query_column, (err, result) => {
        if (err){
          console.log(err);
          req.flash("error", "Error updating product" + pname);
          return res.redirect('/updateproducts/'+req.params.id);

        }

        if(result) {
          req.flash("success", pname + " Updated successfully");
          return res.redirect('/updateproducts/'+req.params.id);

          
        }
          

      });
    }

  });

});



const catrouter = require('./routes/catroutes');
app.use('/catproducts', catrouter);

const dogrouter = require('./routes/dogroutes');
app.use('/dogproducts', dogrouter);

const fishrouter = require('./routes/fishroutes');
app.use('/fishproducts', fishrouter);

const loginrouter = require('./routes/loginroutes');
app.use('/login', loginrouter);

const signuprouter = require('./routes/signuproutes');
app.use('/signup', signuprouter);

// const adminloginrouter= require('./routes/adminlogin');
// app.use('/admin',adminloginrouter);

const userprofilerouter = require('./routes/userprofile');
app.use('/myorders', userprofilerouter);
// const landingpagerouter= require('./routes/landingpageroute'); //login bhaye pachi balla dekhinu parne page ho yo  
// app.use('/landingpage',landingpagerouter);

const userlogoutrouter = require('./routes/userlogout');
app.use('/userlogout', userlogoutrouter);

const cartrouter = require('./routes/cart');
app.use('/cart', cartrouter);

const cartaddrouter = require('./routes/addtocart');

app.use('/add/cart', cartaddrouter);

const { publicDecrypt } = require('crypto');
const { type } = require('os');
const { search } = require('./routes/catroutes');



//ipsha

let payload;
// forget and reset password routes

app.get('/forget-password', (req, res, next) => {
  res.render('forget-password');
})

let product;

app.post('/forget-password', (req, res, next) => {
  const { email } = req.body;
  console.log('the email is '+email)

  db.query("SELECT * from user where user_email=?", [email], (err, result) => {
    console.log(result);
    product = result[0];
    if (email != product.user_email) {
      res.send('user not registerd');
      return;

    }
    //if user exist creating a one time link valid for certain time

    const secret = jwt_secret + product.user_password;
    const payload = {
      email: product.user_email,
      id: product.user_id
    }

    const token = jwt.sign(payload, secret, { expiresIn: '15m' });
    const link = `http://localhost:3000/reset-password/${product.user_id}/${token}}`;

    // send the link to email// here
   

    var mailOptions = {
      from: 'purfect1123@gmail.com',
      to: payload.email,
      subject: 'Password reset link',
      text: link
    };

    let transport = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'purfect1123@gmail.com',
        pass: "cbkqzdsluwcqvmdq"
      },
      port: 3000,
      host: 'smtp.gmail.com'

    });


    transport.sendMail(mailOptions, (error) => {
      if (error) {
        console.log(error)

      }
      else {
        console.log("email sent");
      }
    })

    res.send('password reset link sent to email...');
    console.log(link);
  });


})

app.get('/reset-password/:id/:token', (req, res, next) => {

  const { id, token } = req.params;

  //check if this id exist in database
  if (id != product.user_id) {
    res.send('invalid id....');
    return;
  }
  //here if false then we have a valid id

  const secret = jwt_secret + product.user_password;
  // let email;
  try {
    const payload = jwt.verify(token, secret);
    res.render('reset-password', {
      email: product.user_email
    });
  }
  catch (error) {
    console.log(error.message);
    res.send(error.message);
  }

})

app.post('/reset-password/:id/:token', async (req, res, next) => {
  const { id, token } = req.params;
  const { password, password2 } = req.body;
  //check if this id existin database
  if (id != product.user_id) {
    res.send('invalid id....');
    return;
  }
  const secret = jwt_secret + product.user_password;

  try {
    const payload = jwt.verify(token, secret);
    //validate password and password2
    if (password !== password2) {
      res.send('password do not match');
      return;
    }


    db.query(`select * from user where user_email=${payload.email} and user_id=${payload.id}`, async (error, results) => {

      console.log(results);

      let hashpassword = await bcrypt.hash(password2, 8);
      console.log(`the hassed password id ${hashpassword}`);



      let sql = `update user set user_password=? where user_id=?`;
      let data = [hashpassword, payload.id]



      db.query(sql, data, (error, results, feilds) => {
        if (error) {
          return console.error(error.message);
        }

      })
      res.send('successful');
    })
  }

  catch (error) {
    console.log(error.message);
    res.send(error.message);

  }
})

//confrim order (shipping details )





app.post('/cart/order', authcontroller.isLoggedIn, function (req, res) {
  // Allow only for logged in user. 
  if (!req.user) {
    res.redirect('/login');
    return;
  }


  // Grab the user information from login 
  // 
  let userId = req.user.user_id;

  // To process the order, capture the shipping details from the req.body 
  let full_name = req.body.full_name || "";
  let email = req.body.email || "";
  let phone = req.body.phone || "";
  let street_address = req.body.street_address || "";
  let city = req.body.city || "";

  // Do shipping form validation 
  // If shipping form is not valid, aware the user with error message
  if (!full_name || !email || !phone || !street_address) {
    // If anyone of the field is empty return again with the message
    res.send("Please fill the shipping details completly");
    return;
  }

  // If everyting is OK, grab the product details from the 
  // user cart, create the order with invoice no, 
  // insert the items from cart to order details 
  // after successfull insert of items from cart 
  // to order_items, Empty the user cart by deleting the items from cart
  // use delete query to delete the cart. 

  // sql to query all the items in a cart of the logged in user 

  // Here we do the join query between cart and product table beacause we want all 
  // information of produt from the product table aswell. 

  // id, user_id, pid, quantity, pid, pname, pprice, pdiscription, pimage, pcategory
  // cart.* => query all column from cart 
  let sql = "select cart.*, product.pprice as price from cart inner join product on cart.pid=product.pid where user_id=?";
  db.query(sql, [userId], function (err, cartItems) {


    if (err) {
      res.send("Error on fetching cart")
      return;
    }
    // If cart is empty retun to the user with messae no items in cart to frontend
    if (cartItems.length <= 0) {
      res.send("Your cart is empty");

      // If result.length > 0 that means the user has added the product into the cart 
      // Now query and create an order based on the product present in the cart.
    } else if (cartItems.length >= 1) {
      // To add items from cart to invoice first create an invoice with invoice id. 
      // Order table is used to insert the userOrdered items from cart to order table.
      // create an order and invoice. 
      // Shipping also required to ship the order details, with every order, there is 
      // also a shipping record

      // Shipping is created based on the data sent durin the checkout process from frontend.
      let shippingSql = "insert into shipping_address(full_name, email, phone, street_address, city) values(?)";
      let shippingTableColumn = [full_name, email, phone, street_address, city];

      db.query(shippingSql, [shippingTableColumn], function (err, shippingInsertResult) {
        if (err) {
          // If shipping fails return to the user with this error message
          res.send("Server error on inserting shipping address");
          return;
        }

        let shippingId = shippingInsertResult.insertId;


        //create order
        let createOrderSql = "insert into user_order(user_id, shipping_address_id,order_status) values(?)";

        let createOrderColumns = [req.user.user_id, shippingId, 'pending'];
        db.query(createOrderSql, [createOrderColumns], function (err, result) {
          if (err) {
            res.send("error on creating orders");
            return;
          }
          let orderId = result.insertId;

          // insert items from cart to ordered items. 

          let insertSql = "insert into ordered_items(product_id, ordered_price, ordered_quantity, user_order_id) select cart.pid, product.pprice, cart.quantity, ? from cart inner join product on cart.pid=product.pid where cart.user_id=?";

          db.query(insertSql, [orderId, req.user.user_id], function (err, result) {

            if (err) {
              console.log(err);
              console.log("Error while adding items form cart to ordereditems");
            }

            if (result) {

              console.log("Inserted items into ordered items from cart", result);


              // delete items from cart 


              db.query("delete from cart where user_id=?", [req.user.user_id], function (err, result) {
                if (!err) {

                  return res.redirect('/payment/'+orderId);
                }

                if (result) {
                  console.log("Delete from cart");
                  return;
                }
              });

            }

          });
        });
      });

      // res.redirect('/');
    }
  })
});




app.get('/search', function (req, res) {
  let search_query = req.query.search_query

  let sql_search_query = "select * from product where pname like ?";
  db.query(sql_search_query, ['%' + search_query + '%'], function (err, result) {

    res.render('search', {
      products: result,
      searchQuery: search_query
    });

  });

});

//searchDetails


app.get('/searchproductdetail/:id',function(req,res){
  let id=req.params.id;


  db.query("SELECT * from product where pid=?", [id], (err, result) => {

    console.log(result);
    res.render('searchproductdetail', { result: result });
    console.log(result[0].pname);
    console.log(err);

  });


});





//order details from here


app.get('/order/detail/:orderId', authcontroller.isLoggedIn,(req, res)=> 
  {
    if (!req.user) {
        res.redirect('/login');
    }
    let orderId = req.params.orderId;
    if (!orderId) {
        res.send("Invalid orderId");
        return;
    }


    // order detail. 
    db.query("select user_order.*, shipping_address.* from user_order inner join shipping_address on user_order.shipping_address_id=shipping_address.id where user_order.user_id=? and user_order.id=?", [req.user.user_id,orderId], function (err, orderDetail) {
        if (err) {
            res.send("Error on fetching order");
            return;
        }

        // query shipping details. 
        let sqlShippingdetail = "select * from shipping_address where id=?";

        if (orderDetail.length > 0) {
          // if(sqlShippingdetail.length>0){

            console.log("Order detail is",orderDetail);
            console.log('----');



            db.query(sqlShippingdetail,orderDetail[0].shipping_address_id, function (err, shippingAddress) {
                if (err) {
                    res.send("Error on fetching shipping details.");
                    return;
                }


                if (shippingAddress.length <= 0) {
                    res.send("No shipping details found");
                    return;
                }




                // fetch order details having order.id  
                let sqlOrderItemDetail = "select product.pname, ordered_price, ordered_quantity, (ordered_quantity * ordered_price) as subtotal from ordered_items inner join user_order on ordered_items.user_order_id=user_order.id inner join product on ordered_items.product_id=product.pid where user_order.user_id =? and user_order.id =?";
                db.query(sqlOrderItemDetail, [req.user.user_id,orderId], function (err, order_items) {
                    if (!err) {


                        if (order_items.length <= 0) {
                            res.send(`No items found in order ${orderId}`);
                            return;
                        }

                        // calculate total quantity and total price
                        let totalPrice = 0;
                        order_items.forEach(item => {
                            totalPrice += item.subtotal;

                        });

                        // render order detail page. 
                        res.render("order_detail", {
                            order: orderDetail[0] || "",
                            items: order_items || "",
                            shippingAddress: shippingAddress[0] || "",
                            totalPrice: totalPrice,
                            orderId:orderId
                        });
                    }
                    if (err) {
                        res.send(`Error on fetching order items  having order id ${orderId}`);
                        return;

                    }



                });



            });

        } else {
            res.send("Error on fetching order detail");
            return;
        }

    });
})


app.get('/payment/:id',authcontroller.isLoggedIn,(req,res)=>{
  let totalPrice=0;
  let orderId=req.params.id;
  let paymentprice = "select product.pname, ordered_price, ordered_quantity, (ordered_quantity * ordered_price) as subtotal from ordered_items inner join user_order on ordered_items.user_order_id=user_order.id inner join product on ordered_items.product_id=product.pid where user_order.user_id =? and user_order.id =?";
  
  db.query(paymentprice, [req.user.user_id,orderId],function(err,result){

    console.log(result);

    let totalPrice = 0;
                        result.forEach(item => {
                            totalPrice += item.subtotal;

                        })

     res.render('payment',{
    
      result:result,
      orderId:orderId,
      totalPrice:totalPrice


     });
})
})










app.listen(3000, () => {
  debug(`listening on port ${chalk.blue.bold('3000')}`);
});
