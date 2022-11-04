const express = require('express');
const fishrouter = express.Router();

const mysql = require('mysql');



fishrouter.route('/').get((req, res) => {
  const con = mysql.createConnection(

    {
      host: process.env.DATABASE_HOST,
      user: process.env.DATABASE_USER,
      password: process.env.DATABASE_PASSWORD,
      database: process.env.DATABASE
    }



  );
  con.query("SELECT * from product where pcategory='fish'", (err, result) => {
    console.log("the value of result is", result);
    res.render('fishproducts', {
      result: result
    })

  })
});


fishrouter.route('/:id').get((req, res) => {

  const id = req.params.id;
  const con = mysql.createConnection({

    host: process.env.DATABASE_HOST,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE


  })


  
 
  

  // related products 
  con.query("SELECT * from product where pcategory='fish' and pid=?", [id], (err, result) => {
    let name= result[0].pname;
    let finalname=name.split(' ')[0];
    console.log('the name is ',finalname);


    let similar = "select * from product where pname like ? and pcategory='fish'";
    con.query(similar, ['%'+finalname+ '%'], function (err, rows) {
      console.log('the similar is',rows);
      console.log('the res is',result);
      
      res.render('fishdetail', { 
        rows:rows,
        result:result
      
        
        
                              
  
      });
    

    });



    

   
  
  })

  

//related closed


});

module.exports = fishrouter;