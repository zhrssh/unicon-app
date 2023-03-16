// Route for app.js
const express = require('express')
const router = express.Router()

const providerController = require("../controller/providerController")
const getDate = require("../utils/logs").getDate
const upload = require("../services/upload")
const auth = require("../services/auth")

// Gets user provider including avatar
router.get('/view?uuid=:uuid', async (req, res) => {
    try {
        const provider = await providerController.getProvider(req.params.uuid)
        res.setHeader("Content-Type", "image/jpeg")
        res.setHeader("Content-Disposition", "inline")
        res.sendFile(path.join(__dirname, `../${provider.avatar}`))
        res.json(provider)
        return res.status(200).end()
    } catch (err) {
        return res.status(err.code).send({ err: err.message })
    }
})

router.post("/register/individual", (req, res) => {
    // TODO: IMPLEMENT REGISTRATION
    req.sendStatus(200)
})

router.post("/register/individual/ids", async (req, res) => {
    upload.array("ids", 2)(req, res, async (err) => {
        if (err) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
            return res.status(400).send(err.message)
        } else {
            if (req.file == undefined) return res.sendStatus(400)

            // Update profile
            const uuid = auth.getUUIDFromToken(req)
            const toUpdate = { uploads: { ids: req.file.path } }

            await providerController.updateProvider(uuid, toUpdate)

            // Sends file details back to the uploader
            return res.status(200).send(req.file)
        }
    })
})

router.post("/register/individual/photo", async (req, res) => {
    upload.single('photo')(req, res, async (err) => {
        if (err) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
            return res.status(400).send(err.message)
        } else {
            if (req.file == undefined) return res.sendStatus(400)

            // Update profile
            const uuid = auth.getUUIDFromToken(req)
            const toUpdate = { uploads: { photo: req.file.path } }

            await providerController.updateProvider(uuid, toUpdate)

            // Sends file details back to the uploader
            return res.status(200).send(req.file)
        }
    })
})

router.post("/register/company", (req, res) => {
    // TODO: IMPLEMENT REGISTRATION
    req.sendStatus(200)
})

// Updates user provider
router.post("/profile/update", async (req, res) => {
    // Stores or update user provider
    try {
        // Req.body.uuid came from jwt token
        if (req.body.uuid === req.params.uuid) {
            await providerController.updateProvider(req.body.uuid, req.body.clientInfo)
            return res.sendStatus(200)
        } else {
            return res.sendStatus(401)
        }
    } catch (err) {
        return res.status(err.code).send({ err: err.message })
    }
})

// Upload an avatar to the database
router.post("/profile/update/avatar", async (req, res) => {
    upload.single('avatar')(req, res, async (err) => {
        if (err) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
            return res.status(400).send(err.message)
        } else {
            if (req.file == undefined) return res.sendStatus(400)

            // Update profile
            const uuid = auth.getUUIDFromToken(req)
            const toUpdate = { avatar: req.file.path }

            await providerController.updateProvider(uuid, toUpdate)

            // Sends file details back to the uploader
            return res.status(200).send(req.file)
        }
    })
})

module.exports = router