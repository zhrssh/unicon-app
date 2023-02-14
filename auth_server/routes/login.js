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
        const userInfo = {
            email: req.body.email,
            password: req.body.password
        }

        const { refreshToken, accessToken } = await auth.requestRefreshToken(userInfo)
        return res.status(200).send({
            refreshToken: refreshToken,
            accessToken: accessToken
        })
    }
    catch (err) {
        return res.status(err.code).send({ err: err.message })
    }
})

// Refreshes access token by passing in the refresh token to the POST
router.post('/token', async (req, res) => {
    try {
        const accessToken = await auth.requestAccessToken(req.body.refreshToken)
        return res.status(200).send({ accessToken })
    }
    catch (err) {
        return res.status(err.code).send({ err: err.message })
    }
})

module.exports = router