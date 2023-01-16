const { string } = require('joi');
const mongoose = require('mongoose');
const validator = require('validator');
const userNameReg = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*_).{6,}/;

const Usermodel = mongoose.Schema({
    username: {
        type: String,
        required: true,
    },
    picture: {
        type: String,
        required: false,
    },
    confirm: {
        type: Boolean
    },
    email: {
        type: String,
        required: true,
        validate: {
            validator(email) {
                return validator.isEmail(email);
            },
            message: '{VALUE} is not a valid email!',
        },
    },
    password: {
        type: String,
        minlength: [6, 'Password need to be longer!'],
        required: true,
    },
    date: {
        type: Date,
        default: Date.now
    },
    token: {
        type: String,
    },
    country:{
        type: String,
    }
}, { timestamps: true, })

module.exports = mongoose.model("user", Usermodel);