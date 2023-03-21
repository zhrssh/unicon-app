const mongoose = require("mongoose")

// Schema for file uploads
const imagesSchema = new mongoose.Schema({
    ids: [{
        type: String
    }],
    photo: {
        type: String
    }
})

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
    },
    content: {
        type: String,
    }
})

const nameSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true
    },
    lastName: {
        type: String,
        required: true
    },
    middleName: {
        type: String
    }
})

const providerSchema = new mongoose.Schema({
    accountType: {
        type: String,
        default: "provider"
    },
    accountGroup: {
        type: String,
        enum: ["individual", "company"],
        required: true
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
    location: {
        type: String,
        required: true
    },
    profession: {
        type: String
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
    },
    projectsHistory: {
        type: mongoose.Types.ObjectId,
        ref: "project"
    },
    reviews: {
        type: reviewSchema
    },
    avatar: {
        type: String,
        default: null
    },
    uploads: {
        type: imagesSchema
    }

}, { timestamps: true })

const Provider = mongoose.model("provider", providerSchema)

// Exports
module.exports = Provider