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
        default: "client"
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
    company: {
        type: String,
        default: null
    },
    interests: [{
        type: String
    }],
    projects: [{
        type: mongoose.Schema.Types.ObjectId,
        unique: true
    }]
})

const Client = mongoose.model("client", profileSchema)

// Exports
module.exports = Client