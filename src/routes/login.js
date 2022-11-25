// Route for app.js
// Used for log ins
const express = require('express')
const router = express.Router()

// User Controller
const userController = require("../controller/userController")

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    next()
})

// Sends a POST request to login the user
router.post('/', (req, res, next) => {

})

module.exports = router