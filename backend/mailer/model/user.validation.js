const Joi = require('joi');
const userNameReg = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*_).{6,}/;


exports.register =  {
        email: Joi.string().email().required(),
        password: Joi.string().required(),
        userName: Joi.string().regex(userNameReg).required(),
}
