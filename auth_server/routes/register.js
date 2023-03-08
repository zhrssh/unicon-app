require("dotenv").config

// Route for app.js
const express = require("express")
const router = express.Router()

const mongoose = require("mongoose")

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
        let userInfo = {
            email: req.body.email,
            password: req.body.password
        }

        // Grabs the uuid and verification code
        const { uuid, code } = await createUser(userInfo)

        userInfo.uuid = uuid
        userInfo.code = code.toLowerCase()

        // Sends verification email
        await verify.sendConfirmationEmail(userInfo)
        return res.status(200).send({ uuid: userInfo.uuid })

    } catch (err) {
        return res.status(err.code || 500).send({ err: err.message })
    }
})

// Resend confirmation email
router.post('/verify/resend', async (req, res) => {
    try {
        // Resends the confirmation email
        let userInfo = {
            email: req.body.email
        }

        await verify.resendConfirmationEmail(userInfo)
        return res.sendStatus(200)
    } catch (err) {
        return res.status(err.code || 500).send({ err: err.message })
    }
})

// Verifies the user
router.get("/verify/:uuid/:confirmationCode", async (req, res) => {
    try {
        // Verifies the user
        await verify.verifyUser(req.params.uuid, req.params.confirmationCode)

        // JWT Payload
        const data = {
            iss: process.env.ISS,
            uuid: req.params.uuid
        }

        const token = auth.generateAccessToken(data)
        return res.status(200).send({ accessToken: token })
    } catch (err) {
        return res.status(err.code || 500).send({ err: err.message })
    }
})

module.exports = router