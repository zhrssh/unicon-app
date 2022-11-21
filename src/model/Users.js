const mongoose = require("mongoose")

// User Schema
const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    },
    hasAcceptedTerms: {
        type: Boolean,
        required: true
    },
    profileId: {
        type: String,
        required: true
    }
})

// Create a model from the schema
const User = mongoose.model("user", userSchema)

// Exports
module.exports = User