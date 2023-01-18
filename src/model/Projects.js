const mongoose = require("mongoose")

// Creates a location with appropriate details
const locationSchema = new mongoose.Schema({
    address: String,
    city: String,
    province: String
})

// Creates a list of workers in the current project
const currentWorkerSchema = new mongoose.Schema({
    workerId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "worker",
        unique: true,
        sparse: true
    }
})

const projectSchema = new mongoose.Schema({
    visibility: {
        type: String,
        enum: ["Public", "Private", "Unlisted"],
        default: "Unlisted"
    },
    status: {
        type: String,
        enum: ["Active", "Inactive"],
        default: "Active"
    },
    postedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "profile",
        required: true
    },
    datePosted: {
        type: Date,
        default: Date.now()
    },
    description: {
        type: String,
        required: true
    },
    estSalary: {
        type: Number,
        required: true
    },
    estDate: {
        type: Date
    },
    location: {
        type: locationSchema,
        required: true
    },
    currentWorkers: {
        type: currentWorkerSchema
    },
    contractor: {
        type: String
    }
})

const Project = mongoose.model("project", projectSchema)

// Exports
module.exports = Project