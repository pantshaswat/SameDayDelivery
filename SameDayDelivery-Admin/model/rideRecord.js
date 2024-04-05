 const mongoose = require('mongoose');

const rideRecordModel = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "users",
    },
    riderId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "users",
    },
    from: {
        type: String,
        required: true,
    },
    to: {
        type: String,
        required: true,
    },
    finalBid: {
        type: String,
        required: true,
    },
    ride_date: {
        type: Date,
        required: true,
        default: Date.now,
    },
    ride_status: {
        type: String,
        required: true,
    },
    riderRating:{
        type: Number,
        required: true,
    },
    riderReview:{
        type: String,
    }
    
});

const RideRecord = mongoose.model("RideRecord", rideRecordModel);
module.exports = RideRecord;