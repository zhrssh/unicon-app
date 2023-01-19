const mongoose = require("mongoose")

// Project info
const infoSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
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
    currentWorkers: [{
        type: currentWorkerSchema
    }],
    contractor: {
        type: String
    }
})

// Creates a location with appropriate details
const locationSchema = new mongoose.Schema({
    address: String,
    city: String,
    province: String
})

// Creates a list of workers in the current project
const currentWorkerSchema = new mongoose.Schema({
    worker: {
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
    datePosted: {
        type: Date,
        default: Date.now()
    },
    projectInfo: {
        type: infoSchema,
    }
    // Separate description or project info
})

const Project = mongoose.model("project", projectSchema)

// Exports
module.exports = Project