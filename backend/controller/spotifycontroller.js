const User = require('../model/usermodel');
const jwt = require ('jsonwebtoken');
const bcrypt = require ('bcrypt');
const Mailer = require('../postfix/mailer');
require('dotenv').config();
const axios = require('axios');
const util = require('util');

const SECRET_KEY = process.env.SECRET_KEY;

module.exports.registerFromSpotify = async(req,res,next) => {
    token = req.body.token;
    var inf;
    axios.get("https://api.spotify.com/v1/me", {
        headers: {
            "Content-Type": "application/json",
            'Authorization': `Bearer ${token}`
        }
    })
    .then(resp => {
        inf = resp.data;
        User.findOne({ email: resp.data.email}, (err, user) => {
            if (user) {
                res.send({ message: "User already exist" }).status(400)
            } else {
                const newUser = new User({
                    username: resp.data.display_name,
                    email: resp.data.email,
                    confirm: true,
                    password: String(bcrypt.hashSync(resp.data.id, 5)),
                    country: resp.data.country
                })
                newUser.save(err => {
                    if (err) {
                        res.send(err).status(401)
                    } else { next()}
                })
            }
        });
    })
    .catch(error => {
        console.error(error);
        return res.status(401).json({ error: error});
    });
}
module.exports.loginSpotify = (req, res) => {
    tokenSpot = req.body.token;
    var inf;
    axios.get("https://api.spotify.com/v1/me", {
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            'Authorization': "Bearer " + tokenSpot
        }
    })
    .then(async resp => {
        inf = resp.data;
        try {
            let user = await User.findOne({ email: inf.email });
            if (user) {
                delete user._doc.password;
                const expireIn = 24 * 60 * 60;
                var token = "RIP";
                try {
                    token = jwt.sign({
                        user: user
                    },
                    SECRET_KEY,
                    {
                        expiresIn: expireIn
                    });
                } catch{}
                // res.header('Authorization', 'Bearer ' + token);
                return res.header('Authorization', 'Bearer ' + token).status(200).json({
                    token:'Bearer ' +token,
                    id: user._id
                });
            } else {
                return res.status(404).json('user_not_found');
            }
        } catch (error) {
            return res.send(error).status(401);
        }
    })
    .catch(error => {
        console.error(error);
        return res.status(401).json({ error: error});
    });
}
module.exports.search = (req, res, next) => {
    tokenSpot = req.body.token;
    axios.get("https://api.spotify.com/v1/search?q="+req.body.search+"&type=artist&market=fr&limit="+req.body.limite, {
        headers: {
            "Content-Type": "application/json",
            'Authorization': "Bearer "+tokenSpot
        }
    }).then(resp => {
        let artistList = [];
        var artist;
        util.inspect(resp);
        resp.data.artists.items.forEach(element => {
            artist = {
                link: element.external_urls.spotify,
                genres: element.genres,
                image: element.images[0].url,
                name: element.name,
                id: element.id
            };
            artistList.push(artist);
        });
        res.status(200).json({ artistList });
    }).catch(error => {
        return res.status(401).json({ error: error});
    });
}
module.exports.playList = (req, res, next) => {
    tokenSpot = req.body.token;
    axios.get("https://api.spotify.com/v1/me/playlists", {
        headers: {
            "Content-Type": "application/json",
            'Authorization': "Bearer "+tokenSpot
        }
    }).then(resp => {
        let playlists = [];
        var playlist;
        util.inspect(resp);
        resp.data.items.forEach(element => {
            playlist = {
                id: element.id,
                name: element.name,
                description: element.description,
                owner: element.owner.display_name,
                link: element.external_urls.spotify,
                genres: element.genres,
                image: element.images[0].url
            };
            playlists.push(playlist);
        });
        res.status(200).json({ playlists });
    }).catch(error => {
        console.error(error);
        return res.status(401).json({ error: error});
    });
}