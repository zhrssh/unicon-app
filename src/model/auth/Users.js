const mongoose = require("mongoose")

// User Schema
const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true,
    },
    hasAcceptedTerms: {
        type: Boolean,
        default: true
    },
    active: {
        type: Boolean,
        default: false
    },
    role: {
        type: String,
        default: 'user'
    }
}, { timestamps: true })

// Create a model from the schema
const User = mongoose.model("user", userSchema)

// Exports
module.exports = User