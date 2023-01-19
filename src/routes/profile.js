// Route for app.js
const express = require('express')
const router = express.Router()

const profileController = require("../controller/profileController")
const getDate = require("../utils/logs").getDate
const upload = require("../services/upload")
const auth = require("../services/auth")

// Gets user profile including avatar
router.get('/view?uuid=:uuid', async (req, res) => {
    try {
        const profile = await profileController.getUserProfile(req.params.uuid)
        return res.status(200).send(profile)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        return res.sendStatus(500)
    }
})

// Updates user profile
router.post("/update", async (req, res) => {
    // Stores or update user profile
    try {
        // Req.body.uuid came from jwt token
        if (req.body.uuid === req.params.uuid) {
            await profileController.createOrUpdateProfile(req.body.profile)
            return res.sendStatus(200)
        } else {
            return res.sendStatus(401)
        }
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        return res.sendStatus(500)
    }
})

// Upload an avatar to the database
router.post("/update/avatar", async (req, res) => {
    upload.single('avatar')(req, res, async (err) => {
        if (err) {
            return res.status(400).send(err)
        } else {
            if (req.file == undefined) return res.sendStatus(400)

            // Update profile
            const uuid = auth.getUUIDFromToken(req)
            await profileController.updateProfileSingleKey(uuid, "avatar", req.file.path)

            // Sends file details back to the uploader
            return res.status(200).send(req.file)
        }
    })
})

module.exports = router