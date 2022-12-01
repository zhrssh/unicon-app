const mongoose = require("mongoose")

const notificationSchema = mongoose.Schema({
    uuid: {
        type: String,
        required: true
    },
    content: {
        type: String
    },
    link: {
        type: String,
        required: true
    }
}, {timestamps: true})

const Notification = mongoose.model("notification", notificationSchema)

// Exports
module.exports = Notification