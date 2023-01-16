const mongoose = require('mongoose');

const Eventmodel = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    artist: {
        type: [String],
        required: true
    },
    genre: {
        type: [String],
        required: true
    },
    price:{
        type: Number,
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
    image: {
        type: String,
        required: true
    },
    date: {
        type: String,
        required: true,
    }
}, { timestamps: true, })

module.exports = mongoose.model("Event", Eventmodel);