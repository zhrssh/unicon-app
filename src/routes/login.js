require("dotenv").config()

// Used for log ins
const express = require("express")
const router = express.Router()

const auth = require("../auth-config")

// Checks if the user is already logged in
router.get('/', auth.verifyAccessToken, (req, res) => {
    // Sends an OK status if the user is alr logged in
    res.sendStatus(200)
})

// Requests access token for user who wants to login
router.post('/', auth.requestAccessToken)

// Refreshes access token
router.post('/token', auth.refreshAccessToken)

module.exports = router