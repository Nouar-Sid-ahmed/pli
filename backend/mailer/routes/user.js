const express = require('express');
const router = express.Router();
const UserController = require('../controller/usercontroller');

// CRUD
// router.post("/user/confirmation/:username", UserController.confirmationRegister);
router.post("/user/changepassword",UserController.changepassword); //test
// router.post("/user/:id/validationchangepassword",UserController.validationchangepasseword); // (oldpass,newpass)

module.exports = router;