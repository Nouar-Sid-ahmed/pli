const User = require('../model/usermodel');
const Video = require('../model/videomodel')
const jwt = require ('jsonwebtoken');
var getDimensions = require('get-video-dimensions');
var ffmpeg = require('fluent-ffmpeg');
var mkdirp = require('mkdirp');
const Mailer = require('../postfix/mailer');
require('dotenv').config();


// hash password manquant

module.exports.creation = async(req, res) => {
    console.log("--")
    Mailer.transport.sendMail(Mailer.mailcreateur('upload',req.body.user,req.body.title,''), function(err, info) {
        if (err) {
            console.log(err)
        } else {
            console.log(info);
        }
    });
};
module.exports.encod = async(req, res) => {
    Mailer.transport.sendMail(Mailer.mailcreateur('uploadForma',req.body.user,req.body.title,req.body.form), function(err, info) {
        if (err) {
            console.log(err)
        } else {
            console.log(info);
        }
    });
};
module.exports.encodingvideo = async(req, res) => {};