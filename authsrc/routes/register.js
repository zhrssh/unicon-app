// Route for app.js
const express = require("express")
const router = express.Router()

const getDate = require("../utils/logs").getDate
const auth = require("../services/auth")
const verify = require("../services/verify")

// User controller
const createUser = require("../controller/userController").createUser

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
        // Creates a new user
        req.body.uuid, req.body.confirmationCode = await createUser(req, res)

        // Sends verification email
        verify.sendConfirmationEmail(req, res)

        //#region REMOVED -> Moved to login
        // Requests for refresh and access token and sends them to client
        // await auth.requestRefreshToken(req, res)
        //#endregion
    } catch (err) {
        return res.status(parseInt(err.code)).send({ err: err.message })
    }
})

// Verifies the user
router.get("/verify/:confirmationCode", async (req, res) => {
    try {
        // Verifies the user
        verify.verifyUser(req.params.confirmationCode)
        res.sendStatus(200)
    } catch (err) {
        return res.status(parseInt(err.code)).send({ err: err.message })
    }
})

module.exports = router