const mongoose = require("mongoose")

const nameSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true
    },
    lastName: {
        type: String,
        required: true
    },
    middleName: {
        type: String
    }
})

const profileSchema = new mongoose.Schema({
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
    }
})

const Profile = mongoose.model("profile", profileSchema)

// Exports
module.exports = Profile