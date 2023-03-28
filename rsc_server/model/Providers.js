const mongoose = require("mongoose")

// Schema for file uploads
const imagesSchema = new mongoose.Schema({
    id: {
        type: String,
        default: null
    },
    photo: {
        type: String,
        default: null
    },
    pcab: {
        type: String,
        default: null
    },
    dti: {
        type: String,
        default: null
    },
    bir: {
        type: String,
        default: null
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
        required: true
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

const companySchema = new mongoose.Schema({
    registeredName: {
        type: String,
        required: true
    },
    location: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    lineOfWork: {
        type: String,
        required: true
    }
})

const providerSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true
    },
    accountType: {
        type: String,
        default: "provider"
    },
    accountGroup: {
        type: String,
        enum: ["individual", "company"],
        required: true
    },
    companyInfo: {
        type: companySchema
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