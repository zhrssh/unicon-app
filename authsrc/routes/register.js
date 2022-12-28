// Route for app.js
const express = require("express")
const router = express.Router()

const getDate = require("../utils/logs").getDate
const auth = require("../services/auth")
const verify = require("../services/verify")

// User controller
const createUser = require("../controller/userController").createUser

// Checks if the user is already logged in
router.get('/', auth.verifyAccessToken, (req, res) => {
    return res.sendStatus(200)
})

// Registers user account to the database
router.post('/', async (req, res) => {
    try {
        // Creates a new user
        await createUser(req, res)

        // Sends verification email
        verify.sendConfirmationEmail(req, res)

    } catch (err) {
        return res.status(parseInt(err.code)).send({ err: err.message })
    }
})

// Verifies the user
router.get("/verify/:uuid/:confirmationCode", async (req, res) => {
    try {
        // Verifies the user
        await verify.verifyUser(req.params.uuid, req.params.confirmationCode)
        res.sendStatus(200)
    } catch (err) {
        return res.status(parseInt(err.code)).send({ err: err.message })
    }
})

module.exports = router