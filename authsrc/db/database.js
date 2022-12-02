// Used to connect the app to the database
const mongoose = require("mongoose")
const getDate = require("../utils/logs").getDate

// Functions
async function connectDb(DATABASE_URL, DB_OPTIONS) {
    await mongoose.connect(DATABASE_URL, DB_OPTIONS)
    console.log(getDate(Date.now()), "Connected to the database.")
}

// Exports
module.exports.connectDb = connectDb