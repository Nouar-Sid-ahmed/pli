const util = require('util');
const Event = require('../model/eventmodel');
var fs = require('fs');
const multer = require('multer');

module.exports.createEvent = async(req, res) => {
    var image = req.files.image;
    var extention = image.name.split('.');
    var path = 'images/' + req.files.image.md5+"."+extention[extention.length - 1];
    image.mv(path)

    const newEvent = new Event({
        name: req.body.name,
        description: req.body.description,
        artist: req.body.artist.split(','),
        genre: req.body.genre.split(','),
        price: req.body.price,
        address: req.body.address,
        latitude: req.body.latitude,
        longitude: req.body.longitude,
        date: req.body.date,
        image: path
    })
    newEvent.save(err => {
        if (err) {
            res.send(err).status(401)
        } else {
            return res.status(201).json({message:"ok"})
        }
    })
};
module.exports.getallevents = async(req, res) => {
    const events = await Event.find();
    res.status(200).json( events );
};
module.exports.removevent = async(req, res) => {
    try {
        await Event.findByIdAndDelete(req.params.id)
        return res.status(204).json({message:"Event : is delete"});
    } catch (err) {
        return res.send(err).status(401);
    }
};

module.exports.recommendationevent = async(req, res) => {
    const events = await Event.find();
    const userlikegenreLists = req.body.genreLists;
    var genreLists  = [];
    for (var j in userlikegenreLists){
        genreLists = genreLists.concat(userlikegenreLists[j]);
    }
    console.log(genreLists);
    var output = [];
    genreLists.forEach(currentGenre => {
        events.forEach(event => {
            if (event.genre.includes(currentGenre))
                output.push(event);
        });
    });
    res.status(200).json(Array.from(new Set(output)));
}