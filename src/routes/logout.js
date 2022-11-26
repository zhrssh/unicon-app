const express = require("express")
const router = express.Router()

const auth = require("../auth-config")

router.delete('/', (req, res) => {
    auth.deleteRefreshToken(req.body.refreshToken)
    res.sendStatus(204)
})

module.exports = router