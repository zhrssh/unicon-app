// Route for app.js
const express = require("express")
const router = express.Router()

const getDate = require("../utils/logs").getDate
const auth = require("../services/auth")

// User controller
const createUser = require("../controller/userController").createUser
const deleteUser = require("../controller/userController").deleteUser

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    console.log(getDate(Date.now()), `Registering ${req.body.email}`)
    return next()
})

// Checks if the user is already logged in
router.get('/', auth.verifyAccessToken, (req, res) => {
    return res.sendStatus(200)
})

// Registers user account to the database
router.post('/', async (req, res) => {
    try {
        req.body.uuid = await createUser(req, res)

        // TODO: Implement email verification
        // If verification failed
        // deleteUser(req.body.uuid)

        // Requests for refresh and access token and sends them to client
        await auth.requestRefreshToken(req, res)
    } catch (err) {
        return res.status(parseInt(err.code)).send({ err: err.message })
    }
}
)

module.exports = router