const mongoose = require('mongoose');
const User = require('./usermodel');

const Videomodel = mongoose.Schema({ // à revoir pour la suite
    title:  {
        type: String,
        required: true,
    },
    source: {
        type: String,
        required: true,
    },
    date: {
        type: Date,
        default: Date.now
    },
    views: {
        type: Number,
        required: true,
    },
    enabled: {
        type: Boolean,
        required: true,
    },
    user: {
        type: JSON,
        required: true,
    },
    format: {
        type: Number,
        required: true,
    },
    duration: {
        type: Number,
        required: true,
    }
}, { timestamps: true, })
/*
"format": {
    "1080": string,
    "720": string,
    "480": string,
    "360": string,
    "240": string,
    "144": string
}*/
module.exports = mongoose.model("video", Videomodel);