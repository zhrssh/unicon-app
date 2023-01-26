// Route for app.js
const express = require('express')
const router = express.Router()

const clientController = require("../controller/clientController")
const getDate = require("../utils/logs").getDate
const upload = require("../services/upload")
const auth = require("../services/auth")

// Gets user client including avatar
router.get('/view?uuid=:uuid', async (req, res) => {
    try {
        const client = await clientController.getUserClient(req.params.uuid)
        return res.status(200).send(client)
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
        return res.sendStatus(err.code)
    }
})

// Updates user client
router.post("/update", async (req, res) => {
    // Stores or update user client
    try {
        // Req.body.uuid came from jwt token
        if (req.body.uuid === req.params.uuid) {
            const clientInfo = {

            }

            await clientController.createOrUpdateClient(clientInfo)
            return res.sendStatus(200)
        } else {
            return res.sendStatus(401)
        }
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
        return res.sendStatus(err.code)
    }
})

// Upload an avatar to the database
router.post("/update/avatar", async (req, res) => {
    upload.single('avatar')(req, res, async (err) => {
        if (err) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
            return res.sendStatus(400)
        } else {
            if (req.file == undefined) return res.sendStatus(400)

            // Update profile
            const uuid = auth.getUUIDFromToken(req)
            await clientController.updateClientSingleKey(uuid, "avatar", req.file.path)

            // Sends file details back to the uploader
            return res.status(200).send(req.file)
        }
    })
})

module.exports = router