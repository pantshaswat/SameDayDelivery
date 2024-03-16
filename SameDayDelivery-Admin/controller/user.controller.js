const userModel = require("../model/user.model");
const md5 = require("md5");
const { createJwt } = require("../middlewares/jwtAuthMiddleware");

exports.register = async (req, res) => {
  const body = req.body;
  console.log("Received data:", req.body);

  if (!(body.email && body.password && body.fullName)) {
    res.status(400).send("All input required");
  }
  const email = body.email;
  const oldEmail = await userModel.findOne({ email });
  if (oldEmail) {
    return res.status(409).send("Email already used");
  }
  const md5Password = md5(body.password);
  const user = await userModel.create({
    email: body.email,
    password: md5Password,
    fullName: body.fullName,
    phoneNumber: body.phoneNumber ?? "",
  });
  return res.status(201).send(user);
};

exports.signIn = async (req, res) => {
  const { email, password } = req.body;

  if (!(email && password)) {
    return res.status(400).send("All input are required");
  }

  const user = await userModel.findOne({ email });
  if (!user) {
    return res.status(404).send("User not found");
  }

  const password_check = md5(password) === user.password;

  if (!password_check) {
    return res.status(400).send("Invalid Credentialsss");
  }

  const token = createJwt(user);
  console.log(token);
  return res
    .status(201)
    .cookie("token", token, {
      expires: new Date(Date.now() + 25892000000),
      httpOnly: false,
    })
    .send("Logged in successfully");
};
exports.signOut = async (req, res) => {
  return res.status(201).clearCookie("token").send("logged out");
};

exports.updateUser = async (req, res) => {
  const { email, password, fullName, phoneNumber } = req.body;

  try {
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Update user properties if provided in the request body
    if (password) user.password = password;
    if (fullName) user.fullName = fullName;
    if (phoneNumber) user.phoneNumber = phoneNumber;

    await user.save();

    return res.status(200).json({ message: "User updated successfully", user });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Internal Server Error" });
  }
};

exports.deleteUser = async (req, res) => {
  const { email } = req.body;

  try {
    const user = await User.findOneAndDelete({ email });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    return res.status(200).json({ message: "User deleted successfully", user });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Internal Server Error" });
  }
};
