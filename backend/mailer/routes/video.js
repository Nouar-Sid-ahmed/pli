const express = require('express');
const router = express.Router();
const VideoController = require('../controller/videocontroller');

// CURD
router.post("/creatvideo",VideoController.creation); // create video
router.post("/encodvideo",VideoController.encod); //

module.exports = router;