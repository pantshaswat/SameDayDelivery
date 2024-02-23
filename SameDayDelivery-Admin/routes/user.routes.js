const express= require("express");
const router = express.Router();

const userController = require("../controller/user.controller");

router.post("/register", userController.createUser);
router.post("/login", userController.getUser);
router.put("/update", userController.updateUser);
router.delete("/delete", userController.deleteUser);

module.exports = router;