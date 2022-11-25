// Route for app.js
const express = require("express")
const router = express.Router()

// User controller
const createUser = require("../controller/userController").createUser

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console

    console.log(Date.now(), ` - `, `New Request: Registering ${req.body.email}`)

    next()
})

router.get('/', (req, res) => {
    // Starting point of the /register route
    res.sendStatus(200)
})

router.post('/', async (req, res) => {
    try {
        await createUser(req, res)
        res.sendStatus(201)
    } catch (err) {
        console.log(`register.js Error: ${err}`)
        res.status(400).send(err)
    }
})

module.exports = router