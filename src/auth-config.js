require("dotenv").config()

const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")

const tokenController = require("./controller/tokenController")

// Get User By Email
const getUserByEmail = require("./controller/userController").getUserByEmail

/**
 * Verifies access token, can be used in other routes as middleware
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns 
 */
function verifyAccessToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]

    if (token == null) return res.sendStatus(401)

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (err) return res.sendStatus(403)
        req.body = { email: user.email }
        return next()
    })
}

/**
 * Requests access token using user credentials
 * @param {*} req 
 * @param {*} res 
 */
async function requestAccessToken(req, res) {

    // Authorization Grant
    try {
        const user = await getUserByEmail(req.body.email)
        if (user == null) { return res.status(400).send({ message: "User does not exists." }) }

        const chk = user.email.toString() === req.body.email && await bcrypt.compare(req.body.password, user.password)
        if (chk === false) { return res.status(401).send({ message: "Incorrect email/password." }) }
    } catch (err) {
        return res.sendStatus(500)
    }

    // Generates a refresh token and stores it in the database
    const refreshToken = jwt.sign({ email: req.body.email }, process.env.REFRESH_TOKEN_SECRET, { expiresIn: "30d" })

    // Store the token in the database
    try {
        await tokenController.storeToken(refreshToken)
    } catch (err) {
        res.sendStatus(500)
    }
    
    // Provide access token when the user is authenticated
    const accessToken = generateAccessToken(req.body.email)
    res.json({ accessToken: accessToken, refreshToken: refreshToken })
}

/**
 * Generates an expiring access token
 * @param {*} email 
 * @returns 
 */
function generateAccessToken(email) {
    return jwt.sign({ email: email }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "24h" })
}

/**
 * Checks the database for a saved refresh token
 * @param {*} token 
 * @returns 
 */
async function verifyRefreshToken(token) {
    const tokenInDb = await tokenController.getToken(token)
    if (tokenInDb == null) return false
    return true
}

/**
 * Deletes a refresh token from the database
 * @param {*} token 
 * @returns
 */
async function deleteRefreshToken(token) {
    try {
        await tokenController.deleteToken(token)
        return true
    } catch (err) {
        throw err
    }
}

/**
 * Generates a new access token, useful for users who are already logged in
 * @param {*} req 
 * @param {*} res 
 * @returns 
 */
function refreshAccessToken(req, res) {
    const refreshToken = req.body.refreshToken
    if (refreshToken == null) return res.sendStatus(401)
    if (!verifyRefreshToken(refreshToken)) res.sendStatus(403)

    jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
        if (err) return res.sendStatus(403)
        const accessToken = generateAccessToken(user.email)
        res.json({ accessToken: accessToken })
    })
}

// Exports
module.exports.verifyAccessToken = verifyAccessToken
module.exports.requestAccessToken = requestAccessToken
module.exports.refreshAccessToken = refreshAccessToken
module.exports.deleteRefreshToken = deleteRefreshToken

