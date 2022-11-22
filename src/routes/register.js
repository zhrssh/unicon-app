// Route for app.js
const express = require("express")
const router = express.Router()

// User controller
const createUser = require("../controller/userController").createUser

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    next()
})

router.get('/', (req, res) => {
    // Starting point of the /register route
    res.sendStatus(200)
})

router.post('/', async (req, res) => {
    try {
        console.log(`Registering User ${req.body.firstName}`)
        await createUser(req, res)
        res.sendStatus(200)
    } catch (err) {
        console.log(`register.js Error: ${err}`)
        res.status(409).send(err)
    }

})

module.exports = router