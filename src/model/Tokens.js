const mongoose = require("mongoose")

const tokenSchema = new mongoose.Schema({
    refreshToken : {
        type: String,
        required: true,
        unique: true
    }
})

// Create a model from schema
const Token = mongoose.model("token", tokenSchema)

// Exports
module.exports = Token