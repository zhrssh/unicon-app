const mongoose = require("mongoose")

const nameSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true
    },
    lastName: {
        type: String,
        required: true
    }
})

const profileSchema = new mongoose.Schema({
    accountType: {
        type: String,
        enum: ["Consumer", "Provider"],
        required: true
    },
    uuid: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        unique: true
    },
    name: {
        type: nameSchema
    },
    birthDate: {
        type: Date,
        required: true
    },
    contactNumber: {
        type: String,
        required: true
    },
    avatar: {
        type: String,
        default: null
    },
    projects: [{
        type: mongoose.Schema.Types.ObjectId,
        unique: true
    }]
})

const Profile = mongoose.model("profile", profileSchema)

// Exports
module.exports = Profile