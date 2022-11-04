// (it deals data from the signup login  form)
const mysql = require('mysql');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');  //password encryption
// const cookieParser= require('cookie-parser');
const { promisify } = require('util');
const dotenv= require('dotenv');
dotenv.config({path:'./.env'});

const con=mysql.createConnection(
    {
    host:process.env.DATABASE_HOST,
    user:process.env.DATABASE_USER,
    password:process.env.DATABASE_PASSWORD,
    database:process.env.DATABASE
  })


exports.login = async (req, res) => {

    try {
        const { email, password } = req.body; //login form ko data haru 

        if (!email || !password) {
            return res.status(400).render('login', {
                message: 'please enter all fields'
            });
        
        }
        con.query('select * from user where user_email=?', [email], async (error, results) => {
            console.log(`the result is ${results}`);
            
            //  checking if no result comes or password for that email is incorrect
            if (!results || !(await bcrypt.compare(password, results[0].user_password))){
                return res.status(401).render('login', {
                    message: 'email or password is incorrect'
                })
               
            }
              
            // sabbaikura match bhayo bhane creating token and using that
            else {
                const user_id = results[0].user_id;
                //token banauna user is ra secrect chaincha
                const token = jwt.sign({ user_id }, process.env.JWT_SECRET, {


                    expiresIn: process.env.JWT_EXPIRES_IN

                });
                console.log(`the token is ${token}`);
             

                const cookieOptions = {
                    expires: new Date(Date.now() + process.env.JWT_COOKIE_EXPIRES * 24 * 60 * 60 * 1000),
                    httpOnly: true
                }
                res.cookie('jwt', token, cookieOptions);
                //cookie lai browser mah set garna(cokkie name jwt rakheko )
            
                res.status(200).redirect("/");
                
            
            }
            
            

        });


    }
    catch (error) {
        console.log(error);
    }
}





exports.signup = (req, res) => {
    console.log(req.body); //form ko kura display garcha req.body le 


    // const name= req.body.name;
    // const email= req.body.email;

    const { name, email, password, passwordconfirm } = req.body;  //mathi bhanda esari destructuring garera gareko ramro

    con.query('select user_email from user where user_email= ?', [email], async (error, results) => {

        if (error) {
            console.log(error);
        }
        if (results.length > 0) {
            return res.render('signup', {
                message: 'This email is already in use'
            })
        }

        else if (password !== passwordconfirm) {
            return res.render('signup', {

                message: 'Password does not match'
            }
            );
        }

        //  database ma halnu agadi check aru confirmation haru then only add to        database
        //firstly hashing password
        let hashpassword = await bcrypt.hash(password, 8);
        console.log(hashpassword);

        con.query('insert into user set ?',{ name: name, user_password: hashpassword, user_email: email }, (error, results) => {


            if (error) {
                console.log(error);
            }

            else {
                console.log(results);
                return res.render('signup', {

                    message: 'User succesfully registered'
                }
                )
            }

        })


    });


}

exports.isLoggedIn = async (req, res, next) => {
    // console.log(req.cookies);

    //******step1 : to verify the token of user*****

    if (req.cookies.jwt) //if jwt ko cookie ho bhane(middleware)
    {
        try {
            //to decode the token to grab the id of user loggin in  
            const decoded = await promisify(jwt.verify)(req.cookies.jwt,
                process.env.JWT_SECRET); //esle promise return gari ra cha ya success  ani failure kai
            console.log(`decoded is ${decoded}`);
            //*********Step 2: to check the user in db****************/

            con.query('select * from user where user_id= ?',[decoded.user_id], (error, results) => {
                console.log(`the result is ${results}`);
                if (!results) {
                    return next();
                }

                req.user = results[0];
                console.log(req.user);
                return next();


            });

        }
        catch (error) {
            console.log(error);
            return next();

        }
    }
    else {
        next();//middleware sakke pachi ko code run garne
    }


}
exports.logout=async(req,res)=>{

    res.cookie('jwt','logout',{
        expires:new Date( Date.now()+4*1000),
        httpOnly:true
    });
res.status(200).redirect('/');

     
}