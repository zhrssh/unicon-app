// Used to connect the app to the database
const mongoose = require('mongoose')

// Functions
const connectDb = async (DATABASE_URL, DB_OPTIONS) => {
    try {
        await mongoose.connect(DATABASE_URL, DB_OPTIONS)
        console.log("Connected to the database.")
    } catch (err) {
        console.log(`Error: ${err}`)
    }
}

// Exports
module.exports.connectDb = connectDb