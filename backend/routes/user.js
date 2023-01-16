const express = require('express');
const router = express.Router();
const UserController = require('../controller/usercontroller');
const auth = require('../middleware/auth');

// CRUD
router.post("/user", UserController.register, UserController.login); // 1
router.put("/user/confirmation/:username", UserController.confirmationRegister);
router.post("/auth", UserController.login); // 2
router.delete("/user/:id",auth, UserController.deleteuser); // 3
router.put("/updateUser", auth, UserController.modifyuser); // 4
router.get("/users", UserController.getallusers); // 5
router.get("/user", auth, UserController.getuserbyid); // 6
router.post("/user/changepassword",UserController.changepassword); //test
router.put("/user/:id/validationchangepassword", auth, UserController.validationchangepasseword); // (oldpass,newpass)

module.exports = router;