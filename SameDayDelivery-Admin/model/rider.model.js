const mongoose = require("mongoose");

const riderModel = new mongoose.Schema({
    rider_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        default:new mongoose.Types.ObjectId,
    },
    rider_name: {
        type: String,
        required: true,
    },
    rider_email: {
        type: String,
        required: true,
    },
    rider_password: {
        type: String,
        required: true,
    },
    rider_phone: {
        type: String,
        required: true,
    },
    rider_address: {
        type: String,
        required: true,
    },
    rider_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
});

const Rider = mongoose.model("Rider", riderModel);
module.exports = Rider;