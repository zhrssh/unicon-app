const mongoose = require("mongoose")


const projectSchema = new mongoose.Schema({
    uuid:{
        type: String
    },
    postedBy: {
        type: String
    },
    datePosted:{
        type: Date,
        default: Date.now
    },
    description:{
        type: String,
        required: true
    },
    estSalary:{
        type: Number,
        required: true
    },
    estDate:{
        type: Date
    },
    location: {
        type: String,
        required: true
    },
    currentWorkers:[{ 
        workerId: {
            type: String,
            unique: true, 
            sparse: true
        }, 
        fullName: String
    }],
    contractor: {
        type: String
    }
})

const Project = mongoose.model("project", projectSchema)

// Exports
module.exports = Project