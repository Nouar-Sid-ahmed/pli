const express = require('express');
const router = express.Router();
const SpotifyController = require('../controller/spotifycontroller');
const auth = require('../middleware/auth');

// CRUD
router.post("/userSpotify",SpotifyController.registerFromSpotify, SpotifyController.loginSpotify);
router.post("/authSpotify",SpotifyController.loginSpotify);
router.get("/search",SpotifyController.search);
router.get("/meplaylists",SpotifyController.playList);
module.exports = router;
