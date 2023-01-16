const mongoose = require("mongoose")

// Schema for followers
const followerSchema = new mongoose.Schema({
    follower: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "profile",
        required: true
    }
})

// Schema for user reviews
const reviewSchema = new mongoose.Schema({
    postedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "profile",
        required: true,
        unique: true
    },
    datePosted: {
        type: Date,
        default: Date.now(),
    },
    rating: {
        type: Number,
        default: 0
    },
    content: {
        type: String,
        default: null
    }
})

const workerSchema = new mongoose.Schema({
    worker: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "profile"
    },
    profession: {
        type: String,
        required: true
    },
    averageRating: {
        type: Number,
        default: 0
    },
    followers: {
        type: followerSchema
    },
    about: {
        type: String,
        default: null
    },
    projectsHistory: {
        type: mongoose.Types.ObjectId,
        ref: "project"
    },
    reviews: {
        type: reviewSchema
    }

}, { timestamps: true })

const Worker = mongoose.model("worker", workerSchema)

// Exports
module.exports = Worker