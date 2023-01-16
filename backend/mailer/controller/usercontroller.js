const User = require('../model/usermodel');
const Mailer = require('../postfix/mailer');
require('dotenv').config();

const urlBase = "http://localhost:8080/user/";
const SECRET_KEY = process.env.SECRET_KEY;

function confirmationEmail(email,username){
    const user = new User({
        username: username,
        pseudo: "",
        email: email,
        confirm: false,
        password: String(bcrypt.hashSync("verification", 5)),
    })
    Mailer.transport.sendMail(Mailer.mailcreateur('Register',user,'',urlBase+user.username), function(err, info) {
        if (err) { console.log(err) }
        else {  }
    });
};
module.exports.register = async(req, res,next) => {
            confirmationEmail(req.body.email,req.body.username);
};

module.exports.changepassword = async(req, res) => {
    console.log("--")
    Mailer.transport.sendMail(Mailer.mailcreateur('ChangePassword',req.body.user,'',req.body.link), function(err, info) {
        if (err) { console.log(err) }
        else { console.log(info); }
    });
    res.status(200).json({ result: "ok"})
};
module.exports.validationchangepasseword = async(req, res) => {
    Mailer.transport.sendMail(Mailer.mailcreateur('ChangePassewordValidet',req.body.user,'',''), function(err, info) {
        if (err) {
            console.log(err)
        } else {
            console.log(info);
        }
    });
};