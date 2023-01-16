const mongoose = require('mongoose');

const Ticketmodel = mongoose.Schema({
    serial: {
        type: Number,
        required: true,
    },
    artist: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    latitude: {
        type: Number,
        required: true,
    },
    longitude: {
        type: Number,
        required: true,
    },
    date: {
        type: Date,
        required: true,
    }
}, { timestamps: true, })

module.exports = mongoose.model("ticket", Ticketmodel);