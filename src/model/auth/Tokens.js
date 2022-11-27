const mongoose = require("mongoose")

const tokenSchema = new mongoose.Schema({
    uuid: {
        type: String,
        required: true,
        unique: true
    },
    refreshToken: {
        type: String,
        unique: true
    },
    tokenType: {
        type: String,
        default: "Bearer"
    }
})

// Create a model from schema
const Token = mongoose.model("token", tokenSchema)

// Exports
module.exports = Token