// Accessing the database
const mongoose = require("mongoose")
// Notification initialization
const notificationSchema = mongoose.Schema({
// time received of notification
// connects to other document
    targetUser: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },
// type of notification - enum 
// info or request 
    typeOfNotif: { 
        type: String, 
        enum: ["Info", "Request"],
        required: true
    },
// job type
    jobType: {
        type: String, 
        required: true
    },
//message in between - enum
    message: { 
        type: String, 
        enum: [
            "wants to take your job in",
         "finished today's task in", 
         "timed in for"
        ],
        required: true
    },
// kanino manggagaling or kanino pupunta?
// target
    targetUser: {
        type: mongoose.Schema.Types.ObjectId, 
        required: true
    },

// source
    sourceUser: {
        type: mongoose.Schema.Types.ObjectId, 
        required: true
}

}, {timestamps: true})

const Notification = mongoose.model("notification", notificationSchema)

// Exports
module.exports = Notification