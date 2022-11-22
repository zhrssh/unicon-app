const mongoose = require("mongoose")

const profileSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true
    },
    lastName: {
        type: String,
        required: true
    },
    birthDate: {
        type: Date,
        required: true
    },
    contactNumber: {
        type: String,
        required: true
    },
    userId: {
        type: String,
        required: true,
        unique: true
    }
})

const Profile = mongoose.model("profile", profileSchema)

// Exports
module.exports = Profile