const mongoose = require("mongoose")

const profileSchema = new mongoose.Schema({
    uuid: {
        type: String,
        required: true,
        unique: true
    },
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
    }
})

const Profile = mongoose.model("profile", profileSchema)

// Exports
module.exports = Profile