const mongoose = require("mongoose")

// User Schema
const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: [true, "Email is required."],
        unique: true
    },
    password: {
        type: String,
        required: [true, "Password is required."],
    },
    hasAcceptedTerms: {
        type: Boolean,
        required: [true, "Must accept terms."]
    },
    isVerified: {
        type: Boolean,
        default: false
    },
    role: {
        type: String,
        required: true,
        default: 'user'
    }
}, { timestamps: true })

// Create a model from the schema
const User = mongoose.model("user", userSchema)

// Exports
module.exports = User