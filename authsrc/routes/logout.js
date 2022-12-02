const express = require("express")
const router = express.Router()

const auth = require("../services/auth")

router.post('/', async (req, res) => {
    try {
        await auth.deleteRefreshToken(req.body.refreshToken)
        return res.sendStatus(204)
    } catch (err) {
        return res.sendStatus(400)
    }
})

module.exports = router