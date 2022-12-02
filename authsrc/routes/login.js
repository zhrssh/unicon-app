require("dotenv").config()

// Used for log ins
const express = require("express")
const router = express.Router()

const auth = require("../services/auth")

// Checks if the user is already logged in
router.get('/', auth.verifyAccessToken, (req, res) => {
    // Sends an OK status if the user is alr logged in
    return res.sendStatus(200)
})

// Requests access and refresh token for user who wants to login
router.post('/', async (req, res) => {
    try {
        await auth.requestRefreshToken(req, res)
    }
    catch (err) {
        return res.status(parseInt(err.code)).send({ err: err.message })
    }
})

// Refreshes access token by passing in the refresh token to the POST
router.post('/token', async (req, res) => {
    try {
        await auth.requestAccessToken(req, res)
    }
    catch (err) {
        return res.status(parseInt(err.code)).send({ err: err.message })
    }
})

module.exports = router