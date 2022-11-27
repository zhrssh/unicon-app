// Route for app.js
const express = require('express')
const router = express.Router()

const profileController = require("../../controller/profileController")
const getDate = require("../../utils/logs").getDate

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    next()
})

router.get('/', async (req, res) => {
    // Starting point of the /profile route
    try {
        const profile = await profileController.getUserProfile(req, res)
        res.status(200).send(profile)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

router.post("/update", (req, res) => {
    // Stores or update user profile
    try {
        profileController.createOrUpdateProfile(req, res)
        res.sendStatus(200)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

module.exports = router