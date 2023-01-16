const express = require('express');
const router = express.Router();
const EventControleur = require('../controller/eventcontroller');

// CRUD
router.post("/createvent",EventControleur.createEvent);
router.get("/allevents",EventControleur.getallevents);
router.delete("/rmevent/:id",EventControleur.removevent);
router.post("/recommendation",EventControleur.recommendationevent);

module.exports = router;