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
        const client = await clientController.getClient(req.params.uuid)
        res.setHeader("Content-Type", "image/jpeg")
        res.setHeader("Content-Disposition", "inline")
        res.sendFile(path.join(__dirname, `../${client.avatar}`))
        res.json(client)
        return res.status(200).end()
    } catch (err) {
        return res.status(err.code).send({ err: err.message })
    }
})

// Registers new user client
router.post("/register", async (req, res) => {
    try {
        // Client info
        const clientInfo = {
            uuid: req.body.uuid,
            name: {
                firstName: req.body.name.firstName,
                lastName: req.body.name.lastName,
                middleName: req.body.name.middleName
            },
            birthDate: req.body.birthDate,
            contactNumber: req.body.contactNumber,
            location: req.body.location,
            company: req.body.company
        }

        // Creates the client profile
        await clientController.createClient(clientInfo)

        return res.sendStatus(200)
    } catch (err) {
        return res.status(err.code).send({ err: err.message })
    }
})

// Updates user client
router.post("/update", async (req, res) => {
    // Stores or update user client
    try {
        // Req.body.uuid came from jwt token
        if (req.body.uuid === req.params.uuid) {
            await clientController.updateClient(req.body.uuid, req.body.clientInfo)
            return res.sendStatus(200)
        } else {
            return res.sendStatus(401)
        }
    } catch (err) {
        return res.status(err.code).send({ err: err.message })
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
            const uuid = auth.getUUIDFromToken(req.headers)
            const toUpdate = { avatar: req.file.path }

            clientController.updateClientSingleKey(uuid, toUpdate)

            // Sends file details back to the uploader
            return res.status(200).send(req.file)
        }
    })
})

module.exports = router