
const mysql = require('mysql');//getting mysql


//exporting this function to app.js and passing paramaters app and passport
module.exports = function (app, passport) {


	//connecting database


	const con = mysql.createConnection({

		host: process.env.DATABASE_HOST,
		user: process.env.DATABASE_USER,
		password: process.env.DATABASE_PASSWORD,
		database: process.env.DATABASE


	})





	// show the login form
	app.get('/admin', function (req, res) {
	

		// render the page and pass in any flash data if it exists,not using flsh at the moment 
		res.render('adminlogin'
		);
	});

	// process the login form
	app.post('/admin', passport.authenticate('local-login', {
		successRedirect: '/orderdashboard', // redirect to the secure profile section
		failureRedirect: '/admin', // redirect back to the signup page if there is an error

	}),
		function (req, res) {
		

			if (req.body.remember) {
				req.session.cookie.maxAge = 1000 * 60 * 3;
			} else {
				req.session.cookie.expires = false;
			}

		});








		//fetching  pending orders in dashboard 

	app.get('/orderdashboard', isLoggedIn, function (req, res) {
		//joining ordered_items and user_order  adn getting items  whose ordered status  starts with p and ends with g
		let sqlQuery ="SELECT user_order.*, ordered_items.*, user.* FROM user_order INNER JOIN ordered_items USING (id) INNER JOIN user USING (user_id) WHERE order_status LIKE 'p%g';" 
		let query = con.query(sqlQuery, (err, rows) => {
		let length=rows.length

			if (err) throw err;
		res.render('adminorders_dashboard', {
			result: rows,//passing result to ejs so it can show all the results obtained from database query 
			length:length,//for checking wheather order exist or not
			user: req.user // get the user out of session and pass to template

		});
			
		});
	});

//getting completed orders 
	
app.get('/completedorders', isLoggedIn, (req, res) => {

	//same as pending order one but replace wiith completed
	let sqlQuery ="SELECT user_order.*, ordered_items.*, user.* FROM user_order INNER JOIN ordered_items USING (id) INNER JOIN user USING (user_id) WHERE order_status LIKE 'c%d';" 
	
	let query = con.query(sqlQuery, (err, rows) => {
		if (err) throw err;
		res.render('completed_orders', {
			result: rows

		});
	});
});


	//fetching  order details with id 
	 
app.get('/orderdetails/:id', function (req, res) {

    
    let orderId = req.params.id || "";//it request order it from url and the order id is passed from ejs 

    if (!orderId) {
        res.send("Invalid order id");
        return;
    }

    // query order details. 
	//joining shipping_address table and user_order table so that result gets stored in orderdeails
    con.query("select user_order.*, shipping_address.* from user_order inner join shipping_address on user_order.shipping_address_id=shipping_address.id where user_order.id=?", [orderId], function (err, orderDetail) {
        if (err) {
            res.send("Error on fetching order");
            return;
        }

        // query shipping details. 
		//getting shipping address for specfic order 
		//its possible because of joining two shipping_address table and user_order table we can get specific shipping address for specific order
		//result is stored in shippingAddress
        let sqlShippingDetail = "select * from shipping_address where id=?";

        if (orderDetail.length > 0) {

            con.query(sqlShippingDetail, orderDetail[0].shipping_address_id, function (err, shippingAddress) {
                if (err) {
                    res.send("Error on fetching shipping details.");
                    return;
                }

                if (shippingAddress.length <= 0) {
                    res.send("No shipping details found");
                    return;
                }

                // fetching order details having given order id
				//we inner join three tables for this product ordered_items and user_order
				//calculating total price of all products 
				//the result gets stored in ordered items
				// quantity and ordered_price (price of product) is fetched from ordered_items
				
                let sqlOrderItemDetail = "select product.pname,product.pprice, ordered_price, ordered_quantity, (ordered_quantity * ordered_price) as subtotal from ordered_items inner join user_order on ordered_items.user_order_id=user_order.id inner join product on ordered_items.product_id=product.pid where  user_order.id =?";
                con.query(sqlOrderItemDetail, [orderId], function (err, order_items) {
                    if (!err) {
						//checking if there are orders or not

                        if (order_items.length <= 0) {
                            res.send(`No items found in order ${orderId}`);
                            return;
                        }
						
						
						//subtotal and quanitu can have more than one subtotal and quantity for each items 
                        // calculate total quantity and total price of each items
					
                        let totalPrice = 0;
						let quantity=0;
                        order_items.forEach(item => {
							console.log(item)
                            totalPrice += item.subtotal;
							quantity += item.ordered_quantity
							
							

                        });
						
						
						
                        res.render("adminorder_details", {
                            order: orderDetail[0] || "",//this varible store order information like dates , id and status,obtained form joining user_order and shipping address
                            orderId: orderId,//we can also get order id from this variable
                            items: order_items || "", //this variable store product information (table : user_order,order_items and poduct)
                            shippingAddress: shippingAddress[0] || "",//this variable store shipping details of user whith orderId
                            totalPrice: totalPrice,
							quantity: quantity

                        });
                    }
                    if (err) {
                        res.send(err);

                        return;

                    }
                });
            });

        } else {
            res.send(err);
			
            return;
        }

    });



});

//getting details of completed order with id
app.get('/completedorderdetails/:id', function (req, res) {

    
    let orderId = req.params.id || "";//form url which is passed from ejs(completedorder.ejs)

    if (!orderId) {
        res.send("Invalid order id");
        return;
    }

    // query order details. 
	//joining shipping_address table and user_order table so that result gets stored in orderdeails
    con.query("select user_order.*, shipping_address.* from user_order inner join shipping_address on user_order.shipping_address_id=shipping_address.id where user_order.id=?", [orderId], function (err, orderDetail) {
        if (err) {
            res.send("Error on fetching order");
            return;
        }

        // query shipping details. 
		//getting shipping address for specfic order 
		//its possible because of joining two shipping_address table and user_order table we can get specific shipping address for specific order
		//result is stored in shippingAddress
        let sqlShippingDetail = "select * from shipping_address where id=?";

        if (orderDetail.length > 0) {

            con.query(sqlShippingDetail, orderDetail[0].shipping_address_id, function (err, shippingAddress) {
                if (err) {
                    res.send("Error on fetching shipping details.");
                    return;
                }

                if (shippingAddress.length <= 0) {
                    res.send("No shipping details found");
                    return;
                }

                // fetching order details having given order id
				//we inner join three tables for this product ordered_items and user_order
				//calculating total price of all products 
				//the result gets stored in ordered items
				//quantity and ordered_price*price of product* is fetched from ordered_items
				
                let sqlOrderItemDetail = "select product.pname,product.pprice, ordered_price, ordered_quantity, (ordered_quantity * ordered_price) as subtotal from ordered_items inner join user_order on ordered_items.user_order_id=user_order.id inner join product on ordered_items.product_id=product.pid where  user_order.id =?";
                con.query(sqlOrderItemDetail, [orderId], function (err, order_items) {
                    if (!err) {
						//checking if there are orders or not

                        if (order_items.length <= 0) {
                            res.send(`No items found in order ${orderId}`);
                            return;
                        }
						
						
						//subtotal can have more than one subtotal for each items 
                        // calculate total quantity and total price of each items
					
                        let totalPrice = 0;
						let quantity=0;
                        order_items.forEach(item => {
							console.log(item)
                            totalPrice += item.subtotal;
							quantity += item.ordered_quantity
							
							

                        });
						
						
						
                        res.render("completedordersdetails", {
                            order: orderDetail[0] || "",//this varible store order information like dates , id and status,obtained form joining user_order and shipping address
                            orderId: orderId,//we can also get order id from this variable
                            items: order_items || "", //this variable store product information //table : user_order,order_items and poduct
                            shippingAddress: shippingAddress[0] || "",//this variable store shipping details of user whith orderId
                            totalPrice: totalPrice,
							quantity: quantity

                        });
                    }
                    if (err) {
                        res.send(err);

                        return;

                    }
                });
            });

        } else {
            res.send(err);
			
            return;
        }

    });



});


//changing order status
app.post('/updatestatus/:id', (req, res) => {
	let sqlQuery = "update user_order set order_status=? where id=?";//updating user_order table whose orderstatus with is id
	let data = ['completed',req.params.id];//passing data
	let query = con.query(sqlQuery,data, (err, rows) => {
		if (err) throw err;
		
		res.send('order sucessfully procedded ')
		});
});


	//get cat products from database
	app.get('/catview', isLoggedIn, (req, res) => {
		let sqlQuery = "select * from product where pcategory='cat'";//fetching from prodcut table with category cat 
		let query = con.query(sqlQuery, (err, rows) => {
			if (err) throw err;
			res.render('admincat_view', {
				result: rows

			});
		});
	});


	//fetch  fish  products from database
	app.get('/fishview', isLoggedIn, (req, res) => {
		let sqlQuery = "select * from product where pcategory='fish'";
		let query = con.query(sqlQuery, (err, rows) => {
			if (err) throw err;
			res.render('adminfish_view', {
				result: rows

			});
		});
	});

//fetch dog products from database

	app.get('/dogview', isLoggedIn, (req, res) => {
		let sqlQuery = "select * from product where pcategory='dog'";
		let query = con.query(sqlQuery, (err, rows) => {
			if (err) throw err;
			res.render('admindogs_view', {
				result: rows

			});
		});
	});

//fetching prdouct details for product with id
	app.get('/productdetails/:id/', isLoggedIn, (req, res) => {
		console.log(req.params.id);
		con.query('select * from product where pid=?', [req.params.id], (err, rows) => {
			if (err) throw err;
			console.log(rows);
			res.render('adminproduct_details', {
				result: rows

			});
		});
	});


	//deleting product  with givn id
	app.get('/deleteproducts/:id', (req, res) => {
		
		var message={//this is required because we have passed message in addproducts ejs if not passed gives error message
			msg:" product deleted sucessfully "
		  }
		console.log(req.params.id);
		con.query('delete from product where pid=?', [req.params.id], (err, rows) => {
			if (err) throw err;
			console.log('No of deleted products is: ' + rows.affectedRows);
			return res.status(400).render('admin_delete_page', {
				message: message
			  });
		
			

		});



	});


//deleting product  with givn id
	app.get('/deleteproducts/:id', (req, res) => {

		console.log(req.params.id);
		con.query('delete from product where pid=?', [req.params.id], (err, rows) => {
			if (err) throw err;
			console.log('No of deleted products is: ' + rows.affectedRows);
			res.send('product deleted sucessfully');
			

		});



	});





//rendering fish page
	app.get('/fishview', isLoggedIn, (req, res) => {
		res.render('adminfish_view');

	});
	//rendering product details page

	app.get('/productdetail', isLoggedIn, (req, res) => {
		res.render('adminproduct_details');

	});
//rendering dog view page
	app.get('/dogview', isLoggedIn, (req, res) => {
		res.render('admindogs_view');

	});
//rendering add product page
	app.get('/addproducts', isLoggedIn, (req, res) => {

		var message={//this is required because we have passed message in addproducts ejs if not passed gives error message
			msg:"",
			type:""
		  }
		 
		res.render('adminadd_page',{
			message: message
		});
		user: req.user
	});


//get the values from database into form
app.get('/updateproducts/:id/', isLoggedIn, (req, res) => {

	var message={//same as add productts
		msg:"",
		type:""
	  }
	con.query('select * from product where pid=?', [req.params.id], (err, rows) => {//geting product with given id 
		if (err) throw err;
		console.log(rows);
		res.render('adminupdate_page', {
			result: rows,//for writing in adminupdate.ejs
			message:message

		});
	});
});





	app.get('/logout', function (req, res) {

		req.session.destroy(function (err) {
			res.clearCookie();//for extra safety clearing cookie
			res.redirect('/');
		});
	});


	//logged in fucntion  to make sure
	function isLoggedIn(req, res, next) {

		// if user is authenticated in the session, carry on
		if (req.isAuthenticated())
			return next();

		// if they aren't redirect them to the home page
		res.redirect('/');
	}




}






