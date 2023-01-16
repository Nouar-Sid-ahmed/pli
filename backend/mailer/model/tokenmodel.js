const mongoose = require('mongoose');

const Tokenmodel = mongoose.Schema({
    userID: {
        type: mongoose.Schema.Types.ObjectId, ref:'user',
    },
    token: {
        type: String,
    }
}, )


module.exports = mongoose.model("token", Tokenmodel);