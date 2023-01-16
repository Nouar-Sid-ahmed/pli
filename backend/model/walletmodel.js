const mongoose = require('mongoose');

const Walletmodel = mongoose.Schema({
    user: {
        type: String,
        required: true,
    },
    tickets: {
        type: Array,
        required: true,
    }
}, { timestamps: true, })

module.exports = mongoose.model("wallet", walletmodel);