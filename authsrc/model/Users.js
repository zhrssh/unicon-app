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
    status: {
        type: String,
        enum: ["Pending", "Active"],
        default: "Pending"
    },
    confirmationCode: {
        type: String,
        unique: true,
        default: null
    },
    role: {
        type: String,
        enum: ["Client", "Provider", "Admin"],
        default: "Client"
    }
}, { timestamps: true })

// Create a model from the schema
const User = mongoose.model("user", userSchema)

// Exports
module.exports = User