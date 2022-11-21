// Route for app.js
const express = require('express')
const router = express.Router()

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
})

router.get('/', (req, res) => {
    // Starting point of the /profile route
})

module.exports = router