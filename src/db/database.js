// Used to connect the app to the database
const mongoose = require('mongoose')

// Functions
const connectDb = async (DATABASE_URL, DB_OPTIONS) => {
    await mongoose.connect(DATABASE_URL, DB_OPTIONS)
    console.log("Connected to the database.")
}

// Exports
module.exports.connectDb = connectDb