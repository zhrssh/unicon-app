// Route for app.js
const express = require("express")
const router = express.Router()
const getDate = require("../../utils/logs").getDate
const auth = require("../../services/auth")

// User controller
const createUser = require("../../controller/userController").createUser

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    console.log(getDate(Date.now()), `Registering ${req.body.email}`)
    next()
})

// Checks if the user is already logged in
router.get('/', auth.verifyAccessToken, (req, res) => {
    res.sendStatus(200)
})

// Registers user account to the database
router.post('/', async (req, res) => {
    try {
        req.body.uuid = await createUser(req, res)

        // TODO: Implement email verification

        // Requests for refresh and access token
        await auth.requestRefreshToken(req, res)
    } catch (err) {
        res.status(parseInt(err.code)).send({ err: err.message })
    }
}
)

module.exports = router