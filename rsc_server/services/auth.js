require("dotenv").config()
const jwt = require("jsonwebtoken")
const getDate = require("../utils/logs")
const raise = require("../utils/raise")

/**
 * Verifies access token, can be used in other routes as middleware
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns {*}
 */
function verifyAccessToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]

    // Returns error if user does not have token
    if (token == null) return res.status(401).send({ err: "E01" })

    try {
        // Verifies if token is valid
        jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, result) => {
            if (err) throw err
            req.body.uuid = result.data.uuid
            return next()
        })
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now(), err.message))
        return res.status(403).send({ err: "E02" })
    }
}

/**
 * Gets the UUID from token without verifying the token. Use this if you know that the token is already verified
 * @param {*} req 
 * @returns {Promise<str>}
 */
function getUUIDFromToken(headers) {
    return new Promise((resolve, reject) => {

        // Gets Token from Auth Header
        const authHeader = headers['authorization']
        const token = authHeader && authHeader.split(' ')[1]

        if (token == null) return resolve(null)

        try {
            const decoded = jwt.decode(token)
            return resolve(decoded.data.uuid)
        } catch (err) {
            return reject(raise(err.message, 500))
        }
    })
}

// Exports
module.exports.verifyAccessToken = verifyAccessToken
module.exports.getUUIDFromToken = getUUIDFromToken

