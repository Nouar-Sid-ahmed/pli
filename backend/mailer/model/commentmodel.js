const mongoose = require('mongoose');

const Commentmodel = mongoose.Schema({
    userID: {
        type: mongoose.Schema.Types.ObjectId, ref:'user',
    },

    videoID: {
        type: mongoose.Schema.Types.ObjectId, ref:'video',
    },
    body: {
        type: String,
    }
}, )


module.exports = mongoose.model("comment", Commentmodel);