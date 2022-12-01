require("dotenv").config()
const jwt = require("jsonwebtoken")

/**
 * Verifies access token, can be used in other routes as middleware
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns {function} next()
 */
function verifyAccessToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]

    if (token == null) {
        const error = new Error(err.message)
        error.code = "401"
        throw error
    }

    try {
        jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, result) => {
            if (err) throw err
            req.body.uuid = result.data.uuid
            return next()
        })
    } catch (err) {
        const error = new Error(err.message)
        error.code = "403"
        throw error
    }

}

/**
 * Gets the UUID from token without verifying the token. Use this if you know that the token is already verified
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns Gets The UUID From Token
 */
function getUUIDFromToken(req) {
    // Gets Token from Auth Header
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]

    if (token == null) return null

    try {
        const decoded = jwt.decode(token)
        return decoded.data.uuid
    } catch (err) {
        const error = new Error(err.message)
        error.code = "403"
        throw error
    }
}

// Exports
module.exports.verifyAccessToken = verifyAccessToken
module.exports.getUUIDFromToken = getUUIDFromToken

