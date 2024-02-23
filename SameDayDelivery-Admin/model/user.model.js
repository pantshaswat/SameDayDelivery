const mongoose = require("mongoose");

const userModel = new mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        default:new mongoose.Types.ObjectId,
    },
    user_name: {
        type: String,
        required: true,
    },
    user_email: {
        type: String,
        required: true,
    },
    user_password: {
        type: String,
        required: true,
    },
    user_phone: {
        type: String,
        required: true,
    },
    user_address: {
        type: String,
        required: true,
    },
    user_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
});

const User = mongoose.model("User", userModel);
module.exports = User;