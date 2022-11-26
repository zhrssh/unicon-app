// Route for app.js
const express = require("express")
const router = express.Router()
const getDate = require("../log-func").getDate
const auth = require("../auth-config")

// User controller
const createUser = require("../controller/userController").createUser

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

router.post('/', async (req, res) => {
    try {
        await createUser(req, res)
        res.sendStatus(201)
    } catch (err) {
        console.log(getDate(Date.now()), `register.js - ${err}`)
        res.status(400).send({ message: err.message })
    }
})

module.exports = router