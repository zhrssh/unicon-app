require("dotenv").config()

const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")

const tokenController = require("../controller/tokenController")

// Get User By Email
const getUserByEmail = require("../controller/userController").getUserByEmail

/**
 * Generates an expiring access token
 * @param {*} data 
 * @returns Access Token
 */
function _generateAccessToken(data) {
    return jwt.sign({ azp: data }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "24h" })
}

/**
 * Generates a refresh token
 * @param {*} data 
 * @returns Refresh Token
 */
function _generateRefreshToken(data) {
    return jwt.sign({ azp: data }, process.env.REFRESH_TOKEN_SECRET, { expiresIn: "7d" })
}

/**
 * Requests access token using refresh token
 * @param {*} req 
 * @param {*} res 
 */
async function requestAccessToken(req, res) {
    const refreshToken = req.body.refreshToken

    // Checks...
    if (refreshToken == null) {
        const error = new Error("Token required.")
        error.code = "401"
        throw error
    }

    if (await checkRefreshTokenInDb(refreshToken) == false) {
        const error = new Error("Invalid token.")
        error.code = "403"
        throw error
    }

    // Provide access token when the user is authenticated
    jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (err, result) => {
        if (err) {
            const error = new Error("Token has expired.")
            error.code = "403"
            throw error
        }

        const accessToken = _generateAccessToken(result.data)
        res.json({ accessToken: accessToken })
    })
}

/**
 * Generates a new refresh token
 * 
 * For logging in the app, only pass in the request the email, password, (old)refreshToken
 * 
 * For registering in the app, pass all the user information to generate a new refreshToken
 * @param {*} req 
 * @param {*} res 
 */
async function requestRefreshToken(req, res) {

    // Authenticate user
    let uuid
    const email = req.body.email
    const password = req.body.password

    try {
        const user = await getUserByEmail(email)
        if (user == null) {
            const error = new Error("Email does not exists.")
            error.code = "404"
            throw error
        }

        const chk = user && user.email === email && await bcrypt.compare(password, user.password)
        if (chk === false) {
            const error = new Error("Incorrect email/password.")
            error.code = "401"
            throw error
        }

        uuid = user._id

    } catch (err) {
        const error = new Error(err.message)
        error.code = "500"
        throw error
    }

    // User Unique Identifier
    const data = uuid

    // Generates the tokens
    const refreshToken = _generateRefreshToken(data)
    const accessToken = _generateAccessToken(data)

    // Stores or updates the refresh token in database
    try {
        tokenController.storeToken(uuid, refreshToken)
    } catch (err) {
        const error = new Error(err.message)
        error.code = "500"
        throw error
    }

    return res.json({ refreshToken: refreshToken, accessToken: accessToken })
}

/**
 * Checks the database for a saved refresh token
 * @param {*} token 
 * @returns 
 */
async function checkRefreshTokenInDb(refreshToken) {
    const tokenInDb = await tokenController.getToken(refreshToken)

    // Checks if the refresh token exists in database
    if (tokenInDb == null) return false

    // If it exists
    return true
}

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
            req.body.uuid = result.azp
            return next()
        })
    } catch (err) {
        const error = new Error(err.message)
        error.code = "403"
        throw error
    }

}

/**
 * Deletes a refresh token from the database
 * @param {*} token 
 */
function deleteRefreshToken(token) {
    try {
        tokenController.deleteToken(token)
    } catch (err) {
        const error = new Error(err.message)
        error.code = "500"
        throw error
    }
}
// Exports
module.exports.verifyAccessToken = verifyAccessToken
module.exports.requestAccessToken = requestAccessToken
module.exports.deleteRefreshToken = deleteRefreshToken
module.exports.requestRefreshToken = requestRefreshToken

