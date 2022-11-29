// Route for app.js
const express = require('express')
const router = express.Router()

const profileController = require("../../controller/profileController")
const getDate = require("../../utils/logs").getDate
const upload = require("../../services/upload")
const auth = require("../../services/auth")

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    next()
})

// Gets own profile including avatar
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

// Gets other users profile
router.get("/view", (req, res) => {
    res.sendStatus(200)
})

router.post("/post", (req, res) => {
    // Stores or update user profile
    try {
        profileController.createOrUpdateProfile(req, res)
        res.sendStatus(200)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

// Upload an avatar to the database
router.post("/post/avatar", async (req, res) => {
    upload.single('avatar')(req, res, (err) => {
        if (err) {
            res.status(400).send(err)
        } else {
            if (req.file == undefined) return res.sendStatus(400)

            // Update profile
            const uuid = auth.getUUIDFromToken(req)
            profileController.updateSingle(uuid, "avatar", req.file.path)

            // Sends file details back to the uploader
            res.status(200).send(req.file)
        }
    })
})

module.exports = router