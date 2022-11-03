const mysql = require('mysql');//getting mysql

const LocalStrategy = require('passport-local').Strategy;//we are going to use local strategy for this method
//connecting database
const con = mysql.createConnection(

    {
        host: process.env.DATABASE_HOST,
        user: process.env.DATABASE_USER,
        password: process.env.DATABASE_PASSWORD,


        database: process.env.DATABASE
    });











// expose this function to our app using module.exports
module.exports = function (passport) {


    // used to serialize the user for the session
    passport.serializeUser(function (user, done) {
        done(null, user.id);
    });

    // used to deserialize the user
    passport.deserializeUser(function (id, done) {
        con.query("select * from admin where id = " + id, function (err, rows) {
            done(err, rows[0]);
        });
    });


    passport.use('local-login', new LocalStrategy({
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true // allows us to pass back the entire request to the callback
    },
        function (req, email, password, done) { 
            con.query("SELECT * FROM admin WHERE email = '" + email + "'", function (err, rows) {
                if (err)
                    return done(err);
                if (!rows.length) {
                    return done(null, false, { message: 'please enter valid email' }

                    ); // req.flash is the way to set flashdata using connect-flash
                }

                // if the user is found but the password is wrong
                if (!(rows[0].password == password))
                    return done(null, false,{ message: 'wrong password' })
                // return successful user
                return done(null, rows[0]);

            });



        }));

}
